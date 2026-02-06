<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="css/error.css">
<link rel="stylesheet" href="css/common.css">

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>


<title>호박마켓 : 에러</title>
</head>
<body>
	<div id="project_container" class="d-flex">
		<div>
			<img src="./images/product/uploaded/logo.png" class="logo">
		</div>
		<div>
			<p>페이지를 찾을 수 없습니다.
		</div>
		<div>
			<div class="d-grid ps-5 pe-5 mt-3 mb-3 text-center">
				<button type="button" class="btn-lg">
					<div class="text-center m">뒤로 가기</div>
				</button>
			</div>
		</div>
	</div>
<script>
	var userId = ${"userId"};
	$("button").on("click", function(){
		if(userId == null){
			location.href = "controller?cmd=loginUI";
		}
		else{
			location.href = "controller?cmd=mainUI";
		}
	})
</script>
</html>