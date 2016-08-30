package com.enmaka.matistikk.ui;

import com.enmaka.matistikk.objects.ClassInfo;
import java.util.List;

/**
 *
 * @author Team ENMAKA
 * 
 * Klassen er en BackingBean for informasjon om skoleklasser. Oppretter en liste med ClassInfo-objekter.
 * 
 * For mer informasjon om klassen, se designdokumentet kapittel 4.10.2.
 */

public class ClassInfoFormBackingBean {
    private List<ClassInfo> allClasses = null;

    public List<ClassInfo> getAllClasses() {
        return allClasses;
    }

    public void setAllClasses(List<ClassInfo> allClasses) {
        this.allClasses = allClasses;
    }
}
