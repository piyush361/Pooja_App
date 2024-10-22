import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Mapscreen extends StatefulWidget
{
    Mapscreen({super.key,this.lt=32.344,this.lng=54.433,this.isSelecting=true});

   double lt;
   double lng;
   bool isSelecting;

   @override
  State<Mapscreen> createState() {
    return _Mapscreenstate();
  }
}

class _Mapscreenstate extends State<Mapscreen>
{

   LatLng? picked;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isSelecting ? "Select the location" : "your location " ,style: const TextStyle(color: Colors.white),),
        backgroundColor: const Color.fromARGB(255, 2, 58, 95),
        actions: [
          if(widget.isSelecting)
          IconButton(onPressed: () {
            Navigator.of(context).pop(picked);
          }, 
          icon: const Icon(Icons.save,color: Colors.white,)
          )
        ],
      ),
     body: GoogleMap(
      onTap:!widget.isSelecting ? null : (position)
      {
        setState(() {
              picked=position;

        });
      },
      initialCameraPosition: CameraPosition(target: LatLng(
        widget.lt,
         widget.lng
         ),
        zoom: 18 
         ),
        markers: (picked==null && widget.isSelecting) ? {}: {
          Marker(
            markerId: const MarkerId("M1"),
            position: picked ?? LatLng(widget.lt, widget.lng) 
            )
        }, 
     ), 
    );
  }
}