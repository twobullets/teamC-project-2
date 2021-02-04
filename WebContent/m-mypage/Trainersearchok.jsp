<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="teamC.DBM" %>
<%@ page import="trainer.TrainerSearchDAO" %>
<%@ page import="teamC.VO" %>
<%@ page import="java.util.*" %>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="org.json.simple.JSONObject"%>
<%
request.setCharacterEncoding("UTF-8");

String N = request.getParameter("t_nick");
String u_id = null;
if(session.getAttribute("u_id") != null) {
	u_id = (String) session.getAttribute("u_id");
}


TrainerSearchDAO dao = new TrainerSearchDAO();

List<VO> list = dao.tSearchDAO(N,u_id);

//out.print(vo.getT_nick());

//nick 조회
if(list.size() <= 0)
{
	out.print("1"); //1인경우 nick이 없음
	
}else
{
	//닉네임 검색 결과가 나왔을 경우 바로 M-Trainerview 페이지로 보내주는 부분. post방식
	JSONArray jsonArrList = new JSONArray();
	for(int i=0; i< list.size(); i++){
		//jsonObject 선언
		VO vo = list.get(i);
		JSONObject jsonList = new JSONObject();
		jsonList.put("p_try", vo.getP_try());
		jsonList.put("p_end", vo.getP_end());
		jsonList.put("p_cnt", Integer.toString(vo.getP_cnt()));
		jsonList.put("p_state", vo.getP_state());
		jsonList.put("t_no", vo.getT_no());
		jsonList.put("t_nick", vo.getT_nick());
		jsonList.put("t_addr1", vo.getT_addr1());
		jsonList.put("t_addr2", vo.getT_addr2());
		jsonList.put("t_score", vo.getT_score());
		//jsonArray 추가 add()메소드 사용
		jsonArrList.add(jsonList);
	}
	
	out.print(jsonArrList);
	%>
	<%-- <form id="sendfrm" name="sendfrm" method="post" action="M-Trainerview.jsp">
		<input type="hidden" id="nick" name="nick" value="<%= N %>">
	</form>
	<script>
		window.onload = function()
		{
			document.sendfrm.submit();
		}
	</script> --%>
	<%
}
//response.sendRedirect("M-Trainerview.jsp?nick=" + N); get방식
%>
