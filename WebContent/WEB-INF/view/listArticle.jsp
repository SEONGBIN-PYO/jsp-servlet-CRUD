<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="u" tagdir="/WEB-INF/tags" %>
${ctxPath = pageContext.request.contextPath ; ''}
<!DOCTYPE html>
<html>
<head>
	<title>게시글 목록</title>
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
					<li>
					  	<button type="button" onclick="location.href='${ctxPath}/changePwd.do' "
				  				class="btn btn-info active">비밀번호변경</button>
					</li>
				</u:isLogin>
				<u:notLogin>
				  	<li>
				  		<button type="button" onclick="location.href='${ctxPath}/login.do' "
				  				class="btn btn-success active">로그인</button>
					</li>
					<li>
						<button type="button" onclick="location.href='${ctxPath}/join.do' "
				  				class="btn btn-primary active">회원가입</button>
					</li>
				</u:notLogin>
					<li>
						<button type="button" onclick="location.href='${ctxPath}/article/list.do' "
				  				class="btn btn-default active">게시판</button>
					</li>
				</ul>
  			</div>
		</nav>
	</header>
	
	<table class="table table-striped table-hover" border="1">
		<tr>
			<td colspan="4">
				<button type="button" onclick="location.href='write.do' "
			  			class="btn btn-primary active">게시글쓰기
			  	</button>
			</td>
		</tr>
		<tr class="table-text">
			<td width="10%">번호</td>
			<td width="60%">제목</td>
			<td width="20%">작성자</td>
			<td width="10%">조회수</td>
		</tr>
	<c:if test="${articlePage.hasNoArticles()}">
		<tr>
			<td colspan="4">게시글이 없습니다.</td>
		</tr>
	</c:if>
	<c:forEach var="article" items="${articlePage.content}">
		<tr class="table-text">
			<td>${article.number}</td>
			<td>
			<a href="read.do?no=${article.number}&pageNo=${articlePage.currentPage}">
			<c:out value="${article.title}"/>
			</a>
			</td>
			<td>${article.writer.name}</td>
			<td>${article.readCount}</td>
		</tr>
	</c:forEach>
	<c:if test="${articlePage.hasArticles()}">
		<tr>
			<td colspan="4">
				<c:if test="${articlePage.startPage > 5}">
				<a href="list.do?pageNo=${articlePage.startPage - 5}">[이전]</a>
				</c:if>
				<c:forEach var="pNo" 
						   begin="${articlePage.startPage}" 
						   end="${articlePage.endPage}">
				<a href="list.do?pageNo=${pNo}">[${pNo}]</a>
				</c:forEach>
				<c:if test="${articlePage.endPage < articlePage.totalPages}">
				<a href="list.do?pageNo=${articlePage.startPage + 5}">[다음]</a>
				</c:if>
			</td>
		</tr>
	</c:if>
	</table>
	
	<script src="//code.jquery.com/jquery-2.1.4.min.js"></script>
	<!-- 부트스트랩 -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
</body>
</html>