package com.enmaka.matistikk.security;

import java.math.BigInteger;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.spec.InvalidKeySpecException;
import java.util.Arrays;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;

/**
 * En enkel klasse for krypering av passord med HMAC SHA1 
 * 
 * @author Team 6
 * 
 * Koden for klassen er hentet fra følgende side:
 * https://github.com/sixthpoint/java-algorithms/blob/master/src/com/sixthpoint/security/HmacSHA1.java
 * 
 * og er brukt gjennomgående i systemet for alt som har med passord å gjøre
 */
public class PasswordHash {

    // Used in encryption for how many cycles
    private static final int PBKDF2_ITERATIONS = 2000;



    /**
     * Validates a password using a hash.
     *
     * @param password passordet som sjekkes
     * @param hash
     * @param salt
     * @return true om passord er korrekt, false hvis ikke
     * @throws java.security.NoSuchAlgorithmException
     * @throws java.security.spec.InvalidKeySpecException
     */
    public static boolean validatePassword(char[] password, byte[] hash, byte[] salt) throws NoSuchAlgorithmException, InvalidKeySpecException {

        // Beregner hash av det innsendte passordet, bruker samme salt, iterasjons teller og hashlengde
        byte[] testHash = pbkdf2(password, salt, PBKDF2_ITERATIONS, hash.length);

        // Sammenligner hasher i konstant tid. Passordet er riktig om begge hashene matcher.
        return slowEquals(hash, testHash);
    }

    /**
     * Validerer et passord ved bruk av en hash.
     *
     * @param password passordet som sjekkes
     * @param hash
     * @param salt
     * @return true om passordet er korrekt, false hvis ikke
     * @throws java.security.NoSuchAlgorithmException
     * @throws java.security.spec.InvalidKeySpecException
     */
    public static boolean validatePassword(String password, byte[] hash, byte[] salt) throws NoSuchAlgorithmException, InvalidKeySpecException {

        return validatePassword(password.toCharArray(), hash, salt);
    }

    /**
     * Beregner PBKDF2 hash av et passord.
     *
     * @param password passordet som skal hashes.
     * @param salt salten som benyttes
     * @param iterations iterasjons telleren (treghets faktor)
     * @param bytes lengden av hashen som beregnes til bytes
     * @return  PBDKF2 hash av passordet
     */
    private static byte[] pbkdf2(final char[] password, final byte[] salt, final int iterationCount, final int keyLength) {

        try {
            return SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1").generateSecret(new PBEKeySpec(password, salt, iterationCount, keyLength * 8)).getEncoded();
        } catch (NoSuchAlgorithmException | InvalidKeySpecException e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * Returnerer en saltet PBKDF2 hash av passordet.
     *
     * @param password passordet som hashes
     * @return en saltet PBKDF2 hash av passordet
     * @throws java.security.NoSuchAlgorithmException
     * @throws java.security.spec.InvalidKeySpecException
     */
    public static String createHash(String password) throws NoSuchAlgorithmException, InvalidKeySpecException {
        return createHash(password.toCharArray());
    }

    /**
     * Returnerer en saltet PBKDF2 hash av passordet.
     *
     * @param password passordet som hashes
     * @return en saltet PBKDF2 hash av passordet på form SALT:HASH
     * @throws java.security.NoSuchAlgorithmException
     * @throws java.security.spec.InvalidKeySpecException
     */
    public static String createHash(char[] password) throws NoSuchAlgorithmException, InvalidKeySpecException {

        // Genererer en tilfeldig salt
        byte[] salt = getSalt().getBytes();

        // Hasher passordet
        byte[] hash = pbkdf2(password, salt, PBKDF2_ITERATIONS, 24);

        // Formaterer til salt:hash
        return toHex(salt) + ":" + toHex(hash);
    }

    /**
     *
     * @return
     * @throws NoSuchAlgorithmException
     */
    private static String getSalt() throws NoSuchAlgorithmException {
        SecureRandom sr = SecureRandom.getInstance("SHA1PRNG");
        byte[] salt = new byte[16];
        sr.nextBytes(salt);
        return Arrays.toString(salt);
    }

    /**
     * Konverterer en byte array til en heksadesimal string.
     *
     * @param array byte array som skal konverteres
     * @return en lengde*2 tegnstreng som koder for byte array
     */
    private static String toHex(byte[] array) {

        BigInteger bi = new BigInteger(1, array);
        String hex = bi.toString(16);
        int paddingLength = (array.length * 2) - hex.length();
        if (paddingLength > 0) {
            return String.format("%0" + paddingLength + "d", 0) + hex;
        } else {
            return hex;
        }
    }

    /**
     * Konverterer en streng med heksadesimale tegn til et byte array.
     *
     * @param hex hex stringen
     * @return hex string dekodet til et byte array
     */
    public static byte[] fromHex(String hex) {        
        byte[] binary = new byte[hex.length() / 2];        
        for (int i = 0; i < binary.length; i++) {
            binary[i] = (byte) Integer.parseInt(hex.substring(2 * i, 2 * i + 2), 16);            
        }       
        return binary;
        
    }

    /**
     * Sammenligner to byte arrays i lengde-konstant tid. Denne sammenlignings metoden
     * er brukt slik at passord hasher ikke kan bli hentet fra et online system
     * som bruker et timing angrep og deretter angriper offline    
     *
     * @param a første byte array
     * @param b andre byte array
     * @return true  om begge byte arrayene er det samme, false hvis ikke
     */
    private static boolean slowEquals(byte[] a, byte[] b) {

        int diff = a.length ^ b.length;
        for (int i = 0; i < a.length && i < b.length; i++) {
            diff |= a[i] ^ b[i];
        }
        return diff == 0;
    }

}