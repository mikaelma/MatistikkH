package com.enmaka.matistikk.objects;

/**
 *
 * @author Team ENMAKA
 * 
 * Klassen representerer et svar med en brøk. Arver fra klassen Answer.
 * 
 * For mer informasjon om klassen, se designdokumentet kapittel 4.7.1.2.
 */

public class AnswerSingleFraction extends Answer {
    private Fraction fraction;
    
    public AnswerSingleFraction(){
        super();
    }
    
    public AnswerSingleFraction(String explenation, String email){
        super(explenation, email);
    }
    
    public AnswerSingleFraction(String explenation, String email, Fraction fraction){
        super(explenation, email);
        this.fraction = fraction;
    }
    
    public AnswerSingleFraction(int id, String explenation, String email, Fraction fraction){
        super(id, explenation, email);
        this.fraction = fraction;
    }

    public AnswerSingleFraction(Fraction fraction, String explenation, String email, int taskId) {
        super(explenation, email, taskId);
        this.fraction = fraction;
    }
    
    @Override
    public Fraction getValue(){
        return fraction;
    }
    
    public void setValue(Fraction newFraction){
        fraction = newFraction;
    }   
}
