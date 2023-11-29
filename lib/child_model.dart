//CLASS MODEL
class ChildModel {
  final String name;
  final String country;
  final bool isNice;

  ChildModel({required this.name, required this.country, required this.isNice});

  ChildModel copyWith({
    String? name,
    String? country,
    bool? isNice,
  }) {
    return ChildModel(
      name: name ?? this.name,
      country: country ?? this.country,
      isNice: isNice ?? this.isNice,
    );
  }
}

