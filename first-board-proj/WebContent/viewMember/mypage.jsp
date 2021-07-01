<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	isELIgnored="false" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"  />     
<%
  request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title>마이페이지</title>
	<c:choose>
		<c:when test='${msg=="addMember" }'>
			<script>
				window.onload = function(){
					alert("회원을 등록했습니다.");
				}
			</script>	
		</c:when>
		<c:when test='${msg=="modified" }'>
			<script>
				window.onload = function(){
					alert("회원을 수정했습니다.");
				}
			</script>	
		</c:when>
		<c:when test='${msg=="deleted" }'>
			<script>
				window.onload = function(){
					alert("회원을 삭제했습니다.");
				}
			</script>	
		</c:when>
	</c:choose>
   <style>
   	.cls1{
   		font-size:40px;
   		text-align:center;
   	}
   </style>
</head>
<body>
<h1  class="cls1">마이페이지</h1>
<form method="post"   action="${contextPath}/member/modMember.do?id=${memInfo.id}">
<table  align="center">
    <tr>
       <td width="200"><p align="right">아이디</td>
       <td width="400"><input type="text" name="id" value="${memInfo.id }" disabled></td>
    </tr>
    <tr>
        <td width="200"><p align="right">비밀번호</td>
        <td width="400"><input type="password"  name="pwd" value="${memInfo.pwd }" disabled></td>
    </tr>
    <tr>
        <td width="200"><p align="right">이름</td>
        <td width="400"><p><input type="text"  name="name" value="${memInfo.name }" disabled></td>
    </tr>
    <tr>
        <td width="200"><p align="right">이메일</td>
        <td width="400"><p><input type="text"  name="email" value="${memInfo.email }" disabled></td>
    </tr>
    <tr>
        <td width="200"><p align="right">가입일</td>
        <td width="400"><p><input type="text"  name="joinDate" value="${memInfo.joinDate }" disabled></td>
    </tr>
    <tr align="center">
        <td colspan="2" width="400">
	       <button type="button" onclick="location.href='${contextPath }/board/listArticles.do'">홈으로</button>
	       <button type="button" onclick="location.href='${contextPath}/member/exitMember.do?id=${memInfo.id}'">회원탈퇴</button>
       </td>
    </tr>
</table>
</form>
</body>
</html>
