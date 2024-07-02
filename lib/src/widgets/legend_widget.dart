import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LegendWidget extends StatelessWidget {
  final String pathSelectedSeat;
  final String pathUnSelectedSeat;
  final String pathSoldSeat;
  final String pathDisabledSeat;
  final String pathOnHoldSeat;
  final String pathOnBoughtSeat;

  final TextStyle? textStyle;

  LegendWidget({
    required this.pathSelectedSeat,
    required this.pathDisabledSeat,
    required this.pathSoldSeat,
    required this.pathUnSelectedSeat,
    required this.pathOnHoldSeat,
    required this.pathOnBoughtSeat,
    this.textStyle
  });
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Container(
        alignment: Alignment.center,
        height: 100,
        decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.withAlpha(50),
        ),
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Colors.grey.withAlpha(50),
              //Colors.black.withAlpha(50),
              Colors.black.withAlpha(100)
            ])),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Wrap(
            spacing: 15,
            children: [
              buildItem(pathSoldSeat, 'Reservado'),
              buildItem(pathUnSelectedSeat, 'Disponible'),
              buildItem(pathSelectedSeat, 'Seleccionado por ti'),
              buildItem(pathOnBoughtSeat, 'Comprado por ti'),
              // buildItem(pathDisabledSeat, 'Deshabilitada'),
              // buildItem(pathOnHoldSeat, 'onHold'),
            ],
          ),
        ),
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
        Text(text, style: textStyle),
      ],
    );
  }
}