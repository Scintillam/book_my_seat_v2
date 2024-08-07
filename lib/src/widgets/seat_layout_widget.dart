import 'package:book_my_seat/book_my_seat.dart';
import 'package:book_my_seat/src/widgets/seat_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vive_models/vive_models.dart';

const double scenarioHeight = 40;

class SeatLayoutWidget extends StatelessWidget {
  final SeatLayoutStateModel stateModel;
  final TextStyle? titleStyle;
  final List<String> rowNames;
  final TextStyle? numberStyle;
  final String title;
  final Future<void> Function(SeatAvailability seat, TapUpDetails details)
      onSeatStateChanged;

  SeatLayoutWidget({
    Key? key,
    required this.stateModel,
    this.titleStyle,
    this.numberStyle,
    required this.title,
    required this.rowNames,
    required this.onSeatStateChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print("BUILDING LAYOUT WIDGET");
    return SingleChildScrollView(
      primary: true,
      scrollDirection: Axis.vertical,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: scenarioHeight),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: rowNames
                    .map<Widget>((row) => Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(right: 10),
                          height: stateModel.seatSvgSize.toDouble(),
                          child: Text(
                            (row).toString(),
                            textAlign: TextAlign.left,
                            style: titleStyle ??
                                const TextStyle(fontFamily: 'monospace'),
                          ),
                        ))
                    .toList()),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 3.5 * stateModel.seatSvgSize.toDouble()),
                      child: Container(
                        width: stateModel.seatSvgSize * 20.5,
                        height: scenarioHeight,
                        color: const Color(0xffeb3d8c),
                        child: Center(
                            child: Text(title,
                                style: titleStyle ??
                                    const TextStyle(fontFamily: 'monospace'))),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ...List<int>.generate(stateModel.rows, (rowI) => rowI)
                        .map<Row>(
                      (rowI) => Row(
                        children: [
                          ...List<int>.generate(stateModel.cols, (colI) => colI)
                              .map<Widget>((colI) => (colI >
                                      stateModel.currentSeats[rowI].length - 1)
                                  ? SizedBox(
                                      width: stateModel.seatSvgSize.toDouble(),
                                      height: stateModel.seatSvgSize.toDouble())
                                  : SeatWidget(
                                      key: ValueKey('seat_${rowI}_$colI'),
                                      textStyle: numberStyle,
                                      model: SeatModel(
                                          seat: stateModel.currentSeats[rowI]
                                              [colI],
                                          rowI: rowI,
                                          colI: colI,
                                          seatSvgSize: stateModel.seatSvgSize,
                                          pathSelectedSeat:
                                              stateModel.pathSelectedSeat,
                                          pathDisabledSeat:
                                              stateModel.pathDisabledSeat,
                                          pathSoldSeat: stateModel.pathSoldSeat,
                                          pathUnSelectedSeat:
                                              stateModel.pathUnSelectedSeat,
                                          pathOnHoldSeat:
                                              stateModel.pathOnHoldSeat,
                                          pathOnBoughtSeat:
                                              stateModel.pathOnBoughtSeat,
                                          pathComingSoon:
                                              stateModel.pathComingSoon),
                                      onSeatStateChanged: onSeatStateChanged))
                        ],
                      ),
                    )
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
