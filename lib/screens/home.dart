import 'package:flutter/material.dart';

import '../models/todo.dart';
import '../constraints/color.dart';
import '../widgets/todo_item.dart';

class home extends StatefulWidget{

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  final todolist = ToDo.todoList();
  List<ToDo> _foundToDo = [];
  final _todoCOntroller  = TextEditingController();

  @override
  void initState() {
    _foundToDo = todolist;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGcolor,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.menu,color: tdblack,size: 30,),
            Container(
              width: 40,
              height: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image.asset('assests/images/ava.png'),),
            )
          ],
        ),
        backgroundColor: tdBGcolor,
        elevation: 1,
      ),

      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 15),
            child: Column(
              children: [
                  searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 50, bottom: 20),
                        child: Text(
                          'All Todos',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),

                      for(ToDo todoo in _foundToDo.reversed)
                        ToDoItem(
                          todo: todoo,
                        onToDoChange: _handleToDoChange,
                        onDeleteItem: _deleteToDoItem,),
                    ],
                  ),
                )
              ],
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: (){
                _addToDoItem(_todoCOntroller.text);
              },
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                        margin: EdgeInsets.only(
                          bottom: 20,
                          right: 20,
                          left: 20,
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: const [BoxShadow(
                            color:  Colors.grey,
                            offset: Offset(0.0,0.0),
                            blurRadius: 10.0,
                            spreadRadius: 0.0,
                          ),],
                        ),

                        child: TextField(
                          controller: _todoCOntroller,
                          decoration: InputDecoration(
                            hintText: 'Add new Item',
                            border: InputBorder.none,
                          ),
                        ),
                      )
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      bottom: 20,
                      right: 20,

                    ),
                    child: ElevatedButton(
                      child: Text('+',style: TextStyle(fontSize: 40),
                      ),
                      onPressed: (){
                        _addToDoItem(_todoCOntroller.text);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: tdblue,
                        minimumSize: Size(60,60),
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      )
    );
  }

void _handleToDoChange(ToDo todo){

    setState(() {
      todo.isDone = !todo.isDone;
    });

}

void _deleteToDoItem(String id){
    setState(() {
      todolist.removeWhere((item) => item.id == id);
    });
}

void _addToDoItem(String todo){

    setState(() {
      todolist.add(ToDo(id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: todo
      ));
    });
    _todoCOntroller.clear();
  }

  void _runFilter(String enteredKeyword){
    List<ToDo> results = [];
    if(enteredKeyword.isEmpty){
      results = todolist;
    }else{
      results = todolist.where((item) => item.todoText!
      .toLowerCase()
      .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundToDo = results;
    });
  }

  Widget searchBox(){
    return  Container(
      padding: EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20)
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(
              Icons.search,
              color: tdblack,
              size: 20,
            ),
            prefixIconConstraints: BoxConstraints(maxHeight: 20,minWidth: 25),
            border: InputBorder.none,
            hintText: 'Search',
            hintStyle: TextStyle(color: tdgrey)

        ),

      ),
    );
  }
}