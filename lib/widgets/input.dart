import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_copy/providers/app.dart';

class AddTodoTextInput extends StatefulWidget {
  const AddTodoTextInput({
    super.key,
  });

  @override
  State<AddTodoTextInput> createState() => _InputState();
}

class _InputState extends State<AddTodoTextInput> {
  bool fieldNotEmpty = true;
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

class EmailTextInput extends StatefulWidget {
  const EmailTextInput({super.key, required this.textController});

  final TextEditingController textController;
  @override
  State<EmailTextInput> createState() => _EmailTextInputState();
}

class _EmailTextInputState extends State<EmailTextInput> {
  bool fieldNotEmpty = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextField(
              controller: widget.textController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                errorText: fieldNotEmpty ? null : "Value can't be empty",
                labelText: "Email",
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PasswordTextInput extends StatefulWidget {
  const PasswordTextInput({super.key, required this.textController});
  final TextEditingController textController;

  @override
  State<PasswordTextInput> createState() => _PasswordTextInputState();
}

class _PasswordTextInputState extends State<PasswordTextInput> {
  bool fieldNotEmpty = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: widget.textController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                errorText: fieldNotEmpty ? null : "Value can't be empty",
                labelText: "Password",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
