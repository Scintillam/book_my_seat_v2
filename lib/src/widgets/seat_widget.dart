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
            SvgPicture.asset(
              _getSvgPath(widget.model.seat.status),
              height: widget.model.seatSvgSize.toDouble(),
              width: widget.model.seatSvgSize.toDouble(),
              fit: BoxFit.cover,
            ),
            Text(widget.model.seat.seat.seatNumber,
                style: widget.textStyle ?? const TextStyle(fontFamily: 'monospace'))
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
}
