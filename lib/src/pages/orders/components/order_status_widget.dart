import 'package:flutter/material.dart';
import 'package:green_grocer/src/config/custom_colors.dart';

class OrderStatusWidget extends StatelessWidget {
  final String status;
  final bool isOverdue;

  const OrderStatusWidget(
      {super.key, required this.status, required this.isOverdue});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _StatusDot(title: 'Teste de pagamento', isActive: true),
        _StatusDot(title: 'Pagamento Efetuado',  isActive: false),
      ],
    );
  }
}

class _StatusDot extends StatelessWidget {
  final bool isActive;
  final String title;

  const _StatusDot({required this.isActive, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Dot
        Container(
          alignment: Alignment.center,
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: CustomColors.customSwatchColor,
            ),
            color:
                isActive ? CustomColors.customSwatchColor : Colors.transparent,
          ),
          child: isActive
              ? const Icon(
                  Icons.check,
                  size: 13,
                  color: Colors.white,
                )
              : const SizedBox.shrink(),
        ),

        const SizedBox(width: 5),

        // Textp
        Expanded(
          child: Text(title),
        ),
      ],
    );
  }
}
