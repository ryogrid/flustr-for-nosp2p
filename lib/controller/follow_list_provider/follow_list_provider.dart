import 'package:nostrp2p/controller/current_pubhex_provider/current_pubhex_provider.dart';
import 'package:nostrp2p/controller/follow_list_cache_probider/follow_list_cache_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'follow_list_provider.g.dart';

@Riverpod(keepAlive: true)
List<String> followList(FollowListRef ref, String pubHex) {
    // needed for checking at app launch???
    final pubHex = ref.watch(currentPubHexProvider);
    if (pubHex == null) {
      throw Exception('not logged in!');
    }

    final usersPubHex = ref.read(followListCacheNotifierProvider);

    if (usersPubHex.followListMap[pubHex] == null) {
      return <String>[];
    }else{
      return usersPubHex.followListMap[pubHex]!;
    }
}

