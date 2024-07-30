import 'package:flutter/material.dart';
class Network_Widget extends StatelessWidget {



  const Network_Widget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset("assets/image/net.jpg",height: 120,width: 120,),
          ),
          const Text("You're offline!! please try again")
        ],
      ),
    );
  }
}
