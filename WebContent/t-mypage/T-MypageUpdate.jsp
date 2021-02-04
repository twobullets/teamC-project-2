<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="teamC.VO" %>
<%@ page import="trainer.TrainerProfilDAO" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
<link href="../style/TMypage.css" rel="stylesheet" type="text/css">
<META HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE">
<title>TRAINER PROFIL</title>
</head>
<script src="../js/jquery-3.5.1.min.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	
	//주소찾기
	function juso()
	{
		new daum.Postcode
		({
			oncomplete: function(data) 
			{
				$("#addr1").val(data.address);
			}
		}).open();
	}
	
	//이미지 미리보기
	function LoadImg(value)
	{
		if(value.files && value.files[0])
		{
			var reader = new FileReader();
			reader.onload = function(e)
			{
				$("#profilimg").attr('src',e.target.result);
			}
			reader.readAsDataURL(value.files[0]);
		}
	}
	$(document).ready(function(){
		$("#fileUp").change(function(){
			LoadImg(this);
		});
	});
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
%>
	<!-- 상단 로그아웃 버튼 -->
	<div id="first">
		<button type="button" class="btn btn-dark" onclick="location.href='../u-login/U-Logout.jsp'">LOGOUT</button>
	</div>	
	
	<!-- 상단 로고 -->
	<div>
		<img src="../images/TLOGO.png" style="width:110px; height:70px; position:absolute; top:0; cursor: pointer;" onclick="location.href='../t-mainpage/T-Mainpage.jsp'">
	</div>
	
	<!-- 상단 메뉴바 -->
	<div class="contents">
		<ul>
			<li>
				<a href="../t-manegement/T-Record.jsp">회원관리</a>
			</li>
			<li>
				<a href="../t-mypage/T-Mypage.jsp">내 PT프로필</a>
			</li>
			<li>
				<a href="../t-mypage/T-Modify.jsp">내 정보</a>
			</li>
		</ul>
	</div>
	
	<%
	// 트레이너 Profil 불러오는 부분
	TrainerProfilDAO dao = new TrainerProfilDAO();
	
	VO vo = dao.tProfil2DAO(u_id);
	
	String M  = vo.getT_major();   // Major 전문분야
	String A1 = vo.getT_addr1();   // Addr1 근무지 주소1
	String A2 = vo.getT_addr2();   // Addr2 근무지 주소2
	String N  = vo.getT_nick();    // Nick 닉네임
	String RP = vo.getT_originP(); // RealPhoto 프로필사진 이름
	String OP = vo.getT_originP(); // OriginPhoto 프로필사진 원본 이름
	String E  = vo.getT_etc();	   // ETC 자기소개
	String C1 = vo.getT_cost1();   // Cost1 가격1
	String C2 = vo.getT_cost2();   // Cost2 가격2
	String C3 = vo.getT_cost3();   // Cost3 가격3
	double S  = vo.getT_score();   // Score 만족도
	String Score = "";			   // S를 공백처리 하기위해 만든 변수
	
	// if문 나눠야함 한번에 하면 안됨!!! 전부 null일때로 조건이 들어감.
	if(E == null)
	{
		E = "자기소개를 입력해주세요";
	}
	if(RP == null && OP == null)
	{
		RP = "basicprofil.png";
		OP = "basicprofil.png";
	}
	if(C1 == null && C2 == null && C3 == null)
	{
		C1 = "1회 PT가격을 입력해주세요";
		C2 = "10회 PT가격을 입력해주세요";
		C3 = "20회 PT가격을 입력해주세요";
	}
	
	// S공백처리 부분
	if(S == 0)
	{
		Score = "-";
	}else
	{
		Score = String.format("%.2f", S); // 소수점 표기
	}
	%>
	<div class="info">
   	 	<form id="prof" name="prof" method="post" action="profilok.jsp" enctype="multipart/form-data">
		<table>
			<thead>
				<tr>
					<th>전문분야</th>
					<td >
						<select class="t_major" id="major" name="major">
							<%
								if(M.equals("H"))
								{
									%><option value="H" selected >헬스</option><% 
								}
								else
								{
									%><option value="H" >헬스</option><% 
								}
								if(M.equals("D"))
								{
									%><option value="D" selected>다이어트</option><%
								}
								else
								{
									%><option value="D">다이어트</option><%
								}
								if(M.equals("C"))
								{
									%><option value="C" selected>재활치료</option><% 			
								}
								else
								{
									%><option value="C">재활치료</option><% 	
								}
							%>	
						</select>
					</td>
				</tr>
				<tr>
					<td colspan="2">
					<hr style="height:2px;"/>
					</td>
				</tr>
				<tr>
					<th>근무지</th>
					<td>
						<input type="text" id="addr1" name="addr1" class="form-control" value="<%= A1 %>" style="display:inline; width:414px;"><button type='button' onclick="javascript:juso()" class='btn btn-primary'>주소찾기</button>
						<input type="text" id="addr2" name="addr2" class="form-control" value="<%= A2 %>" style="width:500px;">
					</td>
				</tr>
				<tr>
					<td colspan="2">
					<hr style="height:2px;"/>
					</td>
				</tr>
				<tr>
					<th>트레이너(닉네임)</th> 
					<td><%= N %></td>				
				</tr>
				<tr>
					<td colspan="2">
					<hr style="height:2px;"/>
					</td>
				</tr>
				<tr class="topdiv">
					<th class="imghover">
						<img src="profildownload.jsp?fileUp=<%= RP %>" style="width:200px; height:200px" id="profilimg">
						<input type="file" name="fileUp" id="fileUp" onchange="LoadImg(this);"><br>
					</th>
					<td>
						<!-- 자기소개 -->
						<textarea class="form-control" cols="30" rows="10" id="etc" name="etc"><%= E %></textarea>
					</td>
				</tr>
				<tr>
					<td colspan="2">
					<hr style="height:2px;"/>
					</td>
				</tr>
			</thead>
			<tbody>
				<tr style="text-align:center;">
					<th rowspan="3">PT가격</th>
					<td><input type="text" id="cost1" name="cost1" class="form-control" value="<%= C1 %>"></td>
				</tr>
				<tr style="text-align:center;">		
					<td><input type="text" id="cost2" name="cost2" class="form-control" value="<%= C2 %>"></td>
				</tr>
				<tr style="text-align:center;">		
					<td><input type="text" id="cost3" name="cost3" class="form-control" value="<%= C3 %>"></td>
				</tr>		
				<tr>
					<!-- 만족도 -->
					<td colspan="3" style="text-align:center;">
					<hr style="height:2px;"/>
						<%= Score %><!-- 1~19.9% 별 하나 , 20~39.9% 별 두개, 40~59.9% 별 세개, 60~79.9% 별 네개 , 80~100% 별 다섯개 -->
					<%-- 	<%
								if(S >= 80){
									
									// 별 다섯 뿌리기
								}else if(S >= 60){
									//별 네개
								}else if(S >= 40){
									//별 세개
								}else if(S >= 20){
									//별 두개
								}else if(S >= 1){
									//별 하나
								}else{
									//빈별
								}
							%> --%>
					</td>
				</tr>
				<tr style="text-align:right;">
					<td colspan="3" style="text-align:right"><button type="submit" class="btn btn-primary" id="save">저장</button></td>
				</tr>
			</tbody>	
		</table>
		</form>
	</div>
</body>
</html>