import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  
  const SplashPage({Key? key}): super(key: key);

  navigateToLogin(BuildContext context) async{
    Future.delayed(Duration(seconds:3),(){
      // Navigator.pushNamed(context, "/login");
      Navigator.pushReplacementNamed(context, "/login");
    });
  }

  @override
  Widget build(BuildContext context) {

    navigateToLogin(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/healthlogger.png", width: 64,height:64),
            const SizedBox(height: 12,),
            const Text("Health Logger", style: TextStyle(color: Colors.amber, fontSize: 24)),
            const Divider(),
            const SizedBox(height: 6,),
            const Text("Log your Health Data for a better healthy life", style: TextStyle(color:Colors.blueGrey, fontSize: 18),),
          ],
        ),
      ),
    );
  }
}
