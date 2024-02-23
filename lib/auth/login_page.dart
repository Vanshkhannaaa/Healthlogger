import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool showLoader = false;

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  void loginUser() async{
    print( "Email:"+emailController.text.trim());
    print("Password:"+passwordController.text.trim());

    try{
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text.trim());

      print("User Signed In Successfully:"+userCredential.user!.uid.toString());

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

      body:showLoader ? Center(child: CircularProgressIndicator(),) : Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/account.png", width: 64,height:64),
            const SizedBox(height: 12,),
            const Text("Login", style: TextStyle(color: Colors.amber, fontSize: 24),),
            const SizedBox(height: 6,),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Enter Email ID",
                // filled: true
              ),
            ),
            const SizedBox(height: 6,),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Enter Password",
                 // filled: true
              ),
            ),
            const SizedBox(height: 6,),
            OutlinedButton(onPressed:(){

              setState(() {
                showLoader = true;
                loginUser();
              });

              loginUser();
            }, child: const Text("LOGIN")),
            const SizedBox(height: 12,),
            InkWell(
              child: Text("New User? Register Here"),
              onTap:(){
                Navigator.pushReplacementNamed(context, "/register");
              },
            )
          ],
        ),
      ),
    );
  }
}
