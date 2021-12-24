package com.example.controller;

import com.example.domain.User;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.RestController;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Map;
import java.util.Properties;
import java.util.stream.Collector;
import java.util.stream.Collectors;

@RestController
public class ControllerUtils {
    private static String hostName;
    private static String senderHost;
    private static String senderPort;
    private static String senderName;
    private static String senderPassword;

    @Value("${hostName}")
    public void setHost(String value) {
        this.hostName = value;
    }

    @Value("${spring.mail.host}")
    public void setSenderHost(String value) {
        this.senderHost = value;
    }

    @Value("${spring.mail.port}")
    public void setSenderPort(String value) {
        this.senderPort = value;
    }

    @Value("${spring.mail.username}")
    public void setSenderName(String value) {
        this.senderName = value;
    }

    @Value("${spring.mail.password}")
    public void setSenderPassword(String value) {
        this.senderPassword = value;
    }

    public static Map<String, String> getErrors(BindingResult bindingResult) {
        Collector<FieldError, ?, Map<String, String>> fieldErrorMapCollector = Collectors.toMap(
                fieldError -> fieldError.getField() + "Error",
                FieldError::getDefaultMessage
        );

        Map<String, String> errorsMap = bindingResult.getFieldErrors().stream().collect(fieldErrorMapCollector);

        return errorsMap;
    }

    public static boolean sendActivationMessage(User user) {
        if (StringUtils.isEmpty(user.getEmail())) {
            return false;
        }

        String messageText = String.format(
                "Hello, %s! \n" +
                        "Welcome to Sweater. Please, visit next link: <a>http://%s/activate/%s</a>",
                user.getUsername(),
                hostName,
                user.getActivationCode()
        );

        Properties prop = new Properties();
        prop.put("mail.smtp.host", senderHost);
        prop.put("mail.smtp.port", senderPort);
        prop.put("mail.smtp.auth", "true");
        prop.put("mail.smtp.socketFactory.port", senderPort);
        prop.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");

        Session session = Session.getInstance(prop,
                new javax.mail.Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(senderName, senderPassword);
                    }
                });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress("belochkaupload@yandex.ru"));
            message.setRecipients(
                    Message.RecipientType.TO,
                    InternetAddress.parse(user.getEmail())
            );

            message.setSubject("Welcome to MyProject!");
            message.setText(messageText);

            Transport.send(message);
        } catch (MessagingException e) {
            e.printStackTrace();

            return false;
        }

        return true;
    }
}
