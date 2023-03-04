// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:masr_a7la/main.dart';

import 'package:masr_a7la/shared/cubit/cubit.dart';
import 'package:masr_a7la/shared/cubit/states.dart';

class UserLayoutScreenModule extends StatelessWidget {
  const UserLayoutScreenModule({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {},
        builder: (BuildContext context, AppStates state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      // FirebaseAuth.instance.signOut().then((value) {
                      //   // Sign-out successful.
                      // }).catchError((error) {
                      //   debugPrint(error.ToString());
                      // });
                      FirebaseAuth.instance.signOut();
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => MyApp(isAdmin: false),
                          ),
                          (route) => false);
                    },
                    icon: Icon(Icons.logout))
              ],
              title: Center(
                child: Text(
                  cubit.titles[cubit.currentIndex],
                  style: GoogleFonts.almarai(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              leading: SizedBox(width: 10),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(
                    Icons.home,
                  ),
                  label: cubit.titles[0],
                ),
                BottomNavigationBarItem(
                  icon: const Icon(
                    Icons.menu,
                  ),
                  label: cubit.titles[1],
                )
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
          );
        },
      ),
    );
  }
}
