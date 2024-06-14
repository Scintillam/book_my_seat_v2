import 'package:equatable/equatable.dart';
import 'package:vive_models/vive_models.dart';

class SeatModel extends Equatable {
  final SeatAvailability seat;
  final int rowI;
  final int colI;
  final int seatSvgSize;
  final String pathSelectedSeat;
  final String pathUnSelectedSeat;
  final String pathSoldSeat;
  final String pathDisabledSeat;
  final String pathOnHoldSeat;

  const SeatModel({
    required this.seat,
    required this.rowI,
    required this.colI,
    this.seatSvgSize = 50,
    required this.pathSelectedSeat,
    required this.pathDisabledSeat,
    required this.pathSoldSeat,
    required this.pathUnSelectedSeat,
    required this.pathOnHoldSeat,
  });

  @override
  List<Object?> get props => [
        seat,
        rowI,
        colI,
        seatSvgSize,
        pathSelectedSeat,
        pathDisabledSeat,
        pathSoldSeat,
        pathUnSelectedSeat,
        pathOnHoldSeat,
      ];
}
