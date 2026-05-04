import 'package:flutter/material.dart';
import 'package:restapi0174/ui/widgets/custom_widget.dart';

class AddHewanPage extends StatefulWidget {
  const AddHewanPage({super.key});

  @override
  State<AddHewanPage> createState() => _AddHewanPageState();
}

class _AddHewanPageState extends State<AddHewanPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _jenisController = TextEditingController();
  final _tanggalLahirController = TextEditingController();
  final _hargaController = TextEditingController();
  String? _status;

  @override
  void dispose() {
    _namaController.dispose();
    _jenisController.dispose();
    _tanggalLahirController.dispose();
    _hargaController.dispose();
    super.dispose();
  }

  void _onSimpan() {
    if (_formKey.currentState!.validate()) {
      // simpan data
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Hewan'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTextField(
                controller: _namaController,
                label: 'Nama Hewan',
                hint: 'Masukkan nama hewan',
                prefixIcon: Icons.pets,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _jenisController,
                label: 'Jenis Hewan',
                hint: 'Masukkan jenis hewan',
                prefixIcon: Icons.category,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _tanggalLahirController,
                label: 'Tanggal Lahir',
                hint: 'YYYY-MM-DD',
                prefixIcon: Icons.calendar_today,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _hargaController,
                label: 'Harga',
                hint: 'Masukkan harga',
                prefixIcon: Icons.attach_money,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _status,
                decoration: InputDecoration(
                  labelText: 'Status',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                items: ['Tersedia', 'Terjual', 'Dipesan']
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
                onChanged: (val) => setState(() => _status = val),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _onSimpan,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  backgroundColor: Colors.deepPurple,
                ),
                child: const Text('Simpan', style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
