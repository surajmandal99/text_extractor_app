import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

class HomeController extends GetxController {
  var selectedImagePath = ''.obs;
  var extractedText = ''.obs;

  ///get image methodkl
  getImage(ImageSource imageSource) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
    } else {
      Get.snackbar("Error", "image is not selected",
          backgroundColor: Colors.red);
    }
  }

  ///recognise image text method
  Future<void> recognizedText(String pickedImage) async {
    // ignore: unnecessary_null_comparison
    if (pickedImage == null) {
      Get.snackbar("Error", "image is not selected",
          backgroundColor: Colors.red);
    } else {
      extractedText.value = '';
      var textRecognizer = GoogleMlKit.vision.textRecognizer();
      final visionImage = InputImage.fromFilePath(pickedImage);
      try {
        var visionText = await textRecognizer.processImage(visionImage);
        for (TextBlock textBlock in visionText.blocks) {
          for (TextLine textLine in textBlock.lines) {
            for (TextElement textElement in textLine.elements) {
              extractedText.value =
                  '${extractedText.value}${textElement.text} ';
            }
            extractedText.value = "${extractedText.value} \n";
          }
        }
      } catch (e) {
        Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
      }
    }
  }
}

