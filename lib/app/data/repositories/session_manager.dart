import 'package:adora_baby/app/data/models/user_model.dart';

class SessionManager {
  SessionManager._privateConstructor();

  static final SessionManager _instance = SessionManager._privateConstructor();

  static SessionManager get instance => _instance;

  Users? _user;

  Users? get user => _user;

  void setUser(Users? user) => _user = user;
}
