import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:masr_a7la/modules/camera/cubit/states.dart';

class CameraCubit extends Cubit<CameraStates> {
  CameraCubit() : super(CameraInitialState());

  static CameraCubit get(context) => BlocProvider.of(context);
  bool isLoading = false;
  File? image;
  void clearImage() {
    image = null;
    emit(ClearImageState());
  }

  void isLoadingTrue() {
    isLoading = true;
    emit(LoadingTrue());
  }

  void isLoadingFalse() {
    isLoading = false;
    emit(LoadingFalse());
  }

  Future<void> getimage() async {
    final picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      emit(CameraImagePickedSuccessState());
    } else {
      debugPrint('No image selected.');
      emit(CameraImagePickedErrorState());
    }
  }
}
