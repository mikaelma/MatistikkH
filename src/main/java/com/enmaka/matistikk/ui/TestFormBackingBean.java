package com.enmaka.matistikk.ui;

import com.enmaka.matistikk.objects.TestInfo;
import java.util.List;

/**
 *
 * @author Team ENMAKA
 * 
 * Klassen er en BackingBean for tester. Oppretter en liste med TestInfo-objekter.
 * 
 * For mer informasjon om klassen, se designdokumentet kapittel 4.10.7.
 */

public class TestFormBackingBean {
    private List<TestInfo> allTests = null;
    private List<TestInfo> selectedTests = null;
    private List<TestInfo> allTestableTests = null;
    private List<TestInfo> allPractiseTests = null;
    
    public void setAllTests(List<TestInfo> allTests) {
        this.allTests = allTests;
    }
    
    public List<TestInfo> getAllTests() {
        return allTests;
    }

    public List<TestInfo> getSelectedTests() {
        return selectedTests;
    }

    public void setSelectedTests(List<TestInfo> selectedTests) {
        this.selectedTests = selectedTests;
    }
    
    public List<TestInfo> getAllTestableTests() {
        return allTestableTests;
    }

    public void setAllTestableTests(List<TestInfo> allTestableTests) {
        this.allTestableTests = allTestableTests;
    }

    public List<TestInfo> getAllPractiseTests() {
        return allPractiseTests;
    }

    public void setAllPractiseTests(List<TestInfo> allPractiseTests) {
        this.allPractiseTests = allPractiseTests;
    }
}
