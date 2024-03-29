/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.enmaka.matistikk.objects;

/**
 *
 * @author Team 6
 * 
 * Klassen representerer et svar for en funksjonsoppgave
 * 
 * For mer informasjon om klassen, se designdokumentet kapittel 5.4.1
 */
public class AnswerFunction extends Answer {

    private String answerText;
    private String geoBase64;
    private String geoListener;

    public AnswerFunction() {
        super();
    }

    public AnswerFunction(String explenation, String email, Function function, String answerText) {
        super(explenation, email);
        this.answerText = answerText;
    }

    public AnswerFunction(String explenation, String email, String geoBase64, String geoListener, int taskId, String answerText) {
        super(explenation, email, taskId);
        this.answerText = answerText;
        this.geoBase64 = geoBase64;
        this.geoListener = geoListener;
    }

    public AnswerFunction(String explenation, String email) {
        super(explenation, email);
    }

    public AnswerFunction(String explenation, String email, Function function) {
        super(explenation, email);
    }

    public AnswerFunction(String explenation, String email, int taskId, String answerText) {
        super(explenation, email, taskId);
        this.answerText = answerText;
    }

    @Override
    public String getValue() {
        return answerText;
    }

    public void setValue(String answerText) {
        this.answerText = answerText;
    }

    public String getGeoBase64() {
        return geoBase64;
    }

    public void setGeoBase64(String geoBase64) {
        this.geoBase64 = geoBase64;
    }

    public String getGeoListener() {
        return geoListener;
    }

    public void setGeoListener(String geoListener) {
        this.geoListener = geoListener;
    }
}
