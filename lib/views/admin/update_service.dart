import 'package:barberapp/controllers/service_controller.dart';
import 'package:barberapp/models/services.dart';
import 'package:barberapp/views/admin/manage_images.dart';
import 'package:barberapp/widgets/snack_bar.dart';
import 'package:flutter/material.dart';

class UpdateService extends StatefulWidget {
  ServiceModel service;
  UpdateService({super.key, required this.service});

  @override
  State<UpdateService> createState() => _UpdateServiceState();
}

class _UpdateServiceState extends State<UpdateService> {
  ServiceController serviceController = ServiceController();
  String? selectedImageUrl;
  TextEditingController serviceNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    serviceNameController.text = widget.service.name;
    descriptionController.text = widget.service.description;
    selectedImageUrl = widget.service.image_url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Service"),
        backgroundColor: const Color(0xFFF3E5AB),
      ),
      backgroundColor: const Color(0xFFFFF8DC),
      body: Container(
        padding: const EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: serviceNameController,
                onChanged: (value) {
                  widget.service.name = value;
                },
                decoration: InputDecoration(
                  labelText: "Service Name",
                  hintText: "Enter Service Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter service name";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                onChanged: (value) {
                  widget.service.description = value;
                },
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: "Description",
                  hintText: "Enter Description",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter description";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (selectedImageUrl != null)
                    Image.network(
                      selectedImageUrl!,
                      height: 80,
                    )
                  else
                    Image.network(widget.service.image_url, height: 80),
                  GestureDetector(
                    onTap: () async {
                      final selectedImageUrl =
                          await showModalBottomSheet<String>(
                        context: context,
                        builder: (BuildContext context) {
                          return const SizedBox(
                            height: 600,
                            child: ManageImages(),
                          );
                        },
                      );
                      if (selectedImageUrl != null) {
                        setState(() {
                          this.selectedImageUrl = selectedImageUrl;
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).canvasColor,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Colors.black),
                      ),
                      child: const Text(
                        "Select Image",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 20.0),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              GestureDetector(
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    final service = {
                      "image_url": selectedImageUrl,
                      "name": serviceNameController.text,
                      "description": descriptionController.text,
                    };
                    serviceController.updateService(service, widget.service.id);
                    showSnackBar(context, "Updated Service Successfully");
                    Navigator.pop(context);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.black),
                  ),
                  child: const Text(
                    "Update Service",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 20.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
