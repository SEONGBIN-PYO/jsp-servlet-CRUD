<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="u" tagdir="/WEB-INF/tags" %>
${ctxPath = pageContext.request.contextPath ; ''}
<!DOCTYPE html>
<html>
<head>
	<title>게시글 읽기</title>
	<link rel="stylesheet" href="${ctxPath}/css/index.css">
	<!-- 부트스트랩 -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
</head>
<body>
	<header>
			<nav class="navbar navbar-expand-md navbar-dark bg-dark fixed-top">
  			<a class="navbar-brand" href="${ctxPath}/">JSP/Servlet 학습</a>
			<span class="navbar-toggler-icon"></span>
			
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="list-inline">
				<u:isLogin>
		  			<li>
		  				<button type="button" onclick="location.href='${ctxPath}/logout.do' "
				  				class="btn btn-danger active">로그아웃</button>
					</li>
				</u:isLogin>
					<li>
						<button type="button" onclick="location.href='${ctxPath}/' "
				  				class="btn btn-primary active">메인화면</button>
					</li>
					<li>
						<button type="button" onclick="location.href='${ctxPath}/article/list.do' "
				  				class="btn btn-default active">게시판</button>
					</li>
				</ul>
  			</div>
			</nav>
	</header>
	
	<table class="table table-striped table-hover" border="1">
		<tr class="table-text">
			<td width="10%">번호</td>
			<td>${articleData.article.number}</td>
		</tr>
		<tr class="table-text">
			<td width="10%">작성자</td>
			<td>${articleData.article.writer.name}</td>
		</tr>
		<tr class="table-text">
			<td width="10%">제목</td>
			<td><c:out value='${articleData.article.title}' /></td>
		</tr>
		<tr class="table-text">
			<td width="10%">내용</td>
			<td style="text-align:left"><u:pre value='${articleData.content}'/></td>
		</tr>
		<tr class="table-text">
			<td colspan="2">
				<c:set var="pageNo" value="${empty param.pageNo ? '1' : param.pageNo}" />
				<a href="list.do?pageNo=${pageNo}">[목록]</a>
				<c:if test="${authUser.id == articleData.article.writer.id}">
				<a href="modify.do?no=${articleData.article.number}">[게시글수정]</a>
				<a href="delete.do?no=${articleData.article.number}">[게시글삭제]</a>
				</c:if>
			</td>
		</tr>
	</table>
	
	<script src="//code.jquery.com/jquery-2.1.4.min.js"></script>
	<!-- 부트스트랩 -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
</body>
</html>