import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/services/auth/auth_provider.dart';
import 'package:myapp/services/auth/bloc/auth_events.dart';
import 'package:myapp/services/auth/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvents, AuthState> {
  AuthBloc(AuthProvider provider) : super(const AuthStateLoading()) {
    on<AuthEventsInitialize>((event, emit) async {
      await provider.initialize();
      final user = provider.currentUser;
      if (user == null) {
        emit(const AuthStateLoggedOut());
      } else if (!user.isEmailVerified) {
        emit(const AuthStateNeedsVerification());
      } else {
        emit(AuthStateLoggedIn(user));
      }
    });

    on<AuthEventsLogIn>((event, emit) async {
      emit(const AuthStateLoading());
      final emial = event.email;
      final password = event.password;
      try {
        final user = await provider.logIn(email: emial, password: password);
        emit(AuthStateLoggedIn(user));
      } on Exception catch (e) {
        emit(AuthStateLoginFailure(e));
      }
    });

    on<AuthEventsLogOut>((event, emit) async {
      try {
        emit(AuthStateLoading());
        await provider.logOut();
        emit(const AuthStateLoggedOut());
      } on Exception catch (e) {
        emit(AuthStateLogoutFailure(e));
      }
    });
  }
}
