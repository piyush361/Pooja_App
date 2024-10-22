import 'package:flutter/material.dart';

class Poojafilter extends StatefulWidget
{
  const Poojafilter({super.key});
  @override
  State<Poojafilter> createState() {
    // TODO: implement createState
     return _Poojafilterstate();
  }
}

class _Poojafilterstate extends State<Poojafilter> 
{

  var f1=false;
  var f2=false;
  var f3=false;
   @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: const Text("FILTERS",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
        backgroundColor: const Color.fromARGB(255, 5, 5, 5),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration:const  BoxDecoration(
            gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 8, 8, 8),
              Color.fromARGB(255, 39, 38, 38)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            tileMode: TileMode.clamp,
          ),
        ),
       child:  Padding(
         padding: const EdgeInsets.all(15.0),
         child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
             SwitchListTile(value: f1, onChanged: (ischeck){
               f1=true;
             },
             title: const Text("filter 1",style: TextStyle(fontSize: 30,color: Colors.white),),
             subtitle: const Text("dkfgfkgdvbfsngbv"),
             activeColor: Colors.green,
             ),
              SwitchListTile(value: f2, onChanged: (ischeck){f2=true;},
             title: const Text("filter 3",style: TextStyle(fontSize: 30,color: Colors.white)),
             subtitle: const Text("dkfgfkgdvbfsngbv"),
             activeColor: Colors.green,
             ),
              SwitchListTile(value: f3, onChanged: (ischeck){f3=true;},
             title: const Text("filter 3",style: TextStyle(fontSize: 30,color: Colors.white)),
             subtitle: const Text("dkfgfkgdvbfsngbv"),
             activeColor: Colors.green,
             ),
         
          ],
         ),
       ), 
      ),
     );
  }   
}

     
    
  
