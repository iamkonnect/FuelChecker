import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import com.onesignal.OneSignal; // Import OneSignal SDK

import org.springframework.stereotype.Service;

@Service
public class EmailService {
    public void sendPushNotification(String playerId, String message) {
        OneSignal.sendNotification(new JSONObject()
            .put("app_id", "YOUR_ONESIGNAL_APP_ID") // Replace with your OneSignal App ID
            .put("include_player_ids", new JSONArray().put(playerId))
            .put("contents", new JSONObject().put("en", message))
        );
    }

    @Autowired
    private JavaMailSender mailSender;

    public void sendResetEmail(String toEmail, String resetToken) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom("noreply@fuelcheck.co.zw");
        message.setTo(toEmail);
        message.setSubject("Password Reset Request");
        
        String resetUrl = "https://your-flutter-app.com/reset-password?token=" + resetToken;
        message.setText("Click the link to reset your password: " + resetUrl);

        mailSender.send(message);
    }
}
