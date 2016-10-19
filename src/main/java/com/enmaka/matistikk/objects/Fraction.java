package com.enmaka.matistikk.objects;

/**
 *
 * @author Team ENMAKA
 * 
 * Klassen representerer en brøk.
 * 
 * For mer informasjon om klassen, se designdokumentet kapittel 4.7.4.
 */

public class Fraction implements Comparable<Fraction>{
    private int numerator;
    private int denominator;
    
    public Fraction(){}

    public Fraction(int numerator, int denominator) {
        this.numerator = numerator;
        this.denominator = denominator;
    }
    
    public int getNumerator() {
        return numerator;
    }
     
    public int getDenominator() {
        return denominator;
    }
    
    public void setNumerator(int numerator) {
        this.numerator = numerator;
    }
    
    public void setDenominator(int denominator) {
        this.denominator = denominator;
    }
    
    //Gets the sum of a fraction
    public double getSum(){
        return (double) numerator / (double) denominator;
    }
    
    //Checks if two fractions are equal
    public boolean equals(Fraction f) {
        if(this.getSum() == f.getSum()) {
            return true;
        }else{
            return false;
        }
    }
    
    @Override
    public int compareTo(Fraction t){
        return Double.compare(this.getSum(), t.getSum());
    }
    
    @Override
    public String toString(){
        return numerator + "/" + denominator;
    }
}
