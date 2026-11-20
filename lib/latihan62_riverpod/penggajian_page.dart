import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/app_theme.dart';
import '../models/karyawan.dart';
import 'gaji_detail_page.dart';
import 'gaji_providers.dart';

class PenggajianPage extends ConsumerWidget {
  const PenggajianPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final daftarAsync = ref.watch(daftarGajiProvider);
    final penggajian = ref.watch(penggajianProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Penggajian (${penggajian.totalDiproses} diproses)'),
        actions: [
          IconButton(
            tooltip: 'Refresh',
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(penggajianProvider.notifier).reset();
              ref.invalidate(daftarGajiProvider);
            },
          ),
        ],
      ),
      body: daftarAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, color: AppColors.error, size: 48),
              const SizedBox(height: 8),
              Text('$error', textAlign: TextAlign.center),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () => ref.invalidate(daftarGajiProvider),
                child: const Text('Coba Lagi'),
              ),
            ],
          ),
        ),
        data: (daftar) => ListView.separated(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          itemCount: daftar.length,
          separatorBuilder: (_, _) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final k = daftar[index];
            final sudah = penggajian.diproses.contains(k.nik);
            return Card(
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                leading: CircleAvatar(
                  backgroundColor: AppColors.surfaceMuted,
                  foregroundColor: AppColors.ink,
                  child: Icon(
                    sudah ? Icons.check_rounded : Icons.schedule_rounded,
                  ),
                ),
                title: Text(
                  k.nama,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    '${k.divisi} · ${formatRupiah(k.gajiPokok)}',
                    style: const TextStyle(color: AppColors.muted),
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => GajiDetailPage(nik: k.nik)),
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: FilledButton.icon(
            onPressed: !daftarAsync.hasValue || penggajian.isProcessing
                ? null
                : () => ref
                      .read(penggajianProvider.notifier)
                      .prosesSemua(daftarAsync.requireValue),
            icon: const Icon(Icons.payments),
            label: Text(
              penggajian.isProcessing ? 'Memproses...' : 'Proses Semua',
            ),
          ),
        ),
      ),
    );
  }
}
