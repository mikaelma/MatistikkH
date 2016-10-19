package com.enmaka.matistikk.ui;

import com.enmaka.matistikk.objects.SchoolInfo;
import java.util.List;

/**
 *
 * @author Team ENMAKA
 * 
 * Klassen er en BackingBean for informasjon om skoler. Oppretter en liste med SchoolInfo-objekter.
 * 
 * For mer informasjon om klassen, se designdokumentet kapittel 4.10.3.
 */
public class SchoolInfoFormBackingBean {
    private List<SchoolInfo> allSchools = null;

    public List<SchoolInfo> getAllSchools() {
        return allSchools;
    }

    public void setAllSchools(List<SchoolInfo> allSchools) {
        this.allSchools = allSchools;
    }
    
    
}
