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
import model.Customer;

/**
 *
 * @author Saesh
 */
@Stateless
public class CustomerFacade extends AbstractFacade<Customer> {

    @PersistenceContext(unitName = "CafeteriaSystem-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public CustomerFacade() {
        super(Customer.class);
    }

       public Customer findByAccname(String accname) {
        TypedQuery<Customer> query = em.createQuery("SELECT u FROM User u WHERE u.accname = :accname", Customer.class);
        query.setParameter("accname", accname);
        List<Customer> result = query.getResultList();
        return result.isEmpty() ? null : result.get(0);
    } 
}
