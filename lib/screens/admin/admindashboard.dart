import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_v/widgets/CustomWidgets/adminfeatureHeader.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/adminHeader.dart';
import 'package:project_v/widgets/CustomFooterHeaderWidgets/adminfooter.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class DashboardCard extends StatelessWidget {
  final String title;
  final int value;
  final IconData icon;

  const DashboardCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      margin: const EdgeInsets.all(8.0),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 18.0,
                  fontWeight: FontWeight.normal),
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(icon),
                Text('$value'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  int _numberOfOrders = 0; // Default value to avoid LateInitializedError
  int _numberOfUsers = 0; // Default value to avoid LateInitializedError

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final ordersSnapshot = await FirebaseFirestore.instance.collection('orders').get();
    final usersSnapshot = await FirebaseFirestore.instance.collection('customers').get();

    setState(() {
      _numberOfOrders = ordersSnapshot.size;
      _numberOfUsers = usersSnapshot.size;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          AdminHeader(context: context),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const AdminFeatureHeader(text: "Admin Dashboard"),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double itemWidth = constraints.maxWidth > 200 ? (constraints.maxWidth / 2) - 16 : constraints.maxWidth - 16;
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: itemWidth,
                              height: 110,
                              child: DashboardCard(
                                title: 'Orders',
                                value: _numberOfOrders,
                                icon: Icons.shopping_cart,
                              ),
                            ),
                            SizedBox(
                              width: itemWidth,
                              height: 110,
                              child: DashboardCard(
                                title: 'Customers',
                                value: _numberOfUsers,
                                icon: Icons.people,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  PaginatedDataTable(
                    header: const Text(
                      'Customers',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                      ),
                    ),
                    columns: const [
                      DataColumn(label: Text('Name',
                        style: TextStyle(
                          fontSize: 20,
                        ),)
                      ),
                      DataColumn(label: Text('Email',
                        style: TextStyle(
                          fontSize: 20,
                        ),)
                      ),
                      DataColumn(label: Text('Phone',
                        style: TextStyle(
                          fontSize: 20,
                        ),)
                      ),
                    ],
                    source: _CustomersDataSource(),
                    rowsPerPage: 10,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  PaginatedDataTable(
                    header: const Text(
                      'Orders Made',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                      ),
                    ),
                    columns: const [
                      DataColumn(label: Text(
                        'Order ID',
                        style: TextStyle(
                          fontSize: 20,
                        ),)
                      ),
                      DataColumn(label: Text(
                          'Order Price',
                        style: TextStyle(
                          fontSize: 20,
                        ),)
                      ),
                      DataColumn(label: Text(
                        'Status',
                        style: TextStyle(
                          fontSize: 20,
                        ),)
                      ),
                    ],
                    source: _OrdersDataSource(),
                    rowsPerPage: 10,
                  ),
                ],
              ),
            ),
          ),
          AdminFooter(
            buttonStatus: const [true, false, false, false, false],
            context: context,
          ),
        ],
      ),
    );
  }
}

class _CustomersDataSource extends DataTableSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<DocumentSnapshot> _customers = [];
  final int _rowsPerPage = 10;
  int _currentStartIndex = 0;

  _CustomersDataSource() {
    _fetchCustomers();
  }

  Future<void> _fetchCustomers() async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('customers')
        .limit(_rowsPerPage)
        .get();

    _customers = querySnapshot.docs;
    notifyListeners();
  }

  @override
  DataRow? getRow(int index) {
    if (index >= _customers.length) {
      return null;
    }
    final customer = _customers[index].data() as Map<String, dynamic>;
    return DataRow(cells: [
      DataCell(Text(customer['name'] ?? '')),
      DataCell(Text(customer['email'] ?? '')),
      DataCell(Text(customer['phoneNumber'] ?? '')),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _customers.length;

  @override
  int get selectedRowCount => 0;

  Future<void> nextPage() async {
    _currentStartIndex += _rowsPerPage;
    QuerySnapshot querySnapshot = await _firestore
        .collection('customers')
        .limit(_rowsPerPage)
        .startAfterDocument(_customers.last)
        .get();

    _customers = querySnapshot.docs;
    notifyListeners();
  }

  Future<void> previousPage() async {
    _currentStartIndex -= _rowsPerPage;
    QuerySnapshot querySnapshot = await _firestore
        .collection('customers')
        .limit(_rowsPerPage)
        .endBeforeDocument(_customers.first)
        .get();

    _customers = querySnapshot.docs;
    notifyListeners();
  }

  bool get hasPreviousPage => _currentStartIndex > 0;

  bool get hasNextPage => _customers.length == _rowsPerPage;
}

class _OrdersDataSource extends DataTableSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<DocumentSnapshot> _orders = [];
  final int _rowsPerPage = 10;
  int _currentStartIndex = 0;

  _OrdersDataSource() {
    _fetchOrders();
  }

  Future<void> _fetchOrders() async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('orders')
        .limit(_rowsPerPage)
        .get();

    _orders = querySnapshot.docs;
    notifyListeners();
  }

  @override
  DataRow? getRow(int index) {
    if (index >= _orders.length) {
      return null;
    }
    final order = _orders[index].data() as Map<String, dynamic>;
    return DataRow(cells: [
      DataCell(Text(order['TrackingID'] ?? '')),
      DataCell(Text(order['OrderPrice'].toString())),
      DataCell(Text(order['IsActive'] == true ? 'ACTIVE' : 'COMPLETED')),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _orders.length;

  @override
  int get selectedRowCount => 0;

  Future<void> nextPage() async {
    _currentStartIndex += _rowsPerPage;
    QuerySnapshot querySnapshot = await _firestore
        .collection('orders')
        .limit(_rowsPerPage)
        .startAfterDocument(_orders.last)
        .get();

    _orders = querySnapshot.docs;
    notifyListeners();
  }

  Future<void> previousPage() async {
    _currentStartIndex -= _rowsPerPage;
    QuerySnapshot querySnapshot = await _firestore
        .collection('orders')
        .limit(_rowsPerPage)
        .endBeforeDocument(_orders.first)
        .get();

    _orders = querySnapshot.docs;
    notifyListeners();
  }

  bool get hasPreviousPage => _currentStartIndex > 0;

  bool get hasNextPage => _orders.length == _rowsPerPage;
}
