import 'package:barberapp/controllers/service_controller.dart';
import 'package:barberapp/models/services.dart';
import 'package:barberapp/models/user_model.dart';
import 'package:barberapp/views/admin/add_services.dart';
import 'package:barberapp/views/admin/update_service.dart';
import 'package:flutter/material.dart';

class BookingListScreen extends StatefulWidget {
  UserModel user;

  BookingListScreen({super.key, required this.user});

  @override
  State<BookingListScreen> createState() => _BookingListScreenState();
}

class _BookingListScreenState extends State<BookingListScreen> {
  final ServiceController _controller = ServiceController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          'Sevices Management',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        )),
        backgroundColor: const Color(0xFFF3E5AB),
      ),
      backgroundColor: const Color(0xFFFFF8DC),
      body: Container(
          margin: const EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("List Services",
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 28)),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddService()));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Theme.of(context).canvasColor,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: Colors.black),
                        ),
                        child: const Text(
                          "Add Service",
                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                      ))
                ],
              ),
              const SizedBox(
                height: 40.0,
              ),
              Expanded(
                child: StreamBuilder<List<ServiceModel>>(
                    stream: _controller.getServicesStream(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final service = snapshot.data![index];
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: const Color(0XFFe29452),
                            ),
                            padding: const EdgeInsets.all(10.0),
                            margin: const EdgeInsets.only(bottom: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.network(service.image_url, height: 80,
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  (loadingProgress
                                                          .expectedTotalBytes ??
                                                      1)
                                              : null,
                                    ),
                                  );
                                }, errorBuilder: (BuildContext context,
                                        Object error, StackTrace? stackTrace) {
                                  return const SizedBox.shrink();
                                }),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(service.name),
                                  ],
                                ),
                                Column(
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      UpdateService(
                                                          service: service)));
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).canvasColor,
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            border:
                                                Border.all(color: Colors.black),
                                          ),
                                          child: const Text(
                                            "Update",
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )),
                                    const SizedBox(height: 10),
                                    GestureDetector(
                                        onTap: () {
                                          _controller.deleteService(service.id);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).canvasColor,
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            border:
                                                Border.all(color: Colors.black),
                                          ),
                                          child: const Text(
                                            "Delete",
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ))
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      );
                    }),
              ),
            ],
          )),
    );
  }
}
