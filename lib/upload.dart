import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import '../datamodel.dart';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import 'customtext.dart';

class PostDataScreen extends StatefulWidget {
  const PostDataScreen({super.key});

  @override
  _PostDataScreenState createState() => _PostDataScreenState();
}

class _PostDataScreenState extends State<PostDataScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  String imageUrl = "";
  final TextEditingController brandController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String selectedcollection = 'tshirt'; // Default document

  void submitData() {
    String name = nameController.text;
    double price = double.parse(priceController.text);
    String brand = brandController.text;
    String description = descriptionController.text;

    Product product = Product(
      PName: name,
      price: price,
      PImage: imageUrl,
      brand: brand,
      description: description,
    );

    // Posting data to Firebase
    FirebaseFirestore.instance
        .collection(selectedcollection)
        .doc()
        .set(product.toJson())
        .then((_) {
      // Data posted successfully
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data posted to Firebase')),
      );
    }).catchError((error) {
      // Error occurred while posting data
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    });
  }

  File? _imageFile;
  XFile? file;

  // Function to pick an image using the image_picker package
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    file = await picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      setState(() {
        _imageFile = File(file!.path);
      });
    }

    if (file == null) return;
    //step 4 create unique name for image
    String imageName = DateTime.now().microsecondsSinceEpoch.toString();

    //steep two is to upload the image.
    //import storage libray
    //to ipload we need a reference of the file and to do that we need to create the reference
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImage = referenceRoot.child('imagestest');
    //create a reference for the specific file we are uploading
    Reference referenceImagetoUpload = referenceDirImage.child(imageName);
    // Step 5 upload the image to storage
    // chek wheher the image has been uploage using a try catch block
    try {
      await referenceImagetoUpload
          .putFile(File(file!.path))
          .whenComplete(() => {
                imageUrl = referenceImagetoUpload.getDownloadURL().toString(),
                print('this is the url$imageUrl'),
              });
      //if succesfull get url
      imageUrl = await referenceImagetoUpload.getDownloadURL();
      print('this is the url$imageUrl');
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    _pickImage();
                  },
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    child: _imageFile != null
                        ? Image.file(_imageFile!, fit: BoxFit.cover)
                        : const Center(
                            child: Text('Press to select image'),
                          ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomText(
                  hintText: 'Name',
                  textInputType: TextInputType.text,
                  textController: nameController,
                  isPass: false,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomText(
                  hintText: 'Price',
                  textInputType: TextInputType.number,
                  textController: priceController,
                  isPass: false,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomText(
                  hintText: 'Brand',
                  textInputType: TextInputType.text,
                  textController: brandController,
                  isPass: false,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomText(
                  hintText: 'Description',
                  textInputType: TextInputType.text,
                  textController: descriptionController,
                  isPass: false,
                ),
                const SizedBox(
                  height: 20,
                ),
                DropdownButton<String>(
                  iconEnabledColor: Colors.lightBlue,
                  value: selectedcollection,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedcollection = newValue!;
                    });
                  },
                  items: <String>[
                    'tshirt',
                    'shoes',
                    'trousers',
                    'jacket',
                    'accessories',
                    'combo'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                ElevatedButton(
                  onPressed: submitData,
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
