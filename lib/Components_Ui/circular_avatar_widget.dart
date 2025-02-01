import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CircularAvatarWidget extends StatefulWidget {
  const CircularAvatarWidget(
      {super.key, this.radius, this.uploadedImage, this.existingImage});

  final Function(String?)? uploadedImage;
  final String? existingImage;

  final double? radius;

  @override
  State<CircularAvatarWidget> createState() => _CircularAvatarWidgetState();
}

class _CircularAvatarWidgetState extends State<CircularAvatarWidget> {
  late XFile? cameraPhoto;
  late XFile? galleryImage;
  String? picturePath; // = 'assets/sample/user.png';
  ImagePicker imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          final img = await showModalBottomSheet<String>(
            context: context,
            backgroundColor: Colors.grey,
            builder: (c) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () async {
                    cameraPhoto =
                        await imagePicker.pickImage(source: ImageSource.camera);
                    if (cameraPhoto != null) {
                      picturePath = cameraPhoto!.path;
                      Navigator.pop(context, picturePath);
                    }
                  },
                  splashColor: Colors.transparent,
                  child: const ListTile(
                    title: Center(
                      child: Text(
                        'Camera',
                      ),
                    ),
                  ),
                ),
                const Divider(),
                InkWell(
                  onTap: () async {
                    galleryImage = await imagePicker.pickImage(
                        source: ImageSource.gallery);
                    if (galleryImage != null) {
                      picturePath = galleryImage!.path;
                      Navigator.pop(context, picturePath);
                    }
                  },
                  splashColor: Colors.transparent,
                  child: const ListTile(
                      title: Center(
                    child: Text(
                      'Gallery',
                    ),
                  )),
                ),
              ],
            ),
          );

          if (img != null) {
            widget.uploadedImage!(img);
          }
        },
        child: CircleAvatar(
          radius: widget.radius ?? 50,
          backgroundImage: picturePath != null
              ? FileImage(File(picturePath!)) as ImageProvider<Object>
              : widget.existingImage != null
                  ? NetworkImage(widget.existingImage!) as ImageProvider<Object>
                  : const AssetImage('lib/img/user.png'),
        ));
  }
}
