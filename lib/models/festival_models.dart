class FestivalModels {
  String name, image, description, date;
  List<String> quotes;
  List<String> images;

  FestivalModels(
    this.name,
    this.image,
    this.description,
    this.date,
    this.quotes,
    this.images,
  );

  factory FestivalModels.fromMap({required Map data}) => FestivalModels(
        data['name'],
        data['image'],
        data['description'],
        data['date'],
        data['quotes'],
        data['images'],
      );

  Map<String, dynamic> get toMap => {
        'name': name,
        'image': image,
        'description': description,
        'date': date,
        'quotes': quotes,
        'images': images,
      };
}
