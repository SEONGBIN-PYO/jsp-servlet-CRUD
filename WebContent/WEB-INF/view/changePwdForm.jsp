<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
${ctxPath = pageContext.request.contextPath ; ''}
<!DOCTYPE html>
<html>
<head>
	<title>암호 변경</title>
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
	
	<form action="changePwd.do" method="post" style="margin:1em">
		<div class="form-group">
			<label for="inputCurPwd" class="col-sm-2 control-label">현재 암호</label>
			<input class="form-control" id="inputCurPwd" placeholder="현재 암호"
					type="password" name="curPwd" style="margin-bottom:1em"/>
			<c:if test="${errors.curPwd}"><mark>현재 암호를 입력하세요.</mark></c:if>
			<c:if test="${errors.badCurPwd}"><mark>현재 암호가 일치하지 않습니다.</mark></c:if>
		</div>
		<div class="form-group">
			<label for="inputNewPwd" class="col-sm-2 control-label">새 암호</label>
			<input class="form-control" id="inputNewPwd" placeholder="새 암호"
					type="password" name="newPwd" style="margin-bottom:1em"/>
			<c:if test="${errors.newPwd}"><mark>새 암호를 입력하세요.</mark></c:if>
			<c:if test="${errors.sameCurNewPwd}"><mark>새 암호가 현재 암호와 같습니다.</mark></c:if>
		</div>
	<input type="submit" value="암호 변경">
	</form>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<!-- 부트스트랩 -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
</body>
</html>