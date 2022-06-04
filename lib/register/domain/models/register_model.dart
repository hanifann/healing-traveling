class Register {
  final String nama;
  final String email;
  final String password;
  final String alamat;
  final String role;

  Register({required this.nama, required this.email, required this.password, required this.alamat, this.role = 'user'});

  Map<String, dynamic> toJson() => {
      "name": nama,
      "address": alamat,
      "email": email,
      "role": role,
      "password": password,
    };
}