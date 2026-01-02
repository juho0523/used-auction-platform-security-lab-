<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="css/common.css">
<link rel="stylesheet" href="css/setPW.css">
<title>Insert title here</title>
<style>
.passwordH6{
	font-size:15px;
}


.img{
  width: 23px;
  height: 23px;

}



#top{
	grid-area: 1/1/2/2;
	display: flex;
	justify-content: space-between;
	align-items: center;
	width: inherit;
	height: 40px;
    position: absolute;
	transform:translateY(-650%);
	display:flex;
	flex-wrap: wrap-reverse;

}
#top h1{
	margin-left: 5px;
	font-size: 20px;
	font-weight: 600;
}
#top > img{
	width: 23px;
	height: 23px;
	cursor: pointer; 
}



#top-head {
  font-size: 20px;
  font-weight: 600;
}


.container {
	

}

.setPWH1 {
    grid-area : 1/1/2/2;
    display : flex;
    justify-content : center;
    margin-top: -30%;
}




.setPW{
    grid-area : 2/1/3/2;
    display : flex;
    justify-content : center;
    transform: translateX(10px);
    margin-top:20px;
}


.checkPassword{
    grid-area : 3/1/4/2;
    display : flex;
    justify-content : center;
	white-space:nowrap;
    transform: translateY(8px);

}

input:focus {outline: none;}


.setPWBtn{
    grid-area : 4/1/5/2;
    display:flex;
    justify-content : center;
    
    padding:1em 3em;
    font-size:1.75em;
}

.container{
	transform: translateX(-8px);
	
}





.fontFindPasswordH1{
	font-size:2em; font-weight:bold;
}

.inputNewPW{
	background-color:#D9D9D9; 
	border:none; 
	border-radius:3px; 
	width:200px; 
	height:35px;
}
.inputNewPWCheck{
	background-color:#D9D9D9; 
	border:none; 
	border-radius:3px; 
	width:200px; 
	height:35px;
}

.lgbt{
    color:#FFFFFF;
    background-color:#FFB966;
    border:none;
    border-radius:5px;
    padding:0.8em 2.5em;
}


</style>
</head>
<body>
	<div id="project_container">
		<br><br><br>
			  <div id="top">
				<img class="img" src="images/icon/arrow.png" onclick="history.back()">
		  	  </div>		
	
		<div class="container">
		
			<div class="setPWH1">
				<h1 class="fontFindPasswordH1">비 밀 번 호 찾 기</h1>
			</div>
<form action="controller?cmd=setPWAction" method="post">
			<div class="setPW">
				<h6 class="passwordH6">새 비밀번호</h6><input type="password" name="password" class="inputNewPW"><br>
			</div>

			<div class="checkPassword">
				<h6 class="passwordH6">비밀번호 확인 </h6><input type="password" name="checkPassword" class="inputNewPWCheck"><br>
			</div>

			<div class="setPWBtn">
				<div>
					<input type="submit" value="O K" class="lgbt" onclick = "return passwordTest()">
				</div>
			</div>
		</form>	
		</div>
	</div>
<script type="text/javascript">
function passwordTest(){

	var p1 = document.getElementById('password').value;
		var p2 = document.getElementById('checkPassword').value;
		if (p1 != p2) {
			alert("비밀번호가 일치 하지 않습니다");
			return false;
		} else {

			return true;
		}
	}

</script>	
</body>
</html>