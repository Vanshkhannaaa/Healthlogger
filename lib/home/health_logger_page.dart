import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HealthLoggerPage extends StatefulWidget {
  const HealthLoggerPage({super.key});

  @override
  State<HealthLoggerPage> createState() => _HealthLoggerPageState();
}

class _HealthLoggerPageState extends State<HealthLoggerPage> {

  bool showLoader = false;

  TextEditingController bpLowController = new TextEditingController();
  TextEditingController bpHighController = new TextEditingController();
  TextEditingController sugarController = new TextEditingController();

  void addHealthData() async{
    print( "BP Low:"+bpLowController.text.trim());
    print( "BP High:"+bpHighController.text.trim());
    print( "Sugar:"+sugarController.text.trim());

    try{

      var uid = FirebaseAuth.instance.currentUser!.uid;

      FirebaseFirestore.instance.collection("users").doc(uid).collection("health").add(
        {
        "bpHigh": int.parse(bpHighController.text.trim()),
        "bpLow": int.parse(bpLowController.text.trim()),
        "sugar": int.parse(sugarController.text.trim()),
        "createdOn": DateTime.now()
        }
      ).then((value)=> Navigator.pop(context));

    } on FirebaseAuthException catch(e){
      print("Something Went Wrong"+e.message.toString());
      print("Error Code:"+e.code.toString());
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Log Health Details"),
      ),
      body:showLoader ? Center(child: CircularProgressIndicator(),) :Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/healthlogger.png", width: 64,height:64),
            const SizedBox(height: 12,),
            const Text("Add Health Data", style: TextStyle(color: Colors.amber, fontSize: 24),),
            const SizedBox(height: 6,),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: bpHighController,
              decoration: const InputDecoration(
                  labelText: "Enter BP High",
              ),
            ),
            const SizedBox(height: 6,),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: bpLowController,
              decoration: const InputDecoration(
                  labelText: "Enter BP Low",
              ),
            ),
            const SizedBox(height: 6,),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: sugarController,
              decoration: const InputDecoration(
                  labelText: "Enter Sugar Level",
              ),
            ),
            const SizedBox(height: 6,),
            OutlinedButton(onPressed:(){
              setState(() {
                showLoader = true;
                addHealthData();
              });

            }, child: const Text("Log Health Data")),
            const SizedBox(height: 12,),
          ],
        ),
      ),
    );
  }
}
