import 'dart:io';

import 'package:barberapp/widgets/snack_bar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ManageImageScreen extends StatefulWidget {
  const ManageImageScreen({super.key});

  @override
  State<ManageImageScreen> createState() => _ManageImageScreenState();
}

class _ManageImageScreenState extends State<ManageImageScreen> {
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

  Future<void> deleteImage(String url) async {
    try {
      final ref = FirebaseStorage.instance.refFromURL(url);
      await ref.delete();
      setState(() {
        uploadedImages.remove(url);
      });
    } catch (e) {
      debugPrint('Error deleting image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Manage Image",
            style: TextStyle(
                color: Colors.black, fontSize: 30, fontWeight: FontWeight.w600),
          ),
        ),
        backgroundColor: const Color(0xFFF3E5AB),
      ),
      backgroundColor: const Color(0xFFFFF8DC),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text("Click double to delete image",
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 20)),
              IconButton(
                onPressed: pickAndManageImages,
                icon: const Icon(Icons.add_a_photo),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  if (isLoading)
                    const Center(
                      child: CircularProgressIndicator(),
                    )
                  else
                    GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 4.0,
                              mainAxisSpacing: 4.0),
                      itemCount: uploadedImages.length,
                      itemBuilder: (context, index) {
                        final src = uploadedImages.elementAt(index);
                        return GestureDetector(
                          onDoubleTap: () {
                            deleteImage(src);
                            showSnackBar(context, 'Image deleted successfully');
                          },
                          child: Image.network(src),
                        );
                      },
                    ),
                  if (uploadProgress > 0)
                    LinearProgressIndicator(
                      value: uploadProgress,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future pickAndManageImages() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // Append a timestamp to the image name to ensure uniqueness
      final uniqueName =
          '${DateTime.now().millisecondsSinceEpoch}_${image.name}';
      final ref = FirebaseStorage.instance.ref("images").child(uniqueName);

      if (kIsWeb) {
        final imageData = await image.readAsBytes();
        final uploadTask = ref.putData(imageData);
        uploadTask.snapshotEvents.listen((event) {
          setState(() {
            uploadProgress = event.bytesTransferred / event.totalBytes;
          });
        });
        await uploadTask.whenComplete(() async {
          String downloadUrl = await ref.getDownloadURL();
          setState(() {
            uploadedImages.add(downloadUrl);
            uploadProgress = 0.0;
          });
        });
      } else {
        final imageFile = File(image.path);
        final uploadTask = ref.putFile(imageFile);
        uploadTask.snapshotEvents.listen((event) {
          setState(() {
            uploadProgress = event.bytesTransferred / event.totalBytes;
          });
        });
        await uploadTask.whenComplete(() async {
          String downloadUrl = await ref.getDownloadURL();
          setState(() {
            uploadedImages.add(downloadUrl);
            uploadProgress = 0.0;
          });
        });
        showSnackBar(context, 'Image uploaded successfully');
      }
    }
  }
}
