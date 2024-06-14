import 'package:book_my_seat/src/model/seat_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vive_models/vive_models.dart';

class SeatWidget extends StatefulWidget {
  final SeatModel model;
  final void Function(int rowI, int colI, SeatAvailability currentSeat)
      onSeatStateChanged;

  SeatWidget({
    Key? key,
    required this.model,
    required this.onSeatStateChanged,
  }) : super(key: key);

  @override
  State<SeatWidget> createState() => _SeatWidgetState();
}

class _SeatWidgetState extends State<SeatWidget> {
  int rowI = 0;
  int colI = 0;

  @override
  void initState() {
    super.initState();
    rowI = widget.model.rowI;
    colI = widget.model.colI;
  }

  @override
  Widget build(BuildContext context) {
      return GestureDetector(
        onTapUp: (_) {
          widget.onSeatStateChanged(rowI, colI, widget.model.seat);
          setState(() { });
        },
        child: widget.model.seat != SeatState.empty
            ? SvgPicture.asset(
                _getSvgPath(widget.model.seat.status),
                height: widget.model.seatSvgSize.toDouble(),
                width: widget.model.seatSvgSize.toDouble(),
                fit: BoxFit.cover,
              )
            : SizedBox(
                height: widget.model.seatSvgSize.toDouble(),
                width: widget.model.seatSvgSize.toDouble(),
              ),
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
      case SeatState.sold:
        {
          return widget.model.pathSoldSeat;
        }
      case SeatState.sold:
        {
          return widget.model.pathSoldSeat;
        }
      case SeatState.onHold:
        {
          return widget.model.pathOnHoldSeat;
        }
      case SeatState.empty:
      default:
        {
          return widget.model.pathDisabledSeat;
        }
    }
  }
}
