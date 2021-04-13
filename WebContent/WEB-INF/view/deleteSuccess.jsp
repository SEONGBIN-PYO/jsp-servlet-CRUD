<%@ page contentType="text/html; charset=utf-8"%>
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
	
	<p style="margin:1em">게시글을 삭제했습니다.</p>
	
	<script src="//code.jquery.com/jquery-2.1.4.min.js"></script>
	<!-- 부트스트랩 -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
</body>
</html>