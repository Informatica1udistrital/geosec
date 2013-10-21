package hgeosec;

import java.util.Date;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Query;
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
    
    public List getIncidentes(){
        List<Incidente> incidentesList = null;
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Criteria criteria=session.createCriteria(Incidente.class);
            incidentesList=(List<Incidente>)criteria.list();
            tx.commit();
        } catch (Exception e) {
            System.err.println(e.toString());
        }
        return incidentesList;
    }
    
    public List getIncidentes(int tipo){
        List<Incidente> incidentesList = null;
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Criteria criteria=session.createCriteria(Incidente.class);
            criteria.add(Restrictions.eq("estado", true));
            if(tipo>0){
                criteria.createAlias("tipocoordenada", "tc").add(Restrictions.eq("tc.tipo", tipo));
            }
            incidentesList=(List<Incidente>)criteria.list();
            tx.commit();
        } catch (Exception e) {
            System.err.println(e.toString());
        }
        return incidentesList;
    }
    
    public List getIncidentes(int tipo, Date from, Date to){
        List<Incidente> incidentesList = null;
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Criteria criteria=session.createCriteria(Incidente.class);
            criteria.add(Restrictions.eq("estado", true));
            criteria.add(Restrictions.ge("fechaincidente", from));
            criteria.add(Restrictions.le("fechaincidente", to));
            if(tipo>0){
                criteria.createAlias("tipocoordenada", "tc").add(Restrictions.eq("tc.tipo", tipo));
            }
            incidentesList=(List<Incidente>)criteria.list();
            tx.commit();
        } catch (Exception e) {
            System.err.println(e.toString());
        }
        return incidentesList;
    }
    
    /**
     * Obtiene lista de incidentes con varios parámetros
     * @param tipo lo aplica si es mayor a 0
     * @param from lo aplica si es diferente de null
     * @param to lo aplica si from es diferente de null
     * @param hi lo aplica si hi es diferente de hf
     * @param hf
     * @return 
     */
    public List getIncidentes(List tipos, Date from, Date to, int hi, int hf){
        List<Incidente> incidentesList = null;
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            String sTipo=tipos.size()>0?"i.tipocoordenada.tipo in (:tipos) and":"";
            String sFecha=from!=null&&(from.compareTo(to)!=0)?"date(i.fechaincidente) between date(:from) and date(:to) and":"";
            String hqlQuery;
            if(hi==hf){
                hqlQuery="from Incidente i where "+sTipo+" "+sFecha+" i.estado=:estado";
            } else if(hi<hf){
                hqlQuery="from Incidente i where "+sTipo+" "+sFecha+" hour(i.fechaincidente) between :hi and :hf and i.estado=:estado";
            }else{
                hqlQuery="from Incidente i where "+sTipo+" "+sFecha+" (hour(i.fechaincidente)>=:hi or hour(i.fechaincidente)<=:hf) and i.estado=:estado";
            }
            Query query=session.createQuery(hqlQuery);
            query.setBoolean("estado", true);
            if(tipos.size()>0){
                query.setParameterList("tipos", tipos);
            }
            if(from!=null&&from.compareTo(to)!=0){
                query.setDate("from", from);
                query.setDate("to", to);
            }
            if(hi!=hf){
                query.setInteger("hi", hi);
                query.setInteger("hf", hf);
            }
            incidentesList=(List<Incidente>)query.list();
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
