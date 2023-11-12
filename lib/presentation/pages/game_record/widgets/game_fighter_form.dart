import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/entities/game_fighter/game_fighter.dart';
import '../../../../domain/use_cases/game_fighter_list/game_fighter_list.dart';

class GameFighterForm extends ConsumerWidget {
  const GameFighterForm({
    required this.value,
    required this.onChanged,
    this.validator,
    this.label,
    super.key,
  });

  final GameFighter? value;
  final ValueChanged<GameFighter?> onChanged;
  final String? Function(GameFighter?)? validator;
  final String? label;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fighterListAsync = ref.watch(gameFighterListProvider);

    return fighterListAsync.when(
      data: (fighterList) => DropdownButtonFormField<GameFighter>(
        value: value,
        items: fighterList.list
            .map(
              (value) => DropdownMenuItem(
                value: value,
                child: Text(value.name),
              ),
            )
            .toList(),
        onChanged: onChanged,
        menuMaxHeight: 316,
        decoration: InputDecoration(
          label: label != null ? Text(label!) : null,
        ),
        validator: validator,
      ),
      error: (e, __) => Text(e.toString()),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
