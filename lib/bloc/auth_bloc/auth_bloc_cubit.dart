import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:majootestcase/models/user.dart';
import 'package:majootestcase/services/user_db.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_bloc_state.dart';

class AuthBlocCubit extends Cubit<AuthBlocState> {
  AuthBlocCubit() : super(AuthBlocInitialState());

  void fetch_history_login() async {
    emit(AuthBlocLoadingState());
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool? isLoggedIn = sharedPreferences.getBool("is_logged_in");
    if (isLoggedIn != null) {
      if (isLoggedIn == true) {
        emit(AuthBlocLoggedInState());
      } else {
        emit(AuthBlocLoginState());
      }
    } else {
      emit(AuthBlocLoginState());
    }
  }

  void login_user(User user) async {
    emit(AuthBlocLoadingState());
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var dbUser = await UserDatabase.getUserByEmail(user.email!);
      if (dbUser != null) {
        if (user.password == dbUser.password) {
          await sharedPreferences.setBool("is_logged_in", true);
          String data = user.toJson().toString();
          sharedPreferences.setString("user_value", data);
          emit(AuthBlocLoggedInState());
        } else {
          emit(AuthBlocErrorState(
              "Email / Password tidak sesuai dengan databse"));
        }
      } else {
        emit(
            AuthBlocErrorState("Email / Password tidak sesuai dengan databse"));
      }
    } catch (e) {
      emit(AuthBlocErrorState("an error occured"));
    }
  }

  void logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool("is_logged_in", false);
    emit(AuthBlocLoginState());
  }

  void register(User user) async {
    emit(AuthBlocLoadingState());
    try {
      var isInserted = await UserDatabase.insert(user);
      if (isInserted) {
        emit(AuthBlocRegisteredState());
      } else {
        emit(AuthBlocErrorState("Email already exists!"));
      }
    } catch (e) {
      emit(AuthBlocErrorState(e.toString()));
    }
  }
}
