import 'package:barberapp/models/services.dart';
import 'package:barberapp/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:barberapp/views/home/booking_view.dart';

class ServiceWidget extends StatelessWidget {
  final ServiceModel service;
  final UserModel user;
  const ServiceWidget({
    super.key,
    required this.service,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final serviceName = service.name;
    final serviceImageURL = service.image_url;
    return Flexible(
      fit: FlexFit.tight,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Booking(service: serviceName, user: user),
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
