import 'dart:developer' as developer;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class EmailService {
  // Placeholder for SMTP server configuration
  static final SmtpServer _smtpServer = SmtpServer(
    'smtp.example.com',
    port: 587,
    username: 'noreply@example.com',
    password: 'password',
  );

  /// Sends a password reset email
  static Future<void> sendPasswordResetEmail(String email) async {
    final message = Message()
      ..from = const Address('noreply@example.com', 'FuelChecker')
      ..recipients.add(email)
      ..subject = 'Password Reset Request'
      ..text = 'You requested a password reset. Please follow the link to reset your password.';

    try {
      // Send the email
      final sendReport = await send(message, _smtpServer);
      developer.log('Email sent successfully', name: 'EmailService');
    } on MailerException catch (e) {
      developer.log('Error sending email', 
          name: 'EmailService', 
          error: e,
          level: developer.Level.SEVERE.value);
      rethrow;
    }
  }
}
