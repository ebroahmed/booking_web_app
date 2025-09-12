class Listing {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  final bool available;

  Listing({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.available,
  });

  factory Listing.fromMap(String id, Map<String, dynamic> data) {
    return Listing(
      id: id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      available: data['available'] ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
      'available': available,
    };
  }
}
