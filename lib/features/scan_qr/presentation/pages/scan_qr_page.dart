import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_top_bar.dart';
import '../bloc/scan_bloc.dart';
import '../bloc/scan_event.dart';
import '../bloc/scan_state.dart';
class ScanQrPage extends StatefulWidget {
  const ScanQrPage({super.key});
  @override
  State<ScanQrPage> createState() => _ScanQrPageState();
}
class _ScanQrPageState extends State<ScanQrPage> {
  final MobileScannerController _cameraController = MobileScannerController();
  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppTopBar(),
      body: Stack(
        children: [
          MobileScanner(
            controller: _cameraController,
            onDetect: (BarcodeCapture capture) {
              final barcode = capture.barcodes.firstOrNull;
              if (barcode?.rawValue != null) {
                context
                    .read<ScanBloc>()
                    .add(QrCodeDetected(qrData: barcode!.rawValue!));
              }
            },
          ),
          const _ViewfinderOverlay(),
          Positioned(
            bottom: 300,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                decoration: BoxDecoration(
                  color: AppColors.surface.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                ),
                child: Text(
                  'Arahkan kamera ke QR Code absensi',
                  style: AppTextStyles.bodyMd.copyWith(
                    color: AppColors.onSurface,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _ScanStatusSheet(),
          ),
        ],
      ),
    );
  }
}
class _ViewfinderOverlay extends StatelessWidget {
  const _ViewfinderOverlay();
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: CustomPaint(
        size: MediaQuery.of(context).size,
        painter: _ViewfinderPainter(),
      ),
    );
  }
}
class _ViewfinderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2 - 60);
    const cutoutSize = 260.0;
    const cornerRadius = 12.0;
    final cutoutRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: center, width: cutoutSize, height: cutoutSize),
      const Radius.circular(cornerRadius),
    );
    final overlayPaint = Paint()
      ..color = const Color(0xFF191B23).withValues(alpha: 0.6);
    final overlayPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addRRect(cutoutRect)
      ..fillType = PathFillType.evenOdd;
    canvas.drawPath(overlayPath, overlayPaint);
    final borderPaint = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    canvas.drawRRect(cutoutRect, borderPaint);
    const accentLength = 36.0;
    const accentWidth = 4.0;
    final accentPaint = Paint()
      ..color = AppColors.primaryContainer
      ..style = PaintingStyle.stroke
      ..strokeWidth = accentWidth
      ..strokeCap = StrokeCap.round;
    final rect = cutoutRect.outerRect;
    canvas.drawLine(
      Offset(rect.left - 2, rect.top + cornerRadius),
      Offset(rect.left - 2, rect.top - 2 + accentLength),
      accentPaint,
    );
    canvas.drawLine(
      Offset(rect.left + cornerRadius, rect.top - 2),
      Offset(rect.left - 2 + accentLength, rect.top - 2),
      accentPaint,
    );
    canvas.drawLine(
      Offset(rect.right + 2, rect.top + cornerRadius),
      Offset(rect.right + 2, rect.top - 2 + accentLength),
      accentPaint,
    );
    canvas.drawLine(
      Offset(rect.right - cornerRadius, rect.top - 2),
      Offset(rect.right + 2 - accentLength, rect.top - 2),
      accentPaint,
    );
    canvas.drawLine(
      Offset(rect.left - 2, rect.bottom - cornerRadius),
      Offset(rect.left - 2, rect.bottom + 2 - accentLength),
      accentPaint,
    );
    canvas.drawLine(
      Offset(rect.left + cornerRadius, rect.bottom + 2),
      Offset(rect.left - 2 + accentLength, rect.bottom + 2),
      accentPaint,
    );
    canvas.drawLine(
      Offset(rect.right + 2, rect.bottom - cornerRadius),
      Offset(rect.right + 2, rect.bottom + 2 - accentLength),
      accentPaint,
    );
    canvas.drawLine(
      Offset(rect.right - cornerRadius, rect.bottom + 2),
      Offset(rect.right + 2 - accentLength, rect.bottom + 2),
      accentPaint,
    );
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
class _ScanStatusSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppSpacing.radiusXl),
        ),
        border: const Border(
          top: BorderSide(color: AppColors.outlineVariant),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.12),
            blurRadius: 24,
            offset: const Offset(0, -8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: AppSpacing.sm),
            child: Container(
              width: 32,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.outlineVariant,
                borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            child: BlocBuilder<ScanBloc, ScanState>(
              builder: (context, state) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Riwayat Absensi Bulanan',
                          style: AppTextStyles.titleMd,
                        ),
                        _buildStatusBadge(state),
                      ],
                    ),
                    if (state is ScanFailureState) ...[
                      const SizedBox(height: AppSpacing.sm),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(AppSpacing.sm),
                        decoration: BoxDecoration(
                          color: AppColors.errorContainer.withValues(alpha: 0.5),
                          borderRadius:
                              BorderRadius.circular(AppSpacing.radius),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.info_outline,
                                size: 16, color: AppColors.error),
                            const SizedBox(width: AppSpacing.xs),
                            Expanded(
                              child: Text(
                                state.message,
                                style: AppTextStyles.bodyMd.copyWith(
                                  color: AppColors.error,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    const SizedBox(height: AppSpacing.sm),
                    if (state is ScanSuccess || state is ScanFailureState)
                      Align(
                        alignment: Alignment.centerRight,
                        child: OutlinedButton.icon(
                          onPressed: () {
                            context.read<ScanBloc>().add(const ResetScan());
                          },
                          icon: const Icon(Icons.refresh, size: 18),
                          label: Text(
                            'Scan Ulang',
                            style: AppTextStyles.labelLg,
                          ),
                        ),
                      ),
                    
                    if (state is ScanSuccess && state.result.monthlyHistory.isNotEmpty)
                      Container(
                        height: 200,
                        child: ListView.separated(
                          padding: const EdgeInsets.only(top: AppSpacing.sm),
                          itemCount: state.result.monthlyHistory.length,
                          separatorBuilder: (context, index) => const Divider(height: 1),
                          itemBuilder: (context, index) {
                            final record = state.result.monthlyHistory[index];
                            final dateStr = '${record.date.day.toString().padLeft(2, '0')}/${record.date.month.toString().padLeft(2, '0')}/${record.date.year}';
                            final inStr = record.clockIn != null ? '${record.clockIn!.hour.toString().padLeft(2, '0')}:${record.clockIn!.minute.toString().padLeft(2, '0')}' : '--:--';
                            final outStr = record.clockOut != null ? '${record.clockOut!.hour.toString().padLeft(2, '0')}:${record.clockOut!.minute.toString().padLeft(2, '0')}' : '--:--';
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryContainer,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.check_circle_outline, color: AppColors.primary, size: 20),
                              ),
                              title: Text(dateStr, style: AppTextStyles.labelLg),
                              subtitle: Text('Masuk: $inStr - Keluar: $outStr'),
                              trailing: Text(
                                record.durationMinutes != null && record.durationMinutes! > 0
                                    ? '${record.durationMinutes! ~/ 60}j ${record.durationMinutes! % 60}m'
                                    : '-',
                                style: AppTextStyles.labelMd.copyWith(fontWeight: FontWeight.bold),
                              ),
                            );
                          },
                        ),
                      )
                    else if (state is ScanSuccess && state.result.monthlyHistory.isEmpty)
                      Container(
                        height: 120,
                        child: Center(
                          child: Text(
                            'Belum ada riwayat absensi bulan ini.',
                            style: AppTextStyles.bodyMd.copyWith(color: AppColors.onSurfaceVariant),
                          ),
                        ),
                      )
                    else if (state is ScanIdle || state is ScanProcessing)
                      Container(
                        height: 180,
                        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                        child: Center(
                          child: Text(
                            state is ScanProcessing ? 'Memproses...' : 'Arahkan kamera ke QR Code',
                            style: AppTextStyles.bodyMd.copyWith(
                              color: AppColors.onSurfaceVariant,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
      ),
    );
  }
  Widget _buildStatusBadge(ScanState state) {
    if (state is ScanSuccess) {
      return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: 2,
        ),
        decoration: BoxDecoration(
          color: AppColors.secondaryContainer,
          borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, size: 16, color: AppColors.primary),
            const SizedBox(width: AppSpacing.xs),
            Text(
              'Berhasil',
              style: AppTextStyles.labelMd.copyWith(
                color: AppColors.onSecondaryContainer,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    }
    if (state is ScanFailureState) {
      return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: 2,
        ),
        decoration: BoxDecoration(
          color: AppColors.errorContainer,
          borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 16, color: AppColors.error),
            const SizedBox(width: AppSpacing.xs),
            Text(
              'Gagal',
              style: AppTextStyles.labelMd.copyWith(
                color: AppColors.onErrorContainer,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
