import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_v/models/customer_model.dart';

const String CUSTOMER_COLLECTION_REF = "customers";

class DatabaseService {
  final _firestore = FirebaseFirestore.instance;

  late final CollectionReference _customerRef;

  DatabaseService() {
    _customerRef =
        _firestore.collection(CUSTOMER_COLLECTION_REF).withConverter<Customer>(
            fromFirestore: (snapshots, _) => Customer.fromJson(
                  snapshots.data()!,
                ),
            toFirestore: (customers, _) => customers.toJson());
  }

  Stream<QuerySnapshot> getCustomers() {
    return _customerRef.snapshots();
  }

  Future<void> addCustomer(Customer customer) async {
    await _customerRef.add(customer);
  }
  
}
