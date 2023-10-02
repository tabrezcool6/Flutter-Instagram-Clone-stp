// ignore_for_file: avoid_print

import 'package:image_picker/image_picker.dart';

class ImagePickerServices {
  ///
  /// Image Picker Method
  static pickImage(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker();

    XFile? file = await imagePicker.pickImage(source: source);

    if (file != null) {
      return await file.readAsBytes();
    }
    print('No Image Selected');
  }
}
