import 'package:aqflite_contacts/contact_details.dart';
import 'package:aqflite_contacts/contact_provider.dart';
import 'package:flutter/material.dart';

import 'contactClass.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

List<Contact> contactList = [];

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "My Contacts",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: FutureBuilder(
          future: ContactProvider.instance.getAllContact(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            if (snapshot.hasData) {
              contactList = snapshot.data!;
              return GridView.builder(
                  itemCount: contactList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    Contact contact = contactList[index];
                    return Padding(
                        padding: EdgeInsets.all(20),
                        child: InkWell(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>  ContactDetails(contact)),
                            );
                          },
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 50,
                                child: Image.network(contact.url),
                              ),
                              Text(
                                contact.name,
                                style: TextStyle(
                                    color: Colors.grey[700],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                              ),
                              Text(
                                contact.phone,
                              ),
                            ],
                          ),
                        ));
                  });
            }
            return Center(
              child: Container(
                height: 100,
                width: 100,
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await showModalBottomSheet(
              context: context,
              builder: (context) {
                return BottomSheetCustomWidget();
              });
          setState(() {});
        },
      ),
    );
  }
}

class BottomSheetCustomWidget extends StatefulWidget {
  const BottomSheetCustomWidget({Key? key}) : super(key: key);

  @override
  State<BottomSheetCustomWidget> createState() =>
      _BottomSheetCustomWidgetState();
}

class _BottomSheetCustomWidgetState extends State<BottomSheetCustomWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController urlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          TextField(
            controller: urlController,
            decoration: InputDecoration(
                hintText: 'Contact image URL',
                hintStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                    fontSize: 19)),
          ),
          TextField(
            controller: nameController,
            decoration: InputDecoration(
                hintText: 'Contact Name',
                hintStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                    fontSize: 19)),
          ),
          TextField(
            controller: phoneController,
            decoration: InputDecoration(
                hintText: 'Contact Number',
                hintStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                    fontSize: 19)),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              ContactProvider.instance.insertContact(Contact(
                name: nameController.text,
                phone: phoneController.text,
                url: urlController.text,
              ));
              Navigator.pop(context);
            },
            child: Container(
              height: 40,
              width: double.infinity,
              color: Colors.blue,
              child: Center(
                child: Text(
                  "ADD",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
