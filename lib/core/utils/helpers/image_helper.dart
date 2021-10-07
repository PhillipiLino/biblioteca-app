import 'package:clean_biblioteca/core/usecase/errors/exceptions.dart';
import 'package:image_picker/image_picker.dart';

class ImageHelper {
  Future saveImage(XFile file, String path) async {
    try {
      await file.saveTo(path);
    } catch (e) {
      throw ImageException();
    }
  }
}
