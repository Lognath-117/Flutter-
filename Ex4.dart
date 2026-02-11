
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) =>
      const MaterialApp(debugShowCheckedModeBanner: false, home: LoginPage());
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  bool isAlphabet(String v) =>
      v.codeUnits.every((c) => (c >= 65 && c <= 90) || (c >= 97 && c <= 122));

  void loginCheck() {
    final u = userCtrl.text, p = passCtrl.text;
    if (u.isEmpty || p.isEmpty) {
      Fluttertoast.showToast(msg: "Please enter all fields");
      return;
    }
    if (!isAlphabet(u)) {
      Fluttertoast.showToast(
          msg: "Username must contain only alphabets",
          backgroundColor: Colors.red,
          textColor: Colors.white);
      return;
    }
    if (int.tryParse(p) == null) {
      Fluttertoast.showToast(
          msg: "Password must contain only numbers",
          backgroundColor: Colors.red,
          textColor: Colors.white);
      return;
    }
    Fluttertoast.showToast(
        msg: "Login Successful",
        backgroundColor: Colors.green,
        textColor: Colors.white);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Text("Login Page",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
          const SizedBox(height: 25),
          SizedBox(
              width: 280,
              child: TextField(
                  controller: userCtrl,
                  decoration: const InputDecoration(
                      labelText: "Username",
                      border: OutlineInputBorder()))),
          const SizedBox(height: 12),
          SizedBox(
              width: 280,
              child: TextField(
                  controller: passCtrl,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder()))),
          const SizedBox(height: 18),
          SizedBox(
              width: 280,
              child:
                  ElevatedButton(onPressed: loginCheck, child: const Text("Login")))
        ]),
      ),
    );
  }
}
