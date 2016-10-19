package com.enmaka.matistikk.objects;

/**
 *
 * @author Team ENMAKA
 * 
 * Klassen brukes ved innlogging.
 * 
 * For mer informasjon om klassen, se designdokumentet kapittel 4.7.19.
 */

public class UserLogin {
    private String username;
    private String password;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
