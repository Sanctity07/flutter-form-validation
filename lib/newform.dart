import 'package:flutter/material.dart';

class Newform extends StatefulWidget {
  const Newform({super.key});

  @override
  State<Newform> createState() => _NewformState();
}

class _NewformState extends State<Newform> {
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
                FocusScope.of(context).unfocus();

                final isValid = _formKey.currentState!.validate();

                if (isValid) {
                  setState(() {
                    errorMessaege = "";
                    name = nameController.text;
                    email = emailController.text;
                    password = passwordController.text;
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Saved successfully'),
                      backgroundColor: Colors.green[700],
                    ),
                  );
                } else {
                  // Build list of errors so user sees them in a SnackBar
                  final List<String> errors = [];
                  if (nameController.text.isEmpty) {
                    errors.add('Please add a name');
                  }

                  if (emailController.text.isEmpty) {
                    errors.add('Please add an email');
                  } else if (!RegExp(
                    r"^[^@]+@[^@]+\.[^@]+",
                  ).hasMatch(emailController.text)) {
                    errors.add('Please enter a valid email address');
                  }

                  if (passwordController.text.length < 6) {
                    errors.add('Password must be at least 6 characters long');
                  }

                  // Show errors in a SnackBar. Join with newlines so they are readable.
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(errors.join('\n')),
                      backgroundColor: Colors.red[700],
                      duration: Duration(seconds: 4),
                    ),
                  );
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
