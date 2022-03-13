import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<bool> checkIfAdmin(String _userId) async {
  final admin = await FirebaseFirestore.instance.collection('admins').doc(_userId).get();
  bool isAdmin = admin.exists;
  return isAdmin;
}

Future<bool> checkIfReporter(String _userId) async {
  final reporter = await FirebaseFirestore.instance.collection('reporters').doc(_userId).get();
  bool isReporter = reporter.exists;
  return isReporter;
}

Future getUserType() async { //yes this is really messy code, i couldn't find out another way to do this with my architecture.
  final user = FirebaseAuth.instance.currentUser;

  final admin = await FirebaseFirestore.instance.collection('admins').doc(user!.uid).get();
  bool isAdmin = admin.exists;
  print(' admin $isAdmin');

  final reporter = await FirebaseFirestore.instance.collection('reporters').doc(user.uid).get();
  bool isReporter = reporter.exists;
  print(' reporter $isReporter');

  if (isAdmin) {return 'admin';}
  if (isReporter) {return 'reporter';}
}

Future getUser() async {
  final userInstance = await FirebaseAuth.instance.currentUser;
  print(userInstance);
  return userInstance;
}

