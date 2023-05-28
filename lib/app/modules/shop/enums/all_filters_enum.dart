enum AllFilters {
  high,
  low,
  recent,
}

extension AllFiltersExtension on AllFilters {
  String get filterName {
    switch (this) {
      case AllFilters.high:
        return 'Sort by Price: High to Low';
      case AllFilters.low:
        return 'Sort by Price: Low to High';
      case AllFilters.recent:
        return 'Sort by Date: Recently Added';
      default:
        return 'Sort by Price: High to Low';
    }
  }

  String get filterSend {
    switch (this) {
      case AllFilters.high:
        return '-regular_price';
      case AllFilters.low:
        return 'regular_price';
      case AllFilters.recent:
        return 'ordering=created_at';
      default:
        return '-regular_price';
    }
  }
}
