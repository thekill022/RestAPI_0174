import 'package:flutter/material.dart';
import 'package:restapi0174/data/models/hewan_model.dart';
import 'package:restapi0174/ui/widgets/custom_widget.dart';

class EditHewanPage extends StatefulWidget {
  final HewanModel hewan;
  const EditHewanPage({super.key, required this.hewan});

  @override
  State<EditHewanPage> createState() => _EditHewanPageState();
}

class _EditHewanPageState extends State<EditHewanPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _namaController;
  late final TextEditingController _jenisController;
  late final TextEditingController _tanggalLahirController;
  late final TextEditingController _hargaController;
  String? _status;

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.hewan.nama);
    _jenisController = TextEditingController(text: widget.hewan.jenis);
    _tanggalLahirController = TextEditingController(text: widget.hewan.tanggalLahir);
    _hargaController = TextEditingController(text: widget.hewan.harga.toString());
    _status = widget.hewan.status;
  }

  @override
  void dispose() {
    _namaController.dispose();
    _jenisController.dispose();
    _tanggalLahirController.dispose();
    _hargaController.dispose();
    super.dispose();
  }

  void _onUpdate() {
    if (_formKey.currentState!.validate()) {
      // update data
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Hewan'),
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
                onPressed: _onUpdate,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  backgroundColor: Colors.deepPurple,
                ),
                child: const Text('Update', style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
