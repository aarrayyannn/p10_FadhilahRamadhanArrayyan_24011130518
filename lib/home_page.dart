import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/app_theme.dart';
import 'latihan61_provider/daftar_karyawan_page.dart';
import 'latihan62_riverpod/penggajian_page.dart';
import 'latihan63_bloc/login_bloc_page.dart';
import 'latihan61_provider/cuti_notifier.dart';
import 'models/karyawan.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _buka(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    final jumlahCuti = context.watch<CutiNotifier>().jumlah;

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final wide = constraints.maxWidth >= 760;
            return SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                wide ? 48 : 20,
                24,
                wide ? 48 : 20,
                32,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1180),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: AppColors.accentDark,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Icon(
                              Icons.business_center_rounded,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'HRIS Dashboard',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.ink,
                                  ),
                                ),
                                Text(
                                  'Manajemen Sumber Daya Manusia',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.muted,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceMuted,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircleAvatar(
                                  radius: 14,
                                  backgroundColor: AppColors.accent,
                                  child: Icon(
                                    Icons.person,
                                    size: 17,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Administrator',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.ink,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(wide ? 32 : 24),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Selamat datang kembali',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Kelola cuti, penggajian, dan autentikasi karyawan '
                              'dari satu dashboard.',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.85),
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 22),
                            Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              children: [
                                _SummaryChip(
                                  icon: Icons.people_alt_rounded,
                                  label: '${dummyKaryawan.length} Karyawan',
                                ),
                                _SummaryChip(
                                  icon: Icons.event_available_rounded,
                                  label: '$jumlahCuti Pengajuan Cuti',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 28),
                      const Text(
                        'Menu Praktikum',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: AppColors.ink,
                        ),
                      ),
                      const SizedBox(height: 14),
                      GridView.count(
                        crossAxisCount: wide
                            ? 3
                            : (constraints.maxWidth >= 520 ? 2 : 1),
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: wide ? 1.45 : 1.7,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          _FeatureCard(
                            icon: Icons.beach_access_rounded,
                            iconColor: AppColors.accentDark,
                            iconBackground: AppColors.surfaceMuted,
                            title: 'Pengajuan Cuti',
                            subtitle: 'Kelola cuti karyawan',
                            tag: 'Provider',
                            onTap: () =>
                                _buka(context, const DaftarKaryawanPage()),
                          ),
                          _FeatureCard(
                            icon: Icons.payments_rounded,
                            iconColor: AppColors.accent,
                            iconBackground: AppColors.surfaceMuted,
                            title: 'Penggajian',
                            subtitle: 'Kelola data gaji karyawan',
                            tag: 'Riverpod',
                            onTap: () => _buka(context, const PenggajianPage()),
                          ),
                          _FeatureCard(
                            icon: Icons.lock_person_rounded,
                            iconColor: AppColors.muted,
                            iconBackground: AppColors.surfaceMuted,
                            title: 'Login Sistem',
                            subtitle: 'Autentikasi pengguna',
                            tag: 'Cubit',
                            onTap: () => _buka(context, const LoginBlocPage()),
                          ),
                        ],
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

class _SummaryChip extends StatelessWidget {
  const _SummaryChip({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: Colors.white),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatefulWidget {
  const _FeatureCard({
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
    required this.title,
    required this.subtitle,
    required this.tag,
    required this.onTap,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBackground;
  final String title;
  final String subtitle;
  final String tag;
  final VoidCallback onTap;

  @override
  State<_FeatureCard> createState() => _FeatureCardState();
}

class _FeatureCardState extends State<_FeatureCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        transform: Matrix4.translationValues(0, _hovered ? -4 : 0, 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: _hovered ? AppColors.accent : AppColors.border,
          ),
          boxShadow: [
            BoxShadow(
              color: _hovered
                  ? const Color(0x18202428)
                  : const Color(0x0C202428),
              blurRadius: _hovered ? 24 : 12,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(18),
          child: InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: widget.onTap,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: widget.iconBackground,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(widget.icon, color: widget.iconColor),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceMuted,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          widget.tag,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: AppColors.accent,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: AppColors.ink,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.subtitle,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.muted,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
