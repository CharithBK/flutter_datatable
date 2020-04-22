class Category {
  String categoryID;
  String category;
  String qualifications_Languages;
  String qualifications_IDEs;
  String nationalID;

  // ignore: non_constant_identifier_names
  Category(CategoryID, Category, Qualifications_Languages, Qualifications_IDEs,
      NationalID) {
    this.categoryID = CategoryID.toString();
    this.category = Category.toString();
    this.qualifications_Languages = Qualifications_Languages.toString();
    this.qualifications_IDEs = Qualifications_IDEs.toString();
    this.nationalID = NationalID.toString();
  }

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      json['CategoryID'],
      json['Category'],
      json['Qualifications_Languages'],
      json['Qualifications_IDEs'],
      json['NationalID'],
    );
  }
}
