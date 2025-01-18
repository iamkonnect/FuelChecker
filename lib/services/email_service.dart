import 'dart:developer' as developer;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class EmailService {
  // SMTP server configuration
  static final SmtpServer _smtpServer = SmtpServer(
    'mail.fuelcheck.co.zw',
    port: 26,
    username: 'noreply@fuelcheck.co.zw',
    password: 'ZWEfuelcheck1',
  );

  /// Sends a password reset email
  static Future<void> sendPasswordResetEmail(String email) async {
    final message = Message()
      ..from = const Address('noreply@fuelcheck.co.zw', 'FuelChecker')
      ..recipients.add(email)
      ..subject = 'Password Reset Request'
      ..text = 'You requested a password reset. Please follow the link to reset your password.';

    try {
      // Send the email
      await send(message, _smtpServer);
      developer.log('Email sent successfully', name: 'EmailService');
    } on MailerException catch (e) {
      developer.log('Error sending email: ${e.toString()}', 
          name: 'EmailService', 
          error: e);
      rethrow;
    }
  }
}
