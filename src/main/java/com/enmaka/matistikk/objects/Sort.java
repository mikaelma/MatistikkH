package com.enmaka.matistikk.objects;

/**
 *
 * @author Team ENMAKA
 * 
 * Klassen representerer en oppgave av typer "sortering". Arver fra klassen Task.
 * 
 * For mer informasjon om klassen, se designdokumentet kapittel 4.7.9.5.
 */

public class Sort extends Task {
    private Fraction[] fractions;
    private Fraction[] solution;
    
    public Sort(){
        super();
    }
    
    public Sort(int id, String text){
        super(id, text);
        fractions = new Fraction[]{};
        solution = new Fraction[]{};
    }
    
    public Sort(int id, String text, Fraction[] fractions, Fraction[] solution){
        super(id, text);
        this.fractions = fractions;
        this.solution = solution;
    }
    
    public Fraction[] getFractions(){
        return fractions;
    }
    
    public void setFractions(Fraction[] newFractions){
        fractions = newFractions;
        
    }
    public Fraction[] getSolution(){
        return solution;
    }
    
    public void setSolution(Fraction[] newSolution){
        solution = newSolution;
    }
    
    public int getLength(){
        return fractions.length;
    }
    
    public boolean equals(Fraction[] f){
        for(int i = 0; i<solution.length; i++){
            if(!f[i].equals(solution[i]))
                return false;
        }
        return true;
    }

    @Override
    public boolean isCorrect() {
        for(int i = 0; i<solution.length; i++){
            if(!solution[i].equals(((AnswerMultipleFractions) answer).getValue()[i])){
                answer.setCorrect(false);
                return false;
            }
        }
        answer.setCorrect(true);
        return true;
    }
    
    @Override
    public String toString(){
        return text;
    }
}
