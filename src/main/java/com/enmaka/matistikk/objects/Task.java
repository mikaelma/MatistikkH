package com.enmaka.matistikk.objects;

/**
 *
 * @author Team ENMAKA
 * 
 * Klassen representerer en oppgave. Nye typer oppgaver må arve fra denne.
 * 
 * For mer informasjon om klassen, se designdokumentet kapittel 4.7.9.
 */

public abstract class Task {
    int id;
    String text;
    Answer answer;
    double time = 0.0;
    double startTime;
    String username;
    
    public Task(){}
    
    public Task(int id, String text){
        this.id = id;
        this.text = text;
    }
    
    public int getId(){
        return id;
    }
    
    public void setId(int newID){
        id = newID;
    }
    
    public String getText() {
        return text;
    }
    
    public void setText(String newText){
        text = newText;
    }

    public Answer getAnswer() {
        return answer;
    }
    
    public void startTime(){
        startTime = System.nanoTime();
    }
    
    public void endTime(){
        double total = System.nanoTime() - startTime;
        total = total / 1000000000.0;
        total = Math.round(total * 100);
        time += total / 100;
    }
    
    public double getTime(){
        return time;
    }
    
    public void setAnswer(Answer answer) {
        this.answer = answer;
    }
    
    public String getUsername(){
        return username;
    }
    
    public void setUsername(String newUsername){
        this.username = newUsername;
    }
    
    public abstract boolean isCorrect();   
}
