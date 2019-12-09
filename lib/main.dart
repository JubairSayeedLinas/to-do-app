import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To Do App',
      home: new ToDoList(),
    );
  }
}

class ToDoList extends StatefulWidget {
  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  List<String> _toDoItems = [];

  void _addTodoItems(String task) {
    if(task.length>0){
    setState(() => _toDoItems.add(task));
    }
  }

Widget _buildTodoList() {
    return new ListView.builder(
      itemBuilder: (context, index) {
        // itemBuilder will be automatically be called as many times as it takes for the
        // list to fill up its available space, which is most likely more than the
        // number of todo items we have. So, we need to check the index is OK.
        if(index < _toDoItems.length) {
          return _buildTodoItem(_toDoItems[index], index);
        }
      },
    );
  }
  Widget _buildTodoItem(String todoText, int index) {
    return new ListTile(
      title: new Text(todoText),
      onTap: () => _promptRemoveTodoItem(index)
    );
  }

  void _pushAddTodoScreen() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new Scaffold(
        appBar: AppBar(
          title: Text('Add a new task'),
        ),
        body: new TextField(
          autofocus: true,
          onSubmitted: (val){
            _addTodoItems(val);
              Navigator.pop(context);
          },
          decoration: new InputDecoration(
            hintText: 'Enter something to do',
            contentPadding: const EdgeInsets.all(16.0)
          ),

          
        ),
      );
    }));
  }

  void _removeTodoItem(int index) {
  setState(() => _toDoItems.removeAt(index));
}

void _promptRemoveTodoItem(int index) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return new AlertDialog(
        title: new Text('Mark "${_toDoItems[index]}" as done?'),
        actions: <Widget>[
          new FlatButton(
            child: new Text('CANCEL'),
            onPressed: () => Navigator.of(context).pop()
          ),
          new FlatButton(
            child: new Text('MARK AS DONE'),
            onPressed: () {
              _removeTodoItem(index);
              Navigator.of(context).pop();
            }
          )
        ]
      );
    }
  );
}

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('Todo List')),
      body: _buildTodoList(),
      floatingActionButton: FloatingActionButton(
          onPressed: _pushAddTodoScreen,
          tooltip: 'Add task',
          child: new Icon(Icons.add)),
    );
  }
}
