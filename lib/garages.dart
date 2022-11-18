import 'dart:math';

class Garages {
  late final int garageId;
  late final String garageName;
  late final bool isOpened;
  late final double startingPrices;
  late final String imageUrl;

  static final List<Garages> _garagesList = [];

  Garages._({
    this.garageId = -1,
    this.garageName = '',
    this.isOpened = false,
    this.startingPrices = 25,
    this.imageUrl = "",
  });
  static List<Garages> generateData(int count) {
    //int prices = Random().nextInt(250);
    for (int i = 1; i <= count; i++) {
      _garagesList.add(
        Garages._(
          garageId: i,
          garageName: 'Garage $i',
          isOpened: true,
          startingPrices: 50,
        ),
      );
    }
    return _garagesList;
  }

  static Garages getNew({String name = '', int id = 1}) {
    return Garages._(
      garageId: _garagesList.length + 1,
      garageName: name,
      isOpened: true,
      startingPrices: 50,
    );
  }
}

enum Speciality { electric, hybrid, fuel }
