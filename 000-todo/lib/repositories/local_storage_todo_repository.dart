import 'package:localstorage/localstorage.dart';

import '../models/models.dart';
import 'todo_repository.dart';

class LocalStorageTodoRepository extends TodoRepository {
  static const _itemKey = 'todos';

  final LocalStorage _localstorage;

  const LocalStorageTodoRepository(this._localstorage);

  @override
  Future<List<Todo>> getTodos() async {
    final List todos = _localstorage.getItem(_itemKey) ?? [];
    return todos.map((s) => Todo.fromJson(s)).toList();
  }

  @override
  Future<void> setTodos(List<Todo> todos) async {
    final todosJson = todos.map((t) => t.toJson()).toList();
    await _localstorage.setItem(_itemKey, todosJson);
  }
}
