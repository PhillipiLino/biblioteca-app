import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../domain/errors/exceptions.dart';

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
