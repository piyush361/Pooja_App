import 'package:abc/providers/pandit.dart';
import 'package:abc/screens/tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:abc/models/category.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'package:panara_dialogs/panara_dialogs.dart';



class Assign extends ConsumerStatefulWidget
{

 
    Assign({super.key,required this.pja,required this.cost,required this.time,required this.p,required this.t,required this.x,required this.name,required this.ph,required this.v,required this.b});

 String pja;
 String time;
 double cost;
  Pandit? p;
  final String t;
  String? name;
  String? ph; 
  Map<String,double> x;
double? v;
double? b;
  @override
  ConsumerState<Assign> createState() {
    // TODO: implement createState
    return _Assignstate();
  }


}

class _Assignstate extends ConsumerState<Assign>
{

  
late Future<List<Pandit>> list;
  bool _hasCallSupport = false;
  @override
  void initState() {
    super.initState();
    list = ref.read(panditProvider.notifier).load();
    canLaunchUrl(Uri(scheme: 'tel', path: '123')).then((bool result) {
      setState(() {
        _hasCallSupport = result;
      });
    });
    
  }


   Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

Set<Polyline> _createPolylines() {
    Set<Polyline> polylines = {};
    List<LatLng> polylineCoordinates = [
       LatLng(widget.v!,widget.b!), 
       LatLng(widget.x['lat']!,widget.x['long']!), 
    ];

    Polyline polyline = Polyline(
      polylineId: const PolylineId('route1'),
      color: Colors.blue,
      points: polylineCoordinates,
      width: 2,
      patterns: const [PatternItem.dot],
    );

    polylines.add(polyline);

    return polylines;
  }
  
  Future<void>? _launched;

  @override
  Widget build(BuildContext context) {
    final h= ref.watch(panditProvider);
   void x() async
   {
        //final c=await ref.read(panditProvider.notifier).load();
        // print(widget.p!.isAssigned);
        await ref.read(panditProvider.notifier).deassignPanditByPhone(widget.ph!);
       
   }

void sendSMS(String phoneNumber, String message) async {
  final encodedMessage = Uri.encodeComponent(message);
  final uri = 'sms:$phoneNumber?body=$encodedMessage';

  if (await canLaunch(uri)) {
    await launch(uri);
  } else {
    throw 'Could not launch $uri';
  }
}


void check() {
  
  bool c = true;
  bool y=false;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              // height: 100,
              // width: 300,
             // decoration: BoxDecoration(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                    const Text('Confirm The Following checks',style: TextStyle(color: Colors.black,fontSize: 18),)
                  ,CheckboxListTile(
                    key: const Key('p1'),
                    title: const Text('Have you completed the Pooja?'),
                    value: c,
                    onChanged: (bool? value) {
                      setState(() {
                        c = value!;
                      });
                    },
                    secondary: const Icon(Icons.hourglass_empty),
                  ),
                  CheckboxListTile(
                    key: const Key('p2'),
                    title: const Text('Have you paid the Pandit?'),
                    value: y,
                    onChanged: (bool? value) {
                      setState(() {
                        y = value!;
                      });
                    },
                    secondary: const Icon(Icons.hourglass_empty),
                  ),
                  const SizedBox(height: 40,),
                  ElevatedButton(onPressed: (){
                   if(c &y)
                   {
                    // var g = ord(pj: widget.pja, pand: widget.name!, date: widget.t!);
                    // ref.read(OrdProvider.notifier).added(g);
                    Navigator.of(context).push(MaterialPageRoute(builder: (ctx)
                    {
                      return const tabs();
                    }));
                   } 
                   else{
                   ScaffoldMessenger.of(context).clearSnackBars();
                   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("all checks are not selected",),duration: Duration(seconds: 2),));
                   }
                    
                  }, 
                  child: const Text("DONE"))
                ],
              ),
            );
          },
        ),
      );
    },
  );
}

void show() {
  PanaraInfoDialog.show(
    context,
    title: "Are you Sure?",
    message: "Is Your Pooja finished?",
    buttonText: "Yes",
    onTapDismiss: () {
      check();    
    },
    panaraDialogType: PanaraDialogType.normal,
    barrierDismissible: false,
  );
}

 void y(String b) async{
   await ref.read(panditProvider.notifier).assignPanditByPhone(b);
 }
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [ Colors.white,Color.fromARGB(255, 245, 245, 244)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
          )
        ),
        child: FutureBuilder<List<Pandit>>(
          future: list,
          builder: (context, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? const Center(child: CircularProgressIndicator())
              : 
           SingleChildScrollView(
             child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(color : Colors.green,
                width: double.infinity,
                height: 180,
               child: Column(
                mainAxisSize: MainAxisSize.min,
               children: [
                const SizedBox(height: 100,),
                const Text("Your Appointment",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22,wordSpacing: 10),textAlign: TextAlign.center,),
                const SizedBox(height: 5,),
                Text(" Scheduled on ${widget.t}",style: const TextStyle(color: Colors.white,fontSize: 17,),textAlign: TextAlign.center,)
               ],),),
               
                Container(
                  margin: const EdgeInsets.symmetric(vertical:0,horizontal: 0),
                  height: 250,
                  width: double.infinity,
                  child:
                  //Image.network(loc,fit: BoxFit.fill,)
                   GoogleMap(
                    initialCameraPosition:   CameraPosition(target: LatLng(widget.v!,widget.b!),
                    zoom: 14
                    ),
                   markers: {
                      Marker(
                      markerId: const MarkerId('sd'),
                      position: LatLng(widget.v!,widget.b!)
                      ),
                      Marker(
                      markerId: const MarkerId('f'),
                      position: LatLng(widget.x['lat']!,widget.x['long']!)
                      ),
                      
                   },
                   polylines: _createPolylines()
                  )
                ),
                const SizedBox(height: 4,),
                Card(
                  margin: const EdgeInsets.symmetric(vertical: 0.4,horizontal: 2),
                  color: Colors.white,
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                       SizedBox(
                        width: 100,
                        child: Image.asset('lib/assets/2.jpeg',fit: BoxFit.fill,),
                       ),
                       const SizedBox(width: 30,),
                         Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(widget.name!,style: const TextStyle(color: Colors.black,fontSize: 17,fontWeight: FontWeight.bold),),
                          const SizedBox(height: 15,),
                          const SizedBox(width: 220,child: Text("A pandit is a term originating from Sanskrit, traditionally referring to a learned scholar or teacher, particularly in the fields of Hindu law, philosophy, music, and the Sanskrit language",style: TextStyle(color: Colors.black,fontSize: 13),)),
                          const SizedBox(height: 30,),
                            Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                 InkWell(
      // onTap: _hasCallSupport
      //     ? () {
      //         final future = _makePhoneCall(widget.ph!);
      //         setState(() {
      //           _launched = future;
      //         });
      //       }:null
      onTap: x

          , child: const Icon(Icons.call_end_outlined,size: 30,)),
                              const SizedBox(width: 60,),
                              InkWell(onTap: (){
                                sendSMS('9860587322', "hello");
                              },child: const Icon(Icons.message,size: 30,)
                              )
                            ],
                          )
                        ],
                       )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Your Appointment Summary",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,fontSize: 20),),
                    const SizedBox(height: 20,),
                    Row(
                      children: [
                                          const SizedBox(width: 10,),
             
                       const Text("Pooja",style: TextStyle(fontSize: 16),),
                      const SizedBox(width: 200,),
                      Text(widget.pja,maxLines: 1,)
                      ]
                    ),
                   // SizedBox(height: 20,),
                    const Text("--------------------------------------------------------",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                    Row(
                      
                      children: [
                                          const SizedBox(width: 10,),
                       const Text("Cost ",style: TextStyle(fontSize: 16),),
                      const SizedBox(width: 230,),
                      Text("${widget.cost}")
                      ]
                    ),
                   // SizedBox(height: 20,),
                                      const Text("--------------------------------------------------------",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                    Row(
                      children: [
                                          const SizedBox(width: 10,),
             
                       const Text("Avg time"),
                      const SizedBox(width: 210,),
                      Text(widget.time)
                      ]
                    ),
                                                                             const Text("--------------------------------------------",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),   
                   
                  ],),
                //TextButton(onPressed: (){}, child: Text("End POOJA"))
                const SizedBox(height: 5,),
                Row(
                  children: [
                                      const SizedBox(width: 6,),
             
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                      decoration: BoxDecoration(
                                            color: const Color.fromARGB(255, 2, 2, 2),
             
                        borderRadius: BorderRadius.circular(6),
                      ),
                      height: 57,
                      //width: double.infinity,
                      child: const Text("CANCEL APPOINTMENT",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w500),),
                    
                    ),
                    const SizedBox(width: 53,),
                    InkWell(
                      onTap: (){
                         show();
                      },
                      child: Container(
                         padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 15),
                        //borderRadius: BorderRadius.circular(10),
                        decoration: BoxDecoration(
                                              color: const Color.fromARGB(255, 10, 9, 9),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        height: 57,
                        //width: double.infinity,
                        child: const Text("END POOJA",style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w500),),
                      
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5,)
              ],
                       ),
           ),
        ),
      ),
    );
  }
}