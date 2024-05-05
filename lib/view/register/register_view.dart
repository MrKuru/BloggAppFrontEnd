import 'package:blog_app/data/service/api_service.dart';
import 'package:blog_app/view/login/login_view.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xffB81736),
              Color(0xff281537),
            ]),
          ),
          child: const Padding(
            padding: EdgeInsets.only(top: 60.0, left: 22),
            child: Text(
              'Create Your\nAccount',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 180.0),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40)),
              color: Colors.white,
            ),
            height: double.infinity,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                        suffixIcon: Icon(
                          Icons.check,
                          color: Colors.grey,
                        ),
                        labelText: 'Name',
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xffB81736),
                        )),
                  ),
                  TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                        suffixIcon: Icon(
                          Icons.check,
                          color: Colors.grey,
                        ),
                        labelText: 'Username',
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xffB81736),
                        )),
                  ),
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                        suffixIcon: Icon(
                          Icons.check,
                          color: Colors.grey,
                        ),
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xffB81736),
                        )),
                  ),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                        suffixIcon: Icon(
                          Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xffB81736),
                        )),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    height: 55,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: const LinearGradient(colors: [
                        Color(0xffB81736),
                        Color(0xff281537),
                      ]),
                    ),
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          String username = _usernameController.text;
                          String email = _emailController.text;
                          String name = _nameController.text;
                          String password = _passwordController.text;
                          await ApiService.instance.register(
                            name: name,
                            username: username,
                            email: email,
                            password: password,
                          );
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginView()));
                        } catch (e) {
                          print('Login failed: $e');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        primary: Colors.transparent,
                        elevation: 0,
                      ),
                      child: const Center(
                        child: Text(
                          'SIGN UP',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          "Do you have an account?",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginView()));
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
