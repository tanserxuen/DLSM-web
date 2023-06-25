import 'package:dlsm_web/admin/dashboard.dart';
import 'package:dlsm_web/admin/menuItems.dart';
import 'package:dlsm_web/admin/viewUserProfile.dart';
import 'package:dlsm_web/app/index.dart';
import 'package:dlsm_web/common/index.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Hive
  await Hive.initFlutter();
  // Initialize Env
  await riverpodContainer.read(envServiceProvider).initializeEnv();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UncontrolledProviderScope(
        container: riverpodContainer, child: const MyApp());
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drive Less Save More (Admin)',
      theme: ThemeData(
        fontFamily: 'Nunito',
      ),
      navigatorObservers: [routeObserver],
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: scaffoldMessengerKey,
      routes: Routes.pages,
      initialRoute: Routes.initPage,
      // home: const AdminDashboard(title: "Dashboard"),
    );
  }
}

// View user profile
// Approve rebate of user
// Generate report
