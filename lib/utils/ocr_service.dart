import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class OcrService {
  final TextRecognizer _textRecognizer = TextRecognizer();

  Future<String> processImage(InputImage inputImage) async {
    final RecognizedText recognizedText =
        await _textRecognizer.processImage(inputImage);
    return recognizedText.text;
  }

  Map<String, double> parseText(String text) {
    final Map<String, double> nutritionData = {};
    final lines = text.split('\n');

    for (final line in lines) {
      final lowerCaseLine = line.toLowerCase();
      if (lowerCaseLine.contains('calories')) {
        nutritionData['calories'] = _extractValue(line);
      } else if (lowerCaseLine.contains('fat')) {
        nutritionData['fats'] = _extractValue(line);
      } else if (lowerCaseLine.contains('protein')) {
        nutritionData['proteins'] = _extractValue(line);
      } else if (lowerCaseLine.contains('carbohydrate')) {
        nutritionData['carbs'] = _extractValue(line);
      } else if (lowerCaseLine.contains('sugar')) {
        nutritionData['sugar'] = _extractValue(line);
      } else if (lowerCaseLine.contains('fiber')) {
        nutritionData['fiber'] = _extractValue(line);
      } else if (lowerCaseLine.contains('sodium')) {
        nutritionData['sodium'] = _extractValue(line);
      }
    }
    return nutritionData;
  }

  double _extractValue(String line) {
    final regex = RegExp(r'(\d+(\.\d+)?)');
    final match = regex.firstMatch(line);
    if (match != null) {
      return double.parse(match.group(0)!);
    }
    return 0.0;
  }

  void dispose() {
    _textRecognizer.close();
  }
}
