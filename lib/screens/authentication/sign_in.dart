import 'package:flutter/material.dart';
import 'package:umddating/services/auth.dart';

class SignIn extends StatefulWidget {
 // const SignIn({Key? key}) : super(key: key);
  final Function toggleView;
  SignIn({required this.toggleView});
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final formKey = GlobalKey<FormState>();
  String error = '';
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white70,
        appBar: AppBar(
          title: Text("UMD Dating App"),
          centerTitle: true,
          backgroundColor: Colors.red,
          actions: [
            TextButton.icon(
                onPressed: (){
                  widget.toggleView();
                },
                icon: Icon(Icons.person),
                label: Text("Register"),
            )
          ],
        ),
        body:Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(height: 20),
                TextFormField(
                  validator: (val) {
                    if(val!.isEmpty) {
                      return "Enter an email address";
                    }
                    if(!val.endsWith("umd.edu")) {
                      return "Email address must be a UMD email address.";
                    }
                    return null;

                  },
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  validator: (val) => val!.length < 6 ? 'Enter a password with more than 6 characters' : null,
                  obscureText: true,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () async {

                    },
                    child:ElevatedButton.icon(
                       onPressed: () async {
                         if(formKey.currentState!.validate()) {
                           dynamic result = await _auth.signIn(email, password);
                           if(result == null) {
                             setState(() => error = 'Could not sign in with those credentials');
                           }
                         }
                       },
                        icon: Icon(
                            Icons.account_circle
                        ),
                        label: Text("LOGIN"),
                      // style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                    )

                ),

              ],
            ),
          ),
          /*ElevatedButton(
              onPressed: () {
              },
              child:ElevatedButton.icon(
                  onPressed: () {

                  },
                  icon: Icon(
                      Icons.account_circle
                  ),
                  label: Text("LOGIN")
                // style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
              )

          ),*/

            /*ElevatedButton(
            onPressed: () {  },
            icon: Icon(
              Icons.
            )

          )*/


        )
    );

  }
}
