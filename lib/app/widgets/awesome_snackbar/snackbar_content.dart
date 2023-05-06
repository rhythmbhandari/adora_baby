import 'asset_path.dart';
import 'content_type.dart';

/// Reflecting proper icon based on the contentType
String assetSVG(SnackContentType contentType) {
  switch (contentType) {
    case SnackContentType.failure:

    /// failure will show `CROSS`
      return AssetsPath.failure;
    case SnackContentType.success:

    /// success will show `CHECK`
      return AssetsPath.success;
    case SnackContentType.warning:

    /// warning will show `EXCLAMATION`
      return AssetsPath.warning;
    case SnackContentType.help:

    /// help will show `QUESTION MARK`
      return AssetsPath.help;
    default:
      return AssetsPath.failure;
  }
}

// static ColorFilter? _getColorFilter(
// ui.Color? color, ui.BlendMode colorBlendMode) =>
// color == null ? null : ui.ColorFilter.mode(color, colorBlendMode);
// }