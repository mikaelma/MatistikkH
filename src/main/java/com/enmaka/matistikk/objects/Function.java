/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.enmaka.matistikk.objects;

/**
 *
 * @author Mikael
 */
public class Function extends Task {
    
    public Function(){
        super();
    }
    
    public Function(int id, String text){
        super(id, text);
    }
    
    @Override
    public String toString(){
        return text;
    }

    @Override
    public boolean isCorrect() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
}
