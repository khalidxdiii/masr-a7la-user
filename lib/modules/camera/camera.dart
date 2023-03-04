import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:masr_a7la/modules/camera/cubit/states.dart';
import 'package:masr_a7la/shared/network/remote/image_uploader.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../shared/component/componant.dart';
import '../../shared/component/icon_card_widget.dart';
import 'cubit/cubit.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var textcontroller = TextEditingController();
    var titlecontroller = TextEditingController();
    var locationcontroller = TextEditingController();
    var formKey = GlobalKey<FormState>();
    //bool isLoading = true;

    return BlocProvider(
      create: (BuildContext context) => CameraCubit(),
      child: BlocConsumer<CameraCubit, CameraStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  //color: Colors.teal[300],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        IconCardGetImageWidget(
                          onTap: CameraCubit.get(context).getimage,
                          onDelete: () {
                            context.read<CameraCubit>().clearImage();
                            debugPrint("del");
                          },
                          image: context.watch<CameraCubit>().image,
                          isSelectedImage:
                              context.watch<CameraCubit>().image != null,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        DefaultTextFild(
                          label: 'عنوان التقرير',
                          controller: titlecontroller,
                          type: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'برجاء ادخال عنوان التقرير';
                            }
                            return null;
                          },
                          prefixIcon: Icons.task,
                          radius: 20,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        DefaultTextFild(
                          label: 'المكان',
                          controller: locationcontroller,
                          type: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'برجاء ادخال المكان ';
                            }
                            return null;
                          },
                          prefixIcon: Icons.explore,
                          radius: 20,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        DefaultTextFild(
                          label: 'تفاصيل التقرير',
                          controller: textcontroller,
                          type: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'برجاء كتابه وصف التقربر';
                            }
                            return null;
                          },
                          prefixIcon: Icons.edit,
                          radius: 20,
                          minLines: 7,
                          maxLines: 7,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        DefaultButton(
                            function: () async {
                              if (formKey.currentState!.validate()) {
                                //context.read<CameraCubit>().isLoadingTrue();
                                var imUp = ImageUploader();
                                var url = await imUp.uploadImage(
                                    context.read<CameraCubit>().image!);
                                bool isDone = await imUp.storeProblem(
                                  url: url,
                                  titleDisc: titlecontroller.text.trim(),
                                  locationDisc: locationcontroller.text.trim(),
                                  problemDisc: textcontroller.text.trim(),
                                );

                                if (isDone) {
                                  debugPrint('done upload image');
                                } else {
                                  debugPrint('finish upload image');
                                }
                                context.read<CameraCubit>().clearImage();
                                titlecontroller.clear();
                                textcontroller.clear();
                                locationcontroller.clear();
                                // context.read<CameraCubit>().isLoadingFalse();

                                var snackBar = SnackBar(
                                  content: Text(
                                    'تم رفع التقرير بنجاح',
                                    style: GoogleFonts.almarai(),
                                  ),
                                  backgroundColor: Colors.teal,
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            },
                            text: 'حفظ')
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
