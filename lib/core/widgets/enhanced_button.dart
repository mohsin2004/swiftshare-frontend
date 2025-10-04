import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';

enum ButtonType { primary, secondary, outline, text, danger }

class EnhancedButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonType type;
  final IconData? icon;
  final bool isLoading;
  final bool isFullWidth;
  final EdgeInsets? padding;
  final double? width;
  final double? height;

  const EnhancedButton({
    super.key,
    required this.text,
    this.onPressed,
    this.type = ButtonType.primary,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = false,
    this.padding,
    this.width,
    this.height,
  });

  @override
  State<EnhancedButton> createState() => _EnhancedButtonState();
}

class _EnhancedButtonState extends State<EnhancedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: AppTheme.fastAnimationDuration,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    if (widget.onPressed != null && !widget.isLoading) {
      _animationController.forward();
    }
  }

  void _onTapUp(TapUpDetails details) {
    _animationController.reverse();
  }

  void _onTapCancel() {
    _animationController.reverse();
  }

  Color _getBackgroundColor() {
    if (widget.isLoading || widget.onPressed == null) {
      return AppTheme.textTertiary;
    }

    switch (widget.type) {
      case ButtonType.primary:
        return AppTheme.primaryColor;
      case ButtonType.secondary:
        return AppTheme.surfaceColor;
      case ButtonType.outline:
        return Colors.transparent;
      case ButtonType.text:
        return Colors.transparent;
      case ButtonType.danger:
        return AppTheme.errorColor;
    }
  }

  Color _getTextColor() {
    if (widget.isLoading || widget.onPressed == null) {
      return AppTheme.textTertiary;
    }

    switch (widget.type) {
      case ButtonType.primary:
      case ButtonType.danger:
        return AppTheme.textPrimary;
      case ButtonType.secondary:
        return AppTheme.textPrimary;
      case ButtonType.outline:
        return AppTheme.primaryColor;
      case ButtonType.text:
        return AppTheme.primaryColor;
    }
  }

  Border? _getBorder() {
    if (widget.type == ButtonType.outline) {
      return Border.all(
        color: widget.onPressed != null && !widget.isLoading
            ? AppTheme.primaryColor
            : AppTheme.textTertiary,
        width: 1.5,
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        onTap: widget.onPressed != null && !widget.isLoading
            ? widget.onPressed
            : null,
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: AnimatedContainer(
                duration: AppTheme.fastAnimationDuration,
                width: widget.isFullWidth ? double.infinity : widget.width,
                height: widget.height ?? 48,
                padding: widget.padding ??
                    const EdgeInsets.symmetric(
                      horizontal: AppTheme.spacingL,
                      vertical: AppTheme.spacingM,
                    ),
                decoration: BoxDecoration(
                  color: _getBackgroundColor(),
                  border: _getBorder(),
                  borderRadius: BorderRadius.circular(AppTheme.radiusM),
                  boxShadow: _isHovered && widget.onPressed != null && !widget.isLoading
                      ? AppTheme.buttonShadow
                      : null,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.isLoading)
                      SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(_getTextColor()),
                        ),
                      )
                    else if (widget.icon != null)
                      Icon(
                        widget.icon,
                        size: 18,
                        color: _getTextColor(),
                      ),
                    if (widget.isLoading || widget.icon != null)
                      const SizedBox(width: AppTheme.spacingS),
                    Flexible(
                      child: Text(
                        widget.text,
                        style: TextStyle(
                          color: _getTextColor(),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    ).animate().fadeIn(duration: AppTheme.animationDuration);
  }
}

class GradientButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final bool isFullWidth;
  final EdgeInsets? padding;
  final double? width;
  final double? height;

  const GradientButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = false,
    this.padding,
    this.width,
    this.height,
  });

  @override
  State<GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: AppTheme.fastAnimationDuration,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    if (widget.onPressed != null && !widget.isLoading) {
      _animationController.forward();
    }
  }

  void _onTapUp(TapUpDetails details) {
    _animationController.reverse();
  }

  void _onTapCancel() {
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        onTap: widget.onPressed != null && !widget.isLoading
            ? widget.onPressed
            : null,
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: AnimatedContainer(
                duration: AppTheme.fastAnimationDuration,
                width: widget.isFullWidth ? double.infinity : widget.width,
                height: widget.height ?? 48,
                padding: widget.padding ??
                    const EdgeInsets.symmetric(
                      horizontal: AppTheme.spacingL,
                      vertical: AppTheme.spacingM,
                    ),
                decoration: BoxDecoration(
                  gradient: widget.onPressed != null && !widget.isLoading
                      ? AppTheme.primaryGradient
                      : LinearGradient(
                          colors: [AppTheme.textTertiary, AppTheme.textTertiary],
                        ),
                  borderRadius: BorderRadius.circular(AppTheme.radiusM),
                  boxShadow: _isHovered && widget.onPressed != null && !widget.isLoading
                      ? AppTheme.buttonShadow
                      : null,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.isLoading)
                      const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(AppTheme.textPrimary),
                        ),
                      )
                    else if (widget.icon != null)
                      Icon(
                        widget.icon,
                        size: 18,
                        color: AppTheme.textPrimary,
                      ),
                    if (widget.isLoading || widget.icon != null)
                      const SizedBox(width: AppTheme.spacingS),
                    Flexible(
                      child: Text(
                        widget.text,
                        style: const TextStyle(
                          color: AppTheme.textPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    ).animate().fadeIn(duration: AppTheme.animationDuration);
  }
}
