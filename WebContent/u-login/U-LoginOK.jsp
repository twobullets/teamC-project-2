<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "teamC.DBM" %>
<%@ page import = "teamC.VO" %>
<%@ page import = "user.UserDAO" %>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import="util.Utility" %>
<%
	request.setCharacterEncoding("UTF-8");
	String u_id = null;
	String u_pw = null;
	
	u_id = (String)request.getParameter("u_id");
	u_pw = (String)request.getParameter("u_pw");
	
	if(u_id == null || u_pw == null)
	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('아이디 또는 비밀번호가 입력되지 않았습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}

	if(u_pw != null)
	{
		u_pw = Utility.encoding(u_pw);
	}

	UserDAO userDAO = new UserDAO();
	int result = userDAO.login(u_id,u_pw);
	String u_check = userDAO.daejang(u_id);
	String u_state = userDAO.outcheck(u_id);
	
	if(result == 1)
	{
		if(u_state.equals("N"))
		{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('탈퇴 처리된 회원입니다');");
			script.println("history.back();");
			script.println("</script>");
			script.close();	
		}else
		{
			session.setAttribute("u_id", u_id);// 아이디 굽기
			
			if(u_check.equals("D"))
			{	
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('당신은 관리자!!');");
				script.println("location.href = '../daejang/Daejang.jsp'");
				script.println("</script>");
				script.close();	
			
			}else
			{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href='../m-mainpage/M-Mainpage.jsp'");
				script.println("</script>");
				script.close();
			}
		}
	}else if(result == 0)
	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('비밀번호가 틀립니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
	}else if(result == -1)
	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('존재하지 않는 아이디입니다');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		
	}else if(result == -2)
	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('데이터베이스 오류가 발생했습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
	}
	
	
	
	
%>