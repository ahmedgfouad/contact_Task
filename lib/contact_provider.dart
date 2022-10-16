

import 'package:aqflite_contacts/contactClass.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String columnId = 'id';
final String columnName = 'name';
final String columnNumber = 'number';
final String columnUrl = 'rul';
final String contactsTable = 'contacts_table';


class ContactProvider{
  late Database db;

  static final ContactProvider instance =ContactProvider.internal();

  factory ContactProvider(){
    return instance;
  }

  ContactProvider.internal();

  Future open() async {
    db = await openDatabase(join(await getDatabasesPath(), 'todos.db'),
        version: 1, onCreate: (Database db, int version) async {
          await db.execute('''
create table $contactsTable ( 
  $columnId integer primary key autoincrement, 
  $columnName text not null,
  $columnNumber text not null,
  $columnUrl text not null
  )
''');
        });
  }

  Future<Contact> insertContact(Contact contact) async {
    contact.id = await db.insert(contactsTable, contact.toMap());
    return contact;
  }

  Future<int> deleteContact(int id) async {
    return await db.delete(contactsTable, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> updateContact(Contact contact) async {
    return await db.update(contactsTable, contact.toMap(),
        where: '$columnId = ?', whereArgs: [contact.id]);
  }

  Future<List<Contact>> getAllContact() async {
    List<Map<String, dynamic>> todoMaps = await db.query(contactsTable);
    if (todoMaps.length == 0)
      return [];
    else {
      List<Contact> todos = [];
      todoMaps.forEach((element) {
        todos.add(Contact.formMap(element));
      });
      return todos;
    }
  }

  Future close() async => db.close();

}
