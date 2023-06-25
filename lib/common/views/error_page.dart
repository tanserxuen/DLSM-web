
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dlsm_web/app/index.dart';
import 'package:dlsm_web/common/index.dart';





class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: FittedBox(
                  child: Image.asset('assets/imgs/logo_title.png',
                      fit: BoxFit.cover))
              .padding(left: 30, top: 10),
          leadingWidth: MediaQuery.of(context).size.width * 0.4,
          toolbarHeight: MediaQuery.of(context).size.height * 0.1,
          actions: [
            IconButton(
              onPressed: () {
                final snackBar = SnackBar(
                  elevation: 0,
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  content: AwesomeSnackbarContent(
                      title: "Error Occured",
                      message: "Please sign in again",
                      contentType: ContentType.failure),
                );
                scaffoldMessenger..hideCurrentSnackBar()..showSnackBar(snackBar);
                navigator.pushNamed(Routes.initPage);
              },
              icon: const Icon(Icons.close),
              color: CustomTheme.activeTheme.primaryColor,
            ).paddingDirectional(end: MediaQuery.of(context).size.width * 0.05)
          ],
        ),
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BackgroundDecoration.blueYellowGradient,
            child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: SafeArea(
                    child: <Widget>[
                  const Text('Error Page',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                ].toColumn()))));
  }
}
