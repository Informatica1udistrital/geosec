/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import hgeosec.GeosecHelper;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
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
    @RequestMapping(value="/indexOld", method= RequestMethod.GET)
    public String indexOld(ModelMap model) {
        GeosecHelper geosecHelper=new GeosecHelper();
        List tipos=geosecHelper.getTipocoordenada();
        Calendar cal =new GregorianCalendar();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
        model.put("today",sdf.format(cal.getTime()));
        model.put("hora",cal.get(Calendar.HOUR_OF_DAY));
        model.put("minuto",cal.get(Calendar.MINUTE));
        model.put("listaTipos", tipos);
        return "index";
    }
    
    @RequestMapping(value="/", method= RequestMethod.GET)
    public String index(ModelMap model, HttpServletRequest request) {
        GeosecHelper geosecHelper=new GeosecHelper();
        if(request.getSession().getAttribute("auth")!=null){
            String auth=(String)request.getSession().getAttribute("auth");
            if(!auth.isEmpty()){
                return "redirect:/mapa";
            }
        }
        //request.getSession().setAttribute("auth", "diegoenrik@gmail.com");
        model.addAttribute("logon", false);
        return "index";
    }
    
    @RequestMapping(value="/logoff", method= RequestMethod.GET)
    public String logoff(ModelMap model, HttpServletRequest request) {
        GeosecHelper geosecHelper=new GeosecHelper();
        if(request.getSession().getAttribute("auth")!=null){
            request.getSession().removeAttribute("auth");
        }
        return "redirect:/";
    }
    
    @RequestMapping(value="/index", method= RequestMethod.POST)
    public String indexPost(ModelMap model, HttpServletRequest request) {
        return "consumer_redirect";
    }

}
