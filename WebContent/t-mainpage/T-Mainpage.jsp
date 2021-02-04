<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="teamC.VO" %>
<%@ page import="pt.PtDAO" %>
<html>
<head>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.7.2/animate.min.css"> <!-- 배너 애니메이션 효과 CSS -->
<link href="../style/Tmainpage.css" rel="stylesheet" type="text/css">
<META HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE">
<title>TRAINER MAIN</title>
</head>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	$(document).ready(function(){
		$("#promotionBanner .btnClose").click(function(){
			$('#promotionBanner').slideUp(500);
		});
	});
	
	function applycheck()
	{
		var win = window.open("../p-apply/T-Applycheck.jsp", "T-Applycheck", "width=550,height=300");
	}
	
</script>
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

	// pt신청 여부 불러오는 부분
	PtDAO ptDAO = new PtDAO();

	int t_no  = ptDAO.findt_no(u_id);
	
	VO vo = ptDAO.alert(t_no);
	
	int p_try = vo.getP_try(); 

	if(p_try == 0 )
	{
		
	}else
	{%>
	
	<!-- PT신청 배너 -->
		<div id="promotionBanner" class="animated infinite bounce">
			<div class="popContents">
				<a href="javascript:void(0);" onclick="applycheck()">▶PT신청이 있습니다◀</a>
				<div class="popClose">
					<a href="#none" class="btnClose"><img src="../images/close.png" alt="배너 닫기" width="15"></a>
				</div>
			</div>
		</div>
		 
	<%}%>	
	
	<!-- 로고 부분 -->
	<div id="logo">
		<img src="../images/ULOGO.png" style="width:110px; height:70px; position:absolute; top:0" onclick="location.href='../startpage/Firstpage.jsp'" >
	</div>
	
	<!-- 상단 로그아웃 버튼 -->
	<div id="first">
		<button type="button" id="first" class="btn btn-link" onclick="location.href='../u-login/U-Logout.jsp'">LOGOUT</button>
	</div>
	
	<!-- 메인 이미지 -->
	<div class="backimg">
	</div>
	
	<!-- 메인 이미지 위에 글 -->
	<div class="content">
		<span id="maincontent">회원의 PT를 보다 편리하게.</span>
	</div>
	
	<!-- 하단 메뉴들 -->
	<div class="contents">
		<ul>
			<li>
				<p><a href="../t-manegement/T-Record.jsp">회원관리</a></p>
			</li>
			<li>
				<p><a href="../t-mypage/T-Mypage.jsp">내 PT프로필</a></p>
			</li>
			<li>
				<p><a href="../t-mypage/T-Modify.jsp">내 정보</a></p>
			</li>
		</ul>
	</div>

</body>
</html>