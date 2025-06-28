import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/providers/provider.dart';




//abdus05@gmail.com
//123456789
class signUp extends ConsumerWidget {
  const signUp({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final email_controller = TextEditingController();
    final pass_contorller = TextEditingController();
    final pass2 = TextEditingController();
    // final Registered=ref.watch(pageProvider.notifier).state;

    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text('Sign Up'),
      ),
      body: SizedBox(
        child: Stack(
          children: [
            Positioned(
              top: 100,
              left: 95,
              child: Text(
                'Register',
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
                    borderRadius: BorderRadius.circular(50)),
                child: Stack(
                  children: [
                    Positioned(
                        right: 50,
                        left: 50,
                        top: 50,
                        child: TextField(
                          controller: email_controller,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            // errorText: 'enter valid username',
                          ),
                        )),
                    Positioned(
                        right: 50,
                        left: 50,
                        top: 100,
                        child: TextField(
                          controller: pass_contorller,
                          decoration: InputDecoration(
                            hintText: 'Enter Password',
                          ),
                        )),
                    Positioned(
                        right: 50,
                        left: 50,
                        top: 150,
                        child: TextField(
                          controller: pass2,
                          decoration: InputDecoration(
                            hintText: ' Re-enter Password',
                          ),
                        )),
                    Positioned(
                      right: 50,
                      left: 50,
                      top: 245,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange),
                          onPressed: () async {

                            if(pass_contorller.text.trim()!=pass2.text.trim()) {
                              showDialog(context: context, builder: (context){
                                return AlertDialog(
                                  backgroundColor: Colors.yellow,
                                  actions: [
                                    TextButton(onPressed: (){
                                      Navigator.of(context).pop();
                                    }, child: Text('ok'))
                                  ],
                                  title: Text('Error'),
                                  content: Text('please enter same password'),
                                );
                              });
                            }
                              try{
                                await createUser(email_controller.text.trim(),
                                    pass_contorller.text.trim());
                                // email_controller.clear();
                                // pass_contorller.clear();
                                // pass2.clear();
                              }on FirebaseAuthException catch(e){
                                showDialog(context: context, builder: (context){
                                  return AlertDialog(
                                    backgroundColor: Colors.yellow,
                                    actions: [
                                      TextButton(onPressed: (){
                                        Navigator.of(context).pop();
                                      }, child: Text('ok'))
                                    ],
                                    title: Text('Error'),
                                    content: Text(e.message.toString()),
                                  );
                                });
                              }



                          },
                          child: Text(
                            "SignUp",
                            style: TextStyle(
                                fontSize: 20, color: Colors.yellow[200]),
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
                        right: 20, left: 200, top: 301, child: Text('or')),
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
                        top: 340,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange),
                            onPressed: () {},
                            child: Text(
                              'Google',
                              style: TextStyle(color: Colors.yellow[200]),
                            ))),
                    Positioned(
                        right: 50,
                        left: 230,
                        top: 340,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange),
                            onPressed: () {},
                            child: Text(
                              'Facebook',
                              style: TextStyle(color: Colors.yellow[200]),
                            )
                        )
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

  Future<void> createUser(email, pass) async {
    try {
      final user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: pass);
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }
}
