import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../layout/user_layout_screen.dart';
import '../../shared/component/componant.dart';
import '../sign_up/sigup_screen.dart';

//mport 'dart:io' as device;

class LoginScreenModule extends StatefulWidget {
  const LoginScreenModule({super.key});

  @override
  State<LoginScreenModule> createState() => _LoginScreenModuleState();
}

final auth = FirebaseAuth.instance;
var formKey = GlobalKey<FormState>();
GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

var emailController = TextEditingController();
var passwordController = TextEditingController();
bool isPasswordShow = true;
bool isLoading = false;

class _LoginScreenModuleState extends State<LoginScreenModule> {
  //bool isWeb = !(device.Platform.isAndroid || device.Platform.isIOS );
  @override
  Widget build(BuildContext context) {
    Future<void> connect() async {
      //print(emailController.text);
      //final formstate = formKey.currentState;
      // setState(() {
      //   isLoading = true;
      // });
      if (formKey.currentState!.validate()) {
        //if (formstate!.validate()) {
        // formstate.save();
        String acssesLogin = 'تم نسجيل الدخول بنجاح';

        var snackBar = SnackBar(
          content: Text(
            acssesLogin,
            style: GoogleFonts.almarai(),
          ),
          backgroundColor: Colors.teal,
        );
        setState(() {
          isLoading = true;
        });
        try {
          await auth.signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const UserLayoutScreen(),
            ),
            (route) => false,
          );
          debugPrint(auth.currentUser!.email);
          debugPrint(auth.currentUser!.uid);
        } on FirebaseAuthException catch (e) {
          setState(() {
            isLoading = false;
          });
          if (e.code == 'user-not-found') {
            String failLogin = 'اسم المستخدم غير موجود';
            var snackBar = SnackBar(
              content: Text(
                failLogin,
                style: GoogleFonts.almarai(),
              ),
              backgroundColor: Colors.teal,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          if (e.code == 'wrong-password') {
            String failLogin = 'كلمه المرور غير صحيحه';
            var snackBar = SnackBar(
              content: Text(
                failLogin,
                style: GoogleFonts.almarai(),
              ),
              backgroundColor: Colors.teal,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          debugPrint(e.toString());
        }

        // try {
        //   User? user = FirebaseAuth.instance.currentUser;
        //   var kk = FirebaseFirestore.instance
        //       .collection('users')
        //       .doc(user!.uid)
        //       .get()
        //       .then((DocumentSnapshot documentSnapshot) {
        //     if (documentSnapshot.exists) {
        //       if (documentSnapshot.get('role') == "admin") {
        //         Navigator.pushReplacement(
        //           context,
        //           MaterialPageRoute(
        //             builder: (context) => const AdminLayoutScreenMoudule(),
        //           ),
        //         );
        //       } else {
        //         Navigator.pushReplacement(
        //           context,
        //           MaterialPageRoute(
        //             builder: (context) => const UserLayoutScreen(),
        //           ),
        //         );
        //       }
        //     } else {
        //       debugPrint('Document does not exist on the database');
        //     }
        //   });
        // } catch (e) {
        //   debugPrint(e.toString());
        // }
      } else {
        String failLogin =
            'برجاء ادخال البريد الالكترونى وكلمه المرور بشكل صحيح';
        var snackBar = SnackBar(
          content: Text(
            failLogin,
            style: GoogleFonts.almarai(),
          ),
          backgroundColor: Colors.teal,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }

    return Scaffold(
      key: scaffoldKey,
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Container(
                  // height: 300,
                  decoration: BoxDecoration(
                    borderRadius: kIsWeb
                        ? const BorderRadius.only(
                            bottomLeft: Radius.circular(
                              30,
                            ),
                            bottomRight: Radius.circular(
                              30,
                            ),
                          )
                        : BorderRadius.circular(30),
                    color: Colors.teal,
                  ),
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(top: 5, right: 20, left: 20),
                        child: Container(
                          padding: const EdgeInsets.only(top: 20),
                          child: Image.asset(
                            "images/logo.gif",
                            height: 160,
                            width: 160,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            right: 0, top: 10, bottom: 20),
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          //"        Login",
                          'تسجيل دخول',
                          style: GoogleFonts.almarai(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      DefaultTextFild(
                        controller: emailController,
                        label: 'البريد الالكترونى',
                        type: TextInputType.emailAddress,
                        prefixIcon: Icons.email,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'يجب ألا يكون عنوان البريد الإلكتروني فارغًا';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      DefaultTextFild(
                        controller: passwordController,
                        label: 'كلمه المرور',
                        type: TextInputType.visiblePassword,
                        prefixIcon: Icons.lock,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'يجب ألا تكون كلمة المرور فارغة';
                          }
                          if (value.length < 6) {
                            return 'كلمه المرور لا يجب ان تقل عن 6 احرف';
                          }
                          return null;
                        },
                        IsPassword: isPasswordShow,
                        suffixIcon: isPasswordShow
                            ? Icons.visibility
                            : Icons.visibility_off,
                        suffixPressad: () {
                          setState(() {
                            isPasswordShow = !isPasswordShow;
                          });
                        },
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 0),
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            // Write Click Listener Code Here
                          },
                          child: const Text("نسيت كلمه المرور ؟"),
                        ),
                      ),
                      DefaultButton(
                        text: 'تسجيل الدخول',
                        function: connect,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "ليس لديك حساب ؟  ",
                              style: GoogleFonts.almarai(),
                            ),
                            GestureDetector(
                              child: Text(
                                "سجل الان !!",
                                style: GoogleFonts.almarai(color: Colors.teal),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignupScreen(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
