package com.ypy.graduationProject.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/test")
public class TestController {
	@RequestMapping("/a")
	public void a() {
		System.out.println("test");
	}
}
