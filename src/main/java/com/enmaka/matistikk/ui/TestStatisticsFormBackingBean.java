package com.enmaka.matistikk.ui;

import com.enmaka.matistikk.objects.TestStatistics;
import java.util.List;

/**
 *
 * @author Team ENMAKA
 * 
 * Klassen er en BackingBean for statistikk til tester. Oppretter en liste med TestStatistics-objekter.
 * 
 * For mer informasjon om klassen, se designdokumentet kapittel 4.10.8.
 */

public class TestStatisticsFormBackingBean {
    private List<TestStatistics> allTestStatistics = null;

    public List<TestStatistics> getAllTestStatistics() {
        return allTestStatistics;
    }

    public void setAllTestStatistics(List<TestStatistics> allTestStatistics) {
        this.allTestStatistics = allTestStatistics;
    }
    
    public int getLength(){
        return allTestStatistics.size();
    }
}
