class Language{
  final int id;
  final String language;
  final String languageCode;

  Language(this.id, this.language, this.languageCode);

  static List<Language> languageList(){
    return <Language>[
      Language(1, 'Eng', 'en'),
      Language(2, 'AR', 'ar'),
    ];
  }
}