/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facade;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import model.ManagerProfile;

/**
 *
 * @author Saesh
 */
@Stateless
public class ManagerProfileFacade extends AbstractFacade<ManagerProfile> {

    @PersistenceContext(unitName = "CafeteriaSystem-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public ManagerProfileFacade() {
        super(ManagerProfile.class);
    }
    
}
