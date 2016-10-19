package com.enmaka.matistikk.ui;

import com.enmaka.matistikk.objects.TaskStatistics;
import java.util.List;

/**
 *
 * @author Team ENMAKA
 * 
 * Klassen er en BackingBean for statiskk til oppgaver. Oppretter en liste med TaskStatistics-objekter.
 * 
 * For mer informasjon om klassen, se designdokumentet kapittel 4.10.5.
 */

public class TaskStatisticsFormBackingBean {
    private List<TaskStatistics> allTaskStatistics = null;
    private List<TaskStatistics> selectedTaskStatistics = null;
    
    public List<TaskStatistics> getAllTaskStatistics() {
        return allTaskStatistics;
    }

    public void setAllTaskStatistics(List<TaskStatistics> allTaskStatistics) {
        this.allTaskStatistics = allTaskStatistics;
    }

    public List<TaskStatistics> getSelectedTaskStatistics() {
        return selectedTaskStatistics;
    }

    public void setSelectedTaskStatistics(List<TaskStatistics> selectedTaskStatistics) {
        this.selectedTaskStatistics = selectedTaskStatistics;
    }
}
