package com.enmaka.matistikk.users;

import java.io.Serializable;

/**
 *
 * @author Team ENMAKA
 * 
 * Klassen representerer en bruker av typen "student". Arver fra klassen User.
 * 
 * For mer informasjon om klassen, se designdokumentet kapittel 4.11.1.2.
 */

public class Student extends User implements Serializable{
    public int age;
    public boolean sex;
    public int classId;
    
    public Student(){}
    
    public Student(String username, int age, boolean sex, int classId, String description, boolean active) {
        super(username, description, active);
        this.age = age;
        this.sex = sex;
        this.classId = classId;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public boolean getSex() {
        return sex;
    }

    public void setSex(boolean sex) {
        this.sex = sex;
    }

    public int getClassId() {
        return classId;
    }

    public void setClassId(int classId) {
        this.classId = classId;
    }
}
