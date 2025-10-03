enum BeerType {
  light,
  ale,
  wheat,
  porter,
  lager,
  stout,
  marzen,
  dunkel,
  pilsner;

  String get label {
    return switch (this) {
      light => "Light",
      ale => "Ale",
      wheat => "Wheat",
      porter => "Porter",
      lager => "Lager",
      stout => "Stout",
      marzen => "Marzen",
      dunkel => "Dunkel",
      pilsner => "Pilsner",
    };
  }
}
