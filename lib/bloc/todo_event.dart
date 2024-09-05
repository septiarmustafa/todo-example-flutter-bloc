part of 'todo_bloc.dart';

@immutable
sealed class TodoEvent {}

class OnAddTodo extends TodoEvent {
  final Todo newTodo;

  OnAddTodo(this.newTodo);
}

class OnRemovedTodo extends TodoEvent {
  final int index;

  OnRemovedTodo(this.index);
}

class OnUpdated extends TodoEvent {
  final int index;
  final Todo newTodo;

  OnUpdated(this.index, this.newTodo);
}
