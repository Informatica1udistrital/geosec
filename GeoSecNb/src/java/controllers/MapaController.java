/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * @author USUARIO
 */
@Controller
public class MapaController {
    
    @RequestMapping(value="/mapa", method= RequestMethod.GET)
    public String ubicar(ModelMap model){
        model.addAttribute("logon", true);
        return "mapa/ubicar";
    }
   
}
