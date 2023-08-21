import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/models/theme_provider.dart';
import 'package:provider/provider.dart';

import '/utils/constants.dart';
import 'components/main_screen/main_screen.dart';
import 'dashboard_stats/dashboard_stats.dart';
import 'netler_stats/netler_stats.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // glassMorphicAppBar' ı kullanacaksan aşağıdaki widget'ın renkleri üste taşmasın diye bunu kullan
      // extendBodyBehindAppBar: true,
      appBar: appBar(context),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DashboardDersler(),
            QuotesWidget(),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: defaultPadding / 2,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Counter(),
                  DashboardStats(),
                ],
              ),
            ),
            SizedBox(height: defaultPadding),
            NetlerStat(),
            SizedBox(
              height: kBottomNavigationBarHeight + defaultPadding * 3,
            ),
          ],
        ),
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      backgroundColor: darkBackgroundColor,
      elevation: 0,
      titleSpacing: defaultPadding / 2,
      centerTitle: false,
      actions: [
        IconButton(
          onPressed: () {
            // scaffoldKey.currentState!.openDrawer();
            context.read<ThemeProvider>().toggleKey();
          },
          icon: SvgPicture.asset(
            "assets/icons/hamburger.svg",
            height: 16,
            width: 16,
            color: Colors.grey.shade100,
          ),
        ),
      ],
      title: const DashboardAppBarTitle(),
    );
  }
}

//   AppBar glassmorphicAppBar(BuildContext context) {
//     return AppBar(
//       backgroundColor:
//           Platform.isIOS ? Colors.transparent : darkBackgroundColor,
//       elevation: 0,
//       titleSpacing: defaultPadding / 2,
//       centerTitle: false,
//       actions: [
//         IconButton(
//           onPressed: () {
//             // scaffoldKey.currentState!.openDrawer();
//             context.read<ThemeProvider>().toggleKey();
//           },
//           icon: SvgPicture.asset(
//             "assets/icons/hamburger.svg",
//             height: 16,
//             width: 16,
//             color: Colors.grey.shade100,
//           ),
//         ),
//       ],
//       flexibleSpace: Platform.isIOS
//           ? ClipRect(
//               child: BackdropFilter(
//                 filter: ImageFilter.blur(sigmaX: 5, sigmaY: 10),
//                 child: Container(
//                   color: Colors.transparent,
//                 ),
//               ),
//             )
//           : null,
//       title: const DashboardAppBarTitle(),
//     );
//   }
// }

class DashboardAppBarTitle extends StatelessWidget {
  const DashboardAppBarTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: defaultPadding / 2,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hoşgeldin, ",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                  ),
            ),
            Text(
              "${context.watch<ThemeProvider>().getUserName}!",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 16,
                  ),
            ),
          ],
        ),
        const Spacer(),
      ],
    );
  }
}
