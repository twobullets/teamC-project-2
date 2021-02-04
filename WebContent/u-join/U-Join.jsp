<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
<link href="../style/U-joinpage.css" rel="stylesheet" type="text/css">
<title>JOIN</title>
<script src="../js/jquery-3.5.1.min.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>

	window.onload = function()
	{
		document.join.id.focus();
	}
	
	var fa = true; 
	var fb = true;
	var fc = true;
	var fd = true;
	var fe = true;
//주소찾기===========================================================
		function juso(){
		new daum.Postcode({
		oncomplete: function(data) {
		$("#t_addr1").val(data.address);
		}
	}).open();
}

	//아이디 중복검사==========================================================
	function idcheck()
	{
		var u_id = $('#u_id').val();
		if(u_id == "")
		{
			alert("아이디 입력 후 중복확인 버튼을 눌러주세요.");
			$('#u_id').focus();
			return;
		}
		var u_check = userFlag;
		/* alert(u_check); */
		
		if(u_check == 'T')
		{
			$.ajax({
				type:'post',
				url:'../t-join/T-idcheck.jsp',
				data:{"u_id":u_id}, // id란 변수에 id 데이터값을 넣어서 보냄 
				success:function(result) // 성공적으로 수행되었으면 result로 값변환 result 정의
				{
					if(result.trim()=="1") // 성공하면 1 실패하면 0을 받아서 실행
					{						
						alert("사용할 수 있는  아이디입니다.");
						fa = true;
					}else
					{	
						alert("이미 사용중인 아이디입니다");
						fa = false;
					}
				}
			});
		
		}else if(u_check == 'U')
		{
		
			$.ajax({
				type:'post',
				url:'idcheck.jsp',
				data:{"u_id":u_id}, // id란 변수에 id 데이터값을 넣어서 보냄 
				success:function(result) // 성공적으로 수행되었으면 result로 값변환 result 정의
				{
					
					if(result.trim()=="1") // 성공하면 1 실패하면 0을 받아서 실행
					{						
						alert("사용할 수 있는 아이디입니다.");
						fa=true;
					}else
					{
						alert("이미 사용중인 아이디입니다");
						fa=false;
					}
				}
			});
		}
	}
	//닉네임 중복검사==========================================================
	function nickcheck()
	{
		var u_nick = $('#u_nick').val();
		if(u_nick == "")
		{
			alert("닉네임 입력 후 중복확인 버튼을 눌러주세요.");
			$('#u_nick').focus();
			return;
		}
		var u_check = userFlag;
		/* alert(u_check); */
		
		if(u_check == 'T')
		{
			$.ajax({
				type:'post',
				url:'../t-join/T-nickcheck.jsp',
				data:{"u_nick":u_nick}, // id란 변수에 id 데이터값을 넣어서 보냄 
				success:function(result) // 성공적으로 수행되었으면 result로 값변환 result 정의
				{
					if(result.trim()=="1") // 성공하면 1 실패하면 0을 받아서 실행
					{						
						alert("사용할 수 있는  닉네임입니다.");
						fb = true;
					}else
					{
						
						alert("이미 사용중인 닉네임입니다");
						fb = false;
					}
				}
			});
		
		}else if(u_check == 'U')
		{
			$.ajax({
				type:'post',
				url:'nickcheck.jsp',
				data:{"u_nick":u_nick}, // id란 변수에 id 데이터값을 넣어서 보냄 
				success:function(result) // 성공적으로 수행되었으면 result로 값변환 result 정의
				{
					if(result.trim()=="1") // 성공하면 1 실패하면 0을 받아서 실행
					{						
						alert("사용할 수 있는  닉네임입니다.");
						fb = true;
					}else
					{
						
						alert("이미 사용중인 닉네임입니다");
						fb = false;
					}
				}
			});
		}
	}
	//비밀번호 확인  1.글자수 제한=========================================
	function pwcheck()
	{
           if(document.getElementById('u_pw').value.length < 6 || document.getElementById('u_pw').value.length> 16)
           {
           	alert('비밀번호는 6글자 이상, 16글자 이하만 이용 가능합니다.');
           	$('#u_pw').focus();
           	fc = false;
          		
           }
           else
           {
           	fc= true;
           }
 	//2.특수문자 사용 ===============================================================            
		var sc = ["!","@","#","$","%","^","&","+","="];
		var check_sc= 0;
           
			for(var i=0;i<sc.length;i++)
            {
           	 	if(document.getElementById('u_pw').value.indexOf(sc[i]) != -1)// indexof: 배열 안의 내용이 없다면 -1을 반환
             	{
             		check_sc = 1;// 특수문자가  있는 경우
            	}
            }
          
           if(check_sc == 0 )//특수문자가 없는 경우
           {
           	alert('!,@,#,$,%,^,&,+,= 등의 특수문자가 들어가 있지 않습니다.');
           	$('#u_pw').focus();
           	fd = false;
           	
           }
           else
           {
           	fd = true;
           }
	}                     
    //비밀번호 재확인 =============================================================
   	function pw2check()
   	{
     	if(document.getElementById('u_pw').value == document.getElementById('u_pwc').value)
     	{
        	fe= true;
    	 }
    	else
    	{
	        alert('비밀번호가 일치하지 않습니다.');
	       
	        fe = false;
    	}
   	}
		
	
	//빈공간 검사, 모든사항 재확인==========================================================
	function Dosubmit()
	{	
		var u_check = userFlag;

		
		if(u_check == 'T')
		{
			if( $("#u_id").val() == "" || $("#u_pw").val() == "" || $("#u_pwc").val() == "" || $("#u_nick").val() == "" || $(".t_major").val() == ""|| $("#t_addr1").val() == ""  ||  $("#t_addr2").val() == ""  || $("#u_phone").val() == "" || $("#u_email").val() == "" || $(".u_check").val() =="" )
			{
				alert('입력하지 않은 항목이 있습니다');		
					
			}
			else
			{
				
				if(fa==true&&fb==true&&fc==true&&fd==true&&fe==true)
				{
					document.join.submit();
				}							
				else
				{				
					alert('입력이 올바르지 않습니다.'); 		
				}
			} 
			
		}else if(u_check == 'U')
		{
			if( $("#u_id").val() == "" || $("#u_pw").val() == "" || $("#u_pwc").val() == "" || $("#u_nick").val() == "" || $(".u_gender").val() == "" || $("#u_phone").val() == "" || $("#u_email").val() == "" || $(".u_check").val() =="" )
			{
				alert('입력하지 않은 항목이 있습니다');		
					
			}
			else
			{
				
				if(fa==true&&fb==true&&fc==true&&fd==true&&fe==true)
				{
					document.join.submit();
				}							
				else
				{				
					alert('입력이 올바르지 않습니다.'); 		
				}
			}		
		}
		
		
	}
	
	
	
	
	
	
	var userFlag = "U";
	// 회원 구분에 따른 tr 추가
	$(document).ready(function()
	{
		$(".u_check").on("change", function()
		{
			//alert($(this).val());
			if($(this).val() == "T")
			{
				$(".tjoin").show();
				userFlag = "T";
			}else
			{
				$(".tjoin").hide();
				userFlag = "U";
			}
		})
	});
	
</script>
</head>
<body>
	<!-- 상단 뒤로가기 버튼 -->
	<div id="first">
		<button type="button" class="btn btn-dark" onclick="location.href='../startpage/Firstpage.jsp'">BACK</button>
	</div>
	
	<!-- 회원가입란 -->
	<div class="join">
		<div id="jointitle">
			<span>회원가입</span>
		</div>
		<form id="join" name="join" method="post" action="U-JoinOK.jsp">
		<table style="width:900px; height:500px; margin-left:32%; margin-top:50px; font-size:20px">
			<tr>
				<th width="30%">회원구분</th>
				<td>
					<input type="radio" class="u_check" name="u_check" value="T">&nbsp;&nbsp;트레이너&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="radio" class="u_check" name="u_check" value="U" checked>&nbsp;&nbsp;일반회원
				</td>
			</tr>
			<tr>
				<th>아이디</th>
				<td>
					<input name="u_id" id="u_id" type="text" size="10" maxlength="10" class="form-control" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" class="btn btn-primary" value="중복검사" onclick="idcheck()">
				</td>
	        </tr>
			<tr>
				<th>닉네임</th>
				<td>
					<input name="u_nick" id="u_nick" type="text" size="10" maxlength="10" class="form-control" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" class="btn btn-primary" value="중복검사" onclick="nickcheck()">
				</td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td>
					<input name="u_pw" id="u_pw" type="password" size="20" maxlength="16" class="form-control" placeholder="6-16자리 영문&숫자&특수문자 조합" onblur="pwcheck()">
				</td>
			</tr>
			<tr>
				<th>비밀번호확인</th>
				<td>
					<input name="u_pwc" id="u_pwc" type="password" size="20" maxlength="16" class="form-control" onblur="pw2check()">
				</td>
			</tr>
			<tr>
				<th>성별</th>
				<td>
					<input type="radio" class="u_gender" name="u_gender" value="M">&nbsp;&nbsp;남&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="radio" class="u_gender" name="u_gender" value="F">&nbsp;&nbsp;여
				</td>
			</tr>        
			<tr>
				<th>휴대폰 번호</th>
				<td>
					<input type="text" id="u_phone" name="u_phone" width="200px" maxlength="20" placeholder="'-'없이 입력해주세요" class="form-control">
				</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>
					<input type="email" class="form-control" id="u_email" name="u_email"  placeholder="ex.Johndoe@gmail.com">
				</td>
			</tr>
			<tr class="tjoin">
				<th>근무지</th>
				<td>
					<input type="text" class="form-control" id="t_addr1" name="t_addr1">
					<button type='button' onclick="juso()" class='btn btn-primary'>주소찾기</button>
					<input type="text" class="form-control" id="t_addr2" name="t_addr2">
				</td>
			</tr>
			<tr class="tjoin">
				<th>전문분야</th>
				<td>
					<select class="t_major" name="t_major">
						<option value="H">헬스</option>
						<option value="D">다이어트</option>
						<option value="C">재활치료</option>
					</select>
				</td>
			</tr>
			<tr class="tjoin">
				<td colspan="2" style="color:#B22222; font-size:20px;"><b>*</b>자세한 사항은 회원님의 프로필에 기입해주세요!<br><b>작성하신 프로필은 PT회원</b>에게 보여집니다.</td>
			</tr>
		</table>
		<div align="center" style="margin:50px 0px 10px 0px;">
			<input type="button" value="회원가입" class="btn btn-primary" onclick="javascript:Dosubmit();">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<button type="button" class="btn btn-primary" onclick="location.href='../startpage/Firstpage.jsp';" >취소</button>
		</div>
		</form>
	</div>
</body>
</html>