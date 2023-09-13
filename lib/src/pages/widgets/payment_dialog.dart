import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:green_grocer/src/models/order/order_item_model.dart';
import 'package:green_grocer/src/services/utils_services.dart';

class PaymentDialog extends StatelessWidget {
  final OrderModel order;
  PaymentDialog({super.key, required this.order});

  final UtilsServices utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Conteúdo
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Titulo
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Pagamento com Pix',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),

                // QR Code
                Image.memory(
                  utilsServices.decodeQrCodeImage(order.qrCodeImage),
                  height: 200,
                  width: 200,
                ),

                // Vencimento
                Text(
                  'Vencimento: ${utilsServices.formatDateTime(order.overdueDateTime)}',
                  style: const TextStyle(fontSize: 12),
                ),

                // Total
                Text(
                  'Total: ${utilsServices.priceToCurrency(order.total)}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),

                // Botão Copia e Cola
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    side: const BorderSide(width: 2, color: Colors.green),
                  ),
                  onPressed: () {
                    FlutterClipboard.copy(order.copyAndPaste);
                    utilsServices.showToast(message: 'Código PIX copiado!');
                  },
                  icon: const Icon(
                    Icons.copy,
                    size: 15,
                  ),
                  label: const Text(
                    'Copiar código Pix',
                    style: TextStyle(fontSize: 13),
                  ),
                )
              ],
            ),
          ),

          // Botão para Fechar
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close),
            ),
          ),
        ],
      ),
    );
  }
}
