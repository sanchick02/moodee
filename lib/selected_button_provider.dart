import 'package:riverpod/riverpod.dart';

final selectedButtonProvider =
    StateNotifierProvider<SelectedButtonNotifier, String>((ref) {
  return SelectedButtonNotifier();
});

class SelectedButtonNotifier extends StateNotifier<String> {
  SelectedButtonNotifier() : super(''); // Set the initial state

  void updateSelectedButton(String button) {
    state = button;
  }
}
