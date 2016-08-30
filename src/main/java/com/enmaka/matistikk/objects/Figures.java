package com.enmaka.matistikk.objects;

/**
 *
 * @author Team ENMAKA
 * 
 * Klassen representerer en oppgave av typen "figurer". Arver fra klassen Task.
 * 
 * For mer informasjon om klassen, se designdokumentet kapittel 4.7.9.2.
 */

public class Figures extends Task{
    private String figureUrl;
    private String solutionUrl;
    
    public Figures(){
        super();
    }
    
    public Figures(int id, String text){
        super(id, text);
    }
    
    public Figures(int id, String text, String figureUrl, String solutionUrl){
        super(id, text);
        this.figureUrl = figureUrl;
        this.solutionUrl = solutionUrl;
    }

    public String getFigureUrl() {
        return figureUrl;
    }

    public void setFigureUrl(String figureUrl) {
        this.figureUrl = figureUrl;
    }
    
    public String getSolutionUrl(){
        return solutionUrl;                
    }
    
    public void setSolutionUrl(String solutionUrl){
        this.solutionUrl = solutionUrl;
    }
    
    @Override
    public boolean isCorrect() {
        answer.setCorrect(((AnswerString) answer).getValue().equals(solutionUrl));
        return answer.isCorrect();
    }
    
    @Override
    public String toString(){
        return text;
    }
}
