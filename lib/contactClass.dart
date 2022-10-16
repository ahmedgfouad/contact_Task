import 'contact_provider.dart';

class Contact {
  int? id;
  late String name;
  late String phone;
  late String url;

  Contact({
    this.id,
    required this.name,
    required this.phone,
    required this.url,
  });

  Contact.formMap(Map<String, dynamic> map) {
    if (map[columnId] != null) this.id = map[columnId];
    this.name = map[columnName];
    this.phone = map[columnNumber];
    this.url = map[columnUrl];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    if (this.id != null) map[columnId] = this.id;
    map[columnName] = this.name;
    map[columnNumber] = this.phone;
    map[columnUrl] = this.url;
    return map ;
  }
}
