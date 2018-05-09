package com.ypy.graduationProject;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@EnableTransactionManagement  //开启事务支持
@SpringBootApplication
public class GraduationProjectApplication {

	public static void main(String[] args) {
		SpringApplication.run(GraduationProjectApplication.class, args);
	}
}
