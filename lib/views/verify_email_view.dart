import 'package:flutter/material.dart';
import 'package:myapp/contants/routes.dart';
import 'package:myapp/services/auth/auth_service.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify Email')),
      body: Column(
        children: [
          const Text(
            "We've sent you and email, please verify your email address",
          ),
          const Text(
            "If you haven't received a verification email, please press the button below to send it again",
          ),
          TextButton(
            onPressed: () async {
              final user = AuthService.firebase().currentUser;
              if (user != null) {
                await AuthService.firebase().sendEmailVerification();
              }
            },
            child: const Text('Send email verification link'),
          ),

          TextButton(
            onPressed: () async {
              await AuthService.firebase().logOut();
              Navigator.of(
                context,
              ).pushNamedAndRemoveUntil(registerRoute, (route) => false);
            },
            child: const Text("Restart"),
          ),
        ],
      ),
    );
  }
}
