class Service {
  String id;
  String image;
  bool isFavourite;
  String name;
  num price;

  Service({this.id, this.image, this.isFavourite, this.name, this.price});

  Service.fromJson(Map<dynamic, dynamic> json)
      : this(
          id: json["id"] as String,
          image: json['image'] as String,
          isFavourite: json['isFavourite'] as bool,
          name: json['name'] as String,
          price: json['price'] as num,
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'isFavourite': isFavourite,
      'name': name,
      'price': price
    };
  }
}
