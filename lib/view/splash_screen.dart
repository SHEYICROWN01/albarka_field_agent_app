import 'package:albarka_agent_app/app_export.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        Timer(const Duration(seconds: 3), () {
          if (mounted) {
            Navigator.pushNamed(context, RouteName.loginAuth);
          }
        });
      }
    });
    // Use WidgetsBinding.instance to add a post-frame callback for navigating to the login view

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.whiteA700,
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              alignment: Alignment.center,
              children: [
                Positioned.fill(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: CommonImageView(
                      imagePath: ImageConstant.background,
                    ),
                  ),
                ),
                Positioned(
                  child: Padding(
                    padding: getPadding(all: 30),
                    child: CommonImageView(
                      imagePath: ImageConstant.logo,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}



