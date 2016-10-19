package com.enmaka.matistikk.objects;

/**
 *
 * @author Team ENMAKA
 * 
 * Klassen representerer et svar med kun tekst. Brukes ved besvarelse av figuroppgaver.
 * Arver fra klassen Answer.
 * 
 * For mer informasjon om klassen, se designdokumentet kapittel 4.7.1.3.
 */

public class AnswerString extends Answer {
    private String answerUrl;
    
    public AnswerString(){
        super();
    }
    
    public AnswerString(String explenation, String email){
        super(explenation, email);
    }
    
    public AnswerString(String explenation, String email, String answerUrl){
        super(explenation, email);
        this.answerUrl = answerUrl;
    }
    
    public AnswerString(int id, String explenation, String email, String answerUrl){
        super(id, explenation, email);
        this.answerUrl = answerUrl;
    }

    public AnswerString(String explenation, String email, int taskId, String answerUrl) {
        super(explenation, email, taskId);
        this.answerUrl = answerUrl;
    }
    
    @Override
    public String getValue(){
        return answerUrl;
    }
    
    public void setValue(String answerUrl){
        this.answerUrl = answerUrl;
    }
}
