class Order {
  num sum;
  num tax;
  num sumPlusTax;
  List serviceList;
  List priceList;
  String location;
  String time;
  String date;

  Order({
    this.sum,
    this.tax,
    this.sumPlusTax,
    this.location,
    this.serviceList,
    this.priceList,
    this.date,
    this.time,
  });

  Order.fromJson(Map<dynamic, dynamic> json)
      : this(
          sum: json['sum'] as num,
          tax: json['tax'] as num,
          sumPlusTax: json['sumPlusTax'] as num,
          serviceList: json['serviceList'] as List,
          priceList: json['priceList'] as List,
          date: json['date'] as String,
          time: json['time'] as String,
          location: json['location'] as String,
        );

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'time': time,
      'serviceList': serviceList,
      'priceList': priceList,
      'location': location,
      "sum": sum,
      "tax": tax,
      "sumPlusTax": sumPlusTax,
    };
  }
}
