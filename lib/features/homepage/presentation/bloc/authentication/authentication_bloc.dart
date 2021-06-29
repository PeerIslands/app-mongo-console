import 'dart:async';

import 'package:flutter_auth/core/constants/storage_constants.dart';
import 'package:flutter_auth/core/http/api_base_helper.dart';
import 'package:flutter_auth/core/util/extension_functions.dart';
import 'package:flutter_auth/features/homepage/presentation/bloc/authentication/authentication_event.dart';
import 'package:flutter_auth/features/homepage/presentation/bloc/authentication/authentication_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(Empty());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is CheckUserLogged) {
      var token = await ApiBaseHelper.storage.read(key: BEARER_TOKEN);

      if (token.isNotNull) {
        add(LoggedInUser(token));
      }
    } else if (event is LoggedInUser) {
      ApiBaseHelper.storage.write(key: BEARER_TOKEN, value: event.token);

      yield Processing();
      yield LoggedIn();
    } else if (event is LoggedOutUser) {
      await ApiBaseHelper.storage.deleteAll();

      yield Processing();
      yield LoggedOut();
    }
  }
}
