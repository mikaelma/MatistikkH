package com.enmaka.matistikk.objects;

/**
 *
 * @author Team ENMAKA
 * 
 * Klassen representerer en test.
 * 
 * For mer informasjon om klassen, se designdokumentet kapittel 4.7.16.
 */

public class Test {
    private int id;
    private Task[] tasks;
    private String teacher;
    private Task currentTask;
    private int counter = 0;
    private boolean active;
    private boolean started = false;
    
    public Test(){}
    
    public Test(int id, String teacher, boolean active){
        this.id = id;
        this.teacher = teacher;
        this.active = active;
    }
    
    public Test(int id, Task[] tasks, String teacher, boolean active){
        this.id = id;
        this.tasks = tasks;
        currentTask = tasks[counter];
        this.teacher = teacher;
        this.active = active;
    }
    
    public int getId(){
        return id;
    }
    public void setId(int newId) {
        id = newId;
    }
    public Task[] getTasks() {
        return tasks;
    }
    
    public int getLength(){
        return tasks.length;
    }

    public void setTasks(Task[] tasks) {
        counter = 0;
        currentTask = tasks[counter]; //Første oppgave blir satt
        this.tasks = tasks; 
    }
    
    public Task getCurrentTask(){
        return currentTask;
    }
    
    //Gir oss neste oppgave i testen
    public void nextTask(){
        counter++;
        currentTask = tasks[counter];
    }
    
    public int getCounter(){
        return counter;
    }
    
    public void setCounter(int counter){
        this.counter = counter;
        currentTask = tasks[counter];
    }
    
    //Gir oss forrige oppgave i testen
    public void previousTask(){
        if(counter > 0){
            counter--;
            currentTask = tasks[counter];
        }
    }
    
    public String getTeacher() {
        return teacher;
    }

    public void setTeacher(String teacher) {
        this.teacher = teacher;
    }
    
    public void setAnswer(Answer answer){
        currentTask.setAnswer(answer);
        currentTask.isCorrect();
    }
    
    public boolean isActive(){
        return active;
    }
    
    public void setActive(boolean active){
        this.active = active;
    }

    public boolean isStarted() {
        return started;
    }

    public void setStarted(boolean started) {
        this.started = started;
    }
    
    @Override
    public String toString(){
        return "Laget av " + teacher;
    }
}
