class Validation {
  Validation._(); // Ngăn không cho tạo instance của lớp này

  // Kiểm tra email hợp lệ
  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return "Email không được để trống";
    }
    
    // Biểu thức chính quy kiểm tra email
    String emailPattern =
        r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";
    RegExp regex = RegExp(emailPattern);
    
    if (!regex.hasMatch(email)) {
      return "Email không hợp lệ";
    }
    
    return null; // hợp lệ
  }

  // Kiểm tra password hợp lệ
  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return "Password không được để trống";
    }

    // Kiểm tra password có ít nhất 8 ký tự, một ký tự viết hoa, một ký tự đặc biệt và một số
    String passwordPattern = r'^(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$';
    RegExp regex = RegExp(passwordPattern);

    if (!regex.hasMatch(password)) {
      return "Password phải có ít nhất 8 ký tự, bao gồm chữ cái viết hoa, số và ký tự đặc biệt";
    }

    return null; // hợp lệ
  }
}
