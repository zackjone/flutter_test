
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

/// ImageView用来展示图片,本地图片和网络图片
///
/// placeholder为图片加载过程中的占位图，仅限于加载网络图片时候使用
/// 设置边框时候，图片的实际大小值等于设置的宽高 - 边框宽度,设置为圆形图时候，会忽略圆角大小，无论是否设置
class ImageWidget extends StatelessWidget {
  ///展示图片的地址，可以是本地文件名，或者网络图片路径
  final String imageUrl;

  ///图片格式，默认为webp，可以自定义png，jpg等
  final String imageFormat;

  ///占位图，本地资源文件名字
  final String placeholder;

  final double width;

  final double height;

  ///是否是圆形图片
  final bool isCircle;

  ///图片边框大小，默认无
  final double? borderWidth;

  ///图片边框颜色，默认无
  final Color borderColor;

  ///图片边框阴影，默认无
  final BoxShadow? shadow;

  ///图片圆角大小
  final BorderRadiusGeometry? borderRadius;

  /// 图片填充方式
  final BoxFit fit;

  /// 图片内部padding
  final EdgeInsetsGeometry? padding;

  /// 图片外部margin
  final EdgeInsetsGeometry? margin;

  /// 点击事件
  final GestureTapCallback? onClick;

  /// 本地图片强制刷新
  final bool forceLocalLoad;

  final bool haveBg;

  const ImageWidget({
    Key? key,
    required this.imageUrl,
    this.imageFormat = "webp",
    this.placeholder = "",
    this.width = 0,
    this.height = 0,
    this.padding,
    this.margin,
    this.isCircle = false,
    this.borderWidth,
    this.borderColor = const Color(0xFFBDBDBD),
    this.borderRadius,
    this.shadow,
    this.forceLocalLoad = false,
    this.fit = BoxFit.fill,
    this.haveBg = true,
    this.onClick,
  }) : super(key: key);

  static String IMG_CACHE_KEY = 'customCacheKey';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
          margin: margin,
          padding: padding,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: (borderWidth != null)
                  ? Border.all(color: borderColor, width: borderWidth!)
                  : null,
              borderRadius: borderRadius,
              boxShadow: shadow != null ? [shadow!] : null),
          child: isCircle
              ? ClipOval(
                  child: getImageView(),
                )
              : (borderRadius != null
                  ? ClipRRect(
                      borderRadius: borderRadius!,
                      child: getImageView(),
                    )
                  : getImageView())),
    );
  }

  Widget _getImageViewNoWidthHeightSet() {
    if (imageUrl.startsWith("http")) {
      return CachedNetworkImage(
          imageUrl: imageUrl,
          alignment: Alignment.center,
          fit: fit,
          cacheManager: CacheManager(
            Config(
              IMG_CACHE_KEY,
              stalePeriod: const Duration(days: 15),
              maxNrOfCacheObjects: 100,
              repo: JsonCacheInfoRepository(databaseName: IMG_CACHE_KEY),
            ),
          ),
          errorWidget: (context, url, error) {
            return Container(
                width: width,
                height: height,
                color: haveBg ? Color(0xFFEBEBEB) : null,
                child: Center(
                    child: Image.asset(
                  'assets/images/logo_icon_default.webp',
                  fit: BoxFit.contain,
                )));
          },
          placeholder: (context, url) {
            return Container(
                width: width,
                height: height,
                color: haveBg ? Color(0xFFEBEBEB) : null,
                child: Center(
                    child: Image.asset(
                  'assets/images/logo_icon_default.webp',
                  fit: BoxFit.contain,
                )));
          });
    } else {
      ///本地图片加载
      return Image.asset(
        'assets/images/$imageUrl.$imageFormat',
        alignment: Alignment.center,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          return Container(
              width: width,
              height: height,
              color: haveBg ? Color(0xFFEBEBEB) : null,
              child: Center(
                  child: Image.asset(
                'assets/images/logo_icon_default.webp',
                fit: BoxFit.contain,
              )));
        },
      );
    }
  }

  Widget getImageView() {
    //网络图片加载

    if (width == 0 || height == 0) {
      return _getImageViewNoWidthHeightSet();
    }
    if (imageUrl.startsWith("http")) {
      return CachedNetworkImage(
          imageUrl: imageUrl,
          width: width,
          height: height,
          alignment: Alignment.center,
          fit: fit,
          cacheManager: CacheManager(
            Config(
              IMG_CACHE_KEY,
              stalePeriod: const Duration(days: 15),
              maxNrOfCacheObjects: 100,
              repo: JsonCacheInfoRepository(databaseName: IMG_CACHE_KEY),
            ),
          ),
          errorWidget: (context, url, error) {
            return Container(
                width: width,
                height: height,
                color: haveBg ? Color(0xFFEBEBEB) : null,
                child: Center(
                    child: Image.asset(
                  'assets/images/logo_icon_default.webp',
                  fit: BoxFit.contain,
                )));
          },
          placeholder: (context, url) {
            return Container(
                width: width,
                height: height,
                color: haveBg ? Color(0xFFEBEBEB) : null,
                child: Center(
                    child: Image.asset(
                  'assets/images/logo_icon_default.webp',
                  fit: BoxFit.contain,
                )));
          });
    } else {
      ///本地图片加载
      return Image.asset(
        'assets/images/$imageUrl.$imageFormat',
        width: width,
        height: height,
        alignment: Alignment.center,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          return Container(
              width: width,
              height: height,
              color: haveBg ? Color(0xFFEBEBEB) : null,
              child: Center(
                  child: Image.asset(
                'assets/images/logo_icon_default.webp',
                fit: BoxFit.contain,
              )));
        },
      );
    }
  }
}
