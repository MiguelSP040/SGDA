package com.utez.edu.almacen.utils;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

import javax.mail.*;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.Properties;public class EmailUtility {

    // Método para enviar el correo de restablecimiento de contraseña
    public static void sendResetPasswordEmail(String recipientEmail, String resetLink) throws AddressException,
            MessagingException, UnsupportedEncodingException {

        // Recupera los parámetros del contexto, que deberías haber configurado
        String host = "smtp.gmail.com";
        String port = "587";
        String senderEmail = "no.reply.almacen7@gmail.com";
        String senderName = "no. reply";
        String password = "gdlc hzbe vimz pqeh";

        Properties properties = new Properties();
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.port", port);
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");

        Authenticator auth = new Authenticator() {
            public PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(senderEmail, password);
            }
        };

        Session session = Session.getInstance(properties, auth);

        // Crea el mensaje de correo
        Message msg = new MimeMessage(session);
        msg.setFrom(new InternetAddress(senderEmail, senderName));
        msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
        msg.setSubject("Restablecimiento de Contraseña");
        msg.setSentDate(new Date());

        // Construye el mensaje HTML con el enlace de restablecimiento de contraseña
        String emailBody = "<p>Para restablecer su contraseña, haga clic en el siguiente enlace:</p>" +
                "<p><a href=\"" + resetLink + "\">Restablecer Contraseña</a></p>" +
                "<p>Si no solicitó este restablecimiento de contraseña, ignore este correo electrónico.</p>";

        msg.setContent(emailBody, "text/html; charset=utf-8");

        // Envía el mensaje
        Transport.send(msg);
    }
}