import 'package:clean_biblioteca/core/usecase/errors/exceptions.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ImageHelper {
  Future saveImage(XFile file, String name) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final myImagePath = '${directory.path}/$name';
      await file.saveTo(myImagePath);
    } catch (e) {
      throw ImageException();
    }
  }
}
