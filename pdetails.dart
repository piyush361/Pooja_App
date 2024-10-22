import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Pdetails extends ConsumerStatefulWidget {
  Pdetails({super.key, required this.t, required this.h, required this.z, required this.x});

  String? t;
  String? h;
  double? z;
  String? x;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _Pdetailsstate();
  }
}

class _Pdetailsstate extends ConsumerState<Pdetails> {
  //late Future<List<Pandit>> list;

  
  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      backgroundColor: Colors.black45,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.black26.withOpacity(0.5), Colors.black45.withOpacity(0.8)]
            )
        ),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60,),
              Row(
                children: [
                  const SizedBox(width: 20,),
                  Text(widget.t!, style: const TextStyle(color: Colors.white, fontSize: 18),),
                ],
              ),
              const SizedBox(height: 15,),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.all(18),
                child: Text(widget.h!, style: const TextStyle(color: Colors.white, fontSize: 14),),
              ),
              InkWell(
                onTap: () {
                 
                },
                child: Card(
                  elevation: 10,
                  margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            const Text('Pandit Dakshina',
                              style: TextStyle(color: Color.fromARGB(255, 206, 150, 150), fontSize: 16, fontWeight: FontWeight.bold),),
                            const SizedBox(width: 120,),
                            const Icon(Icons.currency_rupee, size: 19, color: Colors.green,),
                            Text('${widget.z}', style: const TextStyle(color: Color.fromARGB(255, 7, 7, 7), fontSize: 16,),)
                          ],),
                        const SizedBox(height: 10,),
                        const Row(
                          children: [
                            Text('Average Sahitya cost',
                              style: TextStyle(color: Color.fromARGB(255, 15, 14, 14), fontSize: 16, fontWeight: FontWeight.bold),),
                            SizedBox(width: 85,),
                            Icon(Icons.currency_rupee, size: 19, color: Colors.green,),
                            Text('42.33', style: TextStyle(color: Color.fromARGB(255, 3, 3, 3), fontSize: 16),)
                          ],),
                        const SizedBox(height: 10,),
                        Row(
                          children: [
                            const Text('Average time (hours)',
                              style: TextStyle(color: Color.fromARGB(255, 10, 9, 9), fontSize: 16, fontWeight: FontWeight.bold),),
                            const SizedBox(width: 60,),
                            const Icon(Icons.timer_sharp, size: 20, color: Colors.red,),
                            const SizedBox(width: 2,),
                            Text(widget.x!,
                              style: const TextStyle(color: Color.fromARGB(255, 7, 6, 6), fontSize: 16),)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                height: 290,
                width: double.infinity,
                child: Image.asset('lib/assets/1.jpeg', fit: BoxFit.fill, filterQuality: FilterQuality.medium,),
              )
            ],
          ),
        
      ),
    );
  }
}
