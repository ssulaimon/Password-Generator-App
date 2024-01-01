class PasswordModel {
  int? id;
  String password;
  String title;
  PasswordModel({
    required this.password,
    required this.title,
    this.id,
  });

  toJson() => {
        "password": password,
        "title": title,
      };
  factory PasswordModel.fromJson({required Map<String, dynamic> data}) =>
      PasswordModel(
        password: data['password'],
        title: data['title'],
        id: data['id'],
      );
}
