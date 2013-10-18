/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package controllers;

import hgeosec.Incidente;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import service.GeosecService;

/**
 *
 * @author dfernandez
 */
@Controller
public class AjaxController {
    
    @RequestMapping(value="/ajax/incidentesFiltro", method= RequestMethod.GET)  //@ResponseBody
    public ModelMap incidentesFiltro(HttpServletRequest request, HttpServletResponse response, String tipos, Date from, Date to, int hi, int hf){
        List iTipos=new ArrayList();
        GeosecService geosecService=new GeosecService();
        if(tipos!=null&&!tipos.isEmpty()){
            String []sTipos=tipos.split(",");
            for (String sTipo : sTipos) {
                iTipos.add(Integer.parseInt(sTipo));
            }
        }
        List<Incidente> items=geosecService.getIncidentes(iTipos, from, to, hi, hf);
        
        ModelMap map=new ModelMap();
        for (Incidente incidente : items) {
            ModelMap incidenteJSON=new ModelMap();
            incidenteJSON.put("id", incidente.getId());
            incidenteJSON.put("tipocoordenada", incidente.getTipocoordenada().getTipo());
            incidenteJSON.put("latitud", incidente.getLatitud());
            incidenteJSON.put("longitud", incidente.getLongitud());
            incidenteJSON.put("descripcion", incidente.getDescripcion());
            incidenteJSON.put("fechareporte", incidente.getFechareporte());
            incidenteJSON.put("fechaincidente", incidente.getFechaincidente());
            incidenteJSON.put("estado", incidente.getEstado());
            map.addAttribute("item_"+incidente.getId(), incidenteJSON);        
        }
        return map;
    }
}
