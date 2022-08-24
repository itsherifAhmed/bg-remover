import 'dart:io';
import 'dart:typed_data';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';

class HomeController extends GetxController {
  File imageBefor;
  Uint8List imageAfter;
  final picker = ImagePicker();

  Future getImage() async {
    PickedFile pickedFile = await picker.getImage(source: ImageSource.gallery,
    );
    imageBefor=File(pickedFile.path);
    update();
  }

  void uploadImage(File file)async{
    String fileName=file.path.split("/").last;
    print(fileName);
    FormData data=FormData.fromMap({
      "source_image_file":await MultipartFile.fromFile(file.path,filename: fileName),
    });
    Dio dio =Dio();
    var response= await dio.post("https://api.slazzer.com/v2.0/remove_image_background",data: data,options: Options(
        headers: {"API-KEY":"7ddf8aa27121457498816df0e956ae0e"},
        responseType: ResponseType.bytes
    ));
    print(response.data);
    print(response.headers);
    print(response.statusCode);
    print(response.data.runtimeType);
    imageAfter=response.data;
    print(imageAfter);
    update();
  }
}
