<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
${ctxPath = pageContext.request.contextPath ; ''}
<!DOCTYPE html>
<html>
<head>
	<title>게시글 수정</title>
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
	
	<form action="modify.do" method="post" style="margin:1em">
		<input type="hidden" name="no" value="${modReq.articleNumber}">
		<div class="form-group">
			<label for="inputText" class="col-sm-2 control-label">제목</label>
			<input class="form-control" id="inputTitle" placeholder="Title"
					type="text" name="title" value="${modReq.title}" style="margin-bottom:1em"/>
			<c:if test="${errors.title}"><mark>제목을 입력하세요.</mark></c:if>
		</div>
		<div class="form-group">
			<label for="inputContent" class="col-sm-2 control-label">내용</label>
			<textarea name="content" rows="7" cols="50">${modReq.content}</textarea>
		</div>
	<input type="submit" value="글 수정">
	</form>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<!-- 부트스트랩 -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
</body>
</html>