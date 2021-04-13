<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
${ctxPath = pageContext.request.contextPath ; ''}
<!DOCTYPE html>
<html>
<head>
	<title>임시 비밀번호 발급</title>
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
				  		<button type="button" onclick="location.href='login.do' "
				  				class="btn btn-success active">로그인</button>
					</li>
					<li>
						<button type="button" onclick="location.href='join.do' "
				  				class="btn btn-primary active">회원가입</button>
					</li>
					<li>
						<button type="button" onclick="location.href='${ctxPath}/article/list.do' "
				  				class="btn btn-default active">게시판</button>
					</li>
				</ul>
  			</div>
		</nav>
	</header>
	
	<form action="tempPwd.do" method="post" style="margin:1em">
		<div class="form-group">
			<label for="inputID" class="col-sm-2 control-label">아이디</label>
			<input class="form-control" id="inputID" placeholder="ID"
					type="text" name="id" style="margin-bottom:1em"/>
			<c:if test="${errors.curId}"><mark>가입된 아이디를 입력하세요.</mark></c:if>
		</div>
		<div class="form-group">
			<label for="inputName" class="col-sm-2 control-label">이름</label>
			<input class="form-control" id="inputName" placeholder="NAME"
					type="text" name="name" value="${param.password}" style="margin-bottom:1em"/>
			<c:if test="${errors.curName}"><mark>등록된 이름을 입력하세요.</mark></c:if>
		</div>
	<input type="submit" value="임시 비밀번호 발급">
	</form>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<!-- 부트스트랩 -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
</body>
</html>