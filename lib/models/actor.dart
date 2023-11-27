class Actor {
  final int id;
  final String name;
  final DateTime dateOfBirth;
  final String pictureUrl;

  Actor({
    required this.id,
    required this.name,
    required this.dateOfBirth,
    required this.pictureUrl,
  });

  // Calculating age from date of birth
  int get age {
    final currentDate = DateTime.now();
    int age = currentDate.year - dateOfBirth.year;
    if (dateOfBirth.month > currentDate.month || (dateOfBirth.month == currentDate.month && dateOfBirth.day > currentDate.day)) {
      age--;
    }
    return age;
  }

  // Factory method for JSON conversion if needed
  factory Actor.fromJson(Map<String, dynamic> json) {
    return Actor(
      id: json['id'],
      name: json['name'],
      dateOfBirth: DateTime.parse(json['birthday']),
      pictureUrl: 'https://image.tmdb.org/t/p/w500${json['profile_path']}', // Modify the URL according to your needs
    );
  }
}
