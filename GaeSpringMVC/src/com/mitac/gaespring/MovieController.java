package com.mitac.gaespring;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Example from: http://www.mkyong.com/google-app-engine/google-app-engine-spring-3-mvc-rest-example/
 * @author simonsu
 */
@Controller
@RequestMapping("/views")
public class MovieController {

	String message;
	
	//Uri: "/views/getMovie"
	@RequestMapping(value = "/{name}", method = RequestMethod.GET)
	public String getMovie(@PathVariable String name, ModelMap model) {
		model.addAttribute("name", name);
		model.addAttribute("message", this.message);
		return "index";
	}
	
	public void setMessage(String message) {
		this.message = message;
	}
}