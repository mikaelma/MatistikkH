package com.enmaka.matistikk.ui;

import com.enmaka.matistikk.objects.TaskAnswer;
import java.util.List;

/**
 *
 * @author Team ENMAKA
 * 
 * Klassen er en BackingBean for statistikk til svar. Oppretter en liste med TaskAnswer-objekter.
 * 
 * For mer informasjon om klassen, se designdokumentet kapittel 4.10.1.
 */

public class AnswerStatisticsFormBackingBean {
    private List<TaskAnswer> allAnswerStatistics = null;

    public List<TaskAnswer> getAllAnswerStatistics() {
        return allAnswerStatistics;
    }

    public void setAllAnswerStatistics(List<TaskAnswer> allAnswerStatistics) {
        this.allAnswerStatistics = allAnswerStatistics;
    }
}
