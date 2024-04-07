import "package:flutter/material.dart";
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import "package:musicplayer_app/index.dart";
import 'package:provider/provider.dart';

class PermissionHandler extends StatelessWidget {
  const PermissionHandler({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'We Need Your Permission',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Text(
                'To deliver the best experience, we need access to your device storage to query songs. Please allow this permission to continue.',
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  _requestPermission(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: const Text(
                  'Allow Permission',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _requestPermission(BuildContext context) async {
    PermissionStatus status;
    int sdkVersion = await DeviceInfoPlugin()
        .androidInfo
        .then((info) => info.version.sdkInt);
    print("sdkVersion $sdkVersion");
    if (sdkVersion < 33) {
      status = await Permission.storage.request();
    } else {
      status = await Permission.audio.request();
    }
    print(status);

    if (status == PermissionStatus.denied) {
      print("permission denied");
      openAppSettings();
      await Future.delayed(const Duration(seconds: 5));
      if (await Permission.storage.isPermanentlyDenied ||
          await Permission.audio.isPermanentlyDenied) {
        return Future.error("Permission not allowed");
      }
    }
    if (status == PermissionStatus.permanentlyDenied) {
      openAppSettings();
      return Future.error("Permission permanently denied");
    }
    if (status == PermissionStatus.granted) {
      Provider.of<MainProvider>(context, listen: false).currentPage(0);
    }
  }
}
