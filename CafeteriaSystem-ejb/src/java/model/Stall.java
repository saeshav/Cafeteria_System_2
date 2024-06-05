/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.io.Serializable;
import javax.persistence.Entity;
import javax.persistence.OneToOne;

/**
 *
 * @author Saesh
 */
@Entity
public class Stall extends User{

    @OneToOne
    private StaffProfile stallProfile;

    public Stall() {
    }

    public Stall(StaffProfile stallProfile, String accname, int age, String gender, String name, String password, String contact_number) {
        super(accname, name, age, gender, contact_number, password, "inactive");
        this.stallProfile = stallProfile;
    }

    @Override
    public String getStatus() {
        return super.getStatus();
    }

    @Override
    public void setStatus(String Status) {
        super.setStatus(Status);
    }

    public StaffProfile getStallProfile() {
        return stallProfile;
    }

    public void setStallProfile(StaffProfile stallProfile) {
        this.stallProfile = stallProfile;
    }

}
