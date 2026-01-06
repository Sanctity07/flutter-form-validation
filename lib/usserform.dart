import 'package:flutter/material.dart';

class Usserform extends StatefulWidget {
  const Usserform({super.key});

  @override
  State<Usserform> createState() => _UsserformState();
}

class _UsserformState extends State<Usserform> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String errorMessaege = "";
  String name = "";
  String email = "";
  var password = "";

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please add a name";
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please add an email";
                }
                if (!RegExp(r"^[^@]+@[^@]+\.[^@]+").hasMatch(value)) {
                  return "Please enter a valid email address";
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.password),
              ),
              validator: (value) {
                if (value == null || value.length < 6) {
                  return "Password must be at least 6 character long";
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    errorMessaege = "";
                    name = nameController.text;
                    email = emailController.text;
                    password = passwordController.text;
                  });
                } else {
                  errorMessaege = "Please fill all the fields";
                }
              },
              child: Text("Save Data"),
            ),

            SizedBox(height: 20),
            Text("Name : $name "),
            SizedBox(height: 20),
            Text("Email: $email "),
            SizedBox(height: 20),
            Text("Password: $password"),
            if (errorMessaege.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(errorMessaege, style: TextStyle(color: Colors.red)),
              ),
          ],
        ),
      ),
    );
  }
}
