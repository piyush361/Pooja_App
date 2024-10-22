import 'package:abc/screens/pooja.dart';
import 'package:abc/screens/poojafilters.dart';
import 'package:abc/widgets/orders.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';
import 'package:flutter/material.dart';

class tabs extends StatefulWidget
{
  const tabs({super.key});

  @override
  State<tabs> createState() {
    return _tabsstate();
  }
}

class _tabsstate extends State<tabs>
{

  var selectedpage =0;
  var tname = 'Pooja';
  void selectpage(int index)
  {
    setState(() {
      selectedpage=index;
      tname='orders';
    });
  }

  void qq()
  {
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx)
    {
      return  const Poojafilter();
    }),
    );
  }
  @override
  Widget build(BuildContext context) {

    Widget active = const Pooja();
    if(selectedpage==1) 
  {
    active= const orders();
  }
  if(selectedpage==0)
  {
    tname='Pooja';
  }
//var selectedIndex=0;
 
    return Scaffold(
      // appBar: AppBar(
      //   // title:  Text(tname,style: const TextStyle(color: Color.fromARGB(255, 5, 3, 3),fontStyle: FontStyle.italic,fontWeight: FontWeight.w700),),
      //   // backgroundColor: Color.fromARGB(255, 243, 243, 248),
      //   actions: [IconButton(onPressed: (){
      //     FirebaseAuth.instance.signOut();        }, 
      //     icon: const Icon(Icons.exit_to_app_sharp,color: Color.fromARGB(255, 5, 4, 4),))],
      // ),
      body: active,
      bottomNavigationBar: Container(
        decoration: const  BoxDecoration(
               color: Color.fromARGB(0, 19, 16, 16),
              //borderRadius: BorderRadius.circular(18), // Adjust the border radius
              ),
            
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: SlidingClippedNavBar.colorful(
            fontSize: 18,
            backgroundColor: const Color.fromARGB(255, 230, 226, 226).withAlpha(54),
            barItems: [
               BarItem(
                      icon: Icons.holiday_village,
                      title: 'HOME',
                      activeColor: Colors.blue,
                      inactiveColor: Colors.orange,
                    ),
                    BarItem(
                      icon: Icons.search_rounded,
                      title: 'MY APPOINTMENTS',
                      activeColor: const Color.fromARGB(255, 60, 19, 207),
                      inactiveColor: Colors.green,
                    ),
            ]
          , selectedIndex: selectedpage, onButtonPressed: (int index){
            setState(() {
              selectedpage=index;
            });
          }
          ),
        ),
      ),

        
       

      
      drawer:  Drawer(
        backgroundColor: Colors.black,
        child: Column(
          children: [
            DrawerHeader(
            padding: const EdgeInsets.all(17),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors:[Color.fromARGB(255, 109, 21, 6),Color.fromARGB(255, 223, 57, 6)], 
                 begin: Alignment.topLeft,
                 end: Alignment.bottomRight
              )
            ),
            child: Row(
             children: [
              const  SizedBox(width: 2,),
               IconButton(onPressed: (){}, icon: const Icon(Icons.fireplace,color: Colors.white,),iconSize: 36,),
               const SizedBox(width: 2,),
               const Text("Chanting Mantras!",style: TextStyle(color: Color.fromARGB(255, 236, 228, 228),fontSize: 20,fontWeight: FontWeight.bold),)
             ],
            ) 
             ),
            ListTile(
            leading: const Icon(Icons.filter_1_outlined,color: Color.fromARGB(213, 235, 221, 221),),
            title: const Text("Filters",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: Colors.white)),
            onTap: qq
           )  
          ],
        ),
      ),
    );
  }  
}