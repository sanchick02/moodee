import 'package:firebase_auth/firebase_auth.dart';
import 'package:moodee/providers/user_provider.dart';
import 'package:provider/provider.dart';

class PageParam {
  static const String localUserID = 'local_user_id';
  static const String callId = 'call_id';
}

///  userID has to be globally unique,
final String localUserID = FirebaseAuth.instance.currentUser!.uid;

const String cacheUserIDKey = 'cache_user_id_key';
