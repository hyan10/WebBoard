<%@page import="java.io.File"%>
<%@page import="java.util.Enumeration"%>
<%@page import="kr.co.bit.util.BitFileNamePolicy"%>
<%@page import="com.oreilly.servlet.multipart.FileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="kr.co.bit.board.dao.BoardDAO"%>
<%@page import="kr.co.bit.board.vo.BoardVO"%>
<%@page import="kr.co.bit.board.vo.BoardFileVO"%>
<%@page import="kr.co.bit.util.JDBCClose"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="kr.co.bit.util.ConnectionFactory"%>
<%@page import="java.sql.*"%>

<%

	request.setCharacterEncoding("utf-8");

	// 저장할 웹서버 위치
	String saveFolder = "C:\\hy\\web-workspace\\Mission-Web\\WebContent\\upload";
	
	MultipartRequest multi = new MultipartRequest(request, saveFolder, 1024*1024*3,
													"utf-8", new BitFileNamePolicy());
	
	String title = multi.getParameter("title");
	String writer = multi.getParameter("writer");
	String content = multi.getParameter("content");
	
	BoardDAO dao = new BoardDAO();
	
	// 0. 등록할 게시글의 sequence를 추출
	int no = dao.selectNo();
	
	// 1. 게시물 저장 (t_board)
	BoardVO board = new BoardVO();
	board.setNo(no);
	board.setTitle(title);
	board.setWriter(writer);
	board.setContent(content);
	
	System.out.println(board);	
	boolean result = dao.insertBoard(board);
	
	// 2. 첨부파일 저장 (t_board_file)
	if(result){
			
		Enumeration files = multi.getFileNames();
		
		while(files.hasMoreElements()){
			String fileName = (String)files.nextElement();
			System.out.println(fileName);
			
			File f = multi.getFile(fileName);
			System.out.println(fileName+": "+f);
			
			if(f!=null){
				
				String fileOriName = multi.getOriginalFileName(fileName);
				String fileSaveName = multi.getFilesystemName(fileName);
				int fileSize = (int)f.length();
				
				BoardFileVO fileVO = new BoardFileVO();
				fileVO.setBoardNo(no);
				fileVO.setFileOriName(fileOriName);
				fileVO.setFileSaveName(fileSaveName);
				fileVO.setFileSize(fileSize);
				
				result = dao.insertFile(fileVO);
					
			}
		}
	}
	

	/* String title = request.getParameter("title");
	String writer = request.getParameter("writer");
	String content = request.getParameter("content");
	
	BoardVO board = new BoardVO();
	board.setTitle(title);
	board.setWriter(writer);
	board.setContent(content);
	
	BoardDAO dao = new BoardDAO();
	boolean result = dao.insertBoard(board); */
	
	// DAO로 바뀔 부분
	/* Connection conn = new ConnectionFactory().getConnection();
	StringBuilder sql = new StringBuilder("insert into t_board (no, title, writer, content) ");
	sql.append(" values (seq_t_board_no.nextval, ?,?,?)");
	
	PreparedStatement st = conn.prepareStatement(sql.toString());
	st.setString(1, title);
	st.setString(2, writer);
	st.setString(3, content);
	
	int result = st.executeUpdate();
	
	JDBCClose.close(conn, st); */

%>

<script>

<% if(result) {%>

	alert("게시글이 등록되었습니다.");
	location.href="list.jsp";
<% } %>
</script>