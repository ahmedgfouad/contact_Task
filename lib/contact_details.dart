import 'package:aqflite_contacts/contact_provider.dart';
import 'package:flutter/material.dart';

import 'contactClass.dart';

class ContactDetails extends StatefulWidget {
  Contact contact;
  ContactDetails(this.contact);

  @override
  State<ContactDetails> createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {
  TextEditingController nameController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  TextEditingController urlController=TextEditingController();
  late ContactProvider contact;
  @override
  void initState() {
    super.initState();
    contact =ContactProvider();
    nameController.text=widget.contact.name;
    phoneController.text=widget.contact.phone;
    urlController.text=widget.contact.url;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.blue[900],
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Contact Details",
          style: TextStyle(
              color: Colors.blue[800],
              fontWeight: FontWeight.bold,
              fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CircleAvatar(
                radius: 80,
                child: Image.network(''),
              ),
              SizedBox(
                height: 40,
              ),
              TextField(
                controller:  urlController,
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
                    hintText: 'Contact Number',
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600],
                        fontSize: 19)),
              ),
              TextField(
                controller:  phoneController,
                decoration: InputDecoration(
                    hintText: 'Contact Number',
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600],
                        fontSize: 19)),
              ),
              SizedBox(
                height: 40,
              ),
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Save Contact'),
                          content: Text(
                              'Are you sure you want to save this contact '),
                          actions: [
                            TextButton(
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              child: Text("Cancel",
                                  style: TextStyle(
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),),

                            TextButton(
                              onPressed: (){
                                ContactProvider.instance.updateContact(Contact(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  url: urlController.text,
                                ));
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: Text( 'Yes',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),),

                            ),
                          ],
                        );
                      });
                },
                child: Container(
                  height: 40,
                  width: double.infinity,
                  color: Colors.blue,
                  child: Center(
                    child: Text(
                      "Save",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Delete Contact'),
                          content: Text(
                              'Are you sure you want to delete this contact '),
                          actions: [
                            TextButton(
                                onPressed: (){
                                  Navigator.pop(context);
                                },
                                child: Text(   "Cancel",
                                style: TextStyle(
                                color: Colors.grey[600],
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),),

                            TextButton(
                              onPressed: () async {
                                if (widget.contact.id != null)
                                  await ContactProvider.instance.deleteContact(widget.contact.id!);
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: Text( 'Yes',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),),

                            ),
                          ],
                        );
                      });
                },
                child: Container(
                  height: 40,
                  width: double.infinity,
                  color: Colors.blue,
                  child: Center(
                    child: Text(
                      "DELETE",
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
        ),
      ),
    );
  }
}
