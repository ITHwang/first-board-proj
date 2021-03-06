<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<c:set var="articlesList" value="${articlesMap.articlesList }"/>
<c:set var="totArticles" value="${articlesMap.totArticles }"/>
<c:set var="section" value="${articlesMap.section }"/>
<c:set var="pageNum" value="${articlesMap.pageNum }"/>
<c:set var="loginName" value="${articlesMap.loginName }"/>

<%
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 목록창</title>
<c:choose>
	<c:when test='${msg=="logouted" }'>
	
		<script>
			window.onload = function(){
				alert("로그아웃 되었습니다.");
			}
		</script>	
	</c:when>
	<c:when test='${msg=="deleted" }'>
	
		<script>
			window.onload = function(){
				alert("탈퇴 되었습니다.");
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
	.no-uline {text-decoration:none;}
	.sel-page{text-decoration:none;color:red;}
	.cls1 {text-decoration:none;}
	.cls2 {text-align:center; font-size:30px;}
	#wrap{width:80%; margin:0 auto;}
	header{height:50px; line-height:50px; border-bottom: 3px solid #ccc; margin-bottom:20px;}
	#title{float:left;font-size:24px;}
    h2{float:right; font-size:18px; font-weight:normal; display:inline-block; margin-right:10px;}
 	#clear{clear:both;overflow:hidden}
 	table{margin:auto;}
	
</style>
</head>
<body>
<div id="wrap">
<header>
<h1 id="title"><a href="${contextPath }/board/listArticles.do">first-board-project</a></h1>
<c:choose>
	<c:when test="${empty loginName }">
		<h2><a href="${contextPath }/member/loginForm.do">로그인</a></h2>
		<h2><a href="${contextPath }/member/memberForm.do">회원가입</a></h2>
	</c:when>
	<c:when test="${loginName ==  'admin'}">
		<h2>관리자 모드</h2>
		<h2><a href="${contextPath }/member/listMembers.do">회원 관리</a></h2>
		<h2><a href="${contextPath }/member/logout.do">로그아웃</a></h2>
	</c:when>
	<c:otherwise>
		<h2>환영합니다 ${loginName } 님!!</h2>
		<h2><a href="#">글쓰기</a></h2>
		<h2><a href="${contextPath }/member/mypage.do?id=${loginName}">마이페이지</a></h2>
		<h2><a href="${contextPath }/member/logout.do">로그아웃</a></h2>
	</c:otherwise>
</c:choose>
<div id="clear"></div>
</header>
<section>
<table align="center" border="1" width="80%">
	<tr height="10" align="center" bgcolor="lightgreen">
		<td>글 번호</td>
		<td>작성자</td>
		<td>제목</td>
		<td>작성일</td>
	</tr>
	<c:choose>
		<c:when test="${empty articlesList }">
			<tr height="10">
			<td colspan="4">
			<p align="center"><b><span style="font-size:9pt;">등록된 글이 없습니다.</span></b></p>
			</td>
			</tr>
		</c:when>
		<c:when test="${!empty articlesList }">
			<c:forEach var="article" items="${articlesList }" varStatus="articleNum">
				<tr align="center">
					<td width="5%">${articleNum.count }</td>
					<td width="10%">${article.id }</td>
					<td align="left" width="35%">
						<span style="padding-right:30px"></span>
						<a class="cls1" href="${contextPath }/board/viewArticle.do?articleNO=${article.articleNO}">${article.title }</a>
					</td>
					<td width="10%"><fmt:formatDate value="${article.writeDate }"/></td>
				</tr>
			</c:forEach>
		</c:when>
	</c:choose>
</table>
</section>

<footer>
<div class="cls2">
<c:if test="${totArticles != null }">
	<c:choose>
		<c:when test="${totArticles >= 100 }">
			<c:forEach var="page" begin="1" end="10" step="1">
				<c:if test="${section > 1 && page == 1 }">
					<a class="no-uline" href="
										${contextPath }/board/listArticles.do?
										setion=${section-1}&pageNum=${(page-1)*10 + 1}">
						&nbsp; pre 
					</a>
				</c:if>

				<a class="no-uline" href="
									${contextPath }/board/listArticles.do?
									setion=${section}&pageNum=${page}">
					${(section-1)*10 + page }
				</a>

				<c:if test="${page==10 }">
					<a class="no-uline" href="
										${contextPath }/board/listArticles.do?
										setion=${section+1}&pageNum=${section*10 + 1 }">
						&nbsp; next
					</a>
				</c:if>
			</c:forEach>
		</c:when>

		<c:when test="${totArticles == 100 }">
			<c:forEach var="page" begin="1" end="10" step="1">
				<a class="no-uline" href="#">${page }</a>
			</c:forEach>
		</c:when>
		
		<c:when test="${totArticles < 100 }">
			<c:forEach var="page" begin="1" end="${totArticles/10 + 1 }" step="1">
				<c:choose>
					<c:when test="${page==pageNum }">
						<a class="sel-page" href="
											${contextPath }/board/listArticles.do?
											setion=${section}&pageNum=${page}">
							${page }
						</a>
					</c:when>
					<c:otherwise>
						<a class="no-uline" href="
											${contextPath }/board/listArticles.do?
											setion=${section}&pageNum=${page}">
							${page }
						</a>
					</c:otherwise>
				</c:choose>
				
			</c:forEach>
		</c:when>
	</c:choose>
</c:if>
</div>
<c:if test="${not empty loginName && loginName != 'admin' }">
	<a class="cls1" href="${contextPath }/board/articleForm.do"><p class="cls2">글쓰기</p></a>
</c:if>
</footer>
</body>
</html>