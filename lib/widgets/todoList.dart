import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app.dart';

class TodoList extends StatelessWidget {
  const TodoList({
    super.key,
  });

  TextStyle? _getTextStyle(bool checked) {
    if (!checked) return null;

    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    if (appState.todos.isEmpty) return const Text("Add a todo item");

    return ReorderableListView.builder(
      onReorder: appState.handleReorder,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: appState.todos.length,
      itemBuilder: (context, i) {
        final item = appState.todos[i];
        return Dismissible(
          key: Key(appState.todos[i].title),
          onDismissed: (direction) {
            appState.removeItem(item);
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('Removed ${item.title}')));
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
              child: ListTile(
                leading: Checkbox(
                  value: item.selected,
                  onChanged: (value) {
                    appState.toggleItem(item);
                  },
                ),
                title: Row(
                  children: [
                    Expanded(
                      child: Text(
                        appState.todos[i].title,
                        style: _getTextStyle(item.selected),
                      ),
                    ),
                    const Icon(
                      Icons.drag_indicator,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
