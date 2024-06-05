/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facade;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import model.CustomerProfile;

/**
 *
 * @author Saesh
 */
@Stateless
public class CustomerProfileFacade extends AbstractFacade<CustomerProfile> {

    @PersistenceContext(unitName = "CafeteriaSystem-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public CustomerProfileFacade() {
        super(CustomerProfile.class);
    }
    
}
