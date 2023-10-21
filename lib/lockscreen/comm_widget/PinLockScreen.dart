import 'package:boot_navigation/lockscreen/comm_widget/type_def.dart';
import 'package:flutter/material.dart';

import 'HiddenDots.dart';
import 'NumPad.dart';

class PinLockScreen extends StatefulWidget {
  const PinLockScreen({
    super.key,
    required this.correctPin,
    required this.pinLength,
    this.onPinMatched,
    this.onPinChanged,
    this.disableDotColor,
    this.wrongPinDotColor,
    this.filledPinDotColor,
    this.buttonElevation,
    this.dotsShape,
    this.gapBtwDotsAndNumPad,
    this.buttonBackgroundColor,
    this.buttonForegroundColor,
    this.buttonBorderRadius,
    this.buttonSize,
    this.numPadVerticalSpacing,
    this.numPadHorizontalSpacing,
  });
  final int correctPin;
  final int pinLength;
  final OnPinMatched? onPinMatched;
  final OnPinChanged? onPinChanged;
  final Color? disableDotColor;

  final Color? wrongPinDotColor;

  final Color? filledPinDotColor;

  final double? buttonElevation;

  final BoxShape? dotsShape;

  final double? gapBtwDotsAndNumPad;

  final Color? buttonBackgroundColor;

  final Color? buttonForegroundColor;

  final double? buttonBorderRadius;

  final Size? buttonSize;

  final double? numPadVerticalSpacing;

  final double? numPadHorizontalSpacing;

  @override
  State<PinLockScreen> createState() => _PinLockScreenState();
}

class _PinLockScreenState extends State<PinLockScreen> {
  String value = '';
  bool? isEnteredCorrect;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        HiddenDots(
          values: value,
          pinLength: widget.pinLength,
          isCorrect: isEnteredCorrect,
          disableDotColor: widget.disableDotColor,
          wrongPinColor: widget.wrongPinDotColor,
          fillPinColor: widget.filledPinDotColor,
          dotsShape: widget.dotsShape,
        ),
        SizedBox(height: widget.gapBtwDotsAndNumPad ?? 60),
        NumPad(
          onDelete: _onDelete,
          onNumberTap: _onNumberTap,
          buttonElevation: widget.buttonElevation,
          buttonBackgroundColor: widget.buttonBackgroundColor,
          buttonForegroundColor: widget.buttonForegroundColor,
          buttonRadius: widget.buttonBorderRadius,
          buttonSize: widget.buttonSize,
          numPadVerticalSpacing: widget.numPadVerticalSpacing,
          numPadHorizontalSpacing: widget.numPadHorizontalSpacing,
        ),
      ],
    );
  }

  Future<void> _onNumberTap(int number) async {
    if (value.length < widget.pinLength) {
      setState(() {
        value += number.toString();
        widget.onPinChanged?.call(value);
      });
    }
    if (value.length == widget.pinLength) {
      final isCorrect = int.parse(value) == widget.correctPin;

      isEnteredCorrect = isCorrect;

      if (isCorrect) {
        widget.onPinMatched?.call(int.parse(value));
      } else {
        value = '';
        await Future.delayed(const Duration(milliseconds: 300), () {
          setState(() {
            isEnteredCorrect = null;
          });
        });
      }
    }
  }

  void _onDelete() {
    if (value.isNotEmpty) {
      setState(() {
        value = value.substring(0, value.length - 1);
        isEnteredCorrect = null;
        widget.onPinChanged?.call(value);
      });
    }
  }
}
