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
<!-- <link rel="stylesheet" href="css/findID.css">
 --><title>Insert title here</title>
<style>

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
    display : grid;
    grid-template-rows: 120px 50px 50px 50px 250px;
	height:548px;
	margin-top:50px;
}




.findIdH1 {
    grid-area : 1/1/2/2;
    display:flex;
    align-content: space-between;

    
}



.fontFindIdH1{

	display : flex;
    justify-content : center;
    margin-top: 30%;
    margin-left:30%;
}


.addName{
    grid-area : 2/1/3/2;
    display : flex;
    justify-content : center;
    transform: translateX(8px);
    margin-top:20px;
}


.addEmail{
    grid-area : 3/1/4/2;
    display : flex;
    justify-content : center;
    transform: translateY(8px);
    margin-top:5px;
}

.addPhoneNumber{
    grid-area : 4/1/5/2;
    display : flex;
    justify-content : center;
    transform: translateY(8px);
    transform: translateX(-7px);
    margin-top:5px;
}

input:focus {outline: none;}


.findIdBtn{
    grid-area : 5/1/6/2;
    display:flex;
    justify-content : center;
    
    padding:1em 3em;
    font-size:1.75em;
}

.container{
	transform: translateX(-8px);
	
}

.inputTxt{
	background-color:#D9D9D9;
	border:none; 
	border-radius:3px; 
	width:200px; 
	height:35px;
}

.fontFindIdH1{
	font-size:2em; font-weight:bold;
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

			  <div id="top">
				<img class="img" src="images/icon/arrow.png" onclick="history.back()">
		  	  </div>		

		<div class="container">

		
		
			<div class="findIdH1">
		
				<h1 class="fontFindIdH1">아 이 디 찾 기</h1>
			</div>
<form action="controller?cmd=findIDAction" method="post">
			<div class="addName">
				<h6>이름ㅤ </h6><input type="text" name="name" class="inputTxt"><br>
			</div>

			<div class="addEmail">
				<h6>이메일ㅤ</h6> <input type="text" name="email" class="inputTxt"><br><br>
			</div>

			<div class="addPhoneNumber mt-4">
				<h6>전화번호ㅤ</h6><input type="text" name="phoneNumber" class="inputTxt"><br>
			</div>


			<div class="findIdBtn">
				<div>
					<input type="submit" value="O K" class="lgbt">
				</div>
	
			</div>
		</form>	
		</div>
	</div>
<script type="text/javascript">
</script>	
</body>
</html>