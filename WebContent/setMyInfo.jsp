<%@page import="com.google.gson.JsonObject" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:if test="${userId eq null}">
  <c:redirect url="controller?cmd=loginUI" />
</c:if>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="css/common.css">
<link rel="stylesheet" href="css/setMyInfo.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.0.0/crypto-js.min.js"></script>
<title>마이페이지 : 회원정보수정</title>
<style>
.img {
  width: 23px;
  height: 23px;
}

#top {
  grid-area: 1/1/2/2;
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: inherit;
  height: 40px;
  position: absolute;
  transform: translateY(-650%);
  display: flex;
  flex-wrap: wrap-reverse;
}

#top h1 {
  margin-left: 5px;
  font-size: 20px;
  font-weight: 600;
}

#top>img {
  width: 23px;
  height: 23px;
  cursor: pointer;
}

#top-head {
  font-size: 20px;
  font-weight: 600;
}

.container {
  display: grid;
  grid-template-rows: 40px 330px 70px;
}

.setMyInfoH1 {
  grid-area: 1/1/2/2;
  display: flex;
  justify-content: center;
  transform: translateY(-20px);
}

#addInfo {
  grid-area: 2/1/3/2;
  display: flex;
  flex-wrap: wrap;
  grid-row-gap: 10px;
  margin-top: 20px;
}

#addInfo div {
  display: flex;
  margin: 20px auto;
  justify-content: center;
  margin: 5px auto;
}

.addPassword {
  transform: translateX(-5px);
}

.checkPassword {
  transform: translateX(-1px);
}

.addName {
  transform: translateX(20px);
}

.addNickname {
  transform: translateX(5px);
}

.addPhoneNumber {
  transform: translateX(2px);
}

.addEmail {
  transform: translateX(13px);
}

.addressH6 {
  position: absolute;
  top: -38px;
  transform: translateX(-94px);
}

.addAddress {
  display: flex;
  align-items: center;
  justify-content: center;
  /* justify-content:space-between; */
  transform: translateX(55px);
}

.form-select {
  align-self: flex-start;
  background-color: #ffffff;
  font-size: 12px;
  border-color: #D9D9D9;
  border-radius: 5px;
  width: 144px;
  height: 25px;
}

.addAddress select {
  display: flex;
  align-self: flex-end;
  font-size: 15px;
  transform: translateX(-3px);
}

.inputTxt {
  height: 30px;
}

input:focus {
  outline: none;
}

#citySelect {
  transform: translateX(60px);
}

#districtSelect {
  transform: translateX(-84px);
}

.setMyInfoBtn {
  grid-area: 3/1/4/2;
  display: flex;
  justify-content: center;
  transform: translateY(-30px);
  padding: 1em 3em;
  font-size: 1.75em;
}

.inputTxt {
  background-color: #D9D9D9;
  border: none;
  border-radius: 3px;
}

#nicknameInputSpan {
  display: flex;
  flex-wrap: wrap;
}

#passwordCheckDiv {
  transform: translateY(50px);
}

label {
  white-space: nowrap;
}

.fontJoinH1 {
  font-size: 2em;
  font-weight: bold;
}

.smibt {
  color: #FFFFFF;
  background-color: #FFB966;
  border: none;
  border-radius: 5px;
  padding: 0.5em 1.5em;
}

#submitBtn {
  transform: translateY(-30px);
}

#okBtnSubmit {
  padding: 0.3em 4em;
}
</style>
</head>
<body>
  <div id="project_container">
    <br>
    <br>
    <br>
    <div id="top">
      <img class="img ms-2 mt-2" src="images/icon/arrow.png" onclick="history.back()">
    </div>
    <form action="controller?cmd=setMyInfoAction" method="post" id="setMyInfoForm" onsubmit="hashFormData(event)">
      <div class="container">
     
      
        <div class="setMyInfoH1">
          <h1 class="fontJoinH1">회 원 정 보 수 정</h1>
        </div>
        <div id="addInfo">

          <div class="addPassword mb-0">
            ㅤㅤㅤ<label>비밀번호ㅤ</label><input type="password" name="password"
              class="inputTxt" id="password"><br>
          </div>


          <div class="checkPassword mt-0 mb-0" id="passwordInputSpan">
            <label>비밀번호 확인ㅤ </label><input type="password"
              class="inputTxt mt-0 mb-0" id="checkPassword">
            <div class="mt-0  mb-0" id="passwordCheckDiv"></div>
          </div>

          <!--        <div class="addName">
          ㅤ이름 <input type="text" name="name" class="inputTxt"><br>
        </div> -->

          <div class="addNickname mt-0 mb-0" id="nicknameInputSpan">
            ㅤ<label>ㅤ ㅤㅤ닉네임ㅤ </label><input type="text" name="nickname"
              class="inputTxt mt-0 mb-0" id="nickCheck" value="<%= request.getAttribute("nickname") %>">

          </div>
          <div class="mt-0 mb-0" id="nickCheckFeedBack"></div>

          <div class="addPhoneNumber mt-0 mb-0">
            ㅤㅤ<label>전화번호ㅤ</label><input type="text" name="phoneNumber"
              class="inputTxt" value="<%= request.getAttribute("phoneNumber") %>"><br>
          </div>

          <div class="addEmail mt-0 mb-0">
            ㅤ<label>이메일ㅤ</label><input type="text" name="email"
              class="inputTxt mb-4" value="<%= request.getAttribute("email") %>"><br>
          </div>



          <div class="addAddress mt-3 mb-0">
            <div class="addressH6">
              <p>주</p>
              <p>소ㅤㅤㅤ</p>
            </div>
            <div class="mt-0 mb-3" id="citySelect">
              <select class="form-select mt-0 mb-4"
                aria-label="Default select example" id="cityAddress"
                name="cityAddress">
                <option value="서울특별시" class="selectItems">서울특별시</option>
              </select>
            </div>
            <div class="mt-1" id="districtSelect">
              <select class="form-select mt-4"
                aria-label="Default select example" id="districtAddress"
                name="districtAddress">
                <option value="강남구" class="selectItems">강남구</option>
                <option value="강동구" class="selectItems">강동구</option>
                <option value="강북구" class="selectItems">강북구</option>
                <option value="강서구" class="selectItems">강서구</option>
                <option value="관악구" class="selectItems">관악구</option>
              </select>
            </div>
          </div>
          <div class="d-grid ps-5 pe-5 text-center mt-0 mb-0" id="submitBtn">
            <button type="submit" class="btn btn-primary btn-lg"
              id="okBtnSubmit" onclick="return passwordTest()">
              <div class="text-center m">OK</div>
            </button>
          </div>

        </div>



        <!-- <div class="setMyInfoBtn mb-0"> -->

        <!-- </div> -->
      </div>
    </form>
    <jsp:include page="/navbar_my.jsp"></jsp:include>
  </div>

</body>
<script>
var ac = '<%= request.getAttribute("cityAddress")%>';
console.log(ac);
var cityAddressSelect = document.getElementById("cityAddress");

cityAddressSelect.value = ac;


var ad = '<%= request.getAttribute("districtAddress")%>';
console.log(ad);
var districtAddressSelect = document.getElementById("districtAddress");

districtAddressSelect.value = ad;
</script>
<script type="text/javascript">




  //닉네임 중복체크
  $(document)
      .ready(
          function() {
            $("#nickCheck")
                .on(
                    "change",
                    function() {
                      let
                      nick = $(this).val();
                      $('.nickCheckFeedBackSpan')
                          .remove();
                      $
                          .post(
                              "controller?cmd=sessionNickCheckAction",
                              {
                                nick : nick
                              },
                              function(
                                  responseText) {

                                result_data = JSON
                                    .parse(responseText);
                                //$("nickCheckFeedBack").html(result_data.result);
                                //alert(result_data.result);

                                console
                                    .log(result_data.result);
                                if (result_data.result == '다른 유저가 사용중인 닉네임입니다.') {
                                  $(
                                      '#nickCheckFeedBack')
                                      .after(
                                          "<span class='nickCheckFeedBackSpan mt-0 mb-0' id='spanNickname' style='font-size:9px; font-weight:bold; color:red; white-space:nowrap; transform:translateX(120px);'>"
                                              + result_data.result
                                              + "</span>")
                                } else {
                                  $(
                                      '#nickCheckFeedBack')
                                      .after(
                                          "<span class='nickCheckFeedBackSpan mt-0 mb-0' id='spanNickname' style='font-size:9px; font-weight:bold; color:green; white-space:nowrap; transform:translateX(120px); '>"
                                              + result_data.result
                                              + "</span>")
                                }
                                
                                if(nick == ''){
									$('.nickCheckFeedBackSpan').remove();
								}
                              });
                    });
          });

  //비밀번호 일치하는 지 확인
  $(document)
      .ready(
          function() {
            $("#checkPassword")
                .on(
                    "change",
                    function() {
                      let
                      nick = $(this).val();
                      $('.passwordCheckSpan').remove();
                      var p1 = document
                          .getElementById('password').value;
                      var p2 = document
                          .getElementById('checkPassword').value;

                      if (p1 != p2) {
                        $('#passwordInputSpan')
                            .after(
                                "<span class='passwordCheckSpan mt-0 mb-0' id='spanPassword' style='font-size:9px; font-weight:bold; color:red; white-space:nowrap;  transform:translateX(120px);'>비밀번호가 일치하지 않습니다.</span>")
                      } else {
                        $('#passwordInputSpan')
                            .after(
                                "<span class='passwordCheckSpan mt-0 mb-0' id='spanPassword' style='font-size:9px; font-weight:bold; color:green; white-space:nowrap; transform:translateX(120px);'>비밀번호가 일치합니다.</span>")
                      }
                      
                      if(p1 == '' || p2 == ''){
							$('.passwordCheckSpan').remove();
						}
                    });
          });
  
  $(document)
  .ready(
      function() {
        $("#password")
            .on(
                "change",
                function() {
                  let
                  nick = $(this).val();
                  $('.passwordCheckSpan').remove();
                  var p1 = document
                      .getElementById('password').value;
                  var p2 = document
                      .getElementById('checkPassword').value;

                  if (p1 != p2) {
                    $('#passwordInputSpan')
                        .after(
                            "<span class='passwordCheckSpan mt-0 mb-0' id='spanPassword' style='font-size:9px; font-weight:bold; color:red; white-space:nowrap;  transform:translateX(120px);'>비밀번호가 일치하지 않습니다.</span>")
                  } else {
                    $('#passwordInputSpan')
                        .after(
                            "<span class='passwordCheckSpan mt-0 mb-0' id='spanPassword' style='font-size:9px; font-weight:bold; color:green; white-space:nowrap; transform:translateX(120px);'>비밀번호가 일치합니다.</span>")
                  }
                  
                  if(p1 == '' || p2 == ''){
						$('.passwordCheckSpan').remove();
					}
                });
      });
  
  
  
  
  
  
  
  

  function passwordTest() {
    var spanNickname = document.getElementById('spanNickname');
    var spanPassword = document.getElementById('spanPassword');

    if (spanNickname.style.color === 'red'
        || spanPassword.style.color === 'red') {
      alert('정보수정이 불가능합니다.')
      return false;
    } else {
      alert('정보수정이 완료됐습니다.')
      return true;
    }

  }
</script>

<script>
function hashFormData(event) {
  event.preventDefault();
  var form = document.getElementById("setMyInfoForm");
  var formData = new FormData(form);  
  var password = formData.get("password");
  var hashedPassword = CryptoJS.SHA256(password).toString(CryptoJS.enc.Hex);
  document.getElementById("password").value = hashedPassword;
  form.submit();
}
</script> 
  
</html>