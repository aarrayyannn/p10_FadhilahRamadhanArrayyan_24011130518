import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/app_theme.dart';
import '../models/karyawan.dart';
import 'cuti_notifier.dart';

class RingkasanCutiPage extends StatelessWidget {
  const RingkasanCutiPage({super.key});

  @override
  Widget build(BuildContext context) {
    final daftarNik = context.watch<CutiNotifier>().pengajuan;
    return Scaffold(
      appBar: AppBar(title: Text('Ringkasan Cuti (${daftarNik.length})')),
      body: daftarNik.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 76,
                    height: 76,
                    decoration: const BoxDecoration(
                      color: AppColors.surfaceMuted,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.event_busy_outlined,
                      size: 34,
                      color: AppColors.accent,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Belum ada pengajuan cuti',
                    style: TextStyle(
                      color: AppColors.muted,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: daftarNik.length,
              separatorBuilder: (_, _) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final nik = daftarNik[index];
                final karyawan = cariKaryawan(nik);
                return Card(
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    leading: const CircleAvatar(
                      backgroundColor: AppColors.surfaceMuted,
                      foregroundColor: AppColors.ink,
                      child: Icon(Icons.event_busy_outlined),
                    ),
                    title: Text(
                      karyawan?.nama ?? nik,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    subtitle: Text(
                      nik,
                      style: const TextStyle(color: AppColors.muted),
                    ),
                    trailing: IconButton(
                      tooltip: 'Batalkan',
                      icon: const Icon(Icons.close),
                      onPressed: () =>
                          context.read<CutiNotifier>().batalkan(nik),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
