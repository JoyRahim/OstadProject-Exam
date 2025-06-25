
abstract class Vehicle {
  int? _speed;
  void move();

  void setSpeed(int speed) {
    _speed = speed;
  }

  int? get getSpeed {
    return _speed;
  }
}

class Car extends Vehicle {
  @override
  void move() {
    print("The car is moving at $_speed km/h");
  }

}

void main() {
  Car carObj = Car();
  carObj.setSpeed(10);
  carObj.move();

}

