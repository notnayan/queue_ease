const location = [
  Location(destination: "Chahabil", price: 2000),
  Location(destination: "Ekantakuna", price: 3000),
  Location(destination: "Radhe Radhe", price: 4000),
];

class Location {
  final String destination;
  final num price;

  const Location({required this.destination, required this.price});
}
