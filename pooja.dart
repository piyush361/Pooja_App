import 'package:abc/models/category.dart';
import 'package:abc/providers/loc.dart';
import 'package:abc/screens/auth.dart';
import 'package:abc/screens/mapscreen.dart';
import 'package:abc/widgets/catitem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

import 'dart:convert';

class Pooja extends ConsumerStatefulWidget {
  const Pooja({super.key});
  @override
  ConsumerState<Pooja> createState() {
    return _PoojaState();
  }
}

class _PoojaState extends ConsumerState<Pooja> {
  String? select = '';
  double? latt;
  double? long;

  @override
  void initState() {
    super.initState();
    getloc();
  }

  Future<void> save(double l,double g)
  async {
    final url = Uri.parse(
          'https://maps.googleapis.com/maps/api/geocode/json?latlng=$l,$g&key=AIzaSyDN2OZYV8MPCBvFk6MxwjJYysc88r5nK7E');

      final resp = await http.get(url);
      if (resp.statusCode == 200) {
        final resdata = json.decode(resp.body);
        final address = resdata['results'][0]['formatted_address'];

        setState(() {
          select = address;
          latt = l;
          long = g;
        });
              //ref.read(panditProvider.notifier).zz(latt!, long!);
      }
  }

  

  void selectloc()
  async  {
    final ploc = await Navigator.of(context).push<LatLng>(MaterialPageRoute(builder: (ctx)
            {
                return Mapscreen(lt: latt!,lng: long!,);
            }
       )
    );
    if(ploc==null)
    {
      return;
    }

    save(ploc.latitude,ploc.longitude);
    
  }



  void getloc() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();
    final lat = locationData.latitude;
    final lng = locationData.longitude;

    
    if (lat == null && lng == null) {
      return;
    } 
          ref.read(coordinatesProvider.notifier).setCoordinates(lat!, lng!);

    save(lat, lng);
  }

  

  

  var content = const CircularProgressIndicator();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Color.fromARGB(255, 240, 236, 235),
              Color.fromARGB(255, 245, 236, 236)
            ],
            // begin: Alignment.topLeft,
            // end: Alignment.bottomRight,
            radius: 29,
            tileMode: TileMode.mirror,
          ),
        ),
        alignment: Alignment.center,
        child: (select == '')
            ? content
            : 
                 Stack(
                   children: [
                    //Image.asset('lib/assets/b3.jpg',fit: BoxFit.fill,width: 900,height: 900,),
                   Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                   
                      //const SizedBox(height: 14),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 0),
                        width: double.infinity,
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient:  LinearGradient(
                            colors: [const Color.fromARGB(255, 134, 128, 136).withOpacity(0.5),const Color.fromARGB(255, 209, 218, 88).withOpacity(0.5)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter
                          )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                                      
                            IconButton(
                              onPressed: () {
                                selectloc();
                              },
                              icon: const Icon(Icons.location_on),
                              color: Colors.red,
                              iconSize: 36,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              select!.substring(0, 30),
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 238, 238, 240)
                              ),
                            ),
                            const SizedBox(width: 30,),
                            IconButton(onPressed: (){
                              //FirebaseAuth.instance.signOut();
                               FirebaseAuth.instance.signOut().then((_) {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Authscreen(),
                                    ),
                                    (route) => false,
                                  );
                                });
                            }, 
                            icon: const Icon(Icons.save)
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Container(
                          height: 210,
                          width: 450,
                          padding: const EdgeInsets.all(2),
                          child:  InkWell(
                            onTap: () {},
                            child:   Card(
                              color: const Color.fromARGB(255, 231, 90, 25),
                                                  
                              margin: const EdgeInsets.all(0),
                              elevation: 15,
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(13),
                                    child: Image.asset('lib/assets/welc.jpg',fit: BoxFit.fill,width: 470,height: 208,)
                                    ),
                                    const SizedBox(
                                  child: Column(
                                    children: [
                                      SizedBox(height: 160,),
                                      Row(
                                        children: [
                                          SizedBox(width: 20,),
                                          Text(
                                            "Namaste",
                                            style:
                                                TextStyle(fontSize: 25, color: Colors.white,fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),]
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      // Provide a height for the GridView
                      Row(
                        children: [
                          const SizedBox(width:40,),
                          CircleAvatar(radius: 40,child: ClipRRect(clipBehavior: Clip.hardEdge,borderRadius: BorderRadius.circular(40),child: Image.asset('lib/assets/1.jpeg')),),//backgroundColor: const Color.fromARGB(255, 8, 3, 3),),
                                                  const SizedBox(width:40,),
                   
                          CircleAvatar(radius: 40,child: ClipRRect(clipBehavior: Clip.hardEdge,borderRadius: BorderRadius.circular(40),child: Image.asset('lib/assets/1.jpeg')),),//backgroundColor: const Color.fromARGB(255, 8, 3, 3),),
                                                  const SizedBox(width:40,),
                   
                          CircleAvatar(radius: 40,child: ClipRRect(clipBehavior: Clip.hardEdge,borderRadius: BorderRadius.circular(40),child: Image.asset('lib/assets/1.jpeg',semanticLabel: "GGG",),),),//backgroundColor: const Color.fromARGB(255, 8, 3, 3),)
                        ],
                      ),
                      SingleChildScrollView(child:Container(
                        //padding: const EdgeInsets.fromLTRB(15,0,15,0),
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 0),
                        height: 368, // Adjust height as needed
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.9,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: poojacat.length,
                          itemBuilder: (context, index) {
                            final t = poojacat[index];
                            return catitem(ct: t);
                          },
                        ),
                      ),
                      ),
                     
                    ],
                                                   ),]
                 ),
              
      ),
    );
  }
}
