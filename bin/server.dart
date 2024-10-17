import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';

import '../bin/api/login/login_controller.dart';
import '../bin/api/collection/collection_controller.dart';
import '../bin/services/collection_service.dart';
import '../bin/infra/middleware_interception.dart';
import '../bin/infra/security/security_service.dart';
import '../bin/dao/collection_dao.dart';
import '../bin/infra/database/supabase_database_connection.dart';

void main(List<String> args) async {
  // Use any available host or container IP (usually `0.0.0.0`).

  final database = SupabaseDatabaseConnection();
  // final userLoginDao = UserLoginDao(database: database);
  final collectionDao = CollectionDao(database: database);
  final collectionService = CollectionService(dao: collectionDao);
  final securityService = SecurityService(supabase: database);
  final middlewareInterception = MiddlewareInterception();

  final cascadeHandler = Cascade()
      .add(
        LoginController(service: securityService).getHandler(
          middlewares: [
            middlewareInterception.loginResponseMiddleware,
          ],
        ),
      )
      .add(
        CollectionController(service: collectionService).getHandler(
          middlewares: [
            securityService.authorization,
          ],
        ),
      )
      .handler;

  final handler = Pipeline()
      .addMiddleware(logRequests())
      // .addMiddleware(corsHeaders())
      .addMiddleware(middlewareInterception.headerMiddleware)
      .addHandler(cascadeHandler);

  final address = String.fromEnvironment('ADDRESS', defaultValue: InternetAddress.anyIPv4.address);
  final port = int.fromEnvironment('PORT', defaultValue: 8080);
  final server = await serve(handler, address, port);

  print('Server listening on ${server.address.address}:${server.port}');
}
