import 'package:fitness/common/colo_extension.dart';
import 'package:flutter/material.dart';


class MenuItems extends StatefulWidget {
  const MenuItems({super.key});

  @override
  State<MenuItems> createState() => _MenuItemsState();
}

class _MenuItemsState extends State<MenuItems> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          width: 250,
          color: TColor.primaryColor1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Copiar cuenta y contraseña', style: TextStyle(color: Colors.white, fontSize: 16)),
              Icon(Icons.copy, color: Colors.white,),
            ],
          ),
        ),
        Divider(color: Colors.white, height: 0.8,),
        Container(
          height: 50,
          width: 250,
          color: TColor.primaryColor1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Copiar perfil y pin', style: TextStyle(color: Colors.white, fontSize: 16)),
              Icon(Icons.copy, color: Colors.white,),
            ],
          ),

        ),
        Divider(color: Colors.white,height: 0.8),
        Container(
          height: 50,
          width: 250,
          color: TColor.primaryColor1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Editar nombre', style: TextStyle(color: Colors.white, fontSize: 16)),
              Icon(Icons.copy, color: Colors.white,),
            ],
          ),
        ),
        Divider(color: Colors.white,height: 0.8),
        Container(
          height: 50,
          width: 250,
          color: TColor.primaryColor1,
          child: Text('Editar telefono', style: TextStyle(color: Colors.white, fontSize: 16)),
        ),
        Divider(color: Colors.white,height: 0.8),
        Container(
          height: 50,
          width: 250,
          color: TColor.primaryColor1,
          child: Text('Editar mensualidad', style: TextStyle(color: Colors.white, fontSize: 16)),
        ),
        Divider(color: Colors.white,height: 0.8),
        Container(
          height: 50,
          width: 250,
          color: TColor.primaryColor1,
          child: Text('Editar pin', style: TextStyle(color: Colors.white, fontSize: 16)),
        ),
        Divider(color: Colors.white,height: 0.8),
        Container(
          height: 50,
          width: 250,
          color: TColor.primaryColor1,
          child: Text('Liberar perfil', style: TextStyle(color: Colors.white, fontSize: 16)),
        ),
        Divider(color: Colors.white,height: 0.8),
        
      ],
    );
  }
}