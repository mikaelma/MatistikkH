package com.enmaka.matistikk.objects;

/**
 *
 * @author Team ENMAKA
 * 
 * Klassen brukes sammen med uthenting av statistisk informasjon om en oppgave.
 * 
 * For mer informasjon om klassen, se designdokumentet kapittel 4.7.13.
 */

public class TaskStatistics {
    private int taskId;
    private int students;
    private int correct;
    private int wrong;
    
    public TaskStatistics(){}
    
    public TaskStatistics(int taskId, int students, int correct, int wrong) {
        this.taskId = taskId;
        this.students = students;
        this.correct = correct;
        this.wrong = wrong;
    }

    public int getTaskId() {
        return taskId;
    }

    public void setTaskId(int taskId) {
        this.taskId = taskId;
    }

    public int getStudents() {
        return students;
    }

    public void setStudents(int students) {
        this.students = students;
    }

    public int getCorrect() {
        return correct;
    }

    public void setCorrect(int correct) {
        this.correct = correct;
    }

    public int getWrong() {
        return wrong;
    }

    public void setWrong(int wrong) {
        this.wrong = wrong;
    }
    
    @Override
    public String toString() {
        return "Oppgave: " + taskId + " Antall studenter: " + students + " Antall riktig: " + correct + " Antall feil: " + wrong;
    }
}
