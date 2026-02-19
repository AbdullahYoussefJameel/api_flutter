import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:api_flutter/cubit/user_cubit.dart';
import 'package:api_flutter/cubit/user_state.dart';

class PickImageWidget extends StatelessWidget {
  const PickImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = context.read<UserCubit>();

        return SizedBox(
          width: 130,
          height: 130,
          child: context.read<UserCubit>().profilePic == null
              ? CircleAvatar(
                  backgroundColor: Colors.grey.shade200,
                  backgroundImage: cubit.profilePic != null
                      ? FileImage(File(cubit.profilePic!.path))
                      : const AssetImage("assets/images/avatar.png")
                            as ImageProvider,
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 5,
                        right: 5,
                        child: GestureDetector(
                          onTap: () async {},
                          child: Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                              color: Colors.blue.shade400,
                              border: Border.all(color: Colors.white, width: 3),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                ImagePicker()
                                    .pickImage(source: ImageSource.gallery)
                                    .then(
                                      (value) => context
                                          .read<UserCubit>()
                                          .uploadProfilePic(value!),
                                    );
                              },

                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 22,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : CircleAvatar(
                  backgroundImage: FileImage(
                    File(context.read<UserCubit>().profilePic!.path),
                  ),
                ),
        );
      },
    );
  }
}
