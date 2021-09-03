import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/presentation/common/widgets/custom_button.dart';


class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  static const String IMAGE_URL = "https://image.jimcdn.com/app/cms/image/transf/dimension=1000x10000:format=png/path/s2438491d518fdaa9/image/i3add59b945903421/version/1553695597/image.png";
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final userController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    userController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nouvelle recette"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Form(
                key: formKey,
                child: Expanded(
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 16.0, left: 16.0, right: 16.0, bottom: 8.0),
                        child: TextFormField(
                          controller: titleController,
                          decoration: InputDecoration(
                              labelText: 'Title',
                              border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)))),
                          validator: (value) {
                            if (value?.isEmpty == true) {
                              return 'Please enter a title';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 16.0, left: 16.0, right: 16.0, bottom: 8.0),
                        child: TextFormField(
                          controller: descriptionController,
                          decoration: InputDecoration(
                              labelText: 'Description',
                              border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)))),
                          keyboardType: TextInputType.multiline,
                          minLines: 3,
                          maxLines: 5,
                          validator: (value) {
                            if (value?.isEmpty == true) {
                              return 'Please enter a description';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 16.0, left: 16.0, right: 16.0, bottom: 8.0),
                        child: TextFormField(
                          controller: userController,
                          decoration: InputDecoration(
                              labelText: 'Username',
                              border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)))),
                          validator: (value) {
                            if (value?.isEmpty == true) {
                              return 'Please enter an username';
                            }
                            return null;
                          },
                        ),
                      )
                    ],
                  ),
                )
            ),
            Container(
              margin: const EdgeInsets.all(20.0),
              height: 50.0,
              width: double.infinity,
              alignment: Alignment.center,
              child: CustomButton(
                onTap: () {
                  if (formKey.currentState?.validate() == true) {
                    Recipe recipe = Recipe(
                        titleController.value.text,
                        userController.value.text,
                        IMAGE_URL,
                        descriptionController.value.text,
                        false,
                        new Random().nextInt(100));

                    print(recipe);
                    Navigator.pop(context);
                  }
                },
                title: 'Save',
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Recipe {

  String title;
  String user;
  String imageUrl;
  String description;
  bool isFavorite;
  int favoriteCount;

  Recipe(this.title, this.user, this.imageUrl, this.description,
      this.isFavorite, this.favoriteCount);

  String key() => title.hashCode.toString();
}