package com.enmaka.matistikk.ui;

import com.enmaka.matistikk.objects.StudentInfo;
import com.enmaka.matistikk.objects.TeacherInfo;
import java.util.List;

/**
 *
 * @author Team ENMAKA
 * 
 * Klassen er en BackingBean for brukere. Oppretter en liste med StudentInfo-objekter
 * og en liste med TeacherInfo-objekter.
 * 
 * For mer informasjon om klassen, se designdokumentet kapittel 4.10.9.
 */

public class UserFormBackingBean {
    private List<StudentInfo> allStudents = null;
    private List<TeacherInfo> allTeachers = null;
    
    public void setAllStudents(List<StudentInfo> allStudents) {
        this.allStudents = allStudents;
    }
    
    public List<StudentInfo> getAllStudents() {
        return allStudents;
    }
    
    public void setAllTeachers(List<TeacherInfo> allTeachers) {
        this.allTeachers = allTeachers;
    }
    
    public List<TeacherInfo> getAllTeachers() {
        return allTeachers;
    }
}
