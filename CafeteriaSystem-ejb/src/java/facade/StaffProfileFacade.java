/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facade;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import model.StaffProfile;

/**
 *
 * @author Saesh
 */
@Stateless
public class StaffProfileFacade extends AbstractFacade<StaffProfile> {

    @PersistenceContext(unitName = "CafeteriaSystem-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public StaffProfileFacade() {
        super(StaffProfile.class);
    }
    
}
