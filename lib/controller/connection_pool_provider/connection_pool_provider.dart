import 'package:flustr/controller/relay_url_provider.dart/relay_url_provider.dart';
import 'package:flustr/external/connection_pool.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'connection_pool_provider.g.dart';

@Riverpod(keepAlive: true)
Future<ConnectionPool> connectionPool(ConnectionPoolRef ref) async {
  // TODO: need to remove referencing relayUrlProvider (connectionPool at conection_pool_provider.dart)
  final urls = await ref.watch(relayUrlProvider.future);
  return ConnectionPool(urls);
}
