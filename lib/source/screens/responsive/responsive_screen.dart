import 'package:flutter/cupertino.dart';
import 'package:instagram_clone/services/providers/user_provider.dart';
import 'package:instagram_clone/utils/constants.dart';
import 'package:provider/provider.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget mobScreenLayout;
  final Widget webScreenLayout;
  const ResponsiveLayout({
    super.key,
    required this.mobScreenLayout,
    required this.webScreenLayout,
  });

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  ///

  @override
  void initState() {
    super.initState();

    ///
    readUserData();
  }

  void readUserData() async {
    ///
    UserProvider provider = Provider.of<UserProvider>(context, listen: false);
    await provider.refreshUserData();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > WEB_SCREEN_SIZE) {
          return widget.webScreenLayout;
        }
        return widget.mobScreenLayout;
      },
    );
  }
}
