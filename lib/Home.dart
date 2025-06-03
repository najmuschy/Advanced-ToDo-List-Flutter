import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, dynamic>> tasks = [];
  bool showActiveTask = true;
  _showTaskDialog({int? index}) {
    TextEditingController _taskController = TextEditingController(
      text: index!= null ? tasks[index]["task"]:'' ,
    );
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(index!=null?"Edit Task":"Add Task"),
            content: TextField(
              controller: _taskController,
              decoration: InputDecoration(hintText: 'Enter Task'),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed:
                    () => {
                      if(index==null){
                        _addTask(_taskController.text),
                      }
                      else{
                        _updateTask(index, _taskController.text)
                      },
                      Navigator.pop(context),
                    },
                child: Text(index!=null?'Edit':'Create'),
                style: ElevatedButton.styleFrom(shape: StadiumBorder()),
              ),
            ],
          ),
    );
  }

  void _addTask(String task) {
    setState(() {
      tasks.add({"task": task, "completed": false});
    });
  }

  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  void _togleTaskStatus(int index) {
    setState(() {
      tasks[index]["completed"] = !tasks[index]["completed"];
    });
  }
  void _updateTask(int index, String updatedTask){
    setState(() {
      tasks[index]["task"] = updatedTask ;
    });
  }
  int get completedCount => tasks.where((task)=>task["completed"]).length ;
  int get activeCount => tasks.where((task)=>!task["completed"]).length ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Task Tracking App',
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade900,
                    boxShadow: [
                      BoxShadow(color: Colors.pinkAccent, blurRadius: 4),
                    ],
                  ),
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        'Active',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.amberAccent,
                        ),
                      ),
                      Text(
                        '$activeCount',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.amberAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade900,
                    boxShadow: [
                      BoxShadow(color: Colors.pinkAccent, blurRadius: 4),
                    ],
                  ),
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        'Completed',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.amberAccent,
                        ),
                      ),
                      Text(
                        '$completedCount',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.amberAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return Dismissible(key: Key(tasks[index].hashCode.toString()),

                    background: Container(
                      color: Colors.green,
                      alignment: Alignment.centerLeft,
                      child: Icon(Icons.check, color: Colors.white, weight: 20, size: 25,),
                    ),
                    secondaryBackground: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      child: Icon(Icons.delete, color: Colors.white, weight: 20, size: 25,),
                    ),
                    confirmDismiss: (direction)async{
                      if(direction == DismissDirection.startToEnd){
                        setState(() {

                          _togleTaskStatus(index) ;
                        });
                      }
                      else{
                        setState(() {

                          tasks.removeAt(index);
                        });
                      }
                    },
                    child: Card(
                      child: ListTile(
                        title: DefaultTextStyle.merge(
                      style: TextStyle(
                      color: Colors.white,
                        fontWeight: FontWeight.bold,
                        decoration: tasks[index]["completed"]
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        decorationThickness: 2,
                      ),
                      child: Text(tasks[index]["task"]),
                    ),
                        leading: Checkbox(shape: CircleBorder(), value: tasks[index]["completed"] , onChanged: (value)=>_togleTaskStatus(index)),
                        trailing: IconButton(onPressed: (){}, icon: IconButton(onPressed: ()=>_showTaskDialog(index: index), icon: Icon(Icons.edit))),
                  ),
                ));
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showTaskDialog(),
        child: Icon(Icons.add),
      ),
    );
  }
}
