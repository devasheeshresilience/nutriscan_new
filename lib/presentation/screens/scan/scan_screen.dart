import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:nutriscan/domain/entities/food_item.dart';
import 'package:nutriscan/domain/usecases/add_food_item.dart';
import 'package:nutriscan/utils/ocr_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  late CameraController _cameraController;
  late OcrService _ocrService;
  bool _isCameraInitialized = false;
  bool _isFlashOn = false;

  @override
  void initState() {
    super.initState();
    _ocrService = OcrService();
    _requestCameraPermission();
  }

  Future<void> _requestCameraPermission() async {
    final status = await Permission.camera.request();
    if (status.isGranted) {
      _initializeCamera();
    } else {
      // Handle permission denied
    }
  }

  void _initializeCamera() async {
    final cameras = await availableCameras();
    _cameraController = CameraController(cameras[0], ResolutionPreset.high);
    await _cameraController.initialize();
    setState(() {
      _isCameraInitialized = true;
    });
  }

  @override
  void dispose() {
    _cameraController.dispose();
    _ocrService.dispose();
    super.dispose();
  }

  Future<void> _scanImage() async {
    if (!_isCameraInitialized) return;

    try {
      final image = await _cameraController.takePicture();
      final inputImage = InputImage.fromFilePath(image.path);
      final text = await _ocrService.processImage(inputImage);
      final nutritionData = _ocrService.parseText(text);

      if (mounted) {
        _showManualEntryDialog(nutritionData);
      }
    } catch (e) {
      // Handle error
    }
  }

  void _showManualEntryDialog(Map<String, double> initialData) {
    final nameController = TextEditingController();
    final caloriesController =
        TextEditingController(text: initialData['calories']?.toString() ?? '');
    final fatsController =
        TextEditingController(text: initialData['fats']?.toString() ?? '');
    final proteinsController =
        TextEditingController(text: initialData['proteins']?.toString() ?? '');
    final carbsController =
        TextEditingController(text: initialData['carbs']?.toString() ?? '');
    final sugarController =
        TextEditingController(text: initialData['sugar']?.toString() ?? '');
    final fiberController =
        TextEditingController(text: initialData['fiber']?.toString() ?? '');
    final sodiumController =
        TextEditingController(text: initialData['sodium']?.toString() ?? '');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Enter Nutrition Info'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Name')),
                TextField(
                    controller: caloriesController,
                    decoration: const InputDecoration(labelText: 'Calories')),
                TextField(
                    controller: fatsController,
                    decoration: const InputDecoration(labelText: 'Fats (g)')),
                TextField(
                    controller: proteinsController,
                    decoration: const InputDecoration(labelText: 'Proteins (g)')),
                TextField(
                    controller: carbsController,
                    decoration: const InputDecoration(labelText: 'Carbs (g)')),
                TextField(
                    controller: sugarController,
                    decoration: const InputDecoration(labelText: 'Sugar (g)')),
                TextField(
                    controller: fiberController,
                    decoration: const InputDecoration(labelText: 'Fiber (g)')),
                TextField(
                    controller: sodiumController,
                    decoration: const InputDecoration(labelText: 'Sodium (mg)')),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final foodItem = FoodItem(
                  name: nameController.text,
                  calories: double.tryParse(caloriesController.text) ?? 0,
                  fats: double.tryParse(fatsController.text) ?? 0,
                  proteins: double.tryParse(proteinsController.text) ?? 0,
                  carbs: double.tryParse(carbsController.text) ?? 0,
                  sugar: double.tryParse(sugarController.text) ?? 0,
                  fiber: double.tryParse(fiberController.text) ?? 0,
                  sodium: double.tryParse(sodiumController.text) ?? 0,
                  date: DateTime.now(),
                );
                Provider.of<AddFoodItem>(context, listen: false)(foodItem);
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan'),
        actions: [
          IconButton(
            icon: Icon(_isFlashOn ? Icons.flash_on : Icons.flash_off),
            onPressed: () {
              setState(() {
                _isFlashOn = !_isFlashOn;
                _cameraController
                    .setFlashMode(_isFlashOn ? FlashMode.torch : FlashMode.off);
              });
            },
          ),
        ],
      ),
      body: _isCameraInitialized
          ? Stack(
              children: [
                CameraPreview(_cameraController),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: FloatingActionButton(
                      onPressed: _scanImage,
                      child: const Icon(Icons.camera),
                    ),
                  ),
                ),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
