/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import hgeosec.Incidente;
import java.util.Date;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import service.GeosecService;

/**
 * @author USUARIO
 */
@Controller
@RequestMapping(value="/incidente")
public class IncidenteController {
    
    @RequestMapping(method= RequestMethod.GET)
    public String getReportar(@ModelAttribute("incidente") Incidente incidente, Map<String, Object> model){
        //model.addAttribute(new Incidente());
        GeosecService geosecService=new GeosecService();
        List tipos=geosecService.listaTiposCoordenada();
        model.put("listaTipos", tipos);
        return "incidente/getReportar";
    }
    
    @RequestMapping(method = RequestMethod.POST)
    public String reportar(@ModelAttribute("incidente") Incidente incidente, Map<String, Object> model) {	
        GeosecService geosecService=new GeosecService();
        incidente.setEstado((byte)2); //estado 2 en verificación
        Date date = new Date();
        incidente.setFechaincidente(date);
        incidente.setFechareporte(date);
        incidente=geosecService.insertaIncidente(incidente);
        return "redirect:/";
    } 
}
