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
public class DefaultController {
    
    /**
     * 
     * @param map
     * @return
     */
    @RequestMapping(value="/", method= RequestMethod.GET)
    public String index(ModelMap map) {
        map.addAttribute("hello", "Hello Spring from Netbeans!!");
        return "index";
    }
}
