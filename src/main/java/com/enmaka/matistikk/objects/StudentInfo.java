package com.enmaka.matistikk.objects;

/**
 *
 * @author Team ENMAKA
 * 
 * Klassen representerer informasjon om en student.
 * 
 * For mer informasjon om klassen, se designdokumentet kapittel 4.7.8.
 */

public class StudentInfo {
    private String email;
    private int testCount;
    private int age;
    private boolean sex;
    private String school;
    private String className;
    private boolean active;
    
    public StudentInfo(){}
    
    public StudentInfo(String email, int testCount, int age, boolean sex, String school, String className) {
        this.email = email;
        this.testCount = testCount;
        this.age = age;
        this.sex = sex;
        this.school = school;
        this.className = className;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getTestCount() {
        return testCount;
    }

    public void setTestCount(int testCount) {
        this.testCount = testCount;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public boolean isSex() {
        return sex;
    }

    public void setSex(boolean sex) {
        this.sex = sex;
    }

    public String getSchool() {
        return school;
    }

    public void setSchool(String school) {
        this.school = school;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }
}
