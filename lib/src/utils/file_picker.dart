
import 'package:file_picker/file_picker.dart';

class FilePickerUtil {
  Future<PlatformFile> getFiles() async {
    FilePickerResult? result;
    try {
      result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.any,
      );
    } catch (e) {
      throw Exception(e);
    }

    return result!.files.first;
  }
}
