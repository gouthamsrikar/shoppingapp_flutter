class Httpexception implements Exception{
  final String message;
Httpexception(this.message);

@override
  String toString() {
    
    return message;
  }
}
