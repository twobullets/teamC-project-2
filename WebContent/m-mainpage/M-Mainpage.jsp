<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="user.UserDAO"%>
<html>
<head>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
<link href="../style/Mmainpage.css" rel="stylesheet" type="text/css">
<META HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE">
<title>MEMBER MAIN</title>
</head>
<style>
</style>
<body>
<%
	String u_id = null;
	if(session.getAttribute("u_id") != null) {
		u_id = (String) session.getAttribute("u_id");
	}
	if(u_id == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('잘못된 접근입니다!!');");
		script.println("location.href = '../startpage/Firstpage.jsp'");
		script.println("</script>");
		script.close();	
	}
%>	

	<!-- 로고 부분 -->
	<div id="logo">
		<img src="../images/TLOGO.png" style="width:110px; height:70px; position:absolute; top:0" onclick="location.href='../startpage/Firstpage.jsp'">
	</div>
	
	<!-- 상단 로그아웃 버튼 -->
	<div id="first">
		<button type="button" class="btn btn-link" onclick="location.href='../u-login/U-Logout.jsp'">LOGOUT</button>
	</div>
	
	<!-- 메인 이미지 -->
	<div class="backimg">
	</div>
	
	<!-- 메인 이미지 위에 글 -->
	<div class="content">
		<span id="maincontent">나만의 PT를 보다 편리하게.</span>
	</div>
	
	<!-- 하단 메뉴들 -->
	<div class="contents">
		<ul>
			<li>
				<p><a href="../m-record/M-Record.jsp">나의 PT 기록</a></p>
			</li>
			<li>
				<p><a href="../m-mypage/M-Trainerview.jsp">트레이너 검색</a></p>
			</li>
			<li>
				<p><a href="../m-mypage/M-Mypage.jsp">마이페이지</a></p>	
			</li>
		</ul>
	</div>
</body>
</html>