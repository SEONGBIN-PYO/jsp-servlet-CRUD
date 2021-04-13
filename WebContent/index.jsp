<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="u" tagdir="/WEB-INF/tags" %>
${ctxPath = pageContext.request.contextPath ; ''}
<!DOCTYPE html>
<html>
<head>
	<title>회원제 게시판 예제</title>
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
		  				<button type="button" onclick="location.href='logout.do' "
				  				class="btn btn-danger active">로그아웃</button>
					</li>
					<li>
					  	<button type="button" onclick="location.href='changePwd.do' "
				  				class="btn btn-info active">비밀번호변경</button>
					</li>
				</u:isLogin>
				<u:notLogin>
				  	<li>
				  		<button type="button" onclick="location.href='login.do' "
				  				class="btn btn-success active">로그인</button>
					</li>
					<li>
						<button type="button" onclick="location.href='join.do' "
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

	<script src="//code.jquery.com/jquery-2.1.4.min.js"></script>
	<!-- 부트스트랩 -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
</body>
</html>