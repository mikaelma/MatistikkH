package com.enmaka.matistikk.objects;

/**
 *
 * @author Team ENMAKA
 * 
 * Klassen representerer en oppgave av typer "velg riktig". Arver fra klassen Task.
 * 
 * For mer informasjon om klassen, se designdokumentet kapittel 4.7.9.4.
 */

public class SingleChoice extends Task{
    private Fraction[] choices;
    private Fraction solution;
    
    public SingleChoice(){
        super();
    }
    
    public SingleChoice(int id, String text){
        super(id, text);
        this.choices = new Fraction[]{};
        this.solution = new Fraction();
    }
    
    public SingleChoice(int id, String text, Fraction[] choices, Fraction solution){
        super(id, text);
        this.choices = choices;
        this.solution = solution;
    }
    
    public Fraction[] getChoices(){
        return choices;
    }
    
    public int getLength(){
        return choices.length;
    }
    
    public void setChoices(Fraction[] newChoices){
        choices = newChoices;
    }
    
    public Fraction getSolution(){
        return solution;
    }
    
    public void setSolution(Fraction newSolution){
        solution = newSolution;
    }
    
    public boolean equals(int i){
        return choices[i] == solution;
    }

    @Override
    public boolean isCorrect() {
        answer.setCorrect(solution.equals(((AnswerSingleFraction) answer).getValue()));
        return answer.isCorrect();
    }
    
    @Override
    public String toString(){
        return text;
    }
}
