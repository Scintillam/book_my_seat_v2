import 'package:equatable/equatable.dart';
import 'package:vive_models/vive_models.dart';

class SeatLayoutStateModel extends Equatable {
  final int rows;
  final int cols;
  final List<List<SeatAvailability>> currentSeats;
  final int seatSvgSize;
  final String pathSelectedSeat;
  final String pathUnSelectedSeat;
  final String pathSoldSeat;
  final String pathDisabledSeat;
  final String pathOnHoldSeat;

  const SeatLayoutStateModel({
    required this.rows,
    required this.cols,
    required this.currentSeats,
    this.seatSvgSize = 50,
    required this.pathSelectedSeat,
    required this.pathDisabledSeat,
    required this.pathSoldSeat,
    required this.pathUnSelectedSeat,
    required this.pathOnHoldSeat,
  });

  @override
  List<Object?> get props => [
        rows,
        cols,
        seatSvgSize,
        currentSeats,
        pathUnSelectedSeat,
        pathSelectedSeat,
        pathSoldSeat,
        pathDisabledSeat,
      ];
}
