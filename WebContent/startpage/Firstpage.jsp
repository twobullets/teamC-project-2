<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
<link href="../style/Firstpage.css" rel="stylesheet" type="text/css">
<META HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE"> <!-- 캐시 안먹일라구 붙임 -->
<title>FIRST PAGE</title>
<script src="../js/jquery-3.5.1.min.js"></script>
<script>

</script>
</head>
<style>
</style>
<body>
	<!-- 로고 부분 -->
	<div id="logo">
		<img src="../images/LOGO.png" style="width:110px; height:70px; position:absolute; top:0" onclick="location.href='Firstpage.jsp'">
	</div>
	
	<!-- 상단 버튼 부분 -->
	<div id="first">
		<button type="button" class="btn btn-primary" onclick="location.href='../u-join/U-Join.jsp'">JOIN</button>
	</div>
	
	<!-- 배경 이미지  -->
	<div class="backimg">
	</div>
	
	<!-- 배경 글 -->
	<div class="content">
		<span id="maincontent">PT 기록을 간편하게.</span>
	</div>
	
	<!-- 로그인 부분 -->
	<div class="contentbody">
		<ul>
			<li>
				<form name="member" method="post" action="../u-login/U-LoginOK.jsp">
				<table style="margin:auto; height:200px; width:300px;">
					<tr>
						<td colspan="2" style="text-align:center;"><span>PT회원</span></td>
					</tr>
					<tr>
					</tr>
					<tr>
						<td colspan="2" style="font-weight:bold;"><input type="text" class="form-control" id="u_id" name="u_id" placeholder="ID"></td>
					</tr>
					<tr>
					</tr>
					<tr>
						<td colspan="2" style="font-weight:bold;"><input type="password" class="form-control" id="u_pw" name="u_pw" placeholder="PASSWORD"></td>
					</tr>	
					<tr style="text-align:center;">
						<td><input type="submit" class="btn btn-dark" value='LOGIN'></td>
						<td><button type="button" class="btn btn-primary" onclick="location.href='../u-find/U-Find.jsp'">ID/PW</button></td>
					</tr>
				</table>
				</form>
			</li>
			
			<li>
				<form name="trainer" method="post" action="../t-login/T-LoginOK.jsp">
				<table style="margin:auto; height:200px; width:300px;">
					<tr>
						<td colspan="2" style="text-align:center;"><span>트레이너</span></td>
					</tr>
					<tr>
					</tr>
					<tr>
						<td colspan="2" style="font-weight:bold;"><input type="text" id="t_id" name="t_id" class="form-control" placeholder="ID"></td>
					</tr>
					<tr>
					</tr>
					<tr>
						<td colspan="2" style="font-weight:bold;"><input type="password" class="form-control" id="t_pw" name="t_pw" placeholder="PASSWORD"></td>
					</tr>
					<tr style="text-align:center;">
						<td><input type="submit" class="btn btn-dark" value="LOGIN"></td>
						<td><button type="button" class="btn btn-primary" onclick="location.href='../t-find/T-Find.jsp'">ID/PW</button></td>
					</tr>	
				</table>
				</form>
			</li>
		</ul>
	</div>
</body>
</html>