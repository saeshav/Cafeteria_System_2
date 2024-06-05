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
import model.Menu;

/**
 *
 * @author Saesh
 */
@Stateless
public class MenuFacade extends AbstractFacade<Menu> {

    @PersistenceContext(unitName = "CafeteriaSystem-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public MenuFacade() {
        super(Menu.class);
    }
    
        public Menu findByItem(String item) {
        TypedQuery<Menu> query = em.createQuery("SELECT item FROM Menu u WHERE u.item = :item", Menu.class);
        query.setParameter("item", item);
        List<Menu> result = query.getResultList();
        return result.isEmpty() ? null : result.get(0);
    }
}
