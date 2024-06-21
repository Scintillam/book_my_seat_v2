import 'package:book_my_seat/book_my_seat.dart';
import 'package:book_my_seat/src/widgets/seat_widget.dart';
import 'package:flutter/material.dart';
import 'package:vive_models/vive_models.dart';

class SeatLayoutWidget extends StatelessWidget {
  final SeatLayoutStateModel stateModel;
  final Future<void> Function(int rowI, int colI, SeatAvailability seat)
      onSeatStateChanged;

  SeatLayoutWidget({
    Key? key,
    required this.stateModel,
    required this.onSeatStateChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      primary: true,
      scrollDirection: Axis.vertical,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List<int>.generate(
              stateModel.rows, (rowI) => rowI + 1).map<Widget>
            (
              (index) => 
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: stateModel.seatSvgSize.toDouble(),
                  child: Text(
                    (index).toString(),
                    textAlign: TextAlign.left,
                    style: const TextStyle(fontFamily: 'monospace'),
                  ),
                )
            ).toList()
          ),
          Expanded(
            child: SingleChildScrollView(
              primary: true,
              scrollDirection: Axis.horizontal,
              child: InteractiveViewer(
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
                              ...List<int>.generate(stateModel.cols, (colI) => colI)
                                  .map<Widget>(
                                    (colI) => (colI > stateModel.currentSeats[rowI].length-1) ? Container() :
                                    SeatWidget(
                                        model: SeatModel(
                                          seat: stateModel.currentSeats[rowI][colI],
                                          rowI: rowI,
                                          colI: colI,
                                          seatSvgSize: stateModel.seatSvgSize,
                                          pathSelectedSeat: stateModel.pathSelectedSeat,
                                          pathDisabledSeat: stateModel.pathDisabledSeat,
                                          pathSoldSeat: stateModel.pathSoldSeat,
                                          pathUnSelectedSeat: stateModel.pathUnSelectedSeat,
                                          pathOnHoldSeat: stateModel.pathOnHoldSeat,
                                          pathOnBoughtSeat: stateModel.pathOnBoughtSeat
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
