class Student {
  String category;
  String nationalID;
  String name;
  String profession;
  String email;
  String affiliation;
  String qualifications_Languages;
  String qualifications_IDEs;

  // ignore: non_constant_identifier_names
  Student(Category, NationalID, Name, Profession,Email,Affiliation,Qualifications_Languages,Qualifications_IDEs) {
    this.category = Category.toString();
    this.nationalID = NationalID.toString();
    this.name = Name.toString();
    this.profession = Profession.toString();
    this.email = Email.toString();
    this.affiliation = Affiliation.toString();
    this.qualifications_Languages = Qualifications_Languages.toString();
    this.qualifications_IDEs = Qualifications_IDEs.toString();
  }

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      json['Category'],
      json['NationalID'],
      json['Name'],
      json['Profession'],
      json['Email'],
      json['Affiliation'],
      json['Qualifications_Languages'],
      json['Qualifications_IDEs'],

    );
  }
}
