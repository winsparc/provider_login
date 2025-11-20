import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_login/providers/user_provider.dart';
import 'package:provider_login/screens/users_list_screen.dart';
import 'providers/auth_provider.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final authProvider = AuthProvider();
  await authProvider.loadLoginStatus();

  runApp(
    // ChangeNotifierProvider(
    //   create: (_) => authProvider,
    //   child: const MyApp(),
    // ),
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
        //  home: auth.isLoggedIn ? const DashboardScreen() : const LoginScreen(),
         home: UsersListScreen(),
        );
      },
    );
  }
}
