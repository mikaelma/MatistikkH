package com.enmaka.matistikk.objects;

import java.util.ArrayList;

/**
 *
 * @author Team ENMAKA
 * 
 * Klassen representerer et svar til en oppgave.
 * 
 * For mer informasjon om klassen, se designdokumentet kapittel 4.7.12.
 */

public class TaskSolution {
    private int id;
    private String text;
    ArrayList<Fraction> solution = new ArrayList<>();
    
    public TaskSolution(){}
    
    public TaskSolution(int id, String text, ArrayList<Fraction> solution){
        this.id = id;
        this.text = text;
        this.solution = solution;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public ArrayList<Fraction> getSolution() {
        return solution;
    }

    public void setSolution(ArrayList<Fraction> solution) {
        this.solution = solution;
    }
    
    public String getSolutionString(){
        String s = "";
        for(Fraction fraction : solution){
            s += fraction.toString() + " ";
        }
        return s;
    }
    
    public void addSolution(Fraction fraction){
        solution.add(fraction);
    }
}
