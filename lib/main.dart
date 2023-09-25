import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_copy/models.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  List<Todo> todos = [];

  void addItem(String title) {
    todos.add(Todo(title: title, selected: false));
    notifyListeners();
  }

  void removeItem(Todo todo) {
    todos.removeWhere((element) => element == todo);
    notifyListeners();
  }

  void toggleItem(Todo todo) {
    todo.toggleSelected();
    notifyListeners();
  }

  void handleReorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final Todo item = todos.removeAt(oldIndex);
    todos.insert(newIndex, item);
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Flutter Todo copy"),
      ),
      body: Column(
        children: [
          Input(),
          SizedBox(height: 20),
          TodoList(),
        ],
      ),
    );
  }
}

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
    if (appState.todos.isEmpty) return Text("Add a todo item");

    return ReorderableListView.builder(
      onReorder: appState.handleReorder,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: appState.todos.length,
      itemBuilder: (context, i) {
        return Padding(
          key: ValueKey(appState.todos[i]),
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
                value: appState.todos[i].selected,
                onChanged: (value) {
                  appState.toggleItem(appState.todos[i]);
                },
              ),
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      appState.todos[i].title,
                      style: _getTextStyle(appState.todos[i].selected),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.delete_outlined,
                      color: Colors.red,
                    ),
                    onPressed: () => appState.removeItem(appState.todos[i]),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class Input extends StatefulWidget {
  const Input({
    super.key,
  });

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  bool fieldNotEmpty = false;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    final TextEditingController textFieldController = TextEditingController();

    void addItem() {
      setState(() {
        fieldNotEmpty = textFieldController.text.isNotEmpty;
      });
      if (fieldNotEmpty) {
        appState.addItem(textFieldController.text);
        textFieldController.clear();
      }
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: textFieldController,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  errorText: fieldNotEmpty ? null : "Value can't be empty",
                  labelText: "Enter a todo item",
                  suffixIcon: IconButton(
                    onPressed: addItem,
                    icon: const Icon(Icons.add),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
