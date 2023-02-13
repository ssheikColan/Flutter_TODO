import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/main.dart';
import 'Notes.dart';
import 'NotesProvider.dart';

void main() {
  runApp( ChangeNotifierProvider(create: (context)=>NotesProviders(),
  child: Home(),
  ));
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Homepage(),
    );
  }
}

class Homepage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
            body: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
      child: Consumer<NotesProviders>(
        builder: (context,NotesProviders data,child){
          return data.getNotes.isNotEmpty ? Container(
            height: 400,
            child: ListView.builder(
              itemCount: data.getNotes.length,
              itemBuilder: (context,index){
                return Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        topLeft: Radius.circular(10),
                      )
                  ),
                  child: ListTile(
                    leading: Icon(Icons.note),
                    title: Text(data.getNotes[index].title),
                    subtitle: Text(data.getNotes[index].description),
                    trailing: IconButton(color: Colors.black26, onPressed: () {
                      Provider.of<NotesProviders>(context,listen: false).removeNotes(index);
                    },  icon: new Icon(Icons.delete),),
                  ),
                );
              },
            ),
          ): GestureDetector(onTap: (){
            showAlertDialog(context);
          },child: Center(child: Text("ADD SOME NOTES NOW",style: TextStyle(color: Colors.white,),)));
        },
      ),
    ),
            ),
            floatingActionButton: FloatingActionButton(onPressed: () {
              showAlertDialog(context);
            },
              backgroundColor: Colors.white,
              child: Icon(Icons.add,color: Colors.black,),
            ),
          );
  }
}


showAlertDialog(BuildContext context) {

  TextEditingController _Title = TextEditingController();
  TextEditingController _Description = TextEditingController();
  // Create button
  Widget okButton = ElevatedButton(
    child: Text("ADD NOTE"),
    onPressed: () {
      if(_Title.value.text.isNotEmpty && _Description.value.text.isNotEmpty){
        Provider.of<NotesProviders>(context, listen: false).addNotes(
            _Title.text, _Description.text);
        Navigator.of(context).pop();
      }
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("ADD A NEW NOTE "),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: _Title,
          decoration: InputDecoration(hintText: "Enter Title"),
        ),
        TextField(
          controller: _Description,
          decoration: InputDecoration(hintText: "Enter Description"),
        ),
      ],
    ),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}








