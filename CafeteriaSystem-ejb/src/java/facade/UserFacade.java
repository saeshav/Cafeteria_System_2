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
import model.User;

/**
 *
 * @author Saesh
 */
@Stateless
public class UserFacade extends AbstractFacade<User> {

    @PersistenceContext(unitName = "CafeteriaSystem-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public UserFacade() {
        super(User.class);
    }
    
    public User findByAccname(String accname) {
        TypedQuery<User> query = em.createQuery("SELECT u FROM User u WHERE u.accname = :accname", User.class);
        query.setParameter("accname", accname);
        List<User> result = query.getResultList();
        return result.isEmpty() ? null : result.get(0);
    }
    
    public int countGender(String gender) {
        TypedQuery<User> query = em.createQuery("SELECT u FROM User u WHERE u.gender = :gender", User.class);
        query.setParameter("gender", gender);
        List<User> result = query.getResultList();
        return result.size();
    }
}
