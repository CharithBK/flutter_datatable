class Member {
  String nationalID;
  String name;
  String profession;
  String email;
  String affiliation;
  String type;
  String password;
  String status;

  // ignore: non_constant_identifier_names
  Member(NationalID, Name, Profession, Email, Affiliation, Type, Password, Status) {
    //print("test1");
    // print(NationalID.toString());
    this.nationalID = NationalID.toString();
    //("test2");
    this.name = Name.toString();
    this.profession = Profession.toString();
    this.email = Email.toString();
    this.affiliation = Affiliation.toString();
    this.type = Type.toString();
    this.password = Password.toString();
    this.status = Status.toString();
  }

//  Employee({this.NationalID,
//    this.Name,
//    this.Profession,
//    this.Email,
//    this.Affiliation,
//    this.Type,
//    this.Password,
//    this.Status});

  factory Member.fromJson(Map<String, dynamic> json) {
    //   print(json['NationalID']);
//    print(json['Name']);
//    print(json['Email']);
//    print(json['Affiliation']);
//    print(json['Type']);
//    print(json['Password']);
//    print(json['Status']);
    //print(Name);

//    return Employee(
//
//      NationalID: json['NationalID'] ,
//      Name: json['Name'],
//      Profession: json['Profession'] ,
//      Email: json['Email'] ,
//      Affiliation: json['Affiliation'] ,
//      Type: json['Type'] ,
//      Password: json['Password'] ,
//      Status: json['Status'] ,
//
//    );

    return Member(
        json['NationalID'],
        json['Name'],
        json['Profession'],
        json['Email'],
        json['Affiliation'],
        json['Type'],
        json['Password'],
        json['Status']);
  }
}
