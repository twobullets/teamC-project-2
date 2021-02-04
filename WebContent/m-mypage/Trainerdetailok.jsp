<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="teamC.VO" %>
<%@ page import="trainer.TrainerProfilDAO" %>
<script>

	//이미지 미리보기
	function LoadImg(value)
	{
		if(value.files && value.files[0])
		{
			var reader = new FileReader();
			reader.onload = function(e)
			{
				$("#fileUp").attr('src',e.target.result);
			}
			reader.readAsDataURL(value.files[0]);
		}
	}
</script>
<%
	request.setCharacterEncoding("UTF-8");
	
	String t_no = request.getParameter("t_no");
	int i = Integer.parseInt(request.getParameter("i"));
	/*
	if(session.getAttribute("u_id") != null) {
		u_id = (String) session.getAttribute("u_id");
	}
	*/
	/* if(u_id == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('잘못된 접근입니다!!');");
		script.println("location.href = '../startpage/Firstpage.jsp'");
		script.println("</script>");
		script.close();	
	} */
%>
	<%
	// 트레이너 Profil 불러오는 부분
	
	TrainerProfilDAO dao = new TrainerProfilDAO();
	
	//out.print("test::"+u_id);
	
	VO vo = dao.tProfilDAO(t_no);
	
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
	int TN = vo.getT_no();			   // t_no
	
	// if문 나눠야함 한번에 하면 안됨!!! 전부 null일때로 조건이 들어감.
	if(E == null)
	{
		E = "자기소개가 없습니다.";
	}
	if(RP == null && OP == null)
	{
		RP = "basicprofil.png";
		OP = "basicprofil.png";
	}
	if(C1 == null && C2 == null && C3 == null)
	{
		C1 = "등록된 PT가격이 없습니다.";
		C2 = "-";
		C3 = "-";
	}
	
	// S공백처리 부분
	if(S == 0)
	{
		Score = " ";
	}else
	{
		Score = String.format("%.2f", S); // 소수점 표기
	}
	
	%>
	<table style="height:600px; width:100%;">
		<tr>
			<td colspan="3">
			<hr style="height:2px;"/>
			</td>
		</tr>
		<tr>
			<th>전문분야</th>
			<td id="major" colspan="2">
				<%
					if(M.equals("H")){ %>헬스<%}
					else if(M.equals("D")){%>다이어트<% }
					else if(M.equals("C")){%>재활치료<% }			
				%>	
			</td>
		</tr>
		<tr>
			<td colspan="3">
			<hr style="height:2px;"/>
			</td>
		</tr>
		<tr>
			<th>근무지</th>	
			<td id="addr" colspan="2">
			<%= A1 %>&nbsp;<%= A2 %>
			</td>
		</tr>
		<tr>
			<td colspan="3">
			<hr style="height:2px;"/>
			</td>
		</tr>
		<tr>			
			<th>트레이너(닉네임)</th>
			<td colspan="2"><%= N %></td>
		</tr>
		<tr class="topdiv">
			<th class="imghover">
				<img src="../t-mypage/profildownload.jsp?fileUp=<%= RP %>" style="width:200px; height:200px">
			</th>
			<!-- 자기소개 -->
			<td colspan="2"><%= E %></td>
		</tr>
		<tr>
			<td colspan="3">
			<hr style="height:2px;"/>
			</td>
		</tr>
		<tr style="text-align:center;">
			<th rowspan="3">PT가격 </th>
			<td>1회  : <%= C1 %></td>
			<td><input type="radio" name="pcnt" class="pcnt" value="1" checked></td>
		</tr>
		<tr style="text-align:center;">
			<td>10회 : <%= C2 %></td>
			<td><input type="radio" name="pcnt" class="pcnt" value="10"></td>
		</tr>
		<tr style="text-align:center;">
			<td>20회: <%= C3 %></td>
			<td><input type="radio" name="pcnt" class="pcnt" value="20"></td>
		</tr>
		<tr>
			<td colspan="3">
			<hr style="height:2px;"/>
			</td>
		</tr>	
		<tr>
			<!-- 만족도 -->
			<td colspan="3"  style="text-align:center;">
			<%= Score %><font color="ff6600">★★★★☆</font>
			</td>
		</tr>
		<tr>
			<td colspan="3">
				<button type="button" class="btn btn-primary" onclick="ptapply(<%= TN %>,<%= i%>)">PT신청</button>
			</td>
		</tr>
	</table>