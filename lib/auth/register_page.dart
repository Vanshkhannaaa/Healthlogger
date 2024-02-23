import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  bool showLoader = false;

  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  void registerUser() async{
    print( "Name:"+nameController.text.trim());
    print( "Email:"+emailController.text.trim());
    print("Password:"+passwordController.text.trim());

    try{
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text.trim());

      print("User Created Successfully:"+userCredential.user!.uid.toString());

      //save user details to firestore database
      FirebaseFirestore.instance.collection("users").doc(userCredential.user!.uid).set(
        {
          "name": nameController.text.trim(),
          "email": emailController.text.trim()
        }
      ).then((value)=> Navigator.pushReplacementNamed(context,"/home"));

      if(userCredential.user!.uid.isNotEmpty){
        Navigator.pushReplacementNamed(context, "/home");
      }

    } on FirebaseAuthException catch(e){
      print("Something Went Wrong"+e.message.toString());
      print("Error Code:"+e.code.toString());
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:showLoader ? Center(child: CircularProgressIndicator(),) :Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/account.png", width: 64,height:64),
            const SizedBox(height: 12,),
            const Text("Register", style: TextStyle(color: Colors.amber, fontSize: 24),),
            const SizedBox(height: 6,),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: nameController,
              decoration: const InputDecoration(
                  labelText: "Enter Full Name",
              ),
            ),
            const SizedBox(height: 6,),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              decoration: const InputDecoration(
                  labelText: "Enter Email ID",
              ),
            ),
            const SizedBox(height: 6,),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                  labelText: "Enter Password",
              ),
            ),
            const SizedBox(height: 6,),
            OutlinedButton(onPressed:(){
              setState(() {
                showLoader = true;
                registerUser();
              });

            }, child: const Text("REGISTER")),
            const SizedBox(height: 12,),
            InkWell(
              child: Text("Existing User? Login Here"),
              onTap:(){
                Navigator.pushReplacementNamed(context, "/login");
              },
            )
          ],
        ),
      ),
    );
  }
}
