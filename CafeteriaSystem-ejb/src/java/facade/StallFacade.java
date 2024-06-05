/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facade;

import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import model.Stall;

/**
 *
 * @author Saesh
 */
@Stateless
public class StallFacade extends AbstractFacade<Stall> {

    @PersistenceContext(unitName = "CafeteriaSystem-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public StallFacade() {
        super(Stall.class);
    }

    public Stall findByAccname(String accname) {
        TypedQuery<Stall> query = em.createQuery("SELECT u FROM User u WHERE u.accname = :accname", Stall.class);
        query.setParameter("accname", accname);
        List<Stall> result = query.getResultList();
        return result.isEmpty() ? null : result.get(0);
    }

}
