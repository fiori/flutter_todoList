// Import MaterialApp and other widgets which we can use to quickly create a material app
import 'package:flutter/material.dart';

void main() => runApp(new TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Todo List',
      home: TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  createState() => TodoListState();
}

class TodoListState extends State<TodoList> {
  List<String> _todoItems = [];
  List<bool> _itemsCheckbox = [];

  void _addTodoItem(String task) {
    //Only add the task if the user actually entered something
    if (task.isNotEmpty) setState(() => _todoItems.add(task));
  }

  //Build the whole list of todo items
  Widget _buildTodoList() {
    return ListView.builder(
      itemBuilder: (context, index) {
        if (index < _todoItems.length) 
        {
          _itemsCheckbox.add(false);
          return _buildTodoItem(_todoItems[index],index);
        }
      },
    );
  }

  Widget _buildTodoItem(String todoText, int i) {
    var _card = Card(
      child: Stack(children: <Widget>[
        ListTile(title: new Text(todoText[0].toUpperCase() + todoText.substring(1), style: TextStyle(color: Colors.white,),),),
        Checkbox(
          value: _itemsCheckbox[i],
          onChanged: (bool x)
            {
              setState(() {
                _itemsCheckbox[i] ? _itemsCheckbox[i] = false : _itemsCheckbox[i] = true; 
              });
            },
        ),
        ],
        alignment: Alignment.centerRight,
        ),
      color: Colors.deepPurpleAccent,
     );
    return _card;
  }

  @override
  Widget build(BuildContext context) {
    var _button = FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: _pushAddTodoScreen,
      tooltip: 'Add Task',
    );
    var _scafold = Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
        leading: Icon(Icons.face),
      ),
      body: _buildTodoList(),
      floatingActionButton: _button,
    );

    return _scafold;
  }

  void _pushAddTodoScreen() {
    // Push this page onto the stack
    Navigator.of(context).push(
        //MaterialPageRoute will automatically animate the screen entry, as well as adding a back button to close it

        new MaterialPageRoute(builder: (context) {
      return new Scaffold(
          appBar: new AppBar(
            title: Text('Add new task'),
          ),
          body: new TextField(
            autofocus: true,
            onSubmitted: (val) {
              _addTodoItem(val);
              Navigator.pop(context); //Close the add todo screen
            },
            decoration: InputDecoration(
                hintText: 'Enter something to do...',
                contentPadding: const EdgeInsets.all(16.0)),
          ));
    }));
  }
}
  // String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
