package com.enmaka.matistikk.objects;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Team ENMAKA
 * 
 * Klassen representerer et svar. Nye typer svar må arve fra denne.
 * 
 * For mer informasjon om klassen, se designdokumentet kapittel 4.7.1.
 */

public abstract class Answer {
    private int id;
    private String explenation;
    private String email;
    private int taskId;
    private boolean correct;
    private double time;
    private List<Double> coordinates = new ArrayList<Double>();
    
    public Answer(){}
    
    public Answer(String explenation, String email){
        this.explenation = explenation;
        this.email = email;
    }
    
    public Answer(int id, String explenation, String email){
        this.id = id;
        this.explenation = explenation;
        this.email = email;
    }

    public Answer(String explenation, String email, int taskId) {
        this.explenation = explenation;
        this.email = email;
        this.taskId = taskId;
    }
    
    public int getId(){
        return id;
    }
    
    public void setId(int newId){
        id = newId;
    }
    
    public String getExplenation(){
        return explenation;
    }
    
    public String getEmail(){
        return email;
    }
    
    public void setEmail(String email){
        this.email = email;
    }
    
    abstract Object getValue();

    public int getTaskId() {
        return taskId;
    }

    public void setTaskId(int taskId) {
        this.taskId = taskId;
    }

    public boolean isCorrect() {
        return correct;
    }

    public void setCorrect(boolean correct) {
        this.correct = correct;
    }
    
    public void setTime(double newTime){
        time = newTime;
    }

    public List<Double> getCoordinates() {
        return coordinates;
    }

    public void setCoordinates(List<Double> coordinates) {
        this.coordinates = coordinates;
    }
    
    public double getTime(){
        return time;
    }   
}
