<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "java.sql.SQLException" %>
<%@ page import="teamC.DBM" %>  
<%@ page import="teamC.VO" %>
<%
	String t_no = request.getParameter("t_no");
	int listMax = Integer.parseInt(request.getParameter("listMax"));
	int p_cnt = Integer.parseInt(request.getParameter("p_cnt"));
	String u_no = request.getParameter("u_no");
	String p_try = request.getParameter("p_try");

	DBM dbmA = new DBM();
	DBM dbmB = new DBM();
	//out.println(t_no);
	//out.println(u_no);
	//out.println(p_try);
	 try 
	 {
		 if(listMax<p_cnt)
		 {
			 dbmA.DBOpen();
			 String sql = "" ;
			 sql = "select max(r_ct) as r_cnt from round where t_no = '" + t_no + "' and u_no = '" + u_no + "' ";
			 System.out.println(sql);
			 dbmA.OpenQuery(sql);		
			 String r_cnt = "";
			 if( dbmA.ResultNext() == true)
			 {
				 r_cnt = dbmA.getString("r_cnt");		 	
			 }
			 dbmA.CloseQuery();	
			 System.out.println(r_cnt);
			 if(r_cnt == null)
			 {
				 r_cnt = "0";
			 }
			 
			 
			 sql = "insert into round(t_no,u_no,p_try,r_ct,r_date)" ;
			 sql+= "value("+t_no+","+u_no+","+p_try+","+r_cnt+" + 1, now())";      // 끝날떄  r_ct +1 하면 되는데
			 System.out.println(sql);
			 dbmA.Excute(sql);
			 out.print('0');
			 System.out.println(sql);
		 }
		 else if(listMax>=p_cnt)
		 {
			 dbmB.DBOpen();
			 String sql = "" ;
			 sql = "update pt set p_state='c', p_end = now() where u_no = "+ u_no ;
			 out.print('1');
			 dbmB.Excute(sql);
		 }
		 /*
		String sql = "select count(c_no) as cnt2 from count where p_no=?"; 
		System.out.println(sql);
		dbm.Excute(sql);
		psmt.setString(1,p_no);
		rs.next();
		*/
	 
	 }catch(Exception e) 
		{ 
			e.printStackTrace(); 
		}finally
		{
			if(listMax<p_cnt)
			{
				dbmA.DBClose();
			}
			else if(listMax>=p_cnt)
			{
				dbmB.DBClose();
			}
		}
	 %>