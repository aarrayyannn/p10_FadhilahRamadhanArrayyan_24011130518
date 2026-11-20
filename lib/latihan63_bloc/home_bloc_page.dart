import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/app_theme.dart';
import 'auth_cubit.dart';
import 'auth_state.dart';
import 'login_bloc_page.dart';

class HomeBlocPage extends StatelessWidget {
  const HomeBlocPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ruang Kerja')),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          final nama = state is Authenticated ? state.nama : '-';
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 720),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'SESI AKTIF',
                      style: TextStyle(
                        color: AppColors.muted,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(28),
                      decoration: BoxDecoration(
                        color: AppColors.accentDark,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 32,
                            backgroundColor: AppColors.surfaceMuted,
                            foregroundColor: AppColors.ink,
                            child: Icon(Icons.person_outline_rounded, size: 30),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Selamat datang,',
                                  style: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.72),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  nama,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.verified_user_outlined,
                              color: AppColors.accent,
                            ),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Text(
                                'Autentikasi berhasil',
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                            ),
                            OutlinedButton.icon(
                              onPressed: () {
                                context.read<AuthCubit>().logout();
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const LoginBlocPage(),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.logout_rounded),
                              label: const Text('Logout'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
