/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.util.ArrayList;
import java.util.List;
import javax.persistence.Entity;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;

/**
 *
 * @author Saesh
 */
@Entity
public class Customer extends User {
    @OneToOne
    private CustomerProfile customerRelation;
    @OneToMany
    private List<Myorder> order = new ArrayList<Myorder>();

    public Customer() {
    }

    public Customer(String accname, String name, int age, String gender, String contact_number, String password) {
        super(accname, name, age, gender, contact_number, password, "customer");
    }
    
    public CustomerProfile getCustomerRelation() {
        return customerRelation;
    }

    public void setCustomerRelation(CustomerProfile customerRelation) {
        this.customerRelation = customerRelation;
    }

    public List<Myorder> getOrder() {
        return order;
    }

    public void setOrder(List<Myorder> order) {
        this.order = order;
    }
}