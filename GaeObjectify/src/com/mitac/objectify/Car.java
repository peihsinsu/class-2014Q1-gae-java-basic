package com.mitac.objectify;

import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class Car {
    @Id 
    String idx; // Can be Long, long, or String
    
    String name;
    
    public Car(String idx, String name) {
    	this.idx = idx;
    	this.name = name;
    }
}
  