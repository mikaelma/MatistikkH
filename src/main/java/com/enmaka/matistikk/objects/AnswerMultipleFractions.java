package com.enmaka.matistikk.objects;

/**
 *
 * @author Team ENMAKA
 * 
 * Klassen representerer et svar med flerer brøker. Arver fra klassen Answer.
 * 
 * For mer informasjon om klassen, se designdokumentet kapittel 4.7.1.1.
 */

public class AnswerMultipleFractions extends Answer{
    private Fraction[] fractions;

    public AnswerMultipleFractions(){
        super();
    }
    
    public AnswerMultipleFractions(String explenation, String email){
        super(explenation, email);
    }

    public AnswerMultipleFractions(Fraction[] fractions, String explenation, String email, int taskId) {
        super(explenation, email, taskId);
        this.fractions = fractions;
    }
    
    public AnswerMultipleFractions(String explenation, String email, Fraction[] fractions){
        super(explenation, email);
        this.fractions = fractions;
    }
    
    public AnswerMultipleFractions(int id, String explenation, String email, Fraction[] fractions) {
        super(id, explenation, email);
        this.fractions = fractions;
    }
    
    public void setFractions(Fraction[] newFractions){
        fractions = newFractions;
    }
    
    @Override
    public Fraction[] getValue(){
        return fractions;
    }
    
    public void setValue(Fraction[] newFractions){
        fractions = newFractions;
    }
    
    public int getLength(){
        return fractions.length;
    }
    public String getFractionString(){
        String s = "";
        for(int i = 0; i<fractions.length; i++){
            s += fractions[i].toString() + "|";
        }
        return s;
    }   
}
