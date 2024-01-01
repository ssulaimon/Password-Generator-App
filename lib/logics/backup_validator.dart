class BackupValidator {
  static String? backupValidator({required String text}) {
    if (text.isEmpty) {
      return 'Title cannot be empty';
    } else if (text.length < 4) {
      return 'Title is too short';
    } else {
      return null;
    }
  }
}
