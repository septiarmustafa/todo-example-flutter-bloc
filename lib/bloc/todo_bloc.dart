import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/todo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(const TodoInitial([])) {
    on<OnAddTodo>((event, emit) async {
      emit(TodoLoading(state.todos));
      await Future.delayed(const Duration(milliseconds: 1500));
      Todo newTodo = event.newTodo;
      emit(TodoAdded([...state.todos, newTodo]));
      // Todo newTodo = event.newTodo;
      // List<Todo> newTodos = state.todos;
      // newTodos.add(newTodo);
      // emit(TodoAdded(newTodos));
    });

    on<OnUpdated>((event, emit) async {
      emit(TodoLoading(state.todos));
      await Future.delayed(const Duration(milliseconds: 1500));
      Todo newTodo = event.newTodo;
      int index = event.index;
      List<Todo> todosUpdated = state.todos;
      todosUpdated[index] = newTodo;
      emit(TodoUpdated(todosUpdated));
    });

    on<OnRemovedTodo>((event, emit) async {
      emit(TodoLoading(state.todos));
      await Future.delayed(const Duration(milliseconds: 1500));
      int index = event.index;
      List<Todo> todoRemoved = state.todos;
      todoRemoved.removeAt(index);
      emit(TodoRemoved(todoRemoved));
    });
  }
}
