class Room {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  final int rating;
  final List<String> amenities;

  Room({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.rating,
    required this.amenities,
  });

  static List<Room> getSampleRooms() {
    return [
      Room(
        id: '1',
        title: 'Chambre de Luxe',
        description: 'La chambre de Luxe offre 50m² d\'espace pensé pour votre bien-être, avec un coin salon séparé et une salle de bain équipée d\'une baignoire et d\'une douche à l\'italienne. Les matériaux de qualité, l\'éclairage soigné et la vue dégagée créent une atmosphère relaxante et chaleureuse.',
        imageUrl: 'assets/images/luxury_room.jpg',
        price: 140,
        rating: 0,
        amenities: ['50m²', 'Coin salon', 'Baignoire', 'Douche italienne', 'Vue dégagée'],
      ),
      Room(
        id: '2',
        title: 'Suite Présidentielle',
        description: 'Notre suite la plus prestigieuse avec 80m² d\'espace luxueux, terrasse privée et service personnalisé 24h/24.',
        imageUrl: 'assets/images/presidential_suite.jpg',
        price: 350,
        rating: 5,
        amenities: ['80m²', 'Terrasse privée', 'Service 24h/24', 'Jacuzzi', 'Vue panoramique'],
      ),
      Room(
        id: '3',
        title: 'Chambre Classique',
        description: 'Élégante chambre de 30m² alliant confort moderne et charme traditionnel.',
        imageUrl: 'assets/images/classic_room.jpg',
        price: 85,
        rating: 4,
        amenities: ['30m²', 'Balcon', 'Minibar', 'WiFi gratuit', 'Climatisation'],
      ),
    ];
  }
}
