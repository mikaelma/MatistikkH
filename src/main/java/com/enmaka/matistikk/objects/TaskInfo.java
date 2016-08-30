package com.enmaka.matistikk.objects;

/**
 *
 * @author Team ENMAKA
 * 
 * Klassen representerer informasjon om en oppgave.
 * 
 * For mer informasjon om klassen, se designdokumentet kapittel 4.7.11.
 */

public class TaskInfo {
    private int id;
    private String taskType;
    private String text;
    private String username;
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTaskType() {
        return taskType;
    }

    public void setTaskType(String taskType) {
        this.taskType = taskType;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }
    
    public String getUsername(){
        return username;
    }
    
    public void setUsername(String username){
        this.username = username;
    }
    
    @Override
    public String toString(){
        return id + " " + taskType + " " + text;
    }
}
