package com.enmaka.matistikk.email;

/**
 *
 * @author Team ENMAKA
 * 
 * Klassen har metoder for å generere passord og sende det på mail.
 * 
 * Koden er innspirert av teamets SCRUM-prosjekt våren 2015.
 * 
 * For mer informasjon om klassen, se designdokumentet kapittel 4.5.2.
 */

import java.security.SecureRandom;
import java.util.Random;
import javax.mail.Message.RecipientType;
import org.codemonkey.simplejavamail.Email;
import org.codemonkey.simplejavamail.Mailer;
import org.codemonkey.simplejavamail.TransportStrategy;

public class Mail {
    private static final Random rnd = new SecureRandom();
    private static final int ant = 8;
    
    public static String generate(){
        String letters = "abcdefghjkmnpqrstuvwxyzABCDEFGHJKMNPQRSTUVWXYZ123456789";
        String password = "";
        for(int i = 0; i < ant; i++){
            int index = (int)(rnd.nextDouble() * letters.length());
            password += letters.substring(index, index+1);
        }
        return password;
    }
    
     public static void sendEmail(String username, String password){
        final Email email = new Email();
        email.setFromAddress("Matistikk", "matistikk@gmail.com");
        email.setSubject("Matistikk - Passord");
        email.addRecipient(" ", username, RecipientType.TO);
        email.setText("Her er ditt passord: " + "\n" + password);
        new Mailer("smtp.gmail.com", 587, "matistikk@gmail.com", "Matistikk123", TransportStrategy.SMTP_TLS).sendMail(email);
    }
}
