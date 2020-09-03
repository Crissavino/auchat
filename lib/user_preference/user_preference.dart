import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static final UserPreferences _instancia = UserPreferences._internal();

  factory UserPreferences() {
    return _instancia;
  }

  UserPreferences._internal();

  SharedPreferences _prefs;

  initPref() async {
    this._prefs = await SharedPreferences.getInstance();
  }
  // bool _colorSecundario;
  // int _genero;
  // String _nombre;

  // GET y SET del firebaseId
  get firebaseId {
    return _prefs.getString('firebaseId') ?? '';
  }

  set firebaseId(String value) {
    _prefs.setString('firebaseId', value);
  }

  // GET y SET del token
  get token {
    return _prefs.getString('token') ?? '';
  }

  set token(String value) {
    _prefs.setString('token', value);
  }

  // GET y SET de la ultima pagina
  get lastPage {
    return _prefs.getString('lastPage') ?? 'home';
  }

  set lastPage(String value) {
    _prefs.setString('lastPage', value);
  }
}
