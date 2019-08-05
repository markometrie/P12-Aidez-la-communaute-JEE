
package com.app.binouz.controller;

import com.app.binouz.dao.BiereRepository;
import com.app.binouz.model.AppUser;
import com.app.binouz.model.Biere;

import java.util.List;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.SortDefault;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;




/*
Classe controller qui va gérer les méthodes relatives aux Bieres
*
@Author: Matthieu Delomez
*/
@Controller
public class BiereController {
    
    
    @Autowired
    private  BiereRepository biereRepository;
    

    @Autowired
    public BiereController(BiereRepository biereRepository) {
        this.biereRepository = biereRepository;
    }

    
    @GetMapping("/addBiere")
    public String addBiereGet(Model model){
        model.addAttribute("biere", new Biere());
        
        
        return "addBiere";
        
    }
    

    @PostMapping("addBiere")
    public String addBiere(@Valid Biere biere, BindingResult result, Model model) {
        if (result.hasErrors()) {
            return "addBiere";
        }

        biereRepository.save(biere);
        return "/index";
    }
    
  
  @GetMapping("listBiere")
  public String showPage(Model model, @RequestParam(defaultValue = "0") int page){
      model.addAttribute("data", biereRepository.findAll(new PageRequest(page, 4)));
      
      model.addAttribute("currentPage", page);
      
      return "listBiere";
  }
    
    

    
    
    @GetMapping("searchBiere")
        public String bierehome( Model model, String nombiere) {
            
       
         List <Biere> listTest = biereRepository.findByNombiere(nombiere);
         model.addAttribute("nombieres", biereRepository.findByNombiere(nombiere));
            
         System.out.println("========================>" + listTest.size() + "<==========================");
         System.out.println("=======================>" +nombiere + "<=============================");
            
            return "searchBiere";
                                
        }
        
        
    
    

    
    
    /*
    ************************************************************
    PARTIE RESERVE A LA MODERATION DE APPLICATION
    ************************************************************
    */
    
    @GetMapping("/deleteBiere")
    @Secured("ROLE_ADMIN")
    public String deleteBiereGet(Model model, AppUser user){
        model.addAttribute("biere", new Biere());
        
        
        return "deleteBiere";
        
    }
    
    
    
    
    @PostMapping("/deleteBiere")
    public String deleteBiereGeet(@Valid Biere biere, BindingResult result,Model model, Long idbiere){
        

        
        biereRepository.deleteById(idbiere);
        
        System.out.println("=======================>" +idbiere + "<=============================");
        
        
        return "index";
        
        

        
    }
  
    
    }
    

