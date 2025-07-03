import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class IdentifyCoinPage extends StatefulWidget {
  const IdentifyCoinPage({super.key});

  @override
  State<IdentifyCoinPage> createState() => _IdentifyCoinPageState();
}

class _IdentifyCoinPageState extends State<IdentifyCoinPage> {
  File? _image;
  String? _coinName;
  bool _loading = false;

  Future<String> fetchNyckelToken() async {
    final url = Uri.parse('https://www.nyckel.com/connect/token');
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    final body = {
      'grant_type': 'client_credentials',
      'client_id': 'uqjo47ricrsqbpuwbohrdrzb9qtr2z9q',
      'client_secret':
          'wp6qh8kb8qfvy2tfby7omc02r7eedzfdi1umi4e335inb3d7wdg4sk4ko3zau6x8',
    };

    final response = await http.post(
      url,
      headers: headers,
      body: body,
      encoding: Encoding.getByName('utf-8'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data != null && data['access_token'] != null) {
        return data['access_token'] as String;
      } else {
        throw Exception('Token non trovato nella risposta');
      }
    } else {
      throw Exception(
        'Errore durante il recupero del token: ${response.statusCode}',
      );
    }
  }

  Future<void> _identifyCoin(File image) async {
    setState(() {
      _loading = true;
      _coinName = null;
    });

    try {
      final token = await fetchNyckelToken();
      final uri = Uri.parse(
        'https://www.nyckel.com/v1/functions/coin-type-identification/invoke',
      );

      final request =
          http.MultipartRequest('POST', uri)
            ..headers['Authorization'] = 'Bearer $token'
            ..files.add(await http.MultipartFile.fromPath('data', image.path));

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final label = data['labelName'];
        final confidence = data['confidence'];

        if (label != null && confidence != null && confidence > 0.3) {
          setState(() {
            _coinName = label;
          });
        } else {
          _showError('Predizione inaffidabile (confidence troppo bassa)');
        }
      } else {
        _showError('Errore Nyckel: ${response.statusCode}');
      }
    } catch (e) {
      _showError('Errore durante identificazione: $e');
    }

    setState(() => _loading = false);
  }

  void _showError(String msg) {
    setState(() => _coinName = null);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 90,
        preferredCameraDevice: CameraDevice.rear,
      );
      if (pickedFile != null) {
        final file = File(pickedFile.path);
        setState(() => _image = file);
        await _identifyCoin(file);
      }
    } catch (e) {
      _showError('Camera non disponibile: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3ED),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              onPressed: _loading ? null : _pickImage,
              icon: const Icon(Icons.camera_alt),
              label: const Text('SCATTA FOTO'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFB08D57),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (_loading) const Center(child: CircularProgressIndicator()),
            if (_image != null) ...[
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.file(
                    _image!,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
            if (_coinName != null) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'NOME MONETA SCANSIONATA:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _coinName!,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFB08D57),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
