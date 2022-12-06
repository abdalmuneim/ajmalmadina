import 'package:flutter/material.dart';

class CompilationLocation extends StatelessWidget {
  const CompilationLocation({
    Key? key,
    required this.latitude,
    required this.longitude,
  }) : super(key: key);

  final double latitude;
  final double longitude;

  Uri get _thumbnailUri {
    return Uri(
      scheme: 'https',
      host: 'maps.googleapis.com',
      port: 443,
      path: '/maps/api/staticmap',
      queryParameters: {
        'center': '$latitude,$longitude',
        'zoom': '18',
        'size': '600x300',
        'maptype': 'roadmap',
        'key': 'AIzaSyCviU_6acdow5dzNN-P8FpIVFwS3s8H4FE',
        'markers': 'color:red|$latitude,$longitude'
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Image.network(
      '$_thumbnailUri',
      width: 0.9 * MediaQuery.of(context).size.width,
      fit: BoxFit.cover,
    );
  }
}
