import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/app_theme.dart';
import '../models/karyawan.dart';
import 'badge_cuti.dart';
import 'cuti_notifier.dart';
import 'ringkasan_cuti_page.dart';

class DaftarKaryawanPage extends StatelessWidget {
  const DaftarKaryawanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengajuan Cuti'),
        actions: [
          IconButton(
            tooltip: 'Ringkasan cuti',
            icon: const BadgeCuti(),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const RingkasanCutiPage()),
            ),
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
        itemCount: dummyKaryawan.length,
        separatorBuilder: (_, _) => const SizedBox(height: 10),
        itemBuilder: (context, index) =>
            KaryawanCutiTile(karyawan: dummyKaryawan[index], nomor: index + 1),
      ),
    );
  }
}

class KaryawanCutiTile extends StatelessWidget {
  const KaryawanCutiTile({
    super.key,
    required this.karyawan,
    required this.nomor,
  });

  final Karyawan karyawan;
  final int nomor;

  @override
  Widget build(BuildContext context) {
    final mengajukan = context.select<CutiNotifier, bool>(
      (n) => n.sudahMengajukan(karyawan.nik),
    );
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            SizedBox(
              width: 30,
              child: Text(
                nomor.toString().padLeft(2, '0'),
                style: const TextStyle(
                  color: AppColors.muted,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            CircleAvatar(
              backgroundColor: AppColors.surfaceMuted,
              foregroundColor: AppColors.ink,
              child: Text(karyawan.nama.trim().characters.first.toUpperCase()),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    karyawan.nama,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${karyawan.nik} · ${karyawan.divisi}',
                    style: const TextStyle(
                      color: AppColors.muted,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            mengajukan
                ? OutlinedButton(
                    onPressed: () =>
                        context.read<CutiNotifier>().batalkan(karyawan.nik),
                    child: const Text('Batal'),
                  )
                : FilledButton(
                    onPressed: () =>
                        context.read<CutiNotifier>().ajukan(karyawan.nik),
                    child: const Text('Ajukan'),
                  ),
          ],
        ),
      ),
    );
  }
}
