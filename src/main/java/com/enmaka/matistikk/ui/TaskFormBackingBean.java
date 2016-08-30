package com.enmaka.matistikk.ui;

import com.enmaka.matistikk.objects.TaskInfo;
import java.util.List;

/**
 *
 * @author Team ENMAKA
 * 
 * Klassen er en BackingBean for oppgaver. Oppretter en liste med TaskInfo-objekter.
 * 
 * For mer informasjon om klassen, se designdokumentet kapittel 4.10.4.
 */

public class TaskFormBackingBean {
    private List<TaskInfo> allTasks = null;
    private List<TaskInfo> selectedTasks = null;
    
    public List<TaskInfo> getAllTasks() {
        return allTasks;
    }
    
    public void setAllTasks(List<TaskInfo> allTasks) {
        this.allTasks = allTasks;
    }

    public List<TaskInfo> getSelectedTasks() {
        return selectedTasks;
    }

    public void setSelectedTasks(List<TaskInfo> selectedTasks) {
        this.selectedTasks = selectedTasks;
    }
}
