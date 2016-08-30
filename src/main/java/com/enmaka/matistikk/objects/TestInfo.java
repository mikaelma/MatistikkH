package com.enmaka.matistikk.objects;


/**
 *
 * @author Team ENMAKA
 * 
 * Klassen representerer informasjon om en test.
 * 
 * For mer informasjon om klassen, se designdokumentet kapittel 4.7.17.
 */

public class TestInfo {
    private int id;
    private String teacher;
    private int size;
    private int progress;
    private boolean active;
    
    public TestInfo(){}
    
    public TestInfo(int id, String teacher, int size, int progress, boolean active){
        this.id = id;
        this.teacher = teacher;
        this.size = size;
        this.progress = progress;
        this.active = active;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTeacher() {
        return teacher;
    }

    public void setTeacher(String teacher) {
        this.teacher = teacher;
    }

    public int getSize() {
        return size;
    }

    public void setSize(int size) {
        this.size = size;
    }
    
    public int getProgress(){
        return progress;
    }
    
    public void setProgress(int progress){
        this.progress = progress;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }
}
