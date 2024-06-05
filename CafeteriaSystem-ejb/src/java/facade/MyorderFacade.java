/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package facade;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import model.Myorder;

/**
 *
 * @author cchie
 */
@Stateless
public class MyorderFacade extends AbstractFacade<Myorder> {

    @PersistenceContext(unitName = "CafeteriaSystem-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public MyorderFacade() {
        super(Myorder.class);
    }
    
}
