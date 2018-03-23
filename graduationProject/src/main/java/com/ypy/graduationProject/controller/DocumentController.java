package com.ypy.graduationProject.controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.tomcat.util.http.fileupload.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ypy.graduationProject.common.Const;
import com.ypy.graduationProject.common.ServerResponse;
import com.ypy.graduationProject.service.IDocumentService;

@Controller
@RequestMapping("/document")
public class DocumentController {
	@Autowired
	private IDocumentService iDocumentService;
	
	/**
	 * 查询文档
	 * @param text
	 * @param session
	 * @return
	 */
	@RequestMapping("/queryDocument")
	@ResponseBody
	public ServerResponse queryTitle(@RequestParam(required=false) String text, HttpSession session) {
		if (session.getAttribute(Const.USER_NAME) == null) {
			return ServerResponse.createByFailMsg("请登录！");
		} else {
			if (Const.USER_ADMIN==null && Const.USER_TEACHER==null) {
				return ServerResponse.createByFailMsg("请以教师或管理员身份登录！");
			} else {
				List documentList = iDocumentService.queryDocument(text, (Integer) session.getAttribute(Const.USER_TEACHER));
				return ServerResponse.createBySuccessPage(documentList, documentList.size());
			}
		}
	}
	
	@RequestMapping("/downloadDocument")
	@ResponseBody
	public ServerResponse downloadFile(String dpath, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		if (session.getAttribute(Const.USER_TEACHER) == null) {
			return ServerResponse.createByFailMsg("请以教师身份登录！");
		} else {
			if (dpath != null) {
		        File file = new File(dpath);
		        //判断文件是否存在
		        if (file.exists()) {
		            response.setContentType("application/force-download");// 设置强制下载不打开
		            //截取文件名
		            int index = dpath.indexOf("//");
		    		while (index != -1) {
		    			dpath = dpath.substring(index+2, dpath.length());
		    			index = dpath.indexOf("//");
		    		}
		            response.addHeader("Content-Disposition", "attachment;fileName=" + dpath);// 设置文件名
		            FileInputStream fis = null;
		            BufferedInputStream bis = null;
		            try {
		                fis = new FileInputStream(file);
		                bis = new BufferedInputStream(fis);
		                IOUtils.copy(bis,response.getOutputStream());  
		                response.flushBuffer();  
		            } catch (Exception e) {
		                e.printStackTrace();
		            } finally {
		                if (bis != null) {
		                    try {
		                        bis.close();
		                    } catch (IOException e) {
		                        e.printStackTrace();
		                    }
		                }
		                if (fis != null) {
		                    try {
		                        fis.close();
		                    } catch (IOException e) {
		                        e.printStackTrace();
		                    }
		                }
		            }
		            return ServerResponse.createBySuccessMsg("success");
		        } else {
		        	return ServerResponse.createByFailMsg("此文件不存在！");
		        }
		    } else {
		    	return ServerResponse.createByFailMsg("路径为空！");
		    }
		}
	}
}
