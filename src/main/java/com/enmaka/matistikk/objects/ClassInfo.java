package com.enmaka.matistikk.objects;

/**
 *
 * @author Team ENMAKA
 * 
 * Klassen representerer informasjon om en skoleklasse.
 * 
 * For mer informasjon om klassen, se designdokumentet kapittel 4.7.3.
 */

public class ClassInfo {
    private int classId;
    private String className;
    private String schoolName;
    private int students;
    
    public ClassInfo(){}
    
    public ClassInfo(int classId, String className, String schoolName, int students) {
        this.classId = classId;
        this.className = className;
        this.schoolName = schoolName;
        this.students = students;
    }

    public int getClassId() {
        return classId;
    }

    public void setClassId(int classId) {
        this.classId = classId;
    }
    
    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public String getSchoolName() {
        return schoolName;
    }

    public void setSchoolName(String schoolName) {
        this.schoolName = schoolName;
    }

    public int getStudents() {
        return students;
    }

    public void setStudents(int students) {
        this.students = students;
    }
    
    public String getSchoolClass() {
        return schoolName + " - " + className;
    }
}
