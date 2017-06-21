<%@page import="java.io.OutputStream"%>
<%@page import="kr.co.bit.board.vo.BoardFileVO"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="kr.co.bit.board.dao.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%

	/* String filePath = (String)request.getParameter("filePath");
	String fileName = (String)request.getParameter("fileName"); */
	 //File f = dao.download(Integer.parseInt(request.getParameter("no")));
	
	InputStream is = null; // request.getInputStream();
	OutputStream os = null;
	// FileInputStream fis = new FileInputStream();
	
	 BoardDAO dao = new BoardDAO();
	 BoardFileVO fileVO = dao.selectFile(Integer.parseInt(request.getParameter("no")));
	 
	 String root = request.getSession().getServletContext().getRealPath("/");
	 String savePath = root + "upload";
	 String fileName = fileVO.getFileSaveName();
	 String origFileName = fileVO.getFileOriName();
	 
	 File file = null;
	 
	 try{
	
		 try{
			 
			 file = new File(savePath, fileName); 
			 is = new FileInputStream(file);
			 
		 }catch(Exception e){
			 e.printStackTrace();
		 }
				 
		String client = request.getHeader("User-Agent");
		response.setContentType("application/octet-stream");
		//response.setHeader("Content-Description","JSP Generated Data");
		
		//IE
		if(client.indexOf("MSIE")!=-1){
			response.setHeader("Content-Disposition", "attachment; filename="+new String(origFileName.getBytes("KSC5601"),"ISO8859_1"));	
		}else {
			origFileName = new String(origFileName.getBytes("utf-8"),"iso-8859-1");
			
			response.setHeader("Content-Disposition", "attachment; filename=\""+origFileName+"\"");
		//	response.setHeader("Content-Type", "application/octet-stream; charset=utf-8");
		}
	
	//	response.setHeader("Content-Length",""+file.length());
		
		os = response.getOutputStream();
		byte b[] = new byte[(int)file.length()];
		int len = 0;
		
		while((len = is.read(b))>0){
			os.write(b,0,len);
		}
		
		is.close();
		os.close();
		
	 }catch(Exception e){
		 e.printStackTrace();
	 }
%>