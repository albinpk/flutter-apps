import '../models/models.dart';

abstract class TodoRepository {
  const TodoRepository();

  Future<List<Todo>> getTodos();

  Future<void> setTodos(List<Todo> todos);
}
