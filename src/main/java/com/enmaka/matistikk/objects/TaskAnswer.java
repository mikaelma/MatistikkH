package com.enmaka.matistikk.objects;

import java.util.ArrayList;

/**
 *
 * @author Team ENMAKA
 * 
 * Klassen representerer et svar til en oppgave.
 * 
 * For mer informasjon om klassen, se designdokumentet kapittel 4.7.10.
 */

public class TaskAnswer {
    private String email;
    private ArrayList<Fraction> answer = new ArrayList<>();
    private String correct;
    private String explenation;
    private double time;
    
    public TaskAnswer(){}

    public TaskAnswer(String email, String correct, String explenation, double time) {
        this.email = email;
        this.correct = correct;
        this.explenation = explenation;
        this.time = time;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public ArrayList<Fraction> getAnswer() {
        return answer;
    }

    public void setAnswer(ArrayList<Fraction> answer) {
        this.answer = answer;
    }
    
    public void addAnswer(Fraction fraction){
        answer.add(fraction);
    }
    
    public String getAnswerString(){
        String s = "";
        for(Fraction fraction : answer){
            s += fraction.toString() + " ";
        }
        return s;
    }
    
    public String getCorrect() {
        return correct;
    }

    public void setCorrect(String correct) {
        this.correct = correct;
    }

    public String getExplenation() {
        return explenation;
    }

    public void setExplenation(String explenation) {
        this.explenation = explenation;
    }
    
    public double getTime(){
        return time;
    }
    
    public void setTime(double time){
        this.time = time;
    }
}
