import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  fetch(){
    var uid = FirebaseAuth.instance.currentUser!.uid;
    Stream<QuerySnapshot> stream=FirebaseFirestore.instance.collection("users").doc(uid).collection("health").snapshots();
    return stream;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Home"),
        actions: [
          IconButton(onPressed:(){
            FirebaseAuth.instance.signOut();
            Navigator.pushReplacementNamed(context, "/splash");
          }, icon: Icon(Icons.logout) ,tooltip:"logout")
        ],
      ),
      body: StreamBuilder(
        stream: fetch(),
        builder: (BuildContext context,AsyncSnapshot snapshot){

          if(snapshot.connectionState== ConnectionState.waiting){
            return Center(
            child: CircularProgressIndicator(),
            );
          }

          return ListView(
            padding: EdgeInsets.all(16),
            children: snapshot.data!.docs.map<Widget>((DocumentSnapshot document){
            Map<String, dynamic> map = document.data()! as Map<String, dynamic>;
            
            return Card(
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("BP High"+map['bpHigh'].toString(),style: TextStyle(fontSize: 16),),
                    Text("BP Low"+map['bpLow'].toString(),style: TextStyle(fontSize: 16),),
                    Text("Sugar"+map['sugar'].toString(),style: TextStyle(fontSize: 16),),
                    Text(map['createdOn'].toString(),style: TextStyle(fontSize: 12),),
                    ],
                  ),
                ),
              );
            }).toList()
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add,color:Colors.white),
        onPressed: (){
          Navigator.pushNamed(context, "/logger");
        },
      ),
    );
  }
}