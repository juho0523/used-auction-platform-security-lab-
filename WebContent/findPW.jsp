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
<link rel="stylesheet" href="/findPW.css">
<title>Insert title here</title>
<style>
.img {
  width: 23px;
  height: 23px;
  
}






#top{
	
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
    display : grid;

	
}

.findPasswordH1 {
    grid-area : 1/1/2/2;
    display : flex;
    justify-content : center;
    margin-top: -20%;
}




.addUserId{
    grid-area : 2/1/3/2;
    display : flex;
    justify-content : center;
    transform: translateX(-5px);
    margin-top:20px;
}


.addName{
    grid-area : 3/1/4/2;
    display : flex;
    justify-content : center;

    transform: translateY(8px);
    margin-top:5px;
}

.addEmail{
    grid-area : 4/1/5/2;
    display : flex;
    justify-content : center;
    transform: translateY(8px);
    transform: translateX(-5px);
    margin-top:20px;
}

input:focus {outline: none;}


.findPasswordBtn{
    grid-area : 5/1/6/2;
    display:flex;
    justify-content : center;
    

   
}

.container{
	transform: translateX(-8px);
	
}

.fontFindPasswordH1{
	font-size: 2em; font-weight: bold;
}


.lgbt{
    color:#FFFFFF;
    background-color:#FFB966;
    border:none;
    margin-top:20px;
    border-radius:5px;
    font-size:1.75em;
    padding:20px 60px;
}


</style>
</head>
<body>
	<div id="project_container">
	
	<br><br><br>
			  <div id="top">
				<img class="img" src="images/icon/arrow.png" onclick="history.back()" style=" width: 23px;  height: 23px;">
		  	  </div>	
	
		<div class="container">
			<div class="findPasswordH1">
				<h1 style="font-size: 2em; font-weight: bold;">비 밀 번 호 찾 기</h1>
			</div>


		<form action="controller?cmd=findPWAction" method="post">
			<div class="addUserId">
				<h6>아이디ㅤ </h6><input type="text" name="userId"
					style="background-color: #D9D9D9; border: none; border-radius: 3px; width: 200px; height: 35px;"><br>
			</div>

			<div class="addName">
				<h6>이름ㅤ </h6><input type="text" name="name"
					style="background-color: #D9D9D9; border: none; border-radius: 3px; width: 200px; height: 35px;"><br>
			</div>

			<div class="addEmail">
				<h6>이메일ㅤ</h6><input type="text" name="email"
					style="background-color: #D9D9D9; border: none; border-radius: 3px; width: 200px; height: 35px;"><br>
			</div>


			<div class="findPasswordBtn">
				<div>
					<input type="submit" value="O K" class="lgbt">
				</div>
			</div>
		</form>	
		</div>
	</div>
</body>
</html>