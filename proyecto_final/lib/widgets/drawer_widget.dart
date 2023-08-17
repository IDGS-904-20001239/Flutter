import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../routes/app_routes.dart';
import '../theme/app_theme.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override  
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

//Implementa el método createState() que devuelve una instancia de _DawerWidgetState
class _DrawerWidgetState extends State<DrawerWidget> {
  //Declara una variable _packageInfo del tipo PackageInfo y la inicializa con 
  //valores predeterminados desconocidos para las propiedades de la aplicación.
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );
  //Define un método asincrónico llamado initPackageInfo() que obtiene la información de 
  //paquete de la plataforma y actualiza el estado de _packageInfo con los valores obtenidos.
  Future<void> initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  //Anula el método initState() para realizar tareas de 
  //inicialización antes de que el widget se construya completamente.
  @override
  void initState() {
    initPackageInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Column(
        children: [
          //Muestra una lista de elementos obtenidos de AppRouters.menuOptions. 
          //Cada elemento se muestra como un ListTile con el nombre y el icono correspondiente. 
          //Al hacer clic en un elemento, se navega a la ruta asociada utilizando Navigator.pushNamed().
          DrawerHeader(
            margin: EdgeInsets.only(top:0),
            decoration: BoxDecoration(color: AppTheme.primaryColor,
            image:DecorationImage(image: AssetImage('assets/borboleta.png'), 
            fit: BoxFit.fitWidth ) ),
            child: Align(alignment: Alignment.bottomRight, 
           
            )
            ,),
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

//Viernes: traer un logotipo con transparencia, icono