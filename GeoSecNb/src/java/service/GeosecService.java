package service;

import hgeosec.GeosecHelper;
import hgeosec.Incidente;
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
}
