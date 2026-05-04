import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restapi0174/data/models/hewan_model.dart';
import 'package:restapi0174/logic/bloc/hewan/hewan_bloc.dart';
import 'package:restapi0174/logic/bloc/hewan/hewan_event.dart';
import 'package:restapi0174/logic/bloc/hewan/hewan_state.dart';
import 'package:restapi0174/ui/pages/dashboard_page.dart';
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
  final List<String> _statusList = const ['Tersedia', 'Terjual', 'Dipesan'];

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.hewan.nama);
    _jenisController = TextEditingController(text: widget.hewan.jenis);
    _tanggalLahirController = TextEditingController(text: widget.hewan.tanggalLahir);
    _hargaController = TextEditingController(text: widget.hewan.harga.toString());
    _status = _normalizeStatus(widget.hewan.status);
  }

  @override
  void dispose() {
    _namaController.dispose();
    _jenisController.dispose();
    _tanggalLahirController.dispose();
    _hargaController.dispose();
    super.dispose();
  }

  String? _normalizeStatus(String status) {
    for (final s in _statusList) {
      if (s.toLowerCase() == status.toLowerCase()) return s;
    }
    return null;
  }

  void _onUpdate() {
    if (_formKey.currentState!.validate()) {
      final data = {
        'nama': _namaController.text.trim(),
        'jenis': _jenisController.text.trim(),
        'tanggal_lahir': _tanggalLahirController.text.trim(),
        'harga': int.tryParse(_hargaController.text) ?? 0,
        'status': _status,
      };
      context.read<HewanBloc>().add(UpdateHewan(widget.hewan.id, data));
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
      body: BlocListener<HewanBloc, HewanState>(
        listener: (context, state) {
          if (state is HewanCreatedSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Data hewan berhasil diperbarui')),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const DashboardPage()),
            );
          } else if (state is HewanError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Form(
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
                  validator: (v) => v == null || v.isEmpty ? 'Nama tidak boleh kosong' : null,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _jenisController,
                  label: 'Jenis Hewan',
                  hint: 'Masukkan jenis hewan',
                  prefixIcon: Icons.category,
                  validator: (v) => v == null || v.isEmpty ? 'Jenis tidak boleh kosong' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _tanggalLahirController,
                  readOnly: true,
                  validator: (v) => v == null || v.isEmpty ? 'Tanggal lahir tidak boleh kosong' : null,
                  decoration: InputDecoration(
                    labelText: 'Tanggal Lahir',
                    hintText: 'Pilih tanggal lahir',
                    prefixIcon: const Icon(Icons.calendar_today),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade400)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.deepPurple, width: 2)),
                  ),
                  onTap: () async {
                    DateTime initial = DateTime.tryParse(_tanggalLahirController.text) ?? DateTime.now();
                    final date = await showDatePicker(
                      context: context,
                      initialDate: initial,
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                    );
                    if (date != null) {
                      _tanggalLahirController.text = date.toIso8601String().split('T').first;
                    }
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _hargaController,
                  label: 'Harga',
                  hint: 'Masukkan harga',
                  prefixIcon: Icons.attach_money,
                  keyboardType: TextInputType.number,
                  validator: (v) => v == null || v.isEmpty ? 'Harga tidak boleh kosong' : null,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _status,
                  decoration: InputDecoration(
                    labelText: 'Status',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  items: _statusList
                      .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                      .toList(),
                  onChanged: (val) => setState(() => _status = val),
                  validator: (v) => v == null ? 'Status harus dipilih' : null,
                ),
                const SizedBox(height: 24),
                BlocBuilder<HewanBloc, HewanState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: state is HewanLoading ? null : _onUpdate,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        backgroundColor: Colors.deepPurple,
                      ),
                      child: state is HewanLoading
                          ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                          : const Text('Update', style: TextStyle(fontSize: 16, color: Colors.white)),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
