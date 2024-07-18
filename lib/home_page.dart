import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider, PhoneAuthProvider;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_state.dart';
import 'src/authentication.dart';
import 'src/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Consumer<ApplicationState>(
              builder: (context, appState, _) {
                if (appState.loggedIn) {
                  return Column(
                    children: [
                      const Text(
                        'Bienvenid@',
                        style: TextStyle(fontSize: 24),
                      ),
                      Image.asset('images/mapa.png', height: 350, width: 350),
                      const SizedBox(height: 8),
                      const Paragraph(
                        'Presiona el botón para ver tu ubicación en tiempo real',
                      ),
                      const SizedBox(height: 8), 
                      StyledButton(
                        onPressed: () {
                          //la verdad no sé cómo mostrar la ubicación xd
                        },
                        child: const Text('Ver mi ubicación'),
                      ),
                      const SizedBox(height: 16), 
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      Image.asset('images/login.png', height: 250, width: 250),
                      const SizedBox(height: 8),
                      const Header("Firebase Login"),
                      const Paragraph(
                        'Presiona el botón para iniciar sesión con nosotros',
                      ),
                    ],
                  );
                }
              },
            ),
            const Divider(
              height: 8,
              thickness: 1,
              indent: 8,
              endIndent: 8,
              color: Colors.grey,
            ),
             const SizedBox(height: 10),
            Consumer<ApplicationState>(
              builder: (context, appState, _) => AuthFunc(
                loggedIn: appState.loggedIn,
                signOut: () {
                  FirebaseAuth.instance.signOut();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
