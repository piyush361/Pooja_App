import 'dart:async';
import 'package:abc/models/category.dart';
import 'package:abc/providers/pandit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:abc/screens/assign.dart';

final formatter = DateFormat().add_yMd();


class Confirmation extends ConsumerStatefulWidget
{
   Confirmation({super.key,required this.Pooja,required this.cost,required this.dt,required this.q,required this.n,required this.p,required this.c1,required this.c2});

  Map<String,double> q;
  String Pooja;
  double cost;
  String dt;
   String n;
   String p;
   double c1;
   double c2;
  @override
  ConsumerState<Confirmation> createState() {
    return _Confirmationstate();
  }

}

class _Confirmationstate extends ConsumerState<Confirmation>
{

late Future<List<Pandit>> list;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    list = ref.read(panditProvider.notifier).load();
  }  
//  void p() async
//   {
//     //await ref.read(panditProvider.notifier).assignPanditByPhone(widget.p);
//     Pandit? p=await ref.read(panditProvider.notifier).getPanditByPhone(widget.p);
//     //print(p!.name);
//     p.isAssigned=true;
//     //print(p.isAssigned);
//   }  


DateTime? picked;
  void datepicker() async
  {
    final now = DateTime.now(); 
    final first = DateTime(now.year,now.month,now.day+1);   
    final date = await showDatePicker(context: context, 
    initialDate: first,
    firstDate: now, 
    lastDate: DateTime(now.year,now.month+1,now.day),
    );
   
     setState(() {
       picked=date;
     });
 
  }

 
     
  

  @override
  Widget build(BuildContext context) {
     final f= ref.watch(panditProvider);
Pandit  j=Pandit(name: widget.n,phone: widget.p,lat: widget.c1,long: widget.c2,intro: "",isAssigned: false);



    return Scaffold(
      backgroundColor: Colors.black45,
     body: Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color.fromARGB(255, 250, 247, 245),Color.fromARGB(255, 243, 241, 240)],
          begin: Alignment.topCenter,
          end: Alignment.bottomRight 
        )
      ),
     child:  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 90+10+3,),
           const Column(
            mainAxisSize: MainAxisSize.min,
          children: [
            //SizedBox(width: 20,),
            Padding(
              padding: EdgeInsets.all(18.0),
              child: SizedBox(height:100,child: Text( "YOUR APPOINTMENT FOR POOJA !",style: TextStyle(fontSize: 27,color: Color.fromARGB(255, 14, 13, 13),fontWeight: FontWeight.bold),))//textAlign: TextAlign.left,)),
            ),
          ],
        ),
        const SizedBox(height: 15,),
         Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //SizedBox(width: 120,),
            const Row(
              children: [
                SizedBox(width: 10,),
                Text("NOTE",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                child: const Text("The charges calculated below are averaged out to provide a fair estimation for all users. This ensures that the rates reflect a balanced cost, considering various factors such as time, effort, and resources required. Please note that individual charges may vary slightly based on specific circumstances.",style: TextStyle(color: Colors.black,fontSize: 14),),
              ),
            ),
          ],
        ),
         
        const SizedBox(height: 10,),
       Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
             const Row(
              children: [
                SizedBox(width: 10,),
                Text("Select the date of appointment" ,style: TextStyle(color: Color.fromARGB(255, 5, 3, 3),fontSize: 20,fontWeight: FontWeight.bold),),
              ],
            ),
            const SizedBox(height: 3,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 20,),
                Text(picked == null ? 'no date selected' : formatter.format(picked!),style: const TextStyle(color: Color.fromARGB(255, 10, 9, 9),fontSize: 15),),
                const SizedBox(width: 170,),
                IconButton(onPressed: datepicker, icon: const Icon(Icons.calendar_month,size: 23,color: Color.fromARGB(255, 14, 10, 10),))
              ],
            ),
          ],
        ),
        Card(
          margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 3),
          color: const Color.fromARGB(255, 23, 226, 192),
          child: Padding(
            padding: const EdgeInsets.all(17.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                
                const SizedBox(height: 10,),
               const  Row(
                  children: [
                    Text('Material if any',style: TextStyle(color: Color.fromARGB(255, 22, 2, 114),fontSize: 15,fontWeight: FontWeight.bold),),
                    SizedBox(width: 210,),
                    Text('1',style: TextStyle(color: Color.fromARGB(255, 3, 1, 102),fontSize: 15,fontWeight: FontWeight.bold))
                  ],
                ),
                 const SizedBox(height: 10,),
                 Row(
                  children: [
                    const Text("Pandit travel charges",style: TextStyle(color: Color.fromARGB(255, 4, 2, 105),fontSize: 15,fontWeight: FontWeight.bold)),
                    const SizedBox(width: 100,),
                    IconButton(onPressed: (){},icon : const Icon(Icons.train_outlined)),
                    const Text("23",style: TextStyle(color: Color.fromARGB(255, 2, 4, 112),fontSize: 15,fontWeight: FontWeight.bold))
                  ],
                ),
                 const SizedBox(height: 10,),
                  Row(
                  children: [
                   const Text("Cost",style: TextStyle(color: Color.fromARGB(255, 16, 4, 124),fontSize: 15,fontWeight: FontWeight.bold)),
                    const SizedBox(width: 220),
                    IconButton(onPressed: (){},icon : const Icon(Icons.currency_rupee)),
                    //SizedBox(width: 3,),
                    const Text('4100',style: TextStyle(color: Color.fromARGB(255, 2, 12, 95),fontSize: 15,fontWeight: FontWeight.bold))
                  ],
                ),               const SizedBox(height: 8,),
               const Text('----------------------------------------------------',style: TextStyle(fontSize: 20,),) ,
                 const SizedBox(height: 8,),
                  const   Row(
                  children: [
                    Text("Total",style: TextStyle(color: Color.fromARGB(255, 68, 1, 65),fontSize: 15,fontWeight: FontWeight.bold)),
                    SizedBox(width: 240,),
                    Text('21.22',style: TextStyle(color: Color.fromARGB(255, 83, 1, 70),fontSize: 15,fontWeight: FontWeight.bold))
                  ],
                ),
                const SizedBox(height: 30,),
                Row(
                  children: [
                    const SizedBox(width: 10,),
                    InkWell(
                      onTap: (){
                        //print(widget.p);
                        //h();
                      },
                      splashColor: Colors.white,
                      child: Container(
                        padding: const EdgeInsets.all(17),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: Colors.black),
                      
                       // color: Colors.black,
                        child: const Text('CANCEL',style: TextStyle(color: Colors.white),),
                      ),
                    ),
                    const SizedBox(width: 80,),
                    InkWell(
                      onTap: (){
                       // print(widget.p);
                       // m();
                        //print(y);
                        // m(widget.p);
                        // ch();
                        // print(y);
                        //  h();
                        //  print(j!.name);
                        //print(widget.p);
                        //print(j!.name);
                        Navigator.of(context).push(MaterialPageRoute(builder: (ctx)
                        {
                          return  Assign(time: widget.dt,cost:widget.cost,pja :widget.Pooja,p: j,t: formatter.format(picked!),x: widget.q,name: widget.n,ph: widget.p,v: widget.c1,b: widget.c2);
                        }));

                      },
                      child: Container(
                        padding: const EdgeInsets.all(17),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: Colors.black),
                       // color: Colors.black,
                        child:  const Text('CHECK PANDITS',style: TextStyle(color: Colors.white),),
                      ),
                    ),

                  ],
                ) 
              ],
            ),
          ),
        )
      ],
     ), 
     ),
    );
  }
}
