import 'package:biblioteca/core/usecase/errors/exceptions.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageHelper {
  Future saveImage(XFile file, String path) async {
    try {
      await file.saveTo(path);
      imageCache.clearLiveImages();
      imageCache.clear();
    } catch (e) {
      throw ImageException();
    }
  }
}
