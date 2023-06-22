import 'package:hooks_riverpod/hooks_riverpod.dart';

final selectedIndexProvider =
    StateNotifierProvider<SelectedIndexNotifier, int>((ref) {
  return SelectedIndexNotifier();
});

class SelectedIndexNotifier extends StateNotifier<int> {
  SelectedIndexNotifier() : super(0);

  void selectIndex(int index) {
    state = index;
  }
}
