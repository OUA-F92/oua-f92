import 'package:flutter/foundation.dart';
import 'package:mentoru/models/categories_model.dart';
import 'package:mentoru/services/repository.dart';

class CategoyProvider with ChangeNotifier {
  Categories? categories;
  final Repository repo = Repository();

  Categories get getCategories => categories!;

  Future<void> refreshUser() async {
    // ignore: no_leading_underscores_for_local_identifiers
    Categories _categories = await repo.getCategories();
    categories = _categories;
    notifyListeners();
  }
}
