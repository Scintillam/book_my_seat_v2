import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class LegendWidget extends StatelessWidget {
  final String pathSelectedSeat;
  final String pathUnSelectedSeat;
  final String pathSoldSeat;
  final String pathDisabledSeat;
  final String pathOnHoldSeat;
  final String pathOnBoughtSeat;

  LegendWidget({
    required this.pathSelectedSeat,
    required this.pathDisabledSeat,
    required this.pathSoldSeat,
    required this.pathUnSelectedSeat,
    required this.pathOnHoldSeat,
    required this.pathOnBoughtSeat,
  });
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Wrap(
        spacing: 15,
        children: [
          buildItem(pathSoldSeat, 'Vendida'),
          buildItem(pathUnSelectedSeat, 'Disponible'),
          buildItem(pathSelectedSeat, 'Seleccionada por ti'),
          buildItem(pathOnBoughtSeat, 'Comprada por ti'),
          buildItem(pathDisabledSeat, 'Deshabilitada'),
          // buildItem(pathOnHoldSeat, 'onHold'),
        ],
      ),
    );
  }
  Widget buildItem(String path, String text){
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          path,
          width: 15,
          height: 15,
        ),
        Text(text),
      ],
    );
  }
}