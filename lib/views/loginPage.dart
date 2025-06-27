import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final email = TextEditingController();
    final pass =  TextEditingController();
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        backgroundColor: Colors.yellow,
          title: Text('Login'),
      ),
      body: SizedBox(
        child: Stack(
          children: [

            Positioned(
              top: 100,
              left: 90,
              child: Text('Welcome!',
                style: GoogleFonts.anton(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
            ),

            Positioned(
              top: 300,
              child: Container(
                width: 410,
                  height: 600,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(50)
                  ),
                child: Stack(
                  children: [
                    Positioned(
                        right: 50,
                        left: 50,
                        top: 100,
                        child: TextField(
                          controller: email,
                              decoration: InputDecoration(
                                hintText: 'Username',
                                // errorText: 'enter valid username',
                              ),
                        )
                    ),
                    Positioned(
                        right: 50,
                        left: 50,
                        top: 170,
                        child: TextField(
                          controller: pass,
                          decoration: InputDecoration(
                            hintText: 'Password',
                          ),
                        )
                    ),
                    Positioned(
                        right: 50,
                        left: 50,
                        top: 245,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange
                          ),
                            onPressed: ()async{
                            login(email.text,pass.text);
                        }, child: Text(
                            "Login",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.yellow[200]
                          ),
                        )),
                    ),
                    Positioned(
                      top: 310,
                      left: 60, // replaces `indent`
                      right: 220, // replaces `endIndent`
                      child: Container(
                        height: 2, // replaces `thickness`
                        color: Colors.black,
                      ),
                    ),
                    Positioned(
                        right: 20,
                        left: 200,
                        top:301 ,
                        child: Text('or')
                    ),
                    Positioned(
                      top: 310,
                      left: 220, // replaces `indent`
                      right: 62, // replaces `endIndent`
                      child: Container(
                        height: 2, // replaces `thickness`
                        color: Colors.black,
                      ),
                    ),
                    Positioned(
                        right: 230,
                        left: 50,
                        top:340 ,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange
                          ),
                            onPressed: (){
                        },
                            child:Text('Google',
                            style: TextStyle(
                              color: Colors.yellow[200]
                            ),
                            ) )
                    ),
                    Positioned(
                        right: 50,
                        left: 230,
                        top:340 ,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange
                            ),
                            onPressed: (){
                        },
                            child:Text('Facebook',
                              style: TextStyle(
                                  color: Colors.yellow[200]
                              ),
                            ) )
                    ),


                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void login(String email, String pass)async{
    try{
      final val = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);
      print(val.credential);
    }on FirebaseException catch(e){
      print(e.message);
    }
  }
}
