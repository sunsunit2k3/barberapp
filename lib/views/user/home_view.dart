// home_view.dart
import 'package:barberapp/controllers/service_controller.dart';
import 'package:barberapp/models/services.dart';
import 'package:barberapp/models/user_model.dart';
import 'package:barberapp/widgets/service_widget.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final UserModel user;
  const Home({super.key, required this.user});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ServiceController _controller = ServiceController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2b1615),
      body: Container(
        margin: const EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Hello",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.user.name,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    widget.user.image,
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      // Handle error here
                      return const Placeholder(
                        fallbackHeight: 80,
                        fallbackWidth: 80,
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            const Divider(color: Colors.white30),
            const SizedBox(height: 20.0),
            const Text(
              "Services",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: StreamBuilder<List<ServiceModel>>(
                stream: _controller.getServicesStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text('No Service not foud.');
                  }
                  final services = snapshot.data!;
                  List<Widget> rows = [];
                  for (int i = 0; i < services.length; i += 2) {
                    // Create a new row for each pair of services
                    if (i + 1 < services.length) {
                      rows.add(
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ServiceWidget(
                                service: services[i], user: widget.user),
                            const SizedBox(width: 20.0),
                            ServiceWidget(
                                service: services[i + 1], user: widget.user)
                          ],
                        ),
                      );
                    } else {
                      // Case where there's only one service left
                      rows.add(
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ServiceWidget(
                                service: services[i], user: widget.user)
                          ],
                        ),
                      );
                    }
                    rows.add(const SizedBox(height: 20.0));
                  }
                  return SingleChildScrollView(
                    child: Column(
                      children: rows,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
