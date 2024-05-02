import 'package:flutter/material.dart';

Widget createdialogFloatbar(
    BuildContext context, String text, Function() navigator) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 90.0, left: 30, right: 30),
    child: Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                fixedSize:
                    MaterialStateProperty.all<Size>(const Size(185, 45))),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100)),
                        height: 185, // Set the desired height
                        width: MediaQuery.of(context).size.width *
                            0.67, // Set the desired width
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                "Cancel Appointment?",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text(
                                "Are you sure you want to cancel your Appointment?",
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.28,
                                        child: ElevatedButton(
                                            style: const ButtonStyle(
                                                elevation:
                                                    MaterialStatePropertyAll(4),
                                                backgroundColor:
                                                    MaterialStatePropertyAll(
                                                        Colors.white)),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text(
                                              "No",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ))),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.25,
                                        child: ElevatedButton(
                                            style: const ButtonStyle(
                                                elevation:
                                                    MaterialStatePropertyAll(4),
                                                backgroundColor:
                                                    MaterialStatePropertyAll(
                                                        Colors.black)),
                                            onPressed: () {
                                              navigator();
                                            },
                                            child: const Text(
                                              "Yes",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ))),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )),
                  );
                },
              );
            },
            child: Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.normal),
            ),
          ),
        ),
      ],
    ),
  );
}
