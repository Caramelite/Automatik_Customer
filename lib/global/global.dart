import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';



final FirebaseAuth fAuth = FirebaseAuth.instance;
User? currentFirebaseUser;
UserModel? customerModelCurrentInfo;
List tList = []; //technicianKey Info List