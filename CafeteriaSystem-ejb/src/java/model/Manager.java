/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import javax.persistence.Entity;
import javax.persistence.OneToOne;

/**
 *
 * @author Saesh
 */
@Entity
public class Manager extends User{
    @OneToOne
    private ManagerProfile managerRelation;
    
    public Manager (){
    }

    public Manager(ManagerProfile managerRelation, String accname, int age, String gender, String name, String password, String contact_number) {
        super(accname, name, age, gender, contact_number, password, "manager");
        this.managerRelation = managerRelation;
    }



    public ManagerProfile getManagerRelation() {
        return managerRelation;
    }

    public void setManagerRelation(ManagerProfile managerRelation) {
        this.managerRelation = managerRelation;
    }
    
    
    
}