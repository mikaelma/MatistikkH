package com.enmaka.matistikk.ui;

import com.enmaka.matistikk.objects.TeacherStatistics;
import java.util.List;

/**
 *
 * @author Team ENMAKA
 * 
 * Klassen er en BackingBean for statistikk til lærere. Oppretter en liste med TeacherStatistics-objekter.
 * 
 * For mer informasjon om klassen, se designdokumentet kapittel 4.10.6.
 */

public class TeacherStatisticsFormBackingBean {
    
    private List<TeacherStatistics> allTeachers = null;

    public List<TeacherStatistics> getAllTeachers() {
        return allTeachers;
    }

    public void setAllTeachers(List<TeacherStatistics> allTeachers) {
        this.allTeachers = allTeachers;
    }
}
