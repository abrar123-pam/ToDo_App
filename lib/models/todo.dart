class ToDo{
  String? id;
  String? todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
});

  static List<ToDo> todoList(){
    return [
      ToDo(id: '01', todoText: 'Test Preparation',isDone: true),
      ToDo(id: '02', todoText: 'Coding Time',isDone: true),
      ToDo(id: '03', todoText: 'Check Emails',),
      ToDo(id: '04', todoText: 'Meeting',),
      ToDo(id: '05', todoText: 'Dinner making',),
      ToDo(id: '06', todoText: 'Work with friends',),
    ];
  }
}