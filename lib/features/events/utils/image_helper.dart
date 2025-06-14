String getCategoryImage(String category) {
  final lowerCategory = category.trim().toLowerCase();
  const validCategories = [
    'sports',
    'music',
    'art',
    'technology',
    'education',
    'politics',
    'health',
    'games',
    'culture',
    'other',
  ];

  if (validCategories.contains(lowerCategory)) {
    return 'assets/images/${lowerCategory}_category.jpg';
  } else {
    return 'assets/images/image-not-found.png';
  }
}
