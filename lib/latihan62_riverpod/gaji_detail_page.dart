import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/app_theme.dart';
import '../models/karyawan.dart';
import 'gaji_providers.dart';

class GajiDetailPage extends ConsumerWidget {
  const GajiDetailPage({super.key, required this.nik});
  final String nik;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(gajiDetailProvider(nik));
    final sudah = ref.watch(
      penggajianProvider.select((s) => s.diproses.contains(nik)),
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          'Detail Gaji',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: detailAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.error_outline_rounded,
                  size: 52,
                  color: AppColors.error,
                ),
                const SizedBox(height: 12),
                Text(
                  '$error',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: AppColors.muted),
                ),
              ],
            ),
          ),
        ),
        data: (k) => LayoutBuilder(
          builder: (context, constraints) {
            final wide = constraints.maxWidth >= 760;
            return SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                wide ? 48 : 20,
                12,
                wide ? 48 : 20,
                32,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 840),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(wide ? 28 : 22),
                        decoration: BoxDecoration(
                          color: AppColors.accentDark,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x29202428),
                              blurRadius: 24,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: wide ? 72 : 58,
                              height: wide ? 72 : 58,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text(
                                  k.nama.isNotEmpty
                                      ? k.nama.trim().split(' ').first[0]
                                      : '?',
                                  style: TextStyle(
                                    color: AppColors.accentDark,
                                    fontSize: wide ? 30 : 24,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 18),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    k.nama,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: wide ? 24 : 19,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(
                                        alpha: 0.16,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.badge_outlined,
                                          size: 15,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          'NIK ${k.nik}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: _DetailCard(
                              icon: Icons.apartment_rounded,
                              iconColor: AppColors.accentDark,
                              iconBackground: AppColors.surfaceMuted,
                              label: 'Divisi',
                              value: k.divisi,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: _DetailCard(
                              icon: sudah
                                  ? Icons.check_circle_rounded
                                  : Icons.schedule_rounded,
                              iconColor: AppColors.accent,
                              iconBackground: AppColors.surfaceMuted,
                              label: 'Status Penggajian',
                              value: sudah
                                  ? 'Sudah diproses'
                                  : 'Belum diproses',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(wide ? 26 : 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: AppColors.border),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x0C202428),
                              blurRadius: 16,
                              offset: Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: AppColors.surfaceMuted,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: const Icon(
                                Icons.payments_rounded,
                                color: AppColors.accentDark,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Gaji Pokok',
                                    style: TextStyle(
                                      color: AppColors.muted,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    formatRupiah(k.gajiPokok),
                                    style: const TextStyle(
                                      color: AppColors.ink,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.surfaceMuted,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                'Per bulan',
                                style: TextStyle(
                                  color: AppColors.accent,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _DetailCard extends StatelessWidget {
  const _DetailCard({
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBackground;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 118,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0C202428),
            blurRadius: 16,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: iconBackground,
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Icon(icon, size: 20, color: iconColor),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.muted,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.ink,
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
