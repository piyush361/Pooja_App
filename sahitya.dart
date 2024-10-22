import 'package:abc/widgets/materialss.dart';
import 'package:flutter/material.dart';
import 'package:abc/models/category.dart';

class Sahitya extends StatelessWidget
{
   Sahitya({super.key});


 List<M> d=mlist;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 14, 13, 13),
              Color.fromARGB(255, 75, 71, 71)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            tileMode: TileMode.clamp,
          ),
        ),
        // height: double.infinity,
        // width: double.infinity,
        child: Column(
          //mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 58,),
            const SizedBox(
              height: 70,
              width: 300,
              child: Text("Here are the Material Lists For Poojas!",style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),)),
            //const SizedBox(height: 14,),
            Expanded(child: Materialss(t: d)),
          ],
        )
      ),
    );
  }
}