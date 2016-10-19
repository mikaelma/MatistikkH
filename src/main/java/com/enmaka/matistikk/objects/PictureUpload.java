
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.enmaka.matistikk.objects;
 
/**
 *
 * @author Anbor
 */
public class PictureUpload extends Function {
   
    private String picurl;
   
   
      public PictureUpload(String picurl){
          this.picurl=picurl;
      }
     
 
    public String getPicurl(){
        return picurl;
    }
   
   public void setPicurl(String newpicurl){
       this.picurl=newpicurl;
   }
   
   
}