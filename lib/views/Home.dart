import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/providers/provider.dart';




class home extends ConsumerWidget {

  const home({super.key});

   @override
  Widget build(BuildContext context,WidgetRef ref) {

    // final provider = ref.watch(todoProvider);
    // final providerNoti = ref.watch(todoProvider.notifier);
     final todos = ref.watch(todoProvider);
     final todoNotifier = ref.read(todoProvider.notifier);


     return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            FirebaseAuth.instance.signOut();
          }, icon: Icon(Icons.exit_to_app))
        ],
        backgroundColor: Colors.yellow[500],
        title: Text('Todos'),
      ),
      body: body(context,ref),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow,
          child: Icon(Icons.add),
          onPressed:(){
              addTask(context, ref);
          }
      ),
    );
  }

  void submitTextField(val,ref,context){
    // ref.watch(todoProvider.notifier).addTask(val);
    ref.read(todoProvider.notifier).addTask(val);
    // Navigator.of(context).pop();
  }



  void addTask(context,WidgetRef ref){
    final _controller = TextEditingController();

    showDialog(context: context, builder: (context){
      return AlertDialog(
        backgroundColor: Colors.yellow,
        // title: Text('add task'),
        content: Container(
          // color: Colors.red,
          height: 150,
          width: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              TextField(
                 controller: _controller,
              onSubmitted: (val){
                   submitTextField(val, ref,context);
                   _controller.clear();
                   Navigator.of(context).pop();
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2)
                )
              )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(onPressed: (){
                    submitTextField(_controller.text.toString(), ref,context);
                    _controller.clear();
                    Navigator.of(context).pop();
                  }, child: Text('save')),
                  TextButton(onPressed: (){
                  Navigator.pop(context);
                  }, child: Text('cancel')),
                ],
              )
            ],
          ),
        ),
      );
    });
  }
  //body
  Widget body(context,WidgetRef ref) {
    final read = ref.watch(todoProvider);
    if (read.isEmpty) {
      return Center(
          child: Text('no Task...',
            style: TextStyle(
              fontSize: 20,
            ),
          )
      );
    }
    else {
      return ListView.builder(
          itemCount: read.length,
          itemBuilder: (context, index) {
            return Dismissible(
              background: Container(
                color: Colors.red,
              ),
              key: UniqueKey(),
              onDismissed: (dismissDirection) {
                ref.read(todoProvider.notifier).deleteTask(read[index].id);
              },
              child: ListTile(
                leading: Checkbox(value: read[index].isDone, onChanged: (value){
                  ref.read(todoProvider.notifier).markDone(read[index].id,value!);
                }),
                title: Text(read[index].task),
              ),
            );
          });
    }
  }
}
