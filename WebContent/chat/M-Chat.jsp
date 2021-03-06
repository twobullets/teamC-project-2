<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Chat</title>
<style>
nav{
	background-color: #0084FF;
    color: #fff;
    height: 40px;
    font-size: 18px;
    line-height: 40px;
    text-align: center;
    border-radius: 5px;
} 

#nav-header{
	text-align : left;
}

#logoutBtn{
	text-align : right;
}


<!-- -->
#roomWrap {
    width: 200px;
}

#roomList {
    border: 1px solid #0084FF;
    border-radius: 5px;
}

#roomHeader {
    background-color: #0084FF;
    color: #fff;
    height: 40px;
    font-size: 18px;
    line-height: 40px;
    text-align: center;
    border-radius: 5px;
}

.roomEl {
    text-align: center;
    border-bottom: 1px solid #f0f0f0;
    padding: 10px 0px;
    cursor: pointer;
}

.roomEl:hover{
    background: #f0f0f0;
}

.roomEl.active{
    background: #f0f0f0;
}

<!-- -->

#chatWrap {
    width: 600px;
    border: 1px solid #ddd;
}

#chatHeader {
    height: 60px;
    text-align: center;
    line-height: 60px;
    font-size: 25px;
    font-weight: 900; 
    border-bottom: 1px solid #ddd;
}

#chatLog {
    height: 700px;
    overflow-y: auto;
    padding: 10px;
}

.myMsg {
    text-align: right;
}

.anotherMsg {
    text-align: left;
    margin-bottom: 5px;
}

.msg {
    display: inline-block;
    border-radius: 15px;
    padding: 7px 15px;
    margin-bottom: 10px;
    margin-top: 5px;

}

.anotherMsg > .msg {
    background-color: #f1f0f0;

}

.myMsg > .msg {
    background-color: #0084FF;
    color: #fff;
}

.anotherName {
    font-size: 12px;
    display: block;
}

<!-- -->

#chatForm {
    display: block;
    width: 100%;
    height: 50px;
    border-top: 2px solid #f0f0f0;
}

#message {
    width: 85%;
    height: calc(100% - 1px);
    border: none;
    padding-bottom: 0;
}

#message:focus {
    outline: none;
}

#chatForm > input[type=submit] {
    outline: none;
    border: none;
    background: none;
    color: #0084FF;
    font-size: 17px;
}

<!-- -->

#memberWrap{
    width: 200px;
}

#memberList {
    border: 1px solid #aaaaaa;
    border-radius: 5px;
}

#memberHeader {
    height: 40px;
    font-size: 18px;
    line-height: 40px;
    padding-left: 15px;
    border-bottom: 1px solid #f0f0f0;
    font-weight: 600;
}

.memberEl {
    border-bottom: 1px solid #f0f0f0;
    padding: 10px 20px;
    font-size: 14px;
}

<!-- -->

#contentCover{
    width: 1280px;
    margin: 0 auto;
    padding-top: 20px;
    display: flex;
    justify-content: space-around;
}

</style>
<script>
function add()
{
	var win = window.open("./ChatAdd.jsp", "ChatAdd", "width=500,height=600");
}
</script>
</head>
<body>
<div id="contentWrap">
    <nav>
		<span id="nav-header"> chat App</span>
        <span id="logoutBtn">로그아웃</span>
    </nav>
    <div id="contentCover">
        <div id="roomWrap">
            <div id="roomList">
                <div id="roomHeader">대화 방 목록</div>
                <div id="roomSelect">
                    <div class="roomEl active" data-id="1">C team</div>
                    <div class="roomEl" data-id="2">Hong</div>
                    <div class="roomEl" data-id="3">Park</div>
                    <div class="roomEl" data-id="4">Kim</div>
                    <div class="roomEl" id="roomAdd" onclick="add()" >+ 대화방 추가</div>
                </div>
            </div>
        </div>
        <div id="chatWrap">
            <div id="chatHeader">C team</div>
            <div id="chatLog">
                <div class="anotherMsg">
                    <span class="anotherName">Hong</span>
                    <span class="msg">네 알겠습니다.</span>
                </div>
                <div class="myMsg">
                    <span class="msg">다음주에는 두 배로 열심히 할게요</span>
                </div>
            </div>
            <form id="chatForm">
                <input type="text" autocomplete="off" size="30" id="message" placeholder="메시지를 입력하세요">
                <input type="submit" value="보내기">
            </form>
        </div>
        <div id="memberWrap">
            <div id="memberList">
                <div id="memberHeader">참가자</div>
                <div id="memberSelect">
                	<div class="memberEl">Jo</div>
                	<div class="memberEl">Hong</div>
                	<div class="memberEl">Park</div>
                	<div class="memberEl">Kim</div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>