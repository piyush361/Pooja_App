import 'package:abc/providers/puja.dart';
import 'package:abc/screens/tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:abc/widgets/panditreg.dart';

final base = FirebaseAuth.instance;

class Authscreen extends ConsumerStatefulWidget{

const Authscreen({super.key});
@override
  ConsumerState<ConsumerStatefulWidget> createState() {
    // TODO: implement createState
    return _Authscreenstate();
  }

}

class _Authscreenstate extends ConsumerState<Authscreen>
{
var isLogin=true;
final form = GlobalKey<FormState>();
var mail='';
var pass='';
 void submit() async {
    final isValid = form.currentState!.validate();
    if (isValid) {
      form.currentState!.save();
    }
    try {
      if (isLogin) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: mail,
          password: pass,
        );
      } else {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: mail,
          password: pass,
        );
      }
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const tabs()),
        (route) => false,
      );
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.message ?? "Authentication failed")),
      );
    }
 }
@override
  Widget build(BuildContext context) {

  

  void go(BuildContext context)
{
  Navigator.of(context).push(MaterialPageRoute(builder: (ctx) 
  {
    return  const tabs();
  }
   )
  );
}

void qq() async
{
  await ref.read(pujaProvider.notifier).updateImageByName("Satya Narayana Pooja",'lib/assets/front.jpeg' );
}
final c=Stack(
          children: [
            Image.asset('lib/assets/u2.png',fit: BoxFit.fill,width: 420,height: 950,)
            ,Column(
      children: [
        const SizedBox(height: 40,),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Card(
            color: Colors.white.withAlpha(123),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Form(
                key: form,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("USER REGISTRATION ",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),),
                    const SizedBox(height: 20,),
                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text("Name"),
                        icon: Icon(Icons.face_4)
                      ),                  
                    ),
                                      const SizedBox(height: 20,),
                    TextFormField(
                      
                      obscureText: false,
                      decoration: const InputDecoration(
                        label: Text("Email"),
                        icon:  Icon(Icons.app_registration),
                      ), 
                      validator: (value)
                      {
                        if(value==null || value.trim().isEmpty || !value.contains('@'))
                        {
                           return "PLease enter valid email address";
                        }
                        return null;
                      },
                      onSaved: (value)
                      {
                        mail=value!;
                      },                 
                    ), 
                                     const SizedBox(height: 20,),
                    TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        label:  Text("password"),
                        icon: Icon(Icons.lock)
                      ), 
                     validator: (value)
                     
                      {
                        if(value==null || value.trim().length<6)
                        {
                           return "password must  be atleast 6 chars";
                        }
                        return null;
                      },  
                     onSaved: (value)
                     {
                      pass=value!;
                     },
                    ),
                    const SizedBox(height: 60,),
                    ElevatedButton(
                    onPressed: ()
                    {
                      submit();
                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Signed in Succesfully")));
                    },
                                      style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(const Color.fromARGB(255, 14, 14, 15)),
                      
                    ),
                    child: const Text("Sign up ",style: TextStyle(color: Colors.white),),
                    ),
                    TextButton(
                    onPressed: 
                      (){
                      setState(() {
                        isLogin=!isLogin;
                      });
                      }
                    ,
                    child: const Text("i am not a new user",style: TextStyle(color: Color.fromARGB(255, 243, 231, 231),fontSize: 12),),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    )],);
 
 

    return   Scaffold(
   body : Container(
    height: double.infinity,
    width: double.infinity,
      decoration : const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.red,Colors.deepOrange],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )
      ),
      child:Stack(
        children: [(Image.asset('lib/assets/a.jpg',height: 1000,width: 1000,fit: BoxFit.fill,)),
         Container(
    height: double.infinity,
    width: double.infinity,
      decoration :  BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color.fromARGB(255, 7, 7, 7).withOpacity(0.2),const Color.fromARGB(255, 7, 7, 6).withOpacity(0.3)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )
      ),)
        ,SingleChildScrollView(child:!isLogin ? c :Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 160),
            //  SizedBox(
            //   height: 150,
            //   width: 150,
            //   child: Image.asset('lib/assets/1.jpeg',),),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Card(
                color: const Color.fromARGB(255, 235, 222, 222).withAlpha(100),
                elevation: 20,
                borderOnForeground: true,
                margin: const EdgeInsets.all(30),
                child:Padding( 
                  padding: const EdgeInsets.all(9),
                  
                  child: Form(
                    key: form,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                         const SizedBox(height: 5,),
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: const Color.fromARGB(255, 194, 11, 5),
                           child: Image.asset('lib/assets/1.jpeg',height: 100,width: 80,),
                    
                         ),
                         Padding(
                           padding: const EdgeInsets.all(10.0),
                           child: TextFormField(
                            decoration: const InputDecoration(
                              label: Text("Email",style: TextStyle(fontSize: 14,color: Colors.white),),
                            ),
                           keyboardType: TextInputType.text,
                           maxLength: 20,
                           validator: (value)
                          {
                            if(value==null || value.trim().isEmpty || !value.contains('@'))
                            {
                               return "Please enter valid email address";
                            }
                            return null;
                          },
                          onSaved: (value)
                          {
                            mail=value!;
                          }, 
                                             ),
                         ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                            decoration: const InputDecoration(
                              label: Text("Password",style: TextStyle(fontSize: 14,color: Colors.white),),
                            ),
                           keyboardType: TextInputType.text,
                           maxLength: 10,
                           obscureText: true,
                           validator: (value)
                         
                          {
                            if(value==null || value.trim().length<6)
                            {
                               return "password must  be atleast 6 chars";
                            }
                            return null;
                          },  
                         onSaved: (value)
                         {
                          pass=value!;
                         },
                          ),
                      ),
                      const SizedBox(height: 5,),
                      ElevatedButton(
                      onPressed: submit,
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(const Color.fromARGB(255, 14, 14, 15)),
                          
                      ),
                      child: const Text("Log in",style: TextStyle(color: Colors.white),),
                      ),
                      TextButton(
                      onPressed: 
                        (){
                        setState(() {
                          isLogin=!isLogin;
                        });
                        //sq();
                        }
                      ,
                      child: const Text("I am a new user.",style: TextStyle(color: Colors.grey,fontSize: 12),),
                      )
                      ],                  
                    ),
                  ),
                ),
              ),
              ) ,
              InkWell(
                onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx)
                    {
                      return const Panditreg();
                    }),);
        //qq();
              }, 
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                  height: 50,
                  width: 250,
                         decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          gradient: const LinearGradient(colors:[Color.fromARGB(255, 238, 227, 226),Colors.white],
                          begin: Alignment.bottomLeft,
                          end:Alignment.topLeft,
                         
                          )
                         ),
                
                          child: const Text("REGISTER AS PANDIT",style: TextStyle(color: Color.fromARGB(255, 5, 5, 5),fontSize: 18,fontWeight: FontWeight.bold),)
                  ),
              )   
          ] 
        
        
        ),
        ),]
      )
   )
  ); 
  }

}