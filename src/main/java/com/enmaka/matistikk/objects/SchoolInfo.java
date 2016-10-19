package com.enmaka.matistikk.objects;

/**
 *
 * @author Team ENMAKA
 * 
 * Klassen representerer informasjon om en skole.
 * 
 * For mer informasjon om klassen, se designdokumentet kapittel 4.7.5.
 */

public class SchoolInfo {
    private int schoolId;
    private String schoolName;
    private int classCount;
    
    public SchoolInfo(){
        
    }

    public SchoolInfo(int schoolId, String schoolName, int classCount) {
        this.schoolId = schoolId;
        this.schoolName = schoolName;
        this.classCount = classCount;
    }

    public int getSchoolId() {
        return schoolId;
    }

    public void setSchoolId(int schoolId) {
        this.schoolId = schoolId;
    }

    public String getSchoolName() {
        return schoolName;
    }

    public void setSchoolName(String schoolName) {
        this.schoolName = schoolName;
    }

    public int getClassCount() {
        return classCount;
    }

    public void setClassCount(int classCount) {
        this.classCount = classCount;
    }
    
    
    
}
