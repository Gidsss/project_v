import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_v/widgets/Layout/headerfooter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return HeaderFooter(
        title: "HeaderFooter",
        buttonStatus: [true, false, false, false, false],
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                  width: double.infinity,
                  color: Colors.black,
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(8,15,8,15),
                    child: Column(
                      children: [
                        Text(
                          "MARCH SALE MADNESS",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontFamily: "Lato",
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "12  :  14  :  23", // Temporary, will be changed once backend real-time countdown is implemented.
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontFamily: "Lato",
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "hour     min     sec",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontFamily: "Lato",
                          )
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ));
  }
}
