<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "teamC.DBM" %>
<%@ page import = "teamC.VO" %>
<%@ page import = "trainer.TrainerDAO" %>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import="util.Utility" %>
<%
	request.setCharacterEncoding("UTF-8");
	String t_id = null;
	String t_pw = null;
	
	t_id = (String)request.getParameter("t_id");
	t_pw = (String)request.getParameter("t_pw");
	
	if(t_id == null || t_pw == null)
	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('아이디 또는 비밀번호가 입력되지 않았습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}

	if(t_pw != null)
	{
		t_pw = Utility.encoding(t_pw);
	}
	
	TrainerDAO trainerDAO = new TrainerDAO();
	int result = trainerDAO.login(t_id,t_pw);
	String t_state = trainerDAO.outcheck(t_id);
	
	if(result == 1)
	{
		if(t_state.equals("N"))
		{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('탈퇴 처리된 회원입니다');");
			script.println("history.back();");
			script.println("</script>");
			script.close();	
		}else{
			
			session.setAttribute("u_id", t_id);//u_id는 key일뿐
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href='../t-mainpage/T-Mainpage.jsp'");
			script.println("</script>");
			script.close();
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