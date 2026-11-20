import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/app_theme.dart';
import 'auth_cubit.dart';
import 'auth_state.dart';
import 'home_bloc_page.dart';

class LoginBlocPage extends StatefulWidget {
  const LoginBlocPage({super.key});

  @override
  State<LoginBlocPage> createState() => _LoginBlocPageState();
}

class _LoginBlocPageState extends State<LoginBlocPage> {
  final _emailController = TextEditingController(text: 'admin@company.com');
  final _passwordController = TextEditingController();
  bool _passwordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomeBlocPage()),
            );
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.pesan),
                backgroundColor: AppColors.error,
              ),
            );
          }
        },
        builder: (context, state) {
          final loading = state is AuthLoading;
          return LayoutBuilder(
            builder: (context, constraints) {
              final wide = constraints.maxWidth >= 850;
              return Stack(
                children: [
                  if (wide)
                    Positioned(
                      right: -90,
                      top: -100,
                      child: Container(
                        width: 280,
                        height: 280,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0x1A202428),
                        ),
                      ),
                    ),
                  SafeArea(
                    child: Center(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.all(wide ? 32 : 20),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxWidth: 980,
                            maxHeight: 620,
                          ),
                          child: Container(
                            constraints: const BoxConstraints(minHeight: 560),
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x14202428),
                                  blurRadius: 40,
                                  offset: Offset(0, 16),
                                ),
                              ],
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: Row(
                              children: [
                                if (wide)
                                  Expanded(
                                    flex: 5,
                                    child: Container(
                                      padding: const EdgeInsets.all(48),
                                      decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            AppColors.accentDark,
                                            AppColors.accent,
                                          ],
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 52,
                                            height: 52,
                                            decoration: BoxDecoration(
                                              color: Colors.white.withValues(
                                                alpha: 0.16,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: const Icon(
                                              Icons.business_center_rounded,
                                              color: Colors.white,
                                              size: 28,
                                            ),
                                          ),
                                          const Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Kelola tim lebih\nmudah.',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 38,
                                                  height: 1.12,
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),
                                              SizedBox(height: 16),
                                              Text(
                                                'Akses pengajuan cuti, penggajian, '
                                                'dan data karyawan dalam satu aplikasi.',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  height: 1.6,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 14,
                                              vertical: 9,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.white.withValues(
                                                alpha: 0.12,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: const Text(
                                              'HR Management System',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                Expanded(
                                  flex: wide ? 5 : 10,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: wide ? 52 : 24,
                                      vertical: 36,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        IconButton(
                                          tooltip: 'Kembali',
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                          icon: const Icon(
                                            Icons.arrow_back_rounded,
                                          ),
                                          style: IconButton.styleFrom(
                                            backgroundColor: const Color(
                                              0xFFF2F4F7,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 22),
                                        const Text(
                                          'Selamat datang',
                                          style: TextStyle(
                                            fontSize: 28,
                                            fontWeight: FontWeight.w800,
                                            color: AppColors.ink,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        const Text(
                                          'Masuk untuk melanjutkan ke sistem HR',
                                          style: TextStyle(
                                            color: AppColors.muted,
                                          ),
                                        ),
                                        const SizedBox(height: 32),
                                        const Text(
                                          'Email',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.ink,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        TextField(
                                          controller: _emailController,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          decoration: _inputDecoration(
                                            hint: 'nama@perusahaan.com',
                                            icon: Icons.mail_outline_rounded,
                                          ),
                                        ),
                                        const SizedBox(height: 18),
                                        const Text(
                                          'Password',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.ink,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        TextField(
                                          controller: _passwordController,
                                          obscureText: !_passwordVisible,
                                          onSubmitted: (_) {
                                            if (!loading) {
                                              context.read<AuthCubit>().login(
                                                _emailController.text.trim(),
                                                _passwordController.text,
                                              );
                                            }
                                          },
                                          decoration: _inputDecoration(
                                            hint: 'Masukkan password',
                                            icon: Icons.lock_outline_rounded,
                                            suffix: IconButton(
                                              onPressed: () => setState(
                                                () => _passwordVisible =
                                                    !_passwordVisible,
                                              ),
                                              icon: Icon(
                                                _passwordVisible
                                                    ? Icons
                                                          .visibility_off_outlined
                                                    : Icons.visibility_outlined,
                                                color: AppColors.muted,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 24),
                                        SizedBox(
                                          width: double.infinity,
                                          height: 52,
                                          child: FilledButton(
                                            onPressed: loading
                                                ? null
                                                : () => context
                                                      .read<AuthCubit>()
                                                      .login(
                                                        _emailController.text
                                                            .trim(),
                                                        _passwordController
                                                            .text,
                                                      ),
                                            style: FilledButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              backgroundColor:
                                                  AppColors.accentDark,
                                            ),
                                            child: loading
                                                ? const SizedBox(
                                                    width: 22,
                                                    height: 22,
                                                    child:
                                                        CircularProgressIndicator(
                                                          strokeWidth: 2.5,
                                                          color: Colors.white,
                                                        ),
                                                  )
                                                : const Text(
                                                    'Masuk',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 10,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors.surfaceMuted,
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            border: Border.all(
                                              color: AppColors.border,
                                            ),
                                          ),
                                          child: const Text(
                                            'Akun uji: admin@company.com / admin123',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: AppColors.accent,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
    Widget? suffix,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: AppColors.muted),
      prefixIcon: Icon(icon, color: AppColors.muted, size: 20),
      suffixIcon: suffix,
      filled: true,
      fillColor: AppColors.surfaceMuted,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.accentDark, width: 1.5),
      ),
    );
  }
}
