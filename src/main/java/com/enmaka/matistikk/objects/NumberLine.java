package com.enmaka.matistikk.objects;

/**
 *
 * @author Team ENMAKA
 * 
 * Klassen representerer en oppgave av typen "tallinje". Arver fra klassen Task.
 * 
 * For mer informasjon om klassen, se designdokumentet kapittel 4.7.9.3.
 */

public class NumberLine extends Task{
    private Fraction solution;
    
    public NumberLine(){
        super();
    }
    
    public NumberLine(int id, String text) {
        super(id, text);
    }
    
    public NumberLine(int id, String text, Fraction solution) {
        super(id, text);
        this.solution = solution;
    }
    
    public Fraction getSolution(){
        return solution;
    }
    
    public void setSolution(Fraction newSolution){
        solution = newSolution;
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
