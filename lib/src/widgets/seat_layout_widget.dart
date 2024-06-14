import 'package:book_my_seat/book_my_seat.dart';
import 'package:book_my_seat/src/widgets/seat_widget.dart';
import 'package:flutter/material.dart';
import 'package:vive_models/vive_models.dart';

class SeatLayoutWidget extends StatelessWidget {
  final SeatLayoutStateModel stateModel;
  final void Function(int rowI, int colI, SeatAvailability seat)
      onSeatStateChanged;

  SeatLayoutWidget({
    Key? key,
    required this.stateModel,
    required this.onSeatStateChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      maxScale: 5,
      minScale: 0.8,
      boundaryMargin: const EdgeInsets.all(8),
      constrained: true,
      panEnabled: false,
      scaleEnabled: false,
      child: Column(
        children: [
          ...List<int>.generate(stateModel.rows, (rowI) => rowI)
              .map<Row>(
                (rowI) => Row(
                  children: [
                    SizedBox(
                      width: 20,
                      child: Text(
                        (rowI+1).toString(),
                        textAlign: TextAlign.end,
                        style: TextStyle(fontFamily: 'monospace'),
                      ),
                    ),
                    ...List<int>.generate(stateModel.cols, (colI) => colI)
                        .map<SeatWidget>((colI) => SeatWidget(
                              model: SeatModel(
                                seat: stateModel.currentSeats[rowI][colI],
                                rowI: rowI,
                                colI: colI,
                                seatSvgSize: stateModel.seatSvgSize,
                                pathSelectedSeat: stateModel.pathSelectedSeat,
                                pathDisabledSeat: stateModel.pathDisabledSeat,
                                pathSoldSeat: stateModel.pathSoldSeat,
                                pathUnSelectedSeat: stateModel.pathUnSelectedSeat,
                                pathOnHoldSeat: stateModel.pathOnHoldSeat
                              ),
                              onSeatStateChanged: onSeatStateChanged
                            ))
                        .toList()
                  ],
                ),
              )
          .toList()
        ],
      ),
    );
  }
}
