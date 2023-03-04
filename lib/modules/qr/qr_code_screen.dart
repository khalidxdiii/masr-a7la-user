import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QrScreen extends StatelessWidget {
  const QrScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
            child: Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)),
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
                margin: const EdgeInsets.only(
                    top: 5, right: 20, left: 20, bottom: 10),
                child: Container(
                  margin: const EdgeInsets.only(top: 0),
                  child: Container(
                    padding: const EdgeInsets.only(top: 10),
                    child: Image.asset(
                      "images/logo.gif",
                      height: 160,
                      width: 160,
                    ),
                  ),
                ),
              ),
              Text(
                'تصفح موقعنا الالكترونى',
                //style: Theme.of(context).textTheme.headline6,

                style: GoogleFonts.almarai(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                // margin: const EdgeInsets.only(right: 20, top: 10, bottom: 10),
                alignment: Alignment.bottomRight,
                child: const SizedBox(height: 27),
              )
            ],
          )),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // const Text(
              //   'Scan to go our Web site',
              //   //style: Theme.of(context).textTheme.headline6,

              //   style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              // ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Image.asset(
                  'images/new-qr-code.png',
                  width: 300,
                  height: 300,
                ),
              ),
            ],
          ),
        ),
      ],
    )));
  }
}
