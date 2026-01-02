<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>
<link rel="stylesheet" href="css/login.css">
<link rel="stylesheet" href="css/common.css">
<title>Insert title here</title>
</head>
<body>
	<div id="project_container">
	
		<form action="controller?cmd=loginAction" method="post">
			<div class="row align-items-center">
				<p class="fs-1 text-center pb-2">로그인</p>
				<div class="row g-2 d-flex align-items-center justify-content-center pt-2">
					<div class="col-4 text-end">
						<label class="col-form-label">아이디</label>
					</div>
					<div class="col-7">
						<input name="userId" type="text" id="inputId"
							class="form-control-sm">
					</div>
					<div class="col-4 text-end">
						<label for="inputPassword6" class="col-form-label">비밀번호</label>
					</div>
					<div class="col-7">
						<input name="userPw" type="password" id="pw"
							class="form-control-sm" aria-describedby="passwordHelpInline">
					</div>
				</div>
			</div>

			<div class="container text-center mt-3" id="linkA">
				<a href="findID.jsp"
					class="link-secondary link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover m-1"
					id="findIDA">아이디 찾기</a>
				<p>|</p>
				<a href="findPW.jsp"
					class="link-secondary link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover m-1"
					id="findPWA">비밀번호 찾기</a>
				<p>|</p>
				<a href="join.jsp"
					class="link-secondary link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover m-1"
					id="joinA">회원가입</a>
			</div>
			<div class="d-grid ps-5 pe-5 mt-3 mb-3 text-center">
				<button type="submit" class="btn btn-primary btn-lg">
					<div class="text-center m">LOGIN</div>
				</button>
			</div>
		</form>
	</div>
<script type="text/javascript">


</script>	
</body>
</html>