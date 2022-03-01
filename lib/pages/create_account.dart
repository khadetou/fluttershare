import 'package:flutter/material.dart';
import 'package:fluttershare/widgets/header.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final _formKey = GlobalKey<FormState>();
  late String username;

  submit() {
    _formKey.currentState!.save();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, title: "Set up your profile"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 25.0),
            child: Center(
              child:
                  Text("Create a username", style: TextStyle(fontSize: 25.0)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: TextFormField(
                onSaved: (val) => username = val!,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Username",
                    labelStyle: TextStyle(fontSize: 15.0),
                    hintText: "Must be at least 3 characters"),
              ),
            ),
          ),
          GestureDetector(
            onTap: submit,
            child: Container(
              height: 50.0,
              width: 350.0,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(7.0)),
              child: const Center(
                child: Text(
                  "Submit",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
