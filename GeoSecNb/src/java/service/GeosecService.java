package service;

import hgeosec.GeosecHelper;
import hgeosec.Incidente;
import java.util.Date;
import java.util.List;

/**
 * @author DIEGO
 */
public class GeosecService {
    
    GeosecHelper helper=null;
    
    public GeosecService(){
        helper=new GeosecHelper();
    }

    public List listaTiposCoordenada(){
        return helper.getTipocoordenada();
    }
    
    public Incidente insertaIncidente(Incidente incidente){
        return helper.addIncidente(incidente);
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
        return helper.getIncidentes(tipos, from, to, hi, hf);
    }
}
