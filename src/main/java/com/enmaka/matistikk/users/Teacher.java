package com.enmaka.matistikk.users;

import java.io.Serializable;

/**
 *
 * @author Team ENMAKA
 * 
 * Klassen representerer en bruker av typen "lærer". Arver fra klassen User.
 * 
 * For mer informasjon om klassen, se designdokumentet kapittel 4.11.1.3.
 */

public class Teacher extends User implements Serializable {
    public String firstName;
    public String lastName;
    public int schoolId;
    
    public Teacher(){}
    
    public Teacher(String username, String firstName, String lastName, String description, int schoolId, boolean active) {
        super(username, description, active);
        this.firstName = firstName;
        this.lastName = lastName;
        this.schoolId = schoolId;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public int getSchoolId() {
        return schoolId;
    }

    public void setSchoolId(int schoolId) {
        this.schoolId = schoolId;
    }
}
