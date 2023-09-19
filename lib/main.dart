import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'src/features/home/screens/home_page.dart';
import 'src/features/home/providers/home_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int startCount = 10;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Online Shopping',
        theme: ThemeData(
          fontFamily: GoogleFonts.notoSansThai().fontFamily,
          textTheme: const TextTheme(
            headlineLarge: TextStyle(fontSize: 32),
            headlineMedium: TextStyle(fontSize: 28),
            titleLarge: TextStyle(fontSize: 22),
            titleMedium: TextStyle(fontSize: 16),
            bodyLarge: TextStyle(fontSize: 16),
            bodyMedium: TextStyle(fontSize: 14),
            bodySmall: TextStyle(fontSize: 12),
          ),
        ),
        home: const HomePage(),
      ),
    );
  }
}
