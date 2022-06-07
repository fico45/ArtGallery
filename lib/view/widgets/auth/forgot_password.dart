import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ForgotPassword extends ConsumerWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String _email = '';
    final _auth = FirebaseAuth.instance;
    return Center(
      child: Container(
        height: 300,
        width: 400,
        child: Card(
          margin: EdgeInsets.all(22),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Forgot Password",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Please enter your email address to recover your password.",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  onChanged: (value) => _email = value,
                  decoration: InputDecoration(
                    label: Text(
                      'Email address',
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).colorScheme.secondary)),
                  child: Text(
                    'Recover password',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                  onPressed: () async {
                    await _auth
                        .sendPasswordResetEmail(email: _email)
                        .then(
                          (value) => showDialog(
                            context: context,
                            builder: (BuildContext context) => Center(
                              child: Card(
                                child: Text('Password link sent!'),
                              ),
                            ),
                          ),
                        )
                        .catchError(
                          (e) => showDialog(
                            context: context,
                            builder: (BuildContext context) => Center(
                              child: Card(
                                child: Text('There was an error.'),
                              ),
                            ),
                          ),
                        );

                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
