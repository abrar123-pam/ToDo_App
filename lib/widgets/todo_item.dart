import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/constraints/color.dart';
import 'package:todo/models/todo.dart';

class ToDoItem extends StatelessWidget{
  final ToDo todo;
  final onToDoChange;
  final onDeleteItem;


  const ToDoItem({
    Key? key,
    required this.todo,
    this.onToDoChange,
    this.onDeleteItem
  }) : super(key: key);

  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: (){
          onToDoChange(todo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        tileColor: Colors.white,
        leading: Icon(
          todo.isDone?
          Icons.check_box: Icons.check_box_outline_blank,
          color: tdblue,
        ),

        title: Text(
          todo.todoText!,
          style: TextStyle(
            fontSize: 16,
            color: tdblack,
            decoration: todo.isDone? TextDecoration.lineThrough:null,
          ),
        ),

        trailing: Container(
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: tdred,
            borderRadius: BorderRadius.circular(5)
          ),
          child: IconButton(
            color:  Colors.white,
            iconSize: 18,
            icon: Icon(Icons.delete),
            onPressed: (){
              onDeleteItem(todo.id);
            },
          ),
        ),
      ),
    
    );
  }
}