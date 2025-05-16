import 'package:flutter/material.dart';

class PaymentButtonWidget extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final Color backgroundColor;

  final double borderRadius;
  final double width;
  final double height;

  const PaymentButtonWidget({
    super.key,
    required this.child,
    required this.onPressed,
    this.backgroundColor = Colors.blueAccent,
    this.borderRadius = 12.0,
    this.width = double.infinity,
    this.height = 50
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        onPressed: onPressed,
        child: Center(child: child)
      ),
    );
  }
}
