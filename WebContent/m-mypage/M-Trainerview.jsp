<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<% 
request.setCharacterEncoding("UTF-8");

	String u_id = null;
	if(session.getAttribute("u_id") != null) 
	{
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
<jsp:useBean id="vo" class="teamC.VO" scope="session" />
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
<link href="../style/MTrainerviewpage.css" rel="stylesheet" type="text/css">
<META HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE">
<title>마이페이지</title>
<script src="../js/jquery-3.5.1.min.js"></script>	
<script>
	function tlist()
	{
		$.ajax({
			url:"Trainersearchok.jsp",
			type:"GET",
			data:$("#tsearch").serialize(),
			success:function(data)
			{
				var output = "";
				if(data.trim() != "1")
				{
					//alert(data);
					output += "<tr><th height='50px' style='background-color:#f4f4f4'>닉네임</th><th style='background-color:#f4f4f4'>근무지</th><th style='background-color:#f4f4f4'>만족도</th><th style='background-color:#f4f4f4'>PT신청현황</th></tr>";
					
					var json = JSON.parse(data);
					//alert("dd::"+json.length);
					for(var i=0; i<json.length; i++)
					{	
						output += "<tr>";
						output += "<td style='height:50px; width:200px'>"+json[i].t_nick+"</td>";
						output += "<td style='text-align:left'>"+json[i].t_addr1+"&nbsp;"+json[i].t_addr2+"</td>";
						output += "<td>"+json[i].t_score+"</td>"
						//alert(json[i].p_try);
						if(json[i].p_try == 0) //해당 트레이너에게 PT신청을 한적없을때
						{
							output += "<td id='sinchung_"+i+"'><button type='button' class='btn btn-primary' onclick='ptdetail("+json[i].t_no+","+i+")'>PT신청하러가기</button></td>";
						}else //해당 트레이너에게 PT신청을 한적있을때
						{
							if(json[i].p_end == null) //PT만료를 insert 하지않았을때, 초기엔 null이기때문
							{
								if(json[i].p_state == 'a') //신청상태
								{
									output += "<td id='sinchung_"+i+"'><button type='button' class='btn btn-danger' onclick='ptcancel("+json[i].t_no+","+i+","+json[i].p_cnt+")'>PT신청취소하기</button></td>";
								}else if(json[i].p_state == 'b') //수락상태
								{
									output += "<td id='sinchung_"+i+"'>PT진행중입니다.</td>";
								}else if(json[i].p_state == 'c') //만료상태
								{
									output += "<td id='sinchung_"+i+"'><button type='button' class='btn btn-primary' onclick='ptdetail("+json[i].t_no+","+i+")'>PT신청하러가기</button></td>";
								}
							}else //PT만료가 됐을때
							{
								output += "<td  id='sinchung_"+i+"'><button type='button' class='btn btn-primary' onclick='ptdetail("+json[i].t_no+","+i+")'>PT신청하러가기</button></td>";
							}
						}
						output += "</tr>";
						output += "<tr>";
						output += "<td colspan='4' class='detail' id='detail_"+i+"'></td>";
						output += "</tr>";
						output += "<tr><td colspan='4' height='1' style='background-color:#cccccc'></tr>"; // 트레이너 회색구분선
					}
					$("#slist").html(output);
				}else
				{
					alert("존재하지 않는 닉네임입니다.");	
				}
			}
		});
	}
	
	var prev_cnt = null;
	function ptdetail(t,cnt)
	{
		if(prev_cnt != null && prev_cnt == cnt)
		{
			$("#detail_"+cnt).toggle();
			prev_cnt = null;
			return;
		}
		$.ajax
		({
			url:"Trainerdetailok.jsp",
			type:"POST",
			data:"t_no=" + t+"&i="+cnt,
			success:function(data)
			{
				//alert(data);
				$("#detail_"+cnt).html(data);
				$(".detail").not("#detail_"+cnt).hide();
				$("#detail_"+cnt).show();
				prev_cnt = cnt;
			}
		});
	}
	
	function ptapply(t,cnt)
	{
		var pCnt = $(".pcnt:checked").val();
		var conf = confirm("신청하시겠습니까?");
		if(conf)
		{
			$.ajax
			({
				url:"Trainerapplyok.jsp",
				type:"POST",
				data:"t_no="+t +"&p_cnt="+pCnt,
				success:function(data)
				{
					var result = data.trim();
					var dataArray = result.split(",");
					if(dataArray[0] == "1")
					{
						alert("신청이 완료 되었습니다.");
						$("#sinchung_"+cnt).html("<button type='button' class='btn btn-danger' onclick='ptcancel("+t+","+cnt+","+dataArray[1]+")'>PT신청취소하기</button>");
						$("#detail_"+cnt).hide();
					}else
					{
						alert("잘못된 접근입니다.");
					}
				}
			});
		}
	}
	
	function ptcancel(t,cnt,pCnt)
	{
		var confirmVal = confirm("취소하시겠습니까?");
		if(confirmVal)
		{
			var u_id = $("#u_id").val();
			$.ajax
			({
				url:"Trainercancelok.jsp",
				type:"POST",
				data:"t_no="+t+"&p_cnt="+pCnt,
				success:function(data)
				{
					var result = data.trim();
					var dataArray = result.split(",");
					if(dataArray[0] == "1")
					{
						alert("취소가 완료 되었습니다.");
						$("#sinchung_"+cnt).html("<button type='button' class='btn btn-primary' onclick='ptapply("+t+","+cnt+","+dataArray[1]+")'>PT신청하러가기</button>");
					}else
					{
						alert("잘못된 접근입니다.");
					}
				}
			});
		}
	}
	
</script>
</head>
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

<%
	String N = request.getParameter("nick"); // Trainersearchok 에서 받아온 N, sendfrm 안에있는 input nick
%>

	<!-- 검색창이 보이는 영역 -->
	<div class="info">	
		<form id="tsearch" name="tsearch" method="post" action="Trainersearchok.jsp" onsubmit="return false;">
		<table style="margin:auto; width:1000px; font-size:20px;">
			<thead>
				<tr>
					<th colspan="4" style="color:#A52A2A;">※트레이너의 닉네임을 통해 검색해주세요※</th>
				</tr>
				<tr>
					<th style="width:200px">트레이너 검색</th>
					<td colspan="2">
					<input type="text" id="t_nick" name="t_nick" class="form-control" style="width:600px; display:inline">
					</td>
					<td style="width:164px">
					<input type="button" class="btn btn-primary" value="검색" onclick="tlist()">
					</td>
				</tr>
			</thead>
			<tr><td height="10px"></td></tr>
		
			<!-- 검색한 트레이너의 프로필이 보이는 tbody -->
			<tbody id="slist">
			</tbody>
		</table>
		</form>
	</div>
</body>
</html>