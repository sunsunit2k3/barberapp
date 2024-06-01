import 'package:barberapp/pages/booking.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Nguyen Sy Long",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: const Image(
                    image: AssetImage('assets/images/boy.jpg'),
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
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
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('services')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child:
                          CircularProgressIndicator(), // Thay thế bằng một tiêu biểu khác nếu bạn muốn
                    );
                  }
                  final services = snapshot.data!.docs;
                  List<Widget> rows = [];
                  for (int i = 0; i < services.length; i += 2) {
                    // Tạo một hàng mới cho mỗi cặp dịch vụ
                    if (i + 1 < services.length) {
                      rows.add(
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildServiceWidget(services[i]),
                            const SizedBox(
                                width:
                                    20.0), // Khoảng cách giữa hai phần tử trong hàng
                            _buildServiceWidget(services[i + 1]),
                          ],
                        ),
                      );
                    } else {
                      // Trường hợp chỉ còn lại một dịch vụ, thêm một hàng với một phần tử
                      rows.add(
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildServiceWidget(services[i]),
                            // Khoảng cách giữa hai phần tử trong hàng
                          ],
                        ),
                      );
                    }
                    rows.add(const SizedBox(height: 20.0));
                  }
                  return Column(
                    children: rows,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceWidget(DocumentSnapshot service) {
    final serviceName = service['name'];
    final serviceImageURL = service['image_url'];
    return Flexible(
      fit: FlexFit.tight,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Booking(service: serviceName),
            ),
          );
        },
        child: Container(
          height: 150.0,
          decoration: BoxDecoration(
            color: const Color(0XFFe29452),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage(serviceImageURL),
                height: 80,
                width: 80,
              ),
              const SizedBox(height: 10.0),
              Text(
                serviceName,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
