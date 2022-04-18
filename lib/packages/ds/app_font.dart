import 'app_system.dart';

class AppFont {
  TextStyle get title1 => TextStyle(
        height: 1.2,
        fontSize: 32.sp,
        fontWeight: FontWeight.w300,
        color: AppDS.color.contrast,
        leadingDistribution: TextLeadingDistribution.even,
      );

  TextStyle get title2 => TextStyle(
        height: 1.18,
        fontSize: 28.sp,
        fontWeight: FontWeight.w300,
        color: AppDS.color.contrast,
        leadingDistribution: TextLeadingDistribution.even,
      );

  TextStyle get title3 => TextStyle(
        height: 1.18,
        fontSize: 24.sp,
        fontWeight: FontWeight.w300,
        color: AppDS.color.contrast,
        leadingDistribution: TextLeadingDistribution.even,
      );

  TextStyle get headline => TextStyle(
        height: 1.3,
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
        color: AppDS.color.contrast,
        leadingDistribution: TextLeadingDistribution.even,
      );

  TextStyle get body => TextStyle(
        height: 1.5,
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: AppDS.color.contrast,
        leadingDistribution: TextLeadingDistribution.even,
      );

  TextStyle get bodyBold => TextStyle(
        height: 1.5,
        fontSize: 14.sp,
        fontWeight: FontWeight.w700,
        color: AppDS.color.contrast,
        leadingDistribution: TextLeadingDistribution.even,
      );

  TextStyle get bodyLarge => TextStyle(
        height: 1.5,
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
        color: AppDS.color.contrast,
        leadingDistribution: TextLeadingDistribution.even,
      );

  TextStyle get bodySmall => TextStyle(
        height: 1.5,
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: AppDS.color.contrast,
        leadingDistribution: TextLeadingDistribution.even,
      );

  TextStyle get bodySmallBold => TextStyle(
        height: 1.5,
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: AppDS.color.contrast,
        leadingDistribution: TextLeadingDistribution.even,
      );

  TextStyle get buttonSmall => TextStyle(
        height: 1.12,
        fontSize: 12.sp,
        fontWeight: FontWeight.w700,
        color: AppDS.color.white,
        leadingDistribution: TextLeadingDistribution.even,
      );

  TextStyle get buttonMedium => TextStyle(
        height: 1.5,
        letterSpacing: 2,
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: AppDS.color.white,
        leadingDistribution: TextLeadingDistribution.even,
      );

  TextStyle get buttonLarge => TextStyle(
        height: 1.5,
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
        color: AppDS.color.white,
        leadingDistribution: TextLeadingDistribution.even,
      );

  TextStyle get label => TextStyle(
        height: 1.5,
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: AppDS.color.contrast,
        leadingDistribution: TextLeadingDistribution.even,
      );

  TextStyle get caption => TextStyle(
        height: 1.5,
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: AppDS.color.contrast,
        leadingDistribution: TextLeadingDistribution.even,
      );
}
