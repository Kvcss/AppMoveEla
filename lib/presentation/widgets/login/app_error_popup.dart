import 'package:flutter/material.dart';

Future<void> showErrorPopup(
    BuildContext context, {
      required String title,
      required String message,
    }) async {
  final cs = Theme.of(context).colorScheme;

  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (ctx) {
      return Dialog(
        backgroundColor: Colors.white,              // ⬅️ branco puro
        surfaceTintColor: Colors.transparent,        // ⬅️ remove o “rosa” do Material 3
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // header rosa
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              decoration: BoxDecoration(
                color: cs.primary,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: const Center(
                child: Text(
                  'Account failed',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 4),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black87,             // bom contraste no fundo branco
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => Navigator.of(ctx).maybePop(),
              child: Text(
                'OK',
                style: TextStyle(
                  color: cs.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      );
    },
  );
}
