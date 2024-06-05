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
import model.Manager;

/**
 *
 * @author Saesh
 */
@Stateless
public class ManagerFacade extends AbstractFacade<Manager> {

    @PersistenceContext(unitName = "CafeteriaSystem-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public ManagerFacade() {
        super(Manager.class);
    }

    public Manager findByAccname(String accname) {
        TypedQuery<Manager> query = em.createQuery("SELECT u FROM User u WHERE u.accname = :accname", Manager.class);
        query.setParameter("accname", accname);
        List<Manager> result = query.getResultList();
        return result.isEmpty() ? null : result.get(0);
    }
}
