import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/app_text_style.dart';
import '../../../../core/navigation/route_enum.dart';
import '../../../../core/utils/size_utils.dart';

class EntryScreen extends StatefulWidget {
  const EntryScreen({super.key});

  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _marqueeCtrl;

  @override
  void initState() {
    super.initState();
    _marqueeCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 7000))..repeat();
  }

  @override
  void dispose() {
    _marqueeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkScaffold,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // "Lumière" Image at the top
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(AppImages.entryBanner), fit: BoxFit.cover),
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  SafeArea(
                    bottom: false,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.only(top: getVerticalSize(14, context)),
                        child: Text('Lumière', style: AppTextStyle.heroBrandOverlay),
                      ),
                    ),
                  ),

                  // Watermark overlay
                  Positioned(
                    bottom: getVerticalSize(1, context),
                    left: 0,
                    right: 0,
                    child: Opacity(
                      opacity: 0.25,
                      child: Text(
                        'Lumière',
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: AppTextStyle.heroBrandOverlay.copyWith(
                          fontSize: getFontSize(100, context),
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          letterSpacing: 2.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: getVerticalSize(5, context)),

          // Bottom cards
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Continuous marquee ticker
              Container(
                width: double.infinity,
                padding: getPadding(context: context, vertical: 24),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.all(Radius.circular(getHorizontalSize(20, context))),
                ),
                child: _Marquee(
                  text: 'TRENDY COLLECTION',
                  style: AppTextStyle.heroHeadline.copyWith(fontSize: getFontSize(52, context)),
                  controller: _marqueeCtrl,
                ),
              ),

              SizedBox(height: getVerticalSize(5, context)),

              // Discover Now
              _DiscoverButton(onTap: () => Navigator.pushNamed(context, RouteEnum.home.path)),
              SizedBox(height: getVerticalSize(10, context)),
            ],
          ),
        ],
      ),
    );
  }
}

// Marquee widget
class _Marquee extends StatefulWidget {
  final String text;
  final TextStyle style;
  final AnimationController controller;

  const _Marquee({required this.text, required this.style, required this.controller});

  @override
  State<_Marquee> createState() => _MarqueeState();
}

class _MarqueeState extends State<_Marquee> {
  late final double _textWidth;
  late final double _textHeight;

  @override
  void initState() {
    super.initState();
    final tp = TextPainter(
      text: TextSpan(text: widget.text, style: widget.style),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    )..layout(maxWidth: double.infinity);
    _textWidth = tp.width;
    _textHeight = tp.height;
  }

  @override
  Widget build(BuildContext context) {
    const gap = 80.0;
    final total = _textWidth + gap;

    return ClipRect(
      child: SizedBox(
        width: double.infinity,
        height: _textHeight,
        child: AnimatedBuilder(
          animation: widget.controller,
          builder: (_, child) {
            final offset = widget.controller.value * total;
            return Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(left: -offset, child: child!),
                Positioned(left: total - offset, child: child),
              ],
            );
          },
          child: Text(widget.text, style: widget.style, maxLines: 1, softWrap: false),
        ),
      ),
    );
  }
}

class _DiscoverButton extends StatelessWidget {
  final VoidCallback onTap;
  const _DiscoverButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      // Increased height to match the large button in the image
      height: getVerticalSize(90, context),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            // Increased radius for full pill shape
            borderRadius: BorderRadius.circular(getHorizontalSize(20, context)),
          ),
        ),
        child: Text('Discover Now', style: AppTextStyle.buttonLabel.copyWith(fontSize: getFontSize(16, context))),
      ),
    );
  }
}
