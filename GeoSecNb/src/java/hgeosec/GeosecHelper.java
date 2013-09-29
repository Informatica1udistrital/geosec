package hgeosec;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

/**
 * @author DIEGO
 */
public class GeosecHelper {
    Session session = null;

    public GeosecHelper() {
        this.session = HibernateUtil.getSessionFactory().getCurrentSession();
    }
    
    public List getIncidentes(int tipo){
        List<Incidente> incidentesList = null;
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Criteria criteria=session.createCriteria(Incidente.class);
            criteria.add(Restrictions.eq("estado", true));
            criteria.createAlias("tipocoordenada", "tc").add(Restrictions.eq("tc.tipo", tipo));
            incidentesList=(List<Incidente>)criteria.list();
            tx.commit();
        } catch (Exception e) {
            System.err.println(e.toString());
        }
        return incidentesList;
    }
    
    public Incidente addIncidente(Incidente incidente){
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            session.save(incidente);
            tx.commit();
        } catch (Exception e) {
            System.err.println(e.toString());
        }
        return incidente;
    }
    
    public List getTipocoordenada(){
        List<Tipocoordenada> tiposList = null;
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Criteria criteria=session.createCriteria(Tipocoordenada.class);
            criteria.add(Restrictions.eq("estado", true));
            tiposList=(List<Tipocoordenada>)criteria.list();
            tx.commit();
        } catch (Exception e) {
            System.err.println(e.toString());
        }
        return tiposList;
    }
}
