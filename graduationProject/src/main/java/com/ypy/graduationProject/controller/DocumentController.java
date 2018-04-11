package com.ypy.graduationProject.controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
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
import org.springframework.web.multipart.MultipartFile;

import com.ypy.graduationProject.common.Const;
import com.ypy.graduationProject.common.FileUtil;
import com.ypy.graduationProject.common.ServerResponse;
import com.ypy.graduationProject.pojo.Document;
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
	public ServerResponse queryTitle(@RequestParam(required=false) String text, @RequestParam(required=false) String isApprove, HttpSession session) {
		if (session.getAttribute(Const.USER_NAME) == null) {
			return ServerResponse.createByFailMsg("请登录！");
		} else {
			if (Const.USER_ADMIN==null && Const.USER_TEACHER==null) {
				return ServerResponse.createByFailMsg("请以教师或管理员身份登录！");
			} else {
				List documentList = iDocumentService.queryDocument(text, isApprove, (Integer) session.getAttribute(Const.USER_TEACHER));
				return ServerResponse.createBySuccessPage(documentList, documentList.size());
			}
		}
	}
	
	/**
	 * 文件上传
	 * @param file
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/uploadDocument")
	@ResponseBody
	public ServerResponse uploadDocument(int sid, MultipartFile file, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		if (session.getAttribute(Const.USER_STUDENT) == null) {
			return ServerResponse.createByFailMsg("请以学生身份登录！");
		} else {
			String contentType = file.getContentType();
	        String fileName = file.getOriginalFilename();  //得到文件名
	        String filePath = request.getSession().getServletContext().getRealPath("fileUpload/");   //要保存的路径
			try {
	            FileUtil.uploadFile(file.getBytes(), filePath, fileName);
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
			String realFileName = FileUtil.wipeOffSuffix(fileName);
			Document documentIsExist = iDocumentService.isExsit(sid, realFileName);  //查询此文档是否已存在
			Date date = new Date();
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			if (documentIsExist != null) {  //文档存在，覆盖原文档
				if ("是".equals(documentIsExist.getIsApprove())) {  //判断文档是否已通过审核
					return ServerResponse.createByFailMsg("您的此文档已通过审核，不需要再次上传！");
				}
				Document doc = new Document();
				doc.setUpdateTime(df.format(date));
				doc.setId(documentIsExist.getId());
				int updateDocumentCount = iDocumentService.updateDocument(doc);
				if (updateDocumentCount > 0) {
					return ServerResponse.createBySuccessMsg("上传成功！");
				} else {
					return ServerResponse.createByFailMsg("更新文档失败！");
				}
			} else {  //文档不存在，添加
				Document doc = new Document();
				doc.setDname(realFileName);
				doc.setSid(sid);
				doc.setUpdateTime(df.format(date));
				String dpath = filePath+fileName;
				dpath = dpath.replaceAll("\\\\", "//");   //替换斜杠
				doc.setDpath(dpath);
				int addDocumentCount = iDocumentService.addDocument(doc);
				if (addDocumentCount > 0) {
					return ServerResponse.createBySuccessMsg("上传成功！");
				} else {
					return ServerResponse.createByFailMsg("上传失败！");
				}
			}
		}
	}
	
	/**
	 * 下载文档
	 * @param dpath
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/downloadDocument")
	@ResponseBody
	public ServerResponse downloadFile(String dpath, int id, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
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
		    		
		            FileInputStream fis = null;
		            BufferedInputStream bis = null;
		            try {
		            	String fileName = new String(dpath.getBytes(), "ISO-8859-1"); //中文文件名需要设置编码
			            response.addHeader("Content-Disposition", "attachment;fileName=" + fileName);// 设置文件名
		                fis = new FileInputStream(file);
		                bis = new BufferedInputStream(fis);
		                IOUtils.copy(bis,response.getOutputStream());  
		                response.flushBuffer();  
		                //教师下载完要更新下载时间
		                Document document = new Document();
		                Date date = new Date();
						SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
						document.setDownloadTime(df.format(date));
						document.setId(id);
						int updateCount = iDocumentService.updateDocument(document);
						if (updateCount <= 0) {
							throw new Exception();
						}
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
		            return null;    //返回空  防止将返回的信息也写到文件中
		        } else {
		        	return ServerResponse.createByFailMsg("此文件不存在！");
		        }
		    } else {
		    	return ServerResponse.createByFailMsg("路径为空！");
		    }
		}
	}
	
	/**
	 * 审核文档
	 * @param document
	 * @param session
	 * @return
	 */
	@RequestMapping("/approveDocument")
	@ResponseBody
	public ServerResponse approveDocument(Document document, HttpSession session) {
		if (session.getAttribute(Const.USER_TEACHER) == null) {
			return ServerResponse.createByFailMsg("请以教师身份登录！");
		} else {
			int queryCount = iDocumentService.queryByIdAndTid(document.getId(),(int)session.getAttribute(Const.USER_TEACHER));
			if (queryCount > 0) {
				Date date = new Date();
				SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				document.setApproveTime(df.format(date));
				int updateCount = iDocumentService.updateDocument(document);
				if (updateCount > 0) {
					return ServerResponse.createBySuccessMsg("审批成功！");
				} else {
					return ServerResponse.createByFailMsg("审批失败！");
				} 
			} else {
				return ServerResponse.createByFailMsg("您没有权力审批此文档！");
			}
		}
	}
	
	/**
	 * 查询单个文档信息
	 * @param id
	 * @param session
	 * @return
	 */
	@RequestMapping("/queryOneDocument")
	@ResponseBody
	public ServerResponse queryOneDocument(int id, HttpSession session) {
		if (session.getAttribute(Const.USER_NAME) == null) {
			return ServerResponse.createByFailMsg("请登录！");
		} else {
			if (Const.USER_ADMIN==null && Const.USER_TEACHER==null) {
				return ServerResponse.createByFailMsg("请以教师或管理员身份登录！");
			} else {
				Document document = iDocumentService.queryOneDocument(id);
				return ServerResponse.createBySuccessData(document);
			}
		}
	}
	
	@RequestMapping("/queryOneDocumentBySidAndDname")
	@ResponseBody
	public ServerResponse queryOneDocumentBySidAndDname(String dname, HttpSession session) {
		if (session.getAttribute(Const.USER_STUDENT) == null) {
			return ServerResponse.createByFailMsg("请以学生身份登录！");
		} else {
			List doc = iDocumentService.queryOneDocumentBySidAndDname(dname, (int)session.getAttribute(Const.USER_STUDENT));
			if (doc != null) {
				return ServerResponse.createBySuccessData(doc.get(0));
			}
			return ServerResponse.createByFailMsg("文档不存在！");
		}
	}
	
	/**
	 * 查询某学生的文档
	 * @param session
	 * @return
	 */
	@RequestMapping("/queryDocumentBySid")
	@ResponseBody
	public ServerResponse queryDocumentByTid(HttpSession session) {
		if (session.getAttribute(Const.USER_STUDENT) == null) {
			return ServerResponse.createByFailMsg("请以学生身份登录！");
		} else {
			List documentList = iDocumentService.queryDocumentBySid((int)session.getAttribute(Const.USER_STUDENT));
			return ServerResponse.createBySuccessData(documentList);
		}
	}
}
