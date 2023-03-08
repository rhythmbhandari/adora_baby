
getBrandName(dynamic categories){
  try {
    if (categories != null && categories.isNotEmpty) {
      for (var element in categories) {
        if (element?.isProductCategory == true) {
          return element?.name ?? '';
        }
      }
    }
    return '';
  } catch (e) {
    return '';
  }
}
