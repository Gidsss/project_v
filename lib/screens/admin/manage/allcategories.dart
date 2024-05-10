import 'package:flutter/material.dart';
import '../../../widgets/CustomFooterHeaderWidgets/adminfooter.dart';
import '../../../widgets/CustomFooterHeaderWidgets/header2.dart';
import 'package:project_v/screens/admin/manage/editcategory.dart';
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
        columnSpacing: 40,
        headingRowHeight: 46, // Adjust the height of the heading row as needed
        headingRowColor: MaterialStateColor.resolveWith((states) => Colors.black),
        columns: [
          DataColumn(
            label: Container(
              color: Colors.black,
              padding: EdgeInsets.only(left: 0), // Remove horizontal padding
              alignment: Alignment.centerLeft, // Align text to the left
              child: Text(
                'Category Name',
                style: TextStyle(color: Colors.white),
                overflow: TextOverflow.ellipsis, // Handle overflow
              ),
            ),
          ),
          DataColumn(
            label: Container(
              color: Colors.black,
              padding: EdgeInsets.only(left: 0), // Remove horizontal padding
              alignment: Alignment.centerLeft, // Align text to the left
              child: Text(
                'Category Type',
                style: TextStyle(color: Colors.white),
                overflow: TextOverflow.ellipsis, // Handle overflow
              ),
            ),
          ),
          DataColumn(
            label: Container(
              color: Colors.black,
              padding: EdgeInsets.only(left: 0), // Remove horizontal padding
              alignment: Alignment.centerLeft, // Align text to the left
              child: Text(
                '   Edit',
                style: TextStyle(color: Colors.white),
                overflow: TextOverflow.ellipsis, // Handle overflow
              ),
            ),
          ),
        ],
        rows: data
            .map(
              (item) => DataRow(cells: [
            DataCell(Text(item['category_name'].toString())),
            DataCell(Text(item['category_type'].toString())),
            DataCell(
              Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20), // Adjust the radius for rounded corners
                ),
                padding: EdgeInsets.symmetric(vertical: 1, horizontal: 1), // Adjust the padding values
                child: IconButton(
                  icon: Icon(Icons.edit, color: Colors.white), // Set icon color to white
                  onPressed: () {
                    // Pass data to the EditCategoryScreen when edit button is clicked
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditCategoryScreen(
                          initialCategoryName: item['category_name'].toString(),
                          initialCategoryType: item['category_type'].toString(),
                        ),
                      ),
                    );
                  },
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
    // Fetch your data here and return it as a list of maps
    // For example:
    // final snapshot = await FirebaseFirestore.instance.collection('categories').get();
    // return snapshot.docs.map((doc) => doc.data()).toList();
    return [
      {'category_name': 'Gucci', 'category_type': 'Brand'},
      {'category_name': 'Rayban', 'category_type': 'Brand'},
      {'category_name': 'Red', 'category_type': 'Color'},
    ];
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
                        builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator();
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
