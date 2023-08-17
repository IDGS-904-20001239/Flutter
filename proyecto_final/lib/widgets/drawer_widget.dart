import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:proyecto_final/theme/app_theme.dart';
import 'package:proyecto_final/routes/app_routes.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override  
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );

  Future<void> initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  void initState() {
    initPackageInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: ListView(
          children: [   
              UserAccountsDrawerHeader(
             accountName: const Text('Leonel Robledo'), 
             accountEmail: const Text('robledo@gmail.com'),
             currentAccountPicture: CircleAvatar(
               child: ClipOval(child: Image.asset('assets/user.jpg')),
             ),
             decoration: BoxDecoration(
               color: AppTheme.secondaryColor,
             ),
             ),
              ListView.separated(
               shrinkWrap: true,
               itemBuilder: (context, i) {
                 return ListTile(
                   title: Text(AppRoutes.menuOptions[i].name),
                   leading: Icon(AppRoutes.menuOptions[i].icon),
                  onTap: () {
                     Navigator.pushNamed(
                         context, AppRoutes.menuOptions[i].router);
                   },
                 );
               },
               separatorBuilder: (__, _) => const Divider(),
               itemCount: AppRoutes.menuOptions.length)
           ],
          ),
       );
   }
 }


//          child: ListView(
//           children: [
//             UserAccountsDrawerHeader(
//             accountName: const Text('Yair'), 
//             accountEmail: const Text('yairguapo@gmail.com'),
//             currentAccountPicture: CircleAvatar(
//               child: ClipOval(child: Image.asset('assets/boyka.jpg')),
//             ),
//             decoration: BoxDecoration(
//               color: AppTheme.secondaryColor,
//             ),
//             ),
//              ListView.separated(
//               shrinkWrap: true,
//               itemBuilder: (context, i) {
//                 return ListTile(
//                   title: Text(AppRoutes.menuOptions[i].name),
//                   leading: Icon(AppRoutes.menuOptions[i].icon),
//                   onTap: () {
//                     Navigator.pushNamed(
//                         context, AppRoutes.menuOptions[i].router);
//                   },
//                 );
//               },
//               separatorBuilder: (__, _) => const Divider(),
//               itemCount: AppRoutes.menuOptions.length)
//           ],
//          ),
//       );
//   }
// }