<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "pt.PtDAO" %>
<%@ page import = "java.io.PrintWriter" %>
<%
	request.setCharacterEncoding("UTF-8");
	int u_no = 0;	
	u_no = Integer.parseInt((String)request.getParameter("u_no"));
	
	PtDAO ptDAO = new PtDAO();
	ptDAO.accept(u_no);
	
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('수락이 완료되었습니다. 회원관리 메뉴에서 확인해주세요.');");
	script.println("history.back();");
	script.println("</script>");
	
%>