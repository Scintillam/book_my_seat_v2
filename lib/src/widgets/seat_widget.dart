import 'package:book_my_seat/src/model/seat_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vive_models/vive_models.dart';

class SeatWidget extends StatefulWidget {
  final SeatModel model;
  final Future<void> Function(
      SeatAvailability currentSeat, TapUpDetails details) onSeatStateChanged;
  final TextStyle? textStyle;

  SeatWidget({
    Key? key,
    required this.model,
    required this.onSeatStateChanged,
    this.textStyle,
  }) : super(key: key);

  @override
  State<SeatWidget> createState() => _SeatWidgetState();
}

class _SeatWidgetState extends State<SeatWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
        child: (widget.model.seat.status == SeatState.available ||
                widget.model.seat.status == SeatState.selected)
            ? GestureDetector(
                onTapUp: (details) async {
                  await widget.onSeatStateChanged(widget.model.seat, details);
                  setState(() {});
                },
                child: buildSeat())
            : buildSeat());
  }

  Widget buildSeat() {
    // print("BUILDING SEAT WIDGET3 " + DateTime.now().toString());
    return widget.model.seat.status != SeatState.empty
        ? Stack(alignment: Alignment.center, children: [
            /*SvgPicture.asset(
              _getSvgPath(widget.model.seat.status),
              height: widget.model.seatSvgSize.toDouble(),
              width: widget.model.seatSvgSize.toDouble(),
              fit: BoxFit.cover,
            ),*/

            Padding(
                padding: const EdgeInsets.all(3),
                child: Container(
                  height: widget.model.seatSvgSize.toDouble() - 6,
                  width: widget.model.seatSvgSize.toDouble() - 6,
                  decoration: _getSeatColor(widget.model.seat.status),
                )),
            Text(widget.model.seat.seat.seatNumber,
                style: widget.textStyle ??
                    const TextStyle(fontFamily: 'monospace'))
          ])
        : SizedBox(
            height: widget.model.seatSvgSize.toDouble(),
            width: widget.model.seatSvgSize.toDouble(),
          );
  }

  String _getSvgPath(SeatState state) {
    switch (state) {
      case SeatState.available:
        {
          return widget.model.pathUnSelectedSeat;
        }
      case SeatState.selected:
        {
          return widget.model.pathSelectedSeat;
        }
      case SeatState.disabled:
        {
          return widget.model.pathDisabledSeat;
        }
      case SeatState.comingSoon:
        {
          return widget.model.pathComingSoon;
        }
      case SeatState.sold:
        {
          return widget.model.pathSoldSeat;
        }
      case SeatState.onHold:
        {
          return widget.model.pathOnHoldSeat;
        }
      case SeatState.bought:
        {
          return widget.model.pathOnBoughtSeat;
        }
      case SeatState.empty:
      default:
        {
          return widget.model.pathDisabledSeat;
        }
    }
  }

  BoxDecoration _getSeatColor(SeatState state) {
    switch (state) {
      case SeatState.available:
        {
          return BoxDecoration(
              border: Border.all(
                color: const Color(0xFF05F995),
                width: 3,
              ),
              borderRadius: BorderRadius.circular(3));
        }
      case SeatState.selected:
        {
          return BoxDecoration(
            color: const Color(0xFFeb3d8c),
            borderRadius:
                BorderRadius.circular(3), // Rounded corners with radius 3
          );
        }
      case SeatState.disabled:
        {
          return BoxDecoration(
            color: const Color(0xFF636366),
            borderRadius:
                BorderRadius.circular(3), // Rounded corners with radius 3
          );
        }
      case SeatState.comingSoon:
        {
          return BoxDecoration(
            color: const Color(0xFF9e9e9e),
            borderRadius:
                BorderRadius.circular(3), // Rounded corners with radius 3
          );
        }
      case SeatState.sold:
        {
          return BoxDecoration(
            color: const Color(0xFFfeba4a),
            borderRadius:
                BorderRadius.circular(3), // Rounded corners with radius 3
          );
        }
      case SeatState.onHold:
        {
          return BoxDecoration(
            color: const Color(0xfffeba4a),
            borderRadius:
                BorderRadius.circular(3), // Rounded corners with radius 3
          );
        }
      case SeatState.bought:
        {
          return BoxDecoration(
            color: const Color(0xFF05cbf9),
            borderRadius:
                BorderRadius.circular(3), // Rounded corners with radius 3
          );
        }
      case SeatState.empty:
      default:
        {
          return BoxDecoration(
            color: const Color(0xFF636366),
            borderRadius:
                BorderRadius.circular(3), // Rounded corners with radius 3
          );
        }
    }
  }
}
