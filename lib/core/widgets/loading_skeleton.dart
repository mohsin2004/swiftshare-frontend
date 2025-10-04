import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../theme/app_theme.dart';

class LoadingSkeleton extends StatelessWidget {
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final EdgeInsets? margin;

  const LoadingSkeleton({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      child: Shimmer.fromColors(
        baseColor: AppTheme.surfaceColor,
        highlightColor: AppTheme.cardColor,
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme.surfaceColor,
            borderRadius: borderRadius ?? BorderRadius.circular(AppTheme.radiusM),
          ),
        ),
      ),
    );
  }
}

class StatCardSkeleton extends StatelessWidget {
  const StatCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(AppTheme.spacingM),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(AppTheme.radiusL),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LoadingSkeleton(
                width: 32,
                height: 32,
                borderRadius: BorderRadius.circular(AppTheme.radiusS),
              ),
              LoadingSkeleton(
                width: 24,
                height: 24,
                borderRadius: BorderRadius.circular(AppTheme.radiusS),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingM),
          LoadingSkeleton(
            width: 120,
            height: 16,
            borderRadius: BorderRadius.circular(AppTheme.radiusS),
          ),
          const SizedBox(height: AppTheme.spacingS),
          LoadingSkeleton(
            width: 80,
            height: 24,
            borderRadius: BorderRadius.circular(AppTheme.radiusS),
          ),
          const SizedBox(height: AppTheme.spacingS),
          LoadingSkeleton(
            width: 100,
            height: 14,
            borderRadius: BorderRadius.circular(AppTheme.radiusS),
          ),
        ],
      ),
    );
  }
}

class ChartSkeleton extends StatelessWidget {
  const ChartSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppTheme.spacingM),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(AppTheme.radiusL),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LoadingSkeleton(
            width: 200,
            height: 20,
            borderRadius: BorderRadius.circular(AppTheme.radiusS),
          ),
          const SizedBox(height: AppTheme.spacingM),
          LoadingSkeleton(
            width: double.infinity,
            height: 200,
            borderRadius: BorderRadius.circular(AppTheme.radiusM),
          ),
        ],
      ),
    );
  }
}

class ListItemSkeleton extends StatelessWidget {
  const ListItemSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingM),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(AppTheme.radiusM),
      ),
      child: Row(
        children: [
          LoadingSkeleton(
            width: 48,
            height: 48,
            borderRadius: BorderRadius.circular(AppTheme.radiusM),
          ),
          const SizedBox(width: AppTheme.spacingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LoadingSkeleton(
                  width: 150,
                  height: 16,
                  borderRadius: BorderRadius.circular(AppTheme.radiusS),
                ),
                const SizedBox(height: AppTheme.spacingS),
                LoadingSkeleton(
                  width: 200,
                  height: 14,
                  borderRadius: BorderRadius.circular(AppTheme.radiusS),
                ),
              ],
            ),
          ),
          LoadingSkeleton(
            width: 80,
            height: 32,
            borderRadius: BorderRadius.circular(AppTheme.radiusM),
          ),
        ],
      ),
    );
  }
}

class TableSkeleton extends StatelessWidget {
  final int rows;
  
  const TableSkeleton({
    super.key,
    this.rows = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(AppTheme.radiusL),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(AppTheme.spacingM),
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppTheme.radiusL),
                topRight: Radius.circular(AppTheme.radiusL),
              ),
            ),
            child: Row(
              children: List.generate(4, (index) => 
                Expanded(
                  child: LoadingSkeleton(
                    width: double.infinity,
                    height: 16,
                    borderRadius: BorderRadius.circular(AppTheme.radiusS),
                    margin: const EdgeInsets.symmetric(horizontal: AppTheme.spacingS),
                  ),
                ),
              ),
            ),
          ),
          // Rows
          ...List.generate(rows, (index) => 
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingM),
              decoration: BoxDecoration(
                border: index < rows - 1 
                  ? const Border(bottom: BorderSide(color: AppTheme.textTertiary, width: 0.5))
                  : null,
              ),
              child: Row(
                children: List.generate(4, (colIndex) => 
                  Expanded(
                    child: LoadingSkeleton(
                      width: double.infinity,
                      height: 14,
                      borderRadius: BorderRadius.circular(AppTheme.radiusS),
                      margin: const EdgeInsets.symmetric(horizontal: AppTheme.spacingS),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
