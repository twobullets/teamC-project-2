<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="teamC.DBM" %>
<%@ page import="trainer.TrainerSearchDAO" %>
<%
request.setCharacterEncoding("UTF-8");

String u_id = null;
if(session.getAttribute("u_id") != null)
{
	u_id = (String) session.getAttribute("u_id");    // 회원 아이디
}
String T    = (String)request.getParameter("t_no");  // 트레이너 번호
String pCnt = (String)request.getParameter("p_cnt"); // PT총회차


TrainerSearchDAO dao = new TrainerSearchDAO();

int result =   dao.tCancelDAO(u_id,T,pCnt);

out.print(result+","+pCnt);

%>