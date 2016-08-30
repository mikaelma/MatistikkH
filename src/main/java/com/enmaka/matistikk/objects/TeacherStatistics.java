package com.enmaka.matistikk.objects;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Team ENMAKA
 * 
 * Klassen brukes sammen med uthenting av statistisk informasjon om en lærer.
 * 
 * For mer informasjon om klassen, se designdokumentet kapittel 4.7.15.
 */

public class TeacherStatistics {
    private String email;
    private String firstName;
    private String lastName;
    private String school;
    private List<String> classes = new ArrayList<>();
    private int testCount;
    
    public TeacherStatistics(){}

    public TeacherStatistics(String email, String firstName, String lastName, String school, List<String> classes, int testCount) {
        this.email = email;
        this.firstName = firstName;
        this.lastName = lastName;
        this.school = school;
        this.classes = classes;
        this.testCount = testCount;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
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
    
    public String getSchool() {
        return school;
    }

    public void setSchool(String school) {
        this.school = school;
    }

    public List<String> getClasses(){
        return classes;
    }
    
    public void setClasses(List<String> classes){
        this.classes = classes;
    }
    
    public void addClassName(String className){
        classes.add(className);
    }
    
    public String getSchoolClasses(){
        String s = school;
        if(classes.size()-1 >= 0){
                s += " - ";
        }
        for(int i = 0; i<classes.size()-1; i++){
            s += classes.get(i) + ", ";
        }
        s += classes.get(classes.size()-1);
        return s;
    }
    
    public int getTestCount() {
        return testCount;
    }

    public void setTestCount(int testCount) {
        this.testCount = testCount;
    }
}
