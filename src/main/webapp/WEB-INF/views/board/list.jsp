<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%
	//세션값 받기
	Object userid = session.getAttribute("userid");
	session.setAttribute("userid", userid);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> -->
<title>커뮤니티 글 목록</title>
<style>
/* 구글 웹폰트 */
@import
	url('https://fonts.googleapis.com/css?family=Gothic+A1|Nanum+Gothic|Noto+Sans+KR&display=swap')
	;

#hr {
	display: block;
	margin-top: 0.5em;
	margin-left: auto;
	margin-right: auto;
	/* border: 1px solid #000; */
	border: 1px solid #ddd;
}

.navbar img {
	/* 	width: 24px;
	height: 24px; */
	vertical-align: middle;
}

.nav-link {
	/* font-family: 'Nanum Gothic', sans-serif; */
	font-size: 1.0em;
	font-weight: 700;
	color: black;
}

.nav-link:hover {
	/* font-family: 'Nanum Gothic', sans-serif; */
	font-size: 1.0em;
	font-weight: 700;
	color: #999999;
}

.form-inline {
	font-size: 0.813rem;
}

.form-inline a:hover { /*클릭하지 않은 링크*/
	text-decoration: none;
}

.form-inline a img {
	vertical-align: middle;
}

.option select {
	font-size: 1.1em;
	font-weight: 700;
	color: gray;
}

.table th {
	font-family: 'Nanum Gothic', sans-serif;
	font-size: 0.938em;
	font-weight: 700;
	color: #999999;
}

.table td {
	font-family: 'Gothic A1', sans-serif;
	font-size: 0.875em;
	font-weight: 600;
}

.table td a {
	font-family: 'Nanum Gothic', sans-serif;
	font-size: 1.0em;
	font-weight: 700;
	text-decoration: none;
	color: black;
}

.table .etc span {
	font-family: 'Gothic A1', sans-serif;
	font-size: 0.813em;
	font-weight: 600;
}

th, td {
	text-align: left;
}

img {
	width: 0 auto;
}
</style>
<!--추가 css-->
<link href="${pageContext.request.contextPath}/resources/css/bootstrap.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/profile.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/style-2.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/font.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/swiper.min.css" rel="stylesheet" type="text/css">

<!-- Google Fonts CDM 방식 사용 -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Dongle:wght@300&family=East+Sea+Dokdo&family=Open+Sans+Condensed:wght@300&display=swap" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Playfair+Display:ital,wght@0,400;0,500;0,600;0,700;1,400;1,500;1,600;1,700|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&display=swap" rel="stylesheet">

<!-- 부트스트랩 최신버전 사용하기 ㅎㅎ -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
  
<!--//추가 css-->

<!--변경전 기존css-->
<!--
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/profile.css">
-->
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script> -->

<!--추가 js-->
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.3.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/popper.min.js"></script>

<!-- Swiper JS -->
<script src="${pageContext.request.contextPath}/resources/js/swiper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-1.9.1.min.js"></script>
<!-- 구글 icon -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css">

<script type="text/javascript">
	function selectedOptionCheck() {
		$("#type > option[value=${param.type}]").attr("selected", "true");
	}

	function moveAction(where) {
		switch (where) {
		case 1:
			location.href = "write";
			break;

		case 2:
			location.href = "list";
			break;
		}
	}
</script>
</head>

<body onload="selectedOptionCheck()">
	<header class="header bg-light">
		<nav class="navbar sticky-top navbar-expand-lg navbar-light bg-light">
			<div class="container">
				<a class="navbar-brand" href="/">
					<img src="${pageContext.request.contextPath}/resources/img/somcoco_icon.png" width="74.31" height="56" class="d-inline align-text-top" alt="logo">
					<span class="d-inline-block align-text-top">Somcoco</span>
				</a>
				<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent1" aria-controls="navbarSupportedContent1" aria-expanded="false" aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>

				<div class="collapse navbar-collapse" id="navbarSupportedContent1">

					<ul class="navbar-nav nav-width mr-auto">
						<li class="nav-item mr-2">
							<a class="nav-link" href="${pageContext.request.contextPath}/member/intro" role="button">솜코코</a>
						</li>
						<li class="dropdown">
							<a class="nav-link dropdown-toggle mr-2" href="#" id="navbarDropdown1" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">뉴스</a>
							<div class="dropdown-menu" aria-labelledby="navbarDropdown1">
								<a class="dropdown-item" href="${pageContext.request.contextPath}/board/notice">공지사항</a>
								<a class="dropdown-item" href="${pageContext.request.contextPath}/board/evnet">이벤트</a>
							</div>
						</li>
						<li class="nav-item dropdown">
							<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown1-2" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">커리어</a>
							<div class="dropdown-menu" aria-labelledby="navbarDropdown1">
								<a class="dropdown-item" href="${pageContext.request.contextPath}/board/activity">대외활동</a>
								<a class="dropdown-item" href="${pageContext.request.contextPath}/board/contest">공모전</a>
								<a class="dropdown-item" href="${pageContext.request.contextPath}/board/employment">취업정보</a>
								<a class="dropdown-item" href="${pageContext.request.contextPath}/board/campustips">대학꿀팁</a>
							</div>
						</li>
						<li class="nav-item mr-2">
							<a class="nav-link" href="${pageContext.request.contextPath}/board/list" role="button">커뮤니티</a>
						</li>
						<li class="nav-item mr-2">
							<a class="nav-link" href="${pageContext.request.contextPath}/board/cs" role="button">고객센터</a>
						</li>
						<li class="nav-serch float-right">
							<form class="form-inline my-2 my-lg-0 main-serch">
								<input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
								<button class="btn my-2 my-sm-0 btn-sm" type="submit">
									<i class="fa fa-search fa-1x"></i>
								</button>
							</form>
						</li>


						<li class="nav-logright">
							<ul class="nav navbar-right nav-log">
								<%
									//아이디 세션이 없을경우 로그인
									if (session.getValue("userid") == null) {
								%>
								<li>
									<a class="text-secondary" href="${pageContext.request.contextPath}/member/join">
										<i class="fas fa-user-alt"></i> 회원가입 &nbsp;|
									</a>
								</li>
								<li>
									<a class="text-secondary" href="${pageContext.request.contextPath}/member/login">
										<i class="fas fa-lock"></i> 로그인
									</a>
								</li>

								<%
									// 세션에 아이디값이 있을경우 다른폼을 구성
									} else {
								%>
								<li class="dropdown">
									<a class="text-secondary dropdown-toggle" href="#" id="navbarDropdown2-1" role="button" data-toggle="dropdown" data-display="static" aria-haspopup="true" aria-expanded="false">
										<span class="text-secondary mr-2">${userName}님${loginUser.name}</span>
										<img src="<c:url value="/resources/img/${p_img}/"/>" alt="프로필사진" height="18" class="rounded-circle">
									</a>
									<div class="dropdown-menu my-dr dropdown-menu-lg-right" aria-labelledby="navbarDropdown1">
										<a class="dropdown-item" href="${pageContext.request.contextPath}/profile/myhome.do">마이페이지</a>
										<input type="hidden" name="userId" value="${loginUser.userId}">
										<a class="dropdown-item" href="${pageContext.request.contextPath}/proposal/proposalrec.do">제안서관리</a>
										<a class="dropdown-item" href="${pageContext.request.contextPath}/member/logout.do">로그아웃</a>
										<c:if test="${not empty admincode}">
											<a class="dropdown-item" href="${pageContext.request.contextPath}/member/adminlist.do">관리페이지</a>
										</c:if>
									</div>
								</li>
								<li>
									<a class="text-secondary" href="${pageContext.request.contextPath}/board/list.do">
										<img src="${pageContext.request.contextPath}/resources/images/svg/bell.svg" height="18">
									</a>
								</li>
								<%
									}
								%>
							</ul>

						</li>

					</ul>


				</div>
			</div>
		</nav>
	</header>
	<%-- <header class="header bg-light">
		<nav class="navbar sticky-top navbar-expand-lg navbar-light">
			<div class="container">
				<a class="navbar-brand mb-0 h1" href="/dressfi/">
					<img src="<%=request.getContextPath()%>/resources/images/svg/clothing-hanger.svg" class="d-inline-block align-top" alt="logo">
					<span class="d-inline-block align-bottom">DressFi</span>
				</a>
				<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>

				<div class="collapse navbar-collapse" id="navbarSupportedContent">
					<ul class="navbar-nav mr-auto">
						<li class="nav-item dropdown">
							<a class="nav-link dropdown-toggle" href="#" id="nbd_1" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">전문가 공간</a>
							<div class="dropdown-menu" aria-labelledby="nbd_1">
								<a class="dropdown-item" href="<%=request.getContextPath()%>/profile/design.do">디자이너</a>
								<a class="dropdown-item" href="<%=request.getContextPath()%>/profile/factory.do">공장</a>
								<a class="dropdown-item" href="<%=request.getContextPath()%>/profile/seller.do">도소매</a>
							</div>
						</li>
						<li class="nav-item dropdown">
							<a class="nav-link dropdown-toggle" href="#" id="nbd_2" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">커뮤니티</a>
							<div class="dropdown-menu" aria-labelledby="nbd_2">
								<a class="dropdown-item" href="<%=request.getContextPath()%>/board/knowhow.do">노하우</a>
								<a class="dropdown-item" href="<%=request.getContextPath()%>/board/qanda.do">Q&A</a>
							</div>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="<%=request.getContextPath()%>/board/list.do" role="button">공지사항</a>
						</li>
					</ul>

					<form class="form-inline my-2 my-lg-0">

						<%
							//아이디 세션이 없을경우 로그인
							if (session.getValue("userId") == null) {
						%>
						<a class="text-secondary mr-2" href="<%=request.getContextPath()%>/member/join.do">
							<i class="fas fa-user-alt"></i> 회원가입 |
						</a>
						<a class="text-secondary mr-2" href="<%=request.getContextPath()%>/member/login.do">
							<i class="fas fa-lock"></i> 로그인
						</a>
						<%
							// 세션에 아이디값이 있을경우 다른폼을 구성
							} else {
						%>
						<a class="text-secondary mr-2" href="#" data-toggle="tooltip" data-placement="bottom" title="알림">
							<img src="<%=request.getContextPath()%>/resources/images/svg/bell.svg">
						</a>
						<span class="text-secondary mr-2"> ${loginUser.name}님 </span>


						<ul class="navbar-nav mr-auto">
							<li class="nav-item dropdown">
								<a class="nav-link dropdown-toggle" href="#" id="nbd_3" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
									<img src="<c:url value="/resources/img/${loginUser.proimg}"/>" alt="프로필사진" class="rounded-circle">
								</a>
								<div class="dropdown-menu dropdown-menu-right" aria-labelledby="nbd_3">
									<a class="dropdown-item" href="<%=request.getContextPath()%>/profile/myhome.do?userId=${userId}">마이페이지</a>
									<a class="dropdown-item" href="#">제안서관리</a>
									<a class="dropdown-item" href="<%=request.getContextPath()%>/member/logout.do">로그아웃</a>
								</div>
							</li>
						</ul>
						<%
							}
						%>
					</form>
					<form:form action="list.do" modelAttribute="searchVO" method="get" class="option form-inline my-2 my-lg-0">
						<select class="form-control mr-sm-2" id="type" name="type">
							<option value="title">제목</option>
							<option value="content">내용</option>
							<option value="writerId">작성자</option>
						</select>
						<input class="form-control mr-sm-2" type="text" id="keyword" name="keyword" placeholder="Search" value="<%if (request.getParameter("keyword") != null) {
					out.print(request.getParameter("keyword"));
				} else {
					out.print("");
				}%>" />
						<button class="btn btn-outline-secondary my-2 my-sm-0" type="submit">Search</button>
					</form:form>
					
				</div>
			</div>
		</nav>
	</header> --%>
	<%-- <header class="bg-light">
		<nav class="navbar navbar-expand-lg navbar-light bg-light">
			<div class="container">
				<a class="navbar-brand" href="list.do">SpringBoard</a>
				<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarTogglerDemo02" aria-controls="navbarTogglerDemo02" aria-expanded="false" aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>

				<div class="collapse navbar-collapse" id="navbarTogglerDemo02">
					<ul class="navbar-nav mr-auto mt-2 mt-lg-0">
						<c:if test="${empty userId }">
							<li class="nav-item">
								<a class="nav-link" href="../member/login.do">로그인 </a>
							</li>
						</c:if>
						<c:if test="${!empty userId }">
							<li class="nav-item">
								<a class="nav-link" href="../member/logout.do">로그아웃</a>
							</li>
						</c:if>
						<c:if test="${!empty userId}">
							<li class="nav-item">
								<a class="nav-link" href="../member/editUser.do" tabindex="-1" aria-disabled="true">정보수정</a>
							</li>
						</c:if>
					</ul>
					<form:form action="list.do" modelAttribute="searchVO" method="get" class="option form-inline my-2 my-lg-0">
						<select class="form-control mr-sm-2" id="type" name="type">
							<option value="title">제목</option>
							<option value="content">내용</option>
							<option value="writerId">작성자</option>
						</select>
						<input class="form-control mr-sm-2" type="text" id="keyword" name="keyword" placeholder="Search" value="<%if (request.getParameter("keyword") != null) {
					out.print(request.getParameter("keyword"));
				} else {
					out.print("");
				}%>" />
						<button class="btn btn-outline-secondary my-2 my-sm-0" type="submit">Search</button>
					</form:form>
				</div>
			</div>
		</nav>
	</header> --%>

	<section class="mt-4 mx-3">
		<div class="container">
			<div class="row">
				<div class="col-12 mb-2">
					<div class="d-flex justify-content-between">
						<h4 class="font-weight-bold">커뮤니티</h4>
						<a class="btn btn-light btn-sm text-info border border-info rounded-pill pt-2" href="${pageContext.request.contextPath}/board/write">
							<i class="fas fa-pen"></i>
							<span> 글쓰기</span>
						</a>
					</div>
				</div>
				<!-- 검색창  -->
				<div class="col-12 mb-2 bg-light">
					<div class="d-flex justify-content-center mb-2  " style="height: 100px;">
						<form:form action="list.do" modelAttribute="searchVO" method="get" class="option form-inline my-2 my-lg-0">
							<div class="form-group">
								<select class="form-control mr-sm-2" id="type" name="type">
									<option value="title">제목</option>
									<option value="content">내용</option>
									<option value="writerId">작성자</option>
								</select>
								<input class="form-control border mr-sm-2" type="text" id="keyword" name="keyword" style="width: 600px;" placeholder="통합검색" value="<%if (request.getParameter("keyword") != null) {
					out.print(request.getParameter("keyword"));
				} else {
					out.print("");
				}%>" />
								<button class="btn btn-outline-secondary my-2 my-sm-0" type="submit">
									<i class="fa fa-search fa-1x"></i>
								</button>
							</div>
						</form:form>
					</div>
					<!-- //검색창  -->
				</div>
			</div>
			<div>
				<table class="table table-hover">
					<thead class="thead-dark">
						<tr class="text-left">
							<th>번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>댓글수</th>
							<th>조회수</th>
							<th>좋아요</th>
							<th>작성일</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="board" items="${boardList}">
							<tr>
								<td class="idx">${board.bno}</td>
								<td class="subject">
									<c:if test="${board.replycnt >= 10}">
										<img src="${pageContext.request.contextPath}/resources/img/hit.jpg" />
									</c:if>
									<a href="view?bno=${board.bno}">${board.title}</a>
								</td>
								<td class="writer">${board.writerId}</td>
								<td class="comment">${board.replycnt}</td>
								<td class="hitcount">${board.viewcnt}</td>
								<td class="recommendcount">${board.recommendcnt}</td>
								<td class="writeDate">${board.regDate}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>

		</div>
	</section>
	<section>
		<%-- 		<nav aria-label="Page navigation example">
			<ul class="pagination">
				<li class="page-item">
					<a class="page-link" href="#" aria-label="Previous">
						<span aria-hidden="true">&laquo;</span>
					</a>
				</li>
				<li class="page-item">
					<a class="page-link" href="#"><br /> ${pageHttp} <br /> <br /></a>${pageHttp} 
				</li>

				<li class="page-item">
					<a class="page-link" href="#" aria-label="Next">
						<span aria-hidden="true">&raquo;</span>
					</a>
				</li>
			</ul>
		</nav> --%>
		<div class="d-flex justify-content-center mb-3">
			<strong>${pageHttp}</strong>
		</div>
		<!-- 		<div class="d-flex justify-content-center">
			<input type="button" value="목록" class="btn btn-outline-secondary mr-1" onclick="moveAction(2)" />
			<input type="button" value="쓰기" class="btn btn-outline-secondary" onclick="moveAction(1)" />
		</div> -->
	</section>

	<!--푸터-->
	<!-- <footer class="footer  bg-light container-fluid">
		<div class="container">
			<div class="row">
				<div class="">
					<p class="small">
						<strong>고객센터 &gt;</strong>
					</p>
					<div class="sns-fill">
						<ul class="nav nav-pills float-right">
							<li class="nav-item">
								<a class="nav-link" href="#">
									<i class="fab fa-facebook"></i>
								</a>
							</li>
							<li class="nav-item">
								<a class="nav-link" href="#">
									<i class="fab fa-twitter"></i>
								</a>
							</li>
							<li class="nav-item">
								<a class="nav-link" href="#">
									<i class="fab fa-google-plus-g"></i>
								</a>
							</li>
						</ul>
					</div>
					<p>
						<label style="font-size: 1.7rem">
							<strong>1544-1004</strong>
						</label>
						<br>
						<span style="font-size: 0.9rem; margin-top: -20px;">평일 10:00~18:00(점심시간 12:00~13:00/주말&공휴일 제외)</span>
					</p>
					<address class="small">상호명(주)0000 이메일0000@0000.net 대표이사 0000 사업자등록번호0000-0000-0000 통신판매업신고번호제2018-서울서초-0000호 주소서울특별시 서초구 서초대로 0000</address>

					<p>Copyright © 2019 by DressFi Republic</p>
				</div>
				<div class="text-right">
					<!-- 					<button class="btn btn-secondary" onClick="location.href='/member/adminlogin.do';">
						<span class="sr-only">관리자</span>
					</button> -->
					<!--  <a class="" href="${pageContext.request.contextPath}/admin/adminlogin.do">
						<span class="small">관리자</span>
					</a>
				</div>
			</div>
		</div>
	</footer>-->
</body>
</html>