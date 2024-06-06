import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ManageImages extends StatefulWidget {
  const ManageImages({super.key});

  @override
  State<ManageImages> createState() => _ManageImagesState();
}

class _ManageImagesState extends State<ManageImages> {
  final uploadedImages = <String>[];
  bool isLoading = true;
  double uploadProgress = 0.0;
  @override
  void initState() {
    super.initState();
    loadImage();
  }

  Future loadImage() async {
    final urls = <String>[];
    try {
      final result = await FirebaseStorage.instance.ref('images').listAll();
      for (var ref in result.items) {
        final downloadUrl = await ref.getDownloadURL();
        urls.add(downloadUrl);
      }
      setState(() {
        uploadedImages.addAll(urls);
        isLoading = false;
      });
    } catch (e) {
      debugPrint('Error: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Photo Gallery'),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
              onPressed: pickAndManageImages, icon: const Icon(Icons.photo))
        ],
      ),
      body: Stack(children: [
        isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0),
                itemCount: uploadedImages.length,
                itemBuilder: (context, index) {
                  final src = uploadedImages.elementAt(index);
                  return GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop(src);
                      },
                      child: Image.network(src));
                }),
        if (uploadProgress > 0)
          LinearProgressIndicator(
            value: uploadProgress,
          )
      ]),
    );
  }

  Future pickAndManageImages() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final ref = FirebaseStorage.instance.ref("images").child(image.name);
      if (kIsWeb) {
        final imageData = await image.readAsBytes();
        await ref.putData(imageData);
      } else {
        final imageFile = File(image.path);
        final upLoadTask = ref.putFile(imageFile);
        upLoadTask.snapshotEvents.listen((event) {
          setState(() {
            uploadProgress = event.bytesTransferred / event.totalBytes;
          });
        });
        await ref.putFile(imageFile);
      }
      String downloadUrL = await ref.getDownloadURL();
      setState(() {
        uploadedImages.add(downloadUrL);
        uploadProgress = 0.0;
      });
    }
  }
}
