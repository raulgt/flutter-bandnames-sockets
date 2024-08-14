import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:band_names/models/band.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'Caramelos de Cianuro', votes: 5),
    Band(id: '2', name: 'Imagine Dragons', votes: 3),
    Band(id: '3', name: 'Nirvana', votes: 4),
    Band(id: '4', name: 'Metallica', votes: 4),
    Band(id: '5', name: 'Aerosmith', votes: 4),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Band Names',
            style: TextStyle(color: Colors.black87, fontSize: 14.0)),
        elevation: 1,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (BuildContext context, int index) =>
            _bandTitle(bands[index]),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 1,
        onPressed: addNewBand,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _bandTitle(band) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: ( direction ){
        print('direction: $direction');
        //TODO: llamar el borrado en el server
        deleteBand(band.id);
      },
      background: Container(
        padding: const EdgeInsets.only(left: 15.0),
        color: Colors.redAccent,
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Text('Delete Band', style: TextStyle(color: Colors.white),)),
      ),
      child: ListTile(
        leading: CircleAvatar(
            backgroundColor: const Color.fromARGB(255, 243, 216, 255),
            child: Text(band.name.substring(0, 2))),
        title: Text(band.name, textAlign: TextAlign.left),
        trailing: Text('${band.votes}', style: const TextStyle(fontSize: 20)),
        onTap: () {
          print(band.name);
        },
      ),
    );
  }

//  Add a new band action button
  addNewBand() {
    final textController = new TextEditingController();

    if (Platform.isAndroid) {
      // Android
     return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('New band name'),
            content: TextField(
              controller: textController,
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5,
                onPressed: () => addBandToList(textController.text),
                textColor: Colors.blue,
                focusColor: Colors.blue,
                child: const Text('Add'),
              )
            ],
          );
        },
      );
    }else if(Platform.isIOS){
        // IOS
        showCupertinoDialog(
          context: context, 
          builder: (context) {
                  return CupertinoAlertDialog(
                     title: const Text('New band name'),
                     content: CupertinoTextField(
                      controller: textController,
                     ),
                     actions: <Widget> [
                       CupertinoDialogAction(
                        isDefaultAction: true,
                        child: const Text('Add'),
                        onPressed: () => addBandToList(textController.text),
                        ),
                        CupertinoDialogAction(
                        isDestructiveAction: true,
                        child: const Text('Close'),
                        onPressed: () => Navigator.pop(context),
                        )
                     ],
                  );
          } 
          );
    }
  }

  void addBandToList(String name) {
    if (name.length > 1) {
      //Podemos agregar
      this.bands.add(new Band(id: DateTime.now.toString(), name: name, votes: 0));
      setState(() {});
    }
  
    Navigator.pop(context);
  }

  deleteBand(String id) {
     this.bands.removeWhere((item) => item.id == id);
      setState(() {});
}

}

