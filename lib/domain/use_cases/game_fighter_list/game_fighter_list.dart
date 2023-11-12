import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_demo/domain/repositories/game_fighter_list/game_fighter_list_repository.dart';

final gameFighterListProvider = FutureProvider.autoDispose((ref) {
  return ref.read(gameFighterListRepositoryProvider).list();
});
