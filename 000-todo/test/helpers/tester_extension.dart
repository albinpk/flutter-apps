import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo/cubit/todo_cubit.dart';
import 'package:todo/utils/test_helper.dart';

import '../mocks/mock_app_service.dart';

extension TesterExtension on WidgetTester {
  /// Wrap given `widget` with [TestHelper], [MaterialApp] and [Scaffold].
  ///
  /// Wrap the widget with [BlocProvider] if `todoCubit` is not null
  Future<void> pumpAndWrap(
    Widget widget, {
    bool withScaffold = true,
    bool withMaterial = true,
    TodoCubit? todoCubit,
    bool inWeb = false,
  }) {
    if (withScaffold) widget = Scaffold(body: widget);
    if (withMaterial) widget = MaterialApp(home: widget);
    if (todoCubit != null) {
      widget = BlocProvider<TodoCubit>(
        create: (_) => todoCubit,
        child: widget,
      );
    }
    final TestHelper testHelper = MockTestHelper();
    when(() => testHelper.isWeb).thenReturn(inWeb);
    widget = RepositoryProvider(create: (_) => testHelper, child: widget);
    return pumpWidget(widget);
  }
}
