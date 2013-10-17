/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import hgeosec.Incidente;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import service.GeosecService;

/**
 * @author USUARIO
 */
@Controller
//@RequestMapping(value="/incidente")
public class IncidenteController {
    
    @RequestMapping(value="/incidente", method= RequestMethod.GET)
    public String getReportar(@ModelAttribute("incidente") Incidente incidente, Map<String, Object> model){
        //model.addAttribute(new Incidente());
        GeosecService geosecService=new GeosecService();
        List tipos=geosecService.listaTiposCoordenada();
        Calendar cal =new GregorianCalendar();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
        model.put("today",sdf.format(cal.getTime()));
        model.put("hora",cal.get(Calendar.HOUR_OF_DAY));
        model.put("minuto",cal.get(Calendar.MINUTE));
        model.put("listaTipos", tipos);
        return "incidente/getReportar";
    }
    
    @RequestMapping(value="/incidente", method = RequestMethod.POST)
    public String reportar(@ModelAttribute("incidente") Incidente incidente, BindingResult result, Map<String, Object> model) {	//@ModelAttribute("incidente")
        GeosecService geosecService=new GeosecService();
        if(result.hasErrors()){
            List tipos=geosecService.listaTiposCoordenada();
            model.put("listaTipos", tipos);
            return "incidente/getReportar";
        }
        incidente.setEstado((byte)2); //estado 2 en verificación
        Date date = new Date();
        incidente.setFechareporte(date);
        Calendar cal =new GregorianCalendar();
        cal.setTime(incidente.getFechaincidente());
        cal.set(Calendar.HOUR_OF_DAY, incidente.getHora());
        cal.set(Calendar.MINUTE, incidente.getMinuto());
        incidente.setFechaincidente(cal.getTime());
        incidente=geosecService.insertaIncidente(incidente);
        return "redirect:/";
    } 
}
