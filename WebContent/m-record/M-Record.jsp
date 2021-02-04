<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="teamC.DBM" %>  
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
<link href="../style/MRecordpage.css" rel="stylesheet" type="text/css">
<title>MEMBER RECORD</title>
<script src="../js/jquery-3.5.1.min.js"></script>
<script>

	//누르면 상단으로 감!
    function onTop()
    {
    	$(".workout").scrollTop(0);	
    }
	
	function Countlist(r_ct,u_no,t_no,p_try)
	{
		var u_no   = u_no;
		var t_no   = t_no;
		var p_try  = p_try;
		var r_ct   = r_ct;
		var list   = r_ct;
		var output = "";
			list   = Number(list);
		for(var i=list; i>=1; i--)
		{			
			output += "<input type='button' id='btn"+i+"' value = '"+i+"회차 운동기록' " ;
			output += "class='btn btn-primary' " ;
			output += "style='width:500px; height:30px; margin-top:10px;'" ;
			output += "onclick= 'Exlistopen("+u_no+","+i+","+t_no+","+p_try+")';>";
			output += "<div class='exlist'>";
			output += "</div>";
		}
			if(list == 0)
			{
				alert("저장된 회차가 없습니다");
			}
			else
			{	
				$(".list1").toggle();
				$(".list1").html(output);
			}
	}
	function Exlistopen(u_no,i,t_no,p_try)
	{
 		var u_no  = u_no;
 		var i 	  = i;
 		var t_no  = t_no;
 		var p_try = p_try;
		$.ajax({
			type:'GET',
			data:{"u_no":u_no, "i":i,"t_no":t_no,"p_try":p_try}, 
			url:'M-Exlistopen.jsp',
			success:function(data)
			{
				//alert(data);
				$(".exlist").html(data);
			}
		});
	}
	
</script>
<style>

</style>
</head>
<%
	String u_id = null;
	if(session.getAttribute("u_id") != null) 
	{
		u_id = (String) session.getAttribute("u_id");
	}
	//System.out.println(u_id);
	if(u_id == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('잘못된 접근입니다!!');");
		script.println("location.href = '../startpage/Firstpage.jsp'");
		script.println("</script>");
		script.close();	
	}
	try
	{
		DBM dbm  = new DBM();
		DBM dbm2 = new DBM();
		DBM dbm3 = new DBM();
		dbm.DBOpen();
		String sql  = "" ;
			   sql += "select u_no, u_nick, u_gender from user where u_id = '" +u_id ;
			   sql += "'" ;
		dbm.OpenQuery(sql);
		dbm.ResultNext();
		 String u_no 	 = dbm.getString("u_no");
		 String u_nick 	 = dbm.getString("u_nick");
		 String u_gender = dbm.getString("u_gender");
		dbm2.DBOpen();	
		sql = "select p_no, t_no, p_state, p_cnt, p_ok, p_end, p_try from pt where u_no = " +u_no ;
		 dbm2.OpenQuery(sql);
		 dbm2.ResultNext();
		 String p_no 	= dbm2.getString("p_no");
		 String t_no 	= dbm2.getString("t_no");
		 String p_state = dbm2.getString("p_state");
		 String p_cnt	= dbm2.getString("p_cnt");
		 String p_ok    = dbm2.getString("p_ok");
		 String p_end	= dbm2.getString("p_end");
		 String p_try	= dbm2.getString("p_try");
		
		 dbm3.DBOpen();
			sql  = "select r_no, Max(r_ct) as r_ct, r_date from round where u_no = " +u_no ;
			sql += " and t_no = " + t_no ;
		 dbm3.OpenQuery(sql);
		 dbm3.ResultNext();
		 String r_no   = dbm3.getString("r_no");
		 String r_ct   = dbm3.getString("r_ct");
		 String r_date = dbm3.getString("r_date");
%>
<body>
	<!-- 상단 로그아웃 버튼 -->
	<div id="first">
		<button type="button" class="btn btn-link" onclick="location.href='../u-login/U-Logout.jsp'">LOGOUT</button>
	</div>	
	
	<!-- 상단 로고 -->
	<div>
		<img src="../images/ULOGO.png" style="width:110px; height:70px; position:absolute; top:0; cursor: pointer;" onclick="location.href='../m-mainpage/M-Mainpage.jsp'">
	</div>
	
	<!-- 상단 메뉴바 -->
	<div class="contents">
		<ul>
			<li>
				<a href="../m-record/M-Record.jsp">내 PT 기록</a>
			</li>
			<li>
				<a href="../m-mypage/M-Trainerview.jsp">트레이너 검색</a>
			</li>
			<li>
				<a href="../m-mypage/M-Mypage.jsp">마이페이지</a>	
			</li>
		</ul>
	</div>
	
	<!-- 회원 자신의 PT기록이 보이는 부분 -->
	<!-- class="workout"는 전체를 감싸는 흰배경부분 -->
	<div class="workout">
		<!-- 안에 있는 content들 -->
		<div class="workoutcont">
			<table style="margin:auto; font-size:20px" border="1">
				<thead>
					<tr>
						<td style="text-align:center;">나의 PT 기록</td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>
						<div style="border:3px solid #343A40; width:500px; height:150px; border-radius:10px" >
					<% 
						if(u_gender.equals("M"))
						{
					%>
							<img src="../images/boy.png" style="width:130px;  height:140px; margin:2px 2px 0px 2px; float:left;">
					<%		
						}
						else
						{
					%>	
							<img src="../images/girl.png" style="width:130px;  height:140px; margin:2px 2px 0px 2px; float:left;">
					<% 
						}
					%>
							닉네임 : <%=u_nick %><br>
							PT차수 : <%=r_ct %>회차 /<%=p_cnt %>회차<br>
							<button class="btn btn-dark" onclick="Countlist(<%=r_ct%>,<%=u_no%>,<%=t_no%>,<%=p_try%>);">PT회차</button>
						</div>
						</td>
					</tr>
					<tr>
						<td>
							<div class="list1">
							
							</div>
						</td>	
					</tr>
				</tbody>
			</table>
		</div>
	<% 
	dbm.CloseQuery();
	dbm.DBClose();
	dbm2.CloseQuery();
	dbm2.DBClose();
	dbm3.CloseQuery();
	dbm3.DBClose();
	}catch(Exception e) 
	{ 
	e.printStackTrace(); 	
	}
	%>
	<!-- 왼쪽 이미지 -->
		<div id="leftimg">
		</div>	
	
	<!-- 상세 운동기록  -->
		<div style="float:right; right:50%; margin-right:300px;" >	
		</div>
	
	<!-- 누르면 상단으로 가는 버튼 -->
		<a href="javascript:onTop();" style="color:black; position:fixed; bottom:5%; right:5%;">[TOP]</a>
	
	</div>
</body>
</html>