import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../controller/home_controller.dart';

// ignore: must_be_immutable
class HomeView extends GetView<HomeController> {
  @override
  var controller = Get.put(HomeController());
  HomeView({Key? key}) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text Extractor App'),
        centerTitle: true,
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ///image box container
            Container(
                height: 220,
                margin: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.blueAccent)),
                child:

                    ///image box scrollview
                    SingleChildScrollView(
                  // scrollDirection: Axis.vertical,
                  child: Obx(
                    () => controller.selectedImagePath.value == ''
                        ? const Padding(
                            padding: EdgeInsets.only(top: 100),
                            child: Center(
                                child: Text(
                                    "Select an image from Gallery / camera")),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.file(
                              File(controller.selectedImagePath.value),
                              width: Get.width,
                              height: 300,
                            ),
                          ),
                  ),
                )),

            ///button row
            Container(
              margin: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        controller.getImage(ImageSource.gallery);
                      },
                      child: const Text("Pick Image")),
                  ElevatedButton(
                      onPressed: () {
                        controller
                            .recognizedText(controller.selectedImagePath.value);
                      },
                      child: const Text("Extract Text")),
                ],
              ),
            ),

            ///text box ScrollView
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                height: 300,
                width: Get.width,
                margin: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.blueAccent),
                ),
                child: Obx(() => controller.extractedText.value.isEmpty
                    ? const Center(child: Text("Text Not Found"))
                    : Center(
                        child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(controller.extractedText.value),
                      ))),
              ),
            )
          ],
        ),
      )),
    );
  }
}
