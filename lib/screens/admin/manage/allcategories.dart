import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../widgets/CustomFooterHeaderWidgets/adminfooter.dart';
import '../../../widgets/CustomFooterHeaderWidgets/header2.dart';
import 'package:project_v/screens/admin/manage/editcategory.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AllCategoryScreen extends StatefulWidget {
  const AllCategoryScreen({super.key});

  @override
  State<AllCategoryScreen> createState() => _AllCategoryScreenState();
}

class _AllCategoryScreenState extends State<AllCategoryScreen> {
  // Define a method to create the table widget
  Widget buildDataTable(List<Map<String, dynamic>> data) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black), // Add gray border
      ),
      child: DataTable(
        columnSpacing: (MediaQuery.of(context).size.width - 280) /
            3, // Responsive data table size column
        headingRowHeight: 46, // Adjust the height of the heading row as needed
        headingRowColor:
            MaterialStateColor.resolveWith((states) => Colors.black),
        columns: [
          DataColumn(
            label: Container(
              color: Colors.black,
              padding:
                  const EdgeInsets.only(left: 0), // Remove horizontal padding
              alignment: Alignment.centerLeft, // Align text to the left
              child: const Text(
                'Category Name',
                style: TextStyle(color: Colors.white),
                overflow: TextOverflow.ellipsis, // Handle overflow
              ),
            ),
          ),
          DataColumn(
            label: Container(
              color: Colors.black,
              padding:
                  const EdgeInsets.only(left: 0), // Remove horizontal padding
              alignment: Alignment.centerLeft, // Align text to the left
              child: const Text(
                'Category Type', // Is category type in firebase
                style: TextStyle(color: Colors.white),
                overflow: TextOverflow.ellipsis, // Handle overflow
              ),
            ),
          ),
          DataColumn(
            label: Container(
              color: Colors.black,
              padding:
                  const EdgeInsets.only(left: 0), // Remove horizontal padding
              alignment: Alignment.centerLeft, // Align text to the left
              child: const Text(
                'Edit',
                style: TextStyle(color: Colors.white),
                overflow: TextOverflow.ellipsis, // Handle overflow
              ),
            ),
          ),
        ],
        rows: data
            .map(
              (item) => DataRow(cells: [
                DataCell(Text(item['category'].toString())),
                DataCell(Text(item['category_type'].toString())),
                DataCell(
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 1.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 1,
                            horizontal: 1), // Adjust the padding values
                        child: IconButton(
                          icon: const Icon(Icons.edit,
                              color: Colors.white), // Set icon color to white
                          onPressed: () {
                            // Pass data to the EditCategoryScreen when edit button is clicked
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditCategoryScreen(
                                  initialCategoryName:
                                      item['category'].toString(),
                                  initialCategoryType:
                                      item['category_type'].toString(),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
            )
            .toList(),
      ),
    );
  }

  // Method to fetch data from Firestore or any other data source
  Future<List<Map<String, dynamic>>> fetchData() async {
    try {
      List<Map<String, dynamic>> categoriesDict = [];
      final db = FirebaseFirestore.instance;
      final QuerySnapshot snapShot = await db.collection('categories').get();

      for (DocumentSnapshot document in snapShot.docs) {
        categoriesDict.add(document.data() as Map<String, dynamic>);
      }
      print(categoriesDict);

      return categoriesDict;

      // Fetch your data here and return it as a list of maps
      // For example:
      // final snapshot = await FirebaseFirestore.instance.collection('categories').get();
      // return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (error) {
      throw Exception("Failed to fetch data: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header2(text: "All Categories"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    createSearchCategory(
                        context), // This is where your search widget will go
                    const SizedBox(height: 10),
                    //table goes here, for management
                    FutureBuilder(
                      future: fetchData(),
                      builder: (context,
                          AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return buildDataTable(snapshot.data ?? []);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          AdminFooter(
              buttonStatus: const [false, false, true, false, false],
              context: context)
        ],
      ),
    );
  }
}

Widget createSearchCategory(BuildContext context) {
  return Container(
      decoration: BoxDecoration(
          border: Border.all(),
          color: Colors.white.withOpacity(0.85),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 3),
            )
          ],
          borderRadius: BorderRadius.circular(5)),
      width: MediaQuery.of(context).size.width * 0.95,
      height: MediaQuery.of(context).size.height * 0.05,
      child: ListTile(
        visualDensity: VisualDensity.compact,
        minVerticalPadding: 0,
        dense: true,
        leading: SizedBox(
          width: MediaQuery.of(context).size.width * 0.45,
          height: MediaQuery.of(context).size.height * 0.25,
          child: TextFormField(
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.only(bottom: 12),
              hintText: "Search Products",
              hintStyle: TextStyle(fontSize: 14),
              border: InputBorder.none,
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
          ),
        ),
        title: InkWell(
          splashColor: Colors.black,
          onTap: () {},
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("All Categories"),
              Icon(Icons.expand_more),
            ],
          ),
        ),
      ));
}
