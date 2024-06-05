package model;

import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2023-11-30T22:25:04")
@StaticMetamodel(Myorder.class)
public class Myorder_ { 

    public static volatile SingularAttribute<Myorder, String> Feedback;
    public static volatile SingularAttribute<Myorder, Double> totalPrice;
    public static volatile SingularAttribute<Myorder, String> Rating;
    public static volatile SingularAttribute<Myorder, Integer> Quantity;
    public static volatile SingularAttribute<Myorder, Long> id;
    public static volatile SingularAttribute<Myorder, String> Menu;
    public static volatile SingularAttribute<Myorder, Date> Date;

}