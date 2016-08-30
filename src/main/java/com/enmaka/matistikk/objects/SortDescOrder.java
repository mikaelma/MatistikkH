package com.enmaka.matistikk.objects;

import java.util.Comparator;

/**
 *
 * @author Team ENMAKA
 * 
 * Klassen brukes for å avgjøre hvilken brøk som er størst.
 * 
 * For mer informasjon om klassen, se designdokumentet kapittel 4.7.7.
 */

public class SortDescOrder implements Comparator<Fraction>{
    @Override
    public int compare(Fraction f1, Fraction f2) {
        return f2.compareTo(f1);
    }    
}
