class Todo {
  Todo({required this.title, required this.selected});

  String title;
  bool selected;

  void toggleSelected() {
    selected = !selected;
  }
}
