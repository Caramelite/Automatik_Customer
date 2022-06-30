class Repair {
  int? _totalSize;
  int? _offset;
  late List<RepairDetailsModel> _details;
  List<RepairDetailsModel> get details => _details;

  Repair({required totalSize, required offset, required details}){
    this._totalSize = totalSize;
    this._offset = offset;
    this._details = details;
  }

  Repair.fromJson(Map<String, dynamic> json) {
    _totalSize = json['total_size'];
    _offset = json['offset'];
    if (json['details'] != null) {
      _details = <RepairDetailsModel >[];
      json['details'].forEach((v) {
        details.add(RepairDetailsModel .fromJson(v));
      });
    }
  }

 /* Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_size'] = this.totalSize;
    data['offset'] = this.offset;
    if (this.details != null) {
      data['details'] = this.details!.map((v) => v.toJson()).toList();
    }
    return data;
  }*/
}

class RepairDetailsModel  {
  int? id;
  String? title;
  String? info;
  int? price;
  String? img;
  String? minutes;

  RepairDetailsModel ({this.id, this.title, this.info, this.price, this.img, this.minutes});

  RepairDetailsModel .fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    info = json['info'];
    price = json['price'];
    img = json['img'];
    minutes = json['minutes'];
  }

  /*Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['info'] = this.info;
    data['price'] = this.price;
    data['img'] = this.img;
    data['minutes'] = this.minutes;
    return data;
  }*/
}