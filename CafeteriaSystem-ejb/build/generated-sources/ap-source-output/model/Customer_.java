package model;

import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import model.CustomerProfile;
import model.Myorder;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2023-11-30T22:25:04")
@StaticMetamodel(Customer.class)
public class Customer_ extends User_ {

    public static volatile SingularAttribute<Customer, CustomerProfile> customerRelation;
    public static volatile ListAttribute<Customer, Myorder> order;

}