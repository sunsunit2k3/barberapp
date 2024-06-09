import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ModalImage extends StatefulWidget {
  String folderName;
  ModalImage({
    super.key,
    required this.folderName,
  });

  @override
  State<ModalImage> createState() => _ModalImageState();
}

class _ModalImageState extends State<ModalImage> {
  final uploadedImages = <String>[];
  bool isLoading = true;
  double uploadProgress = 0.0;
  @override
  void initState() {
    super.initState();
    loadImage(widget.folderName);
  }

  Future loadImage(String folderName) async {
    final urls = <String>[];
    final result = await FirebaseStorage.instance.ref(folderName).listAll();
    for (var ref in result.items) {
      final downloadUrl = await ref.getDownloadURL();
      urls.add(downloadUrl);
    }
    setState(() {
      uploadedImages.addAll(urls);
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Photo Gallery'),
        ),
        backgroundColor: const Color(0xFFF3E5AB),
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
}
