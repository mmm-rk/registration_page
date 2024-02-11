import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'St. John The Baptist Parish Church Register',
      home: RegisterPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RegisterPage extends StatefulWidget {
    const RegisterPage({super.key});
  
    @override
    State<RegisterPage> createState() => _RegisterPageState();
  }
  
  class _RegisterPageState extends State<RegisterPage> {
    bool showPassword = false;
    TextEditingController passController = TextEditingController();

    //Create a global key for the form validation
    final _formKey = GlobalKey<FormState>();

    @override
    Widget build(BuildContext context) {
      return Form(
          key: _formKey,
          child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.redAccent,
            foregroundColor: const Color.fromARGB(255, 255, 255, 255),
            title: const Text('Registration Page'),
          ),
          body: Center(
            child: Container(
              padding: const EdgeInsets.all(30.0),
              child: ListView(
                shrinkWrap: true,
                children: [
                  //Image.asset('assets/images/1.jpg'),
                  const Text('Create new account',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const Text('Made easier just for you, sign up now!',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),

                  const SizedBox(height: 80),

                  TextFormField(
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter name. Invalid Input!';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                    ),
                  ),
                  const SizedBox(height: 10),
            
                  TextFormField(
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Phone number. Invalid Input!';
                      }

                      // Check if the entered phone number is in a valid format
                      if (value.length != 11) {
                        return 'Please enter a valid Phone number.';
                      }

                      // Check if the entered phone number contains only numbers
                      if (!RegExp(r'^[0-9]*$').hasMatch(value)) {
                        return 'Please enter numerical value only.';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Phone Number',
                    ),
                  ),
                  const SizedBox(height: 10),

                  TextFormField(
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Email address. Invalid Input!';
                      }
                      
                      // Check if the entered email is in a valid format
                      if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$').hasMatch(value)) {
                        return 'Please enter a valid Email address.';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email Address',
                    ),
                  ),
                  const SizedBox(height: 10),

                  TextFormField(
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Password. Invalid Input!';
                      }
                      
                      // Check if the password is strong
                      if (!isStrongPassword(value)) {
                        return 'Please enter a strong password.';
                      }
                      passController.text = value;
                      return null;
                    },
                    obscureText: !showPassword,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          showPassword ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          },
                        ),
                    ),
                  ),
                  const SizedBox(height: 10),
            
                  TextFormField(
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please reenter Password. Invalid Input!';
                      }

                      // Compare the value with the password field
                      if (value != passController.text) {
                        return 'Passwords do not match.';
                      }
                      
                      return null;
                    },
                    obscureText: !showPassword,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Confirm password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          showPassword ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          },
                        ),
                    ),
                  ),
                  const SizedBox(height: 10),
            
                  ElevatedButton(
                    onPressed: (){
                      // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(
                          fontSize: 25,
                        ),
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20), // Adjust the padding values to make the box bigger
                      ),
                    child: const Text('Sign Up'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    bool isStrongPassword(String password) {
      // Check if the password has at least 8 characters
      if(password.length < 8) {
        return false;
      }

      // Check if the password contains at least one uppercase letter
      if(!password.contains(RegExp(r'[A-Z]'))) {
        return false;
      }

      // Check if the password contains at least one lowercase letter
      if(!password.contains(RegExp(r'[a-z]'))) {
        return false;
      }

      // Check if the password contains at least one digit
      if(!password.contains(RegExp(r'[0-9]'))) {
        return false;
      }

      // Check if the password contains at least one special character
      if(!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
        return false;
      }

      return true;
    }
}