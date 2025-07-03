import 'package:flutter/material.dart';
import 'package:coin/data/coin_repository.dart';
import 'package:coin/models/coin.dart';
import 'package:coin/models/numismatic_rarity.dart';
import 'package:coin/models/option_conservation.dart';

class AddCoin extends StatefulWidget {
  final CoinRepository repository;
  const AddCoin({super.key, required this.repository});

  @override
  State<AddCoin> createState() => _AddCoinScreenState();
}

class _AddCoinScreenState extends State<AddCoin> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _yearCtrl = TextEditingController();
  final _materialCtrl = TextEditingController();
  final _weightCtrl = TextEditingController();
  final _diameterCtrl = TextEditingController();
  final _heightCtrl = TextEditingController();
  final _priceCtrl = TextEditingController();

  OptionConservation? _selObv;
  OptionConservation? _selRev;
  NumismaticRarity? _selRar;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _yearCtrl.dispose();
    _materialCtrl.dispose();
    _weightCtrl.dispose();
    _diameterCtrl.dispose();
    _heightCtrl.dispose();
    _priceCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate() ||
        _selObv == null ||
        _selRev == null ||
        _selRar == null) {
      return;
    }

    final coin = Coin(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: _nameCtrl.text,
      year: int.parse(_yearCtrl.text),
      material: _materialCtrl.text,
      weight: double.parse(_weightCtrl.text),
      diameter: double.parse(_diameterCtrl.text),
      height: double.parse(_heightCtrl.text),
      price: double.parse(_priceCtrl.text),
      conservationObverse: _selObv!,
      conservationReverse: _selRev!,
      degree: _selRar!,
    );

    await widget.repository.addCoin(coin);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          '✅ MONETA INSERITA CORRETTAMENTE',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: const Color(0xFFFFF8E1),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('AGGIUNGI MONETA'),
        backgroundColor: const Color(0xFFB08D57),
      ),
      backgroundColor: const Color(0xFFF5F3ED),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField('NOME', _nameCtrl),
              _buildTextField('ANNO', _yearCtrl, isNumeric: true),
              _buildTextField('MATERIALE', _materialCtrl),
              _buildTextField('PESO (g)', _weightCtrl, isNumeric: true),
              _buildTextField('DIAMETRO (mm)', _diameterCtrl, isNumeric: true),
              _buildTextField('ALTEZZA (mm)', _heightCtrl, isNumeric: true),
              _buildTextField('PREZZO (€)', _priceCtrl, isNumeric: true),
              _buildCustomDropdown<OptionConservation>(
                label: 'CONSERVAZIONE FRONTE',
                values: OptionConservation.values,
                selected: _selObv,
                onChanged: (v) => setState(() => _selObv = v),
                labelBuilder: (e) => e.wording,
              ),
              _buildCustomDropdown<OptionConservation>(
                label: 'CONSERVAZIONE RETRO',
                values: OptionConservation.values,
                selected: _selRev,
                onChanged: (v) => setState(() => _selRev = v),
                labelBuilder: (e) => e.wording,
              ),
              _buildCustomDropdown<NumismaticRarity>(
                label: 'GRADO NUMISMATICO',
                values: NumismaticRarity.values,
                selected: _selRar,
                onChanged: (v) => setState(() => _selRar = v),
                labelBuilder: (e) => e.wording,
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text('SALVA MONETA'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFB08D57),
                  foregroundColor: Colors.white,
                ),
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController ctrl, {
    bool isNumeric = false,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: ctrl,
        keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.black, width: 2),
          ),
        ),
        validator: (v) => v == null || v.isEmpty ? 'Campo obbligatorio' : null,
      ),
    );
  }

  Widget _buildCustomDropdown<T>({
    required String label,
    required List<T> values,
    required T? selected,
    required ValueChanged<T?> onChanged,
    required String Function(T) labelBuilder,
  }) {
    const outer = Color(0xFFF5F3ED);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: GestureDetector(
        onTap: () async {
          final picked = await showDialog<T>(
            context: context,
            barrierDismissible: true,
            barrierColor: Colors.black54,
            builder:
                (_) => Dialog(
                  backgroundColor: outer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  insetPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 40,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children:
                            values.map((e) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4,
                                ),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(30),
                                  onTap: () => Navigator.pop(context, e),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 2,
                                      ),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                      horizontal: 16,
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(labelBuilder(e)),
                                  ),
                                ),
                              );
                            }).toList(),
                      ),
                    ),
                  ),
                ),
          );
          if (picked != null) onChanged(picked);
        },
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: label,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.black, width: 2),
            ),
          ),
          child: Text(
            selected == null ? 'Seleziona' : labelBuilder(selected),
            style: TextStyle(
              color: selected == null ? Colors.grey : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
