import 'package:d_info/d_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc/todo_bloc.dart';
import 'package:flutter_application_1/models/todo.dart';
import 'package:flutter_application_1/widget/simple_input.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  addTodo() {
    final edtTitle = TextEditingController();
    final edtDescription = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          contentPadding: const EdgeInsets.all(20),
          children: [
            SimpleInput(
              edtTitle: edtTitle,
              edtDescription: edtDescription,
              ontap: () {
                Todo newTodo = Todo(edtTitle.text, edtDescription.text);
                context.read<TodoBloc>().add(OnAddTodo(newTodo));
                Navigator.pop(context);
                DInfo.snackBarSuccess(context, 'Todo Added');
              },
              actionTitle: "Add Todo",
            )
          ],
        );
      },
    );
  }

  updateTodo(int index, Todo oldTodo) {
    final edtTitle = TextEditingController();
    final edtDescription = TextEditingController();
    edtTitle.text = oldTodo.title;
    edtDescription.text = oldTodo.description;
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          contentPadding: const EdgeInsets.all(20),
          children: [
            SimpleInput(
              edtTitle: edtTitle,
              edtDescription: edtDescription,
              ontap: () {
                Todo newTodo = Todo(edtTitle.text, edtDescription.text);
                context.read<TodoBloc>().add(OnUpdated(index, newTodo));
                Navigator.pop(context);
                DInfo.snackBarSuccess(context, 'Todo Updated');
              },
              actionTitle: "Update Todo",
            )
          ],
        );
      },
    );
  }

  removeTodo(int index) {
    DInfo.dialogConfirmation(
            context, 'Remove Todo', 'Are you sure to remove this todo?')
        .then((bool? yes) {
      if (yes ?? false) {
        context.read<TodoBloc>().add(OnRemovedTodo(index));
        DInfo.snackBarSuccess(context, 'Todo Removed');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo App"),
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoInitial) return const SizedBox.shrink();
          if (state is TodoLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          List<Todo> list = state.todos;
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              Todo todo = list[index];
              return ListTile(
                leading: CircleAvatar(
                  child: Text('${index + 1}'),
                ),
                title: Text(todo.title),
                subtitle: Text(todo.description),
                trailing: PopupMenuButton(
                  onSelected: (value) {
                    switch (value) {
                      case 'update':
                        updateTodo(index, todo);
                        break;
                      case 'remove':
                        removeTodo(index);
                        break;
                      default:
                        DInfo.snackBarError(context, 'Invalid Menu');
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'update',
                      child: Text('Update'),
                    ),
                    const PopupMenuItem(
                      value: 'remove',
                      child: Text('Remove'),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addTodo,
        child: const Icon(Icons.add),
      ),
    );
  }
}
