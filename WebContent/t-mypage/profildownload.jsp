<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="java.io.*"%>
<%@ page trimDirectiveWhitespaces="true" %>
<% 
response.addHeader("content-type","application/octet-stream; charset=UTF-8");

String fname = request.getParameter("fileUp");
if(fname == null)
{
	fname = "basicprofil.png";
}
fname = fname.replace("..","");
response.setHeader("Content-Disposition", "attachment; filename=\"" + fname + "\""); //첨부파일명으로 보여줌.
try
{
	File mFile = new File("D:/jsh/Team2/WebContent/profilimage", fname);
	
	InputStream in = null;
	in = new FileInputStream(mFile);
	OutputStream os = null;
	
	os = response.getOutputStream();
	byte b[] = new byte[(int)mFile.length()];
	int leng = 0;
	while((leng = in.read(b)) > 0)
	{
		os.write(b,0,leng);	
	}
	os.close();
	in.close();
}catch(Exception e)
{
	out.print("ERROR");
}
%>