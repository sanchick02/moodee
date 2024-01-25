import 'package:firebase_auth/firebase_auth.dart';

class PageParam {
  static const String localUserID = 'local_user_id';
  static const String callId = 'call_id';
}

///  userID has to be globally unique,
final String localUserID = FirebaseAuth.instance.currentUser!.uid;

const String cacheUserIDKey = 'cache_user_id_key';

const OPENAI_API_KEY = "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";
