package com.enmaka.matistikk.objects;

/**
 *
 * @author Team ENMAKA
 * 
 * Klassens brukes for å hente ut statistisk informasjon om en test.
 * 
 * For mer informasjon om klassen, se designdokumentet kapittel 4.7.18.
 */

public class TestStatistics {
    private int testId;
    private String username;
    private int taskCount;
    private int studentCount;
    private int teacherCount;
    private boolean active;
    
    public TestStatistics(){}
    
    public TestStatistics(int testId, String username, int taskCount, int studentCount, int teacherCount, boolean active) {
        this.testId = testId;
        this.username = username;
        this.taskCount = taskCount;
        this.studentCount = studentCount;
        this.teacherCount = teacherCount;
        this.active = active;
    }

    public int getTestId() {
        return testId;
    }

    public void setTestId(int testId) {
        this.testId = testId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public int getTaskCount() {
        return taskCount;
    }

    public void setTaskCount(int taskCount) {
        this.taskCount = taskCount;
    }

    public int getStudentCount() {
        return studentCount;
    }

    public void setStudentCount(int studentCount) {
        this.studentCount = studentCount;
    }

    public int getTeacherCount() {
        return teacherCount;
    }

    public void setTeacherCount(int teacherCount) {
        this.teacherCount = teacherCount;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }
    
    @Override
    public String toString() {
        return "Test: " + testId + " Lærer: " + username + " Antall oppgaver: " + taskCount + " Antall deltagere: " + studentCount; 
    }
}
