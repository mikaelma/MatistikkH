package com.enmaka.matistikk.users;

/**
 *
 * @author Team ENMAKA
 * 
 * Klassen representerer en bruker av typen "administrator". Arver fra klassen User.
 * 
 * For mer informasjon om klassen, se designdokumentet kapittel 4.11.1.1.
 */

public class Admin extends User{
    
    public Admin(){}
    
    public Admin(String username, String description, boolean active) {
        super(username, description, active);
    }
}
