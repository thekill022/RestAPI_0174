import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restapi0174/data/models/hewan_model.dart';
import 'package:restapi0174/logic/bloc/hewan/hewan_bloc.dart';
import 'package:restapi0174/logic/bloc/hewan/hewan_event.dart';
import 'package:restapi0174/logic/bloc/hewan/hewan_state.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    context.read<HewanBloc>().add(FetchHewan());
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'tersedia':
        return Colors.green;
      case 'terjual':
        return Colors.red;
      case 'dipesan':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Hewan'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: BlocConsumer<HewanBloc, HewanState>(
        listener: (context, state) {
          if (state is HewanError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is HewanLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is HewanLoaded) {
            final list = state.hewanList;
            if (list.isEmpty) {
              return const Center(
                child: Text('Tidak ada data hewan'),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: list.length,
              itemBuilder: (context, index) {
                final hewan = list[index];
                return _buildHewanCard(hewan);
              },
            );
          }

          if (state is HewanError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${state.message}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<HewanBloc>().add(FetchHewan());
                    },
                    child: const Text('Coba Lagi'),
                  ),
                ],
              ),
            );
          }

          return const Center(child: Text('Memuat data...'));
        },
      ),
    );
  }

  Widget _buildHewanCard(HewanModel hewan) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    hewan.nama,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(hewan.status).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    hewan.status,
                    style: TextStyle(
                      color: _getStatusColor(hewan.status),
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('Jenis: ${hewan.jenis}'),
            Text('Tanggal Lahir: ${hewan.tanggalLahir}'),
            Text(
              'Harga: Rp ${hewan.harga.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.deepPurple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
