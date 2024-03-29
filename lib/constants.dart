import 'package:firebase_auth/firebase_auth.dart';

class PageParam {
  static const String localUserID = 'local_user_id';
  static const String callId = 'call_id';
}

///  userID has to be globally unique,
final String localUserID = FirebaseAuth.instance.currentUser!.uid;

const String cacheUserIDKey = 'cache_user_id_key';

const OPENAI_API_KEY = "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";
// once uploaded to github, this key will be revoked and replaced with a new one in the openai console
