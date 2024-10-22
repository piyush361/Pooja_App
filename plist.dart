import 'package:abc/models/category.dart';
import 'package:abc/widgets/pwidget.dart';
import 'package:flutter/material.dart';
import 'package:abc/providers/puja.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Plist extends ConsumerStatefulWidget
{
   Plist({required this.zz,required this.x,super.key});

 String zz;
 List<Puja> x;
 @override
  ConsumerState<Plist> createState() {
    return _Pliststate();
  }
}

class _Pliststate extends ConsumerState<Plist>
{
  late Future<void> list;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    list=ref.read(pujaProvider.notifier).load();
  }

  @override
  Widget build(BuildContext context) {
    final pujas = widget.x;

    return Scaffold(
     body: 
        Container(
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
        height: double.infinity,
        width: double.infinity,
        child:
            Column(
              children: [
                const SizedBox(height: 70,),
                const Row(
                  children: [
                    SizedBox(width: 40,),
                    Text("Pick your Pooja",style: TextStyle(color: Colors.white,fontSize: 30),),
                  ],
                ),
                Expanded(
                  child: FutureBuilder(
                    future: list, 
                    builder: (context,snapshot) =>
                    snapshot.connectionState ==ConnectionState.waiting 
                    ? const Center(child : CircularProgressIndicator()) 
                  : Pwidget(t: pujas), 
                            ),
                ),
              ],
            ), 
        ),
     
    );
     
  }
}
