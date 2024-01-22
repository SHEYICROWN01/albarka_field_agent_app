import 'package:albarka_agent_app/app_export.dart';

import 'package:albarka_agent_app/controller/dailySavingsProvider.dart';
import 'package:albarka_agent_app/controller/savingsByDateProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthViewModel>(create: (_) => AuthViewModel()),
        ChangeNotifierProvider<DashboardViewModel>(
            create: (_) => DashboardViewModel()),
        ChangeNotifierProvider<AllMemberProvider>(
            create: (_) => AllMemberProvider()),
        ChangeNotifierProvider<NotificationProvider>(
            create: (_) => NotificationProvider()),
        ChangeNotifierProvider<SavingsByDateProvider>(
            create: (_) => SavingsByDateProvider()),
        ChangeNotifierProvider<DailySavingsProvider>(
            create: (_) => DailySavingsProvider()),
        ChangeNotifierProvider<InstantMemberRecordProvider>(
            create: (_) => InstantMemberRecordProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Albarka',
        theme: ThemeData.light(useMaterial3: true).copyWith(
          primaryColor: ColorConstant.primaryColor,
          textSelectionTheme: TextSelectionThemeData(
              cursorColor: ColorConstant.primaryColor,
              selectionColor: ColorConstant.primaryColor),
          textTheme: ThemeData.light().textTheme.copyWith(
                // ignore: deprecated_member_use
                bodyText2: const TextStyle(
                  fontFamily: 'Cera Pro',
                  color: Colors.black,
                  fontSize: 10,
                ),
              ),
          bottomAppBarTheme:
              BottomAppBarTheme(color: ColorConstant.primaryColor),
        ),
        initialRoute: RouteName.splashScreen,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
