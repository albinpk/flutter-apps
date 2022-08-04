import 'package:bloc_test/bloc_test.dart';
import 'package:todo/cubit/todo_cubit.dart';

class MockTodoCubit extends MockCubit<TodoState> implements TodoCubit {}
