<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "java.sql.SQLException" %>
<%@ page import="teamC.DBM" %>  
<%
String t_no   = request.getParameter("t_no");
String r_date = request.getParameter("p_state");
String u_no   = request.getParameter("u_no");
String p_try  = request.getParameter("p_try");
String p_end  = request.getParameter("p_end");

DBM dbm = new DBM();
dbm.DBOpen();
String sql = "" ;
sql = "update pt set p_state = 'd', p_end = now() where t_no =" + t_no ;
sql += " and u_no =" + u_no + " and p_try =" + p_try ;
//System.out.println(sql);
dbm.Excute(sql);
dbm.DBClose();
%>