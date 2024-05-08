import 'package:flutter/material.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/header2.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/adminfooter.dart';

import 'adminprofilescreen.dart';


class ViewProfileScreen extends StatefulWidget {
  const ViewProfileScreen({super.key});

  @override
  State<ViewProfileScreen> createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const Header2(text: "View Profile"),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.only(left: 22),
                    child: Stack(
                      children: [
                        const CircleAvatar(
                          radius: 70,
                          backgroundImage: AssetImage('assets/images/user.png'),
                        ),
                        Positioned(
                          right: 5,
                          bottom: 2,
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: IconButton(
                              alignment: Alignment.center,
                              iconSize: 15,
                              color: Colors.white,
                              onPressed: (){},
                              icon: const Icon(Icons.edit),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 10), // Adjust horizontal padding as needed
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Text(
                              "Name",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 30,
                          child: const TextField(
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'Inter',
                            ),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 10), // Adjust horizontal padding as needed
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Text(
                              "Email",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 30,
                          child: const TextField(
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'Inter',
                            ),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 100),
                  Center(
                    child: ElevatedButton(
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                            fixedSize: MaterialStateProperty.all<Size>(const Size(250, 35))),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Confirmation"),
                                content: const Text("Are you sure you want to save changes?"),
                                actions: [
                                  TextButton(
                                    style: ButtonStyle(
                                        foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                                        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                        fixedSize: MaterialStateProperty.all<Size>(const Size(100, 35))),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Cancel"),
                                  ),
                                  ElevatedButton(
                                    style: ButtonStyle(
                                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                        backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                                        fixedSize: MaterialStateProperty.all<Size>(const Size(100, 35))),
                                    onPressed: () {
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AdminProfileScreen()));
                                    },
                                    child: const Text("Change"),
                                  ),
                                ],
                              );
                            },
                          );
                          }, child: const Text("Save")
                    ),
                  )
                ],
              ),
            ),
          ),
          AdminFooter(buttonStatus: const [false, false, false, false, true], context: context),
        ],
      ),
    );
  }
}
