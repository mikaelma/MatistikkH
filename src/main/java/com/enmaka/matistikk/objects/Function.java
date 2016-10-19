
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.enmaka.matistikk.objects;

import java.util.ArrayList;

/**
 *
 * @author Mikael
 */
public class Function extends Task {

    private int answer_type;
    public ArrayList<String> choices;
    public String solution;
    public boolean explanation;
    public boolean drawing;
    private String url;

    public Function(int answer_type, boolean explanation, boolean drawing, String url) {
        this.answer_type = answer_type;
        this.explanation = explanation;
        this.drawing = drawing;
        this.url = url;
    }

    public Function(int answer_type) {
        this.answer_type = answer_type;
    }

    public Function() {
        super();
    }

    public Function(int id, String text) {
        super(id, text);
    }

    public Function(int id, String text, int answer_type, boolean explanation, boolean drawing, String url) {

        super(id, text);
        this.answer_type = answer_type;
        this.explanation = explanation;
        this.drawing = drawing;
        this.url = url;
    }

    public Function(int id, String text, ArrayList<String> choices, String solution) {
        super(id, text);
        this.choices = choices;
        this.solution = solution;
    }

    public ArrayList getChoices() {
        return choices;
    }

    public void setChoices(ArrayList newChoices) {
        this.choices = newChoices;
    }

    public int getLength() {
        return choices.size();
    }

    public String getSolution() {
        return solution;
    }

    public void setSolution(String newSolution) {
        this.solution = newSolution;
    }

    public int getAnswerType() {
        return answer_type;
    }

    public void setAnswerType(int nyId) {
        this.answer_type = nyId;
    }

    public void setExplanationChecked() {
        explanation = true;
    }

    public void setDrawingChecked() {
        drawing = true;
    }

    public void setExplanationUnchecked() {
        explanation = false;
    }

    public void setDrawingUnchecked() {
        drawing = false;
    }

    public boolean isChecked1() {
        return explanation;
    }

    public boolean isChecked2() {
        return drawing;
    }
    public String getUrl() {
        return url;
    }
 
    public void setUrl(String url) {
        this.url = url;
    }

    @Override
    public String toString() {
        return text;
    }

    @Override
    public boolean isCorrect() {
        return true; //To change body of generated methods, choose Tools | Templates.
    }
}
