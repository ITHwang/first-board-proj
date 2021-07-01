<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"  />  
<%
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
	<c:choose>
		<c:when test='${msg=="addMember" }'>
			<script>
				window.onload = function(){
					alert("회원을 등록했습니다.");
				}
			</script>	
		</c:when>
		<c:otherwise>
			<div></div>
		</c:otherwise>
	</c:choose>
    <style>
		*{margin:0;padding:0}
		a{text-decoration:none;}
		#wrap{width:80%; margin:0 auto;}
		header{height:50px; line-height:50px; border-bottom: 3px solid #ccc; margin-bottom:20px;}
		#title{float:left;font-size:24px;}
		h2{float:right; font-size:18px; font-weight:normal;color:#fff; display:inline-block; margin-right:10px;}
	 	#clear{clear:both;overflow:hidden}
	 	table{margin:auto;}
    </style>
	<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
<div id="wrap">
<header>
<h1 id="title"><a href="${contextPath }/board/listArticles.do">first-board-project</a></h1>
<div id="clear"></div>
</header>

    <form name="frmLogin" method="post" action="${contextPath }/member/loginPass.do" enctype="utf-8" id="frmLogin">
        아이디 : <input type="text" name="user_id" id="id"><br>
        비밀번호 : <input type="password" name="user_pwd" id="pwd"><br>
        <br><br>
        <div id="message"></div>
        <input type="button" value="로그인" onclick="fn_check_id();"/>
        <input type="reset" value="다시 입력"/>
	    <button type="button" onclick="location.href='${contextPath}/member/memberForm.do'">회원가입</button>
    </form>
    
	<script>
		function fn_check_id(){
			var _id = $('#id').val();
			var _pwd = $('#pwd').val();
			
			$.ajax({
				type:"post",
				async:true,
				url:"${contextPath}/member/loginCheck.do",
				data:{
					id : _id,
					pwd : _pwd
				},
				success : function(data, textStatus){
					if (data == 'pass'){
						var form = document.getElementById('frmLogin');
						form.submit();
					} else if (data == 'nonpass'){
						$('#message').text("아이디 또는 비밀번호가 틀렸습니다.");
					}
				},
				error : function(data, textStatus){
					alert("에러 발생")	;
				}
			});
			
		}
	</script>
</body>
</html>