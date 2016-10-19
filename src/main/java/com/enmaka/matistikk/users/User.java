package com.enmaka.matistikk.users;

/**
 *
 * @author Team ENMAKA
 * 
 * Klassen representerer en bruker. Nye typer brukere må arve fra denne.
 * 
 * For mer informasjon om klassen, se designdokumentet kapittel 4.11.1.
 */

public abstract class User {
    String username;
    String description;
    boolean active;
    
    public User(){}
    
    public User(String username, String description, boolean active){
        this.username = username;
        this.description = description;
        this.active = active;
    }

    public void setUsername(String username) {
        this.username = username.trim();
    }
    
    public String getUsername(){
        return username;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }
}
