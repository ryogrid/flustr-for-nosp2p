import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'follow_list_cache_notifier.g.dart';

class FollowListDataRepository {
  static final FollowListDataRepository _singleton = FollowListDataRepository._internal();
  factory FollowListDataRepository() {
    return _singleton;
  }
  FollowListDataRepository._internal();

  // key: pubHex, value: following User's pubHexes of a user identified by key pubHex
  Map<String, List<String>> followListMap = <String, List<String>>{};
}

@riverpod
class FollowListCacheNotifier extends _$FollowListCacheNotifier {
  FollowListDataRepository followListRepo = FollowListDataRepository();

  @override
  FollowListDataRepository build() {
    return this.followListRepo;
  }
}