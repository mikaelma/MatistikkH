package com.enmaka.matistikk.controllers;

import com.enmaka.matistikk.objects.TaskInfo;
import com.enmaka.matistikk.service.UserService;
import java.beans.PropertyEditorSupport;

/**
 *
 * @author Team ENMAKA
 * 
 * Klassen brukes for å konvertere String til Task-objekter.
 * 
 * For mer informasjon om klassen, se designdokumentet kapittel 4.4.5.
 */

public class TaskEditor extends PropertyEditorSupport {
    private UserService userService;
    
    public TaskEditor(UserService userService) {
        this.userService = userService;
    }
    
    @Override
    public void setAsText(String text) throws IllegalArgumentException {
        TaskInfo ti = userService.getTaskInfoId(Integer.parseInt(text));
        setValue(ti);
    }
}
