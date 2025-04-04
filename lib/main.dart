import 'dart:io';

import 'package:collection_backend/api/collection/collection_controller.dart';
import 'package:collection_backend/api/login/login_controller.dart';
import 'package:collection_backend/dao/collection_dao.dart';
import 'package:collection_backend/infra/database/supabase_database_connection.dart';
import 'package:collection_backend/infra/middleware_interception.dart';
import 'package:collection_backend/infra/security/security_service.dart';
import 'package:collection_backend/services/collection_service.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';


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
