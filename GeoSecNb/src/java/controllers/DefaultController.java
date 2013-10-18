/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.List;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import service.GeosecService;

/**
 * @author USUARIO
 */
@Controller
public class DefaultController {
    
    /**
     * 
     * @param map
     * @return
     */
    @RequestMapping(value="/", method= RequestMethod.GET)
    public String index(ModelMap model) {
        GeosecService geosecService=new GeosecService();
        List tipos=geosecService.listaTiposCoordenada();
        Calendar cal =new GregorianCalendar();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
        model.put("today",sdf.format(cal.getTime()));
        model.put("hora",cal.get(Calendar.HOUR_OF_DAY));
        model.put("minuto",cal.get(Calendar.MINUTE));
        model.put("listaTipos", tipos);
        return "index";
    }
}
