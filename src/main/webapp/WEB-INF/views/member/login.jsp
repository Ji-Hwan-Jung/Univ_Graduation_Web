<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="description">
    <meta http-equiv="X-UA-Compatible" content="text/html">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- content에 자신의 OAuth2.0 클라이언트ID를 넣습니다. -->
    <meta name ="google-signin-client_id" content="484064947589-ec6qq5jcjh5bcbojthbtfbreo3inqns7.apps.googleusercontent.com">
    <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
    <script async defer crossorigin="anonymous" src="https://connect.facebook.net/ko_KR/sdk.js#xfbml=1&version=v10.0&appId=3239650426314950" nonce="SiOBIhLG"></script>
    <script>

    function window_test(){
        var w_width = 550;
        var w_height = 300;

        // var w_top = parseInt(document.screenTop)
        var w_left = parseInt(window.screenLeft);
        var w_top = parseInt(window.screenTop);
        //var w_left = parseInt(document.body.offsetLeft);
        
        // var t_height = (window.outerheight - window.innerHeight); // 주소창 메뉴 높이 
        var p_top = Math.round(w_top);                               // 브라우저 위치
        var p_left = Math.round(w_left);         
        

        var popupX = (window.screen.width/2) - w_width + w_left ;
        var popupY = (window.screen.height/2) - w_height + w_top;


        var win = window.open('video1.html', '_blank', 'status=yes, toolbar=yes,scrollbars=no,resizable=no, height='+w_height+' width='+w_width+', left='+ popupX + ', top='+ popupY + ', screenX='+ popupX + ', screenY= '+ popupY);
 
    }
     Kakao.init('1e8d3e3001d21879cdb5857aedfd0696'); //발급받은 키 중 javascript키를 사용해준다.
     console.log(Kakao.isInitialized()); // sdk초기화여부판단


      //카카오로그인
     function kakaoLogin() {
            window.Kakao.Auth.login({

                scope: 'profile_image, account_email, gender, age_range, birthday', //동의항목 페이지에 있는 개인정보 보호 테이블의 활성화된 ID값 넣음
                success: function(response) {
                    console.log(response) // 로그인 성공하면 받아오는 데이터
                    window.Kakao.API.request({ // 사용자 정보 가져오기 
                        url: '/v2/user/me',
                        success: (res) => {
                            const kakao_account = res.kakao_account;
                            console.log(kakao_account)
                        }
                    });
                    location.href='http://somcoco.co.kr/loginSuccess.html' //리다이렉트 되는 코드
                },
                fail: function(error) {
                    console.log(error);
                }
            });
        }
    </script>

    <!-- 페이스북 로그인 로직 -->
    <script>

        //기존 로그인 상태를 가져오기 위해 Facebook에 대한 호출
        function statusChangeCallback(res){
            statusChangeCallback(response);
        }
        
        function fnFbCustomLogin(){
            FB.login(function(response) {
                if (response.status === 'connected') {
                    FB.api('/me', 'get', {fields: 'name,email'}, function(r) {
                        console.log(r);
                    })
                } else if (response.status === 'not_authorized') {
                    // 사람은 Facebook에 로그인했지만 앱에는 로그인하지 않았습니다.
                    alert('앱에 로그인해야 이용가능한 기능입니다.');
                } else {
                    // 그 사람은 Facebook에 로그인하지 않았으므로이 앱에 로그인했는지 여부는 확실하지 않습니다.
                    alert('페이스북에 로그인해야 이용가능한 기능입니다.');
                }
            }, {scope: 'public_profile,email'});
        }
        
        window.fbAsyncInit = function() {
            FB.init({
                appId      : '3239650426314950', // 내 앱 ID를 입력한다.
                cookie     : true,
                xfbml      : true,
                version    : 'v10.0'
            });
            FB.AppEvents.logPageView();   
        };
        </script>

        <!-- 구글 로그인 로직 -->
        <script>

            //처음 실행하는 함수
            function init() {
                gapi.load('auth2', function() {
                    gapi.auth2.init();
                    options = new gapi.auth2.SigninOptionsBuilder();
                    options.setPrompt('select_account');
                    // 추가는 Oauth 승인 권한 추가 후 띄어쓰기 기준으로 추가
                    options.setScope('email profile openid https://www.googleapis.com/auth/user.birthday.read');
                    // 인스턴스의 함수 호출 - element에 로그인 기능 추가
                    // GgCustomLogin은 li태그안에 있는 ID, 위에 설정한 options와 아래 성공,실패시 실행하는 함수들
                    gapi.auth2.getAuthInstance().attachClickHandler('GgCustomLogin', options, onSignIn, onSignInFailure);
                })
            }
            
            function onSignIn(googleUser) {
                var access_token = googleUser.getAuthResponse().access_token
                $.ajax({
                    // people api를 이용하여 프로필 및 생년월일에 대한 선택동의후 가져온다.
                    url: 'https://people.googleapis.com/v1/people/me'
                    // key에 자신의 API 키를 넣습니다.
                    , data: {personFields:'birthdays', key:'AIzaSyCZoNBIQAgqc3s_68Iap0iseYxZ6B7gCK0', 'access_token': access_token}
                    , method:'GET'
                })
                .done(function(e){
                    //프로필을 가져온다.
                    var profile = googleUser.getBasicProfile();
                    console.log(profile)
                })
                .fail(function(e){
                    console.log(e);
                })
            }
            function onSignInFailure(t){		
                console.log(t);
            }
            </script>
            <!-- 구글 api 사용을 위한 스크립트 -->
            <script src="https://apis.google.com/js/platform.js?onload=init" async defer></script>
            
            <script type="text/javascript">
function checkErrCode(){
   var msgCode = "${msgCode}";
   if( msgCode != ""){
      alert(msgCode);
   }
}
</script>

    <title>Login Page</title> <!-- Title --> 
    <link href="${pageContext.request.contextPath}/resources/css/others/login.css" rel="stylesheet"> <!-- Login CSS -->
    <link href="${pageContext.request.contextPath}/resources/img/core-img/favicon.ico" rel="icon"> <!-- Favicon -->
    <link href="${pageContext.request.contextPath}/resources/style.css" rel="stylesheet"> <!-- Core Stylesheet --> 
    <link href="${pageContext.request.contextPath}/resources/css/responsive/responsive.css" rel="stylesheet"><!-- Responsive CSS -->
</head>

<body onload="checkErrCode()">

    
    <!-- Preloader Start -->
    <div id="preloader">
        <div class="somcoco-load"></div>
    </div>

<form:form modelAttribute="userVO" class="login-form" name="login-form" method="post" action="login">
<div class="main-panel fadeInUp">
    <div class="content-wrapper" id="formContent">
        <div class="row">
            <div class="col-md-12 grid-margin stretch-card">
                <div class="card-body"></div>
                <h4 class="card-title"><img src="${pageContext.request.contextPath}/resources/img/logo/login_title.svg" id="icon" alt="User Icon"/></h4>
                <p class="card-description">
                
                <p align="left"><span class="error"><form:errors path="userid" /></span><br /></p>
                <input type="text" id="login" class="fadeIn second" name="userid" placeholder="아이디">
                
                <p align="left"><span class="error"><form:errors path="passwd" /></span></p>
                <input type="password" id="password" class="fadeIn third" name="passwd" placeholder="비밀번호">
                
                <input type="submit" class="fadeIn fourth" value=" 로그인 ">
                
                </p>
                <div class="loginArea">
                <div class="formFooter">
                    <div class="top-demo">
                   <div class="template-demo1">
                    
                      <a href="<%=request.getContextPath()%>/member/findId"><input type="button" class="btn btn-social-icon-text fadeIn fifth" value="ID찾기"></a>&nbsp;&nbsp;&nbsp;
                      <a href="<%=request.getContextPath()%>/member/findPass"><input type="button" class="btn btn-social-icon-text fadeIn fifth" value="PW찾기"></a>&nbsp;&nbsp;&nbsp;
                      <a href="<%=request.getContextPath()%>/member/join"><input type="button" class="btn btn-social-icon-text fadeIn fifth" value="회원가입"></a>
                  </div>
                  <div class="template-demo2">
                    <a href="javascript:void(0)" style="margin-bottom: 5px;" class="kakaobtn" class="btn btn-social-icon-text fadeIn"><img src="${pageContext.request.contextPath}/resources/img/icon/kakao_login.png" alt="카카오계정 로그인" onclick="kakaoLogin()"></a>
                    <a href="javascript:void(0)" style="margin-bottom: 5px" class="kakaobtn"><div class="fb-login-button" data-width="" data-size="large" data-button-type="continue_with" data-layout="default" data-auto-logout-link="false" data-use-continue-as="false" onclick="fnFbCustomLogin()"></div></a>
                    <a href="javascript:void(0)" id="GgCustomLogin" class="kakaobtn"><img src="${pageContext.request.contextPath}/resources/img/icon/google_login.png" alt="카카오계정 로그인"></a>
                </div>
            </div>
               
            </div>
         </div>
        </div>
        </div>
    </div>
</div>
</form:form>

<!-- ★ 웹 구동 필수 플러그인 ( jquery, bootstrap, 문서 연결 )-->
    <script src="${pageContext.request.contextPath}/resources/js/jquery/jquery-2.2.4.min.js"></script><!-- Jquery-2.2.4 js -->
    <script src="${pageContext.request.contextPath}/resources/js/bootstrap/popper.min.js"></script><!-- Popper js -->
    <script src="${pageContext.request.contextPath}/resources/js/bootstrap/bootstrap.min.js"></script><!-- Bootstrap-4.6.1 js -->
    <script src="${pageContext.request.contextPath}/resources/js/others/plugins.js"></script><!-- All Plugins JS -->
    <script src="${pageContext.request.contextPath}/resources/js/others/kakao.min.js"></script><!-- All Plugins Kakao -->
    <!-- <script src="${pageContext.request.contextPath}/resources/js/active.js"></script> Active JS -->
</body>
</html>