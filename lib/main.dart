import 'package:flutter/material.dart';
import 'package:myapp/contants/routes.dart';
import 'package:myapp/services/auth/bloc/auth_bloc.dart';
import 'package:myapp/services/auth/bloc/auth_events.dart';
import 'package:myapp/services/auth/bloc/auth_state.dart';
import 'package:myapp/services/auth/firebase_auth_provider.dart';
import 'package:myapp/views/login_view.dart';
import 'package:myapp/views/notes/create_update_note_view.dart';
import 'package:myapp/views/notes/notes_view.dart';
import 'package:myapp/views/register_view.dart';
import 'package:myapp/views/verify_email_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(FirebaseAuthProvider()),
        child: const HomePage(),
      ),
      routes: {
        notesRoute: (context) => const NotesView(),
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        verifyEmailRoute: (context) => const VerifyEmailView(),
        createOrUpdateNoteRoute: (context) => const CreateUpdateNoteView(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventsInitialize());
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (State is AuthStateLoggedIn) {
          return const NotesView();
        } else if (State is AuthStateNeedsVerification) {
          return const VerifyEmailView();
        } else if (State is AuthStateLoggedOut) {
          return const LoginView();
        } else {
          return const Scaffold(body: CircularProgressIndicator());
        }
      },
    );
  }
}
