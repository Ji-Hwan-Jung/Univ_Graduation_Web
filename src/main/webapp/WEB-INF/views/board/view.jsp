<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>글 보기: ${board.title}</title>
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
	border: 1px solid #000;
}

.navbar img {
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
	/* 	width: 2.0em;
	height: 2.0em; */
}

.snschat img {
	width: 2.0em;
	height: 2.0em;
}

.table th {
	font-family: 'Nanum Gothic', sans-serif;
	font-size: 0.938em;
	font-weight: 700;
}

.table td span {
	font-family: 'Gothic A1', sans-serif;
	font-size: 0.938em;
	font-weight: 600;
}

.table td a {
	font-family: 'Nanum Gothic', sans-serif;
	font-size: 0.938em;
	font-weight: 700;
	text-decoration: none;
	color: #4374D9;
}

.table .etc span {
	font-family: 'Gothic A1', sans-serif;
	font-size: 0.813em;
	font-weight: 600;
}

.userimg {
	width: 13.0em;
	height: 13.0em;
}

.profileimg img {
	width: 8em;
	height: 8em;
}

img {
	width: 0 auto;
}

.tcenter {
	text-align: center;
}
/* .commentView th {
	height: 25px;
	background-color: #b0e0e6;
	padding: 5px 5px 5px 5px;
}

.commentView td.writer {
	width: 20%;
	background-color: white;
	padding: 5px 10px 5px 10px;
}

.commentView td.content {
	width: 80%;
	background-color: white;
	padding: 5px 10px 5px 10px;
}

textarea.commentForm {
	width: 80%;
	height: 50px;
}

input.commentBt {
	margin-left: 2%;
	width: 15%;
} */
</style>
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
구글 icon
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script> -->
<!--추가 css-->
<link href="${pageContext.request.contextPath}/resources/css/bootstrap.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/profile.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/style-2.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/font.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/swiper.min.css" rel="stylesheet" type="text/css">
<!--//추가 cc-->

<!--변경전 기존css-->

<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"> -->
<%-- <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/profile.css"> --%>

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
	function errCodeCheck() {
		var errCode =
<%=request.getParameter("errCode")%>
	;
		if (errCode != null || errCode != "") {
			switch (errCode) {
			case 1:
				alert("댓글 내용이 없습니다!");
				break;
			case 2:
				alert("이미 추천하셨습니다!");
				break;
			case 3:
				alert("자기 글은 추천할 수 없습니다.!");
				break;
			case 4:
				alert("로그인하셔야 추천할 수 있습니다.!");
				break;
			}
		}
	}

	function deleteReply(rno, bno) {
		if (confirm("선택하신 댓글을 삭제하시겠습니까?")) {
			location.href = "deleteReply?rno=" + rno + "&bno=" + bno;
		}
	}

	function recommendReply(rno, bno) {
		if (confirm("선택하신 댓글을 추천하시겠습니까?")) {
			location.href = "recommendReply?rno=" + rno + "&bno=" + bno;
		}
	}

	function moveAction(where) {
		switch (where) {
		case 1:
			if (confirm("글을 삭제하시겠습니까?")) {
				location.href = "delete?bno=${board.bno}";
			}
			break;

		case 2:
			if (confirm("글을 수정하시겠습니까?")) {
				location.href = "modify?bno=${board.bno}";
			}
			break;

		case 3:
			location.href = "list";
			break;

		case 4:
			if (confirm("글을 추천하시겠습니까?")) {
				location.href = "recommend?bno=${board.bno}";
			}
			break;
		}
	}
</script>
<script>
	//tooltip script
	$(document).ready(function() {
		/* $('[data-toggle="tooltip"]').tooltip(); */

		$("#imgInp").change(function() {
			//alert(this.value); 
			//선택한 이미지 경로 표시 
			readURL(this);
		});
	});

	function readURL(input) {
		if (input.files && input.files[0]) {
			var reader = new FileReader(); //파일을 읽기 위한 FileReader객체 생성 
			reader.onload = function(e) { //파일 읽어들이기를 성공했을때 호출되는 이벤트 핸들러 
				$('#blah').attr('src', e.target.result);
				$('#img').css('display', 'none');
				$('#upimg').css('display', 'block');
				$('#h_fileloc').val(e.target.result);
				//이미지 Tag의 SRC속성에 읽어들인 File내용을 지정 
				//(아래 코드에서 읽어들인 dataURL형식) 
			}
			reader.readAsDataURL(input.files[0]);
			//File내용을 읽어 dataURL형식의 문자열로 저장 
		}
	}//readURL()-- //file 양식으로 이미지를 선택(값이 변경) 되었을때 처리하는 코드
</script>
</head>
<body class="" onload="errCodeCheck()">
	<!-- <span id="count" class="badge bg-theme"></span> 안읽은 제안서 갯수 출력-->
	<!-- <header class="header bg-light">
		<nav class="navbar sticky-top navbar-expand-lg navbar-light bg-light">
			<div class="container">
				<a class="navbar-brand" href="/dressfi/">
					<img src="${pageContext.request.contextPath}/resources/images/svg/clothing-hanger.svg" width="35" class="d-inline align-text-top" alt="logo">
					<span class="d-inline-block align-text-top">DressFi</span>
				</a>
				<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent1" aria-controls="navbarSupportedContent1" aria-expanded="false" aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>

				<div class="collapse navbar-collapse" id="navbarSupportedContent1">

					<ul class="navbar-nav nav-width mr-auto">
						<li class="nav-item mr-2">
							<a class="nav-link" href="${pageContext.request.contextPath}/member/intro.do" role="button">DressFi 소개</a>
						</li>
						<li class="dropdown">
							<a class="nav-link dropdown-toggle mr-2" href="#" id="navbarDropdown1" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">전문가 공간</a>
							<div class="dropdown-menu" aria-labelledby="navbarDropdown1">
								<a class="dropdown-item" href="${pageContext.request.contextPath}/profile/design.do">디자이너</a>
								<a class="dropdown-item" href="${pageContext.request.contextPath}/profile/factory.do">공장</a>
								<a class="dropdown-item" href="${pageContext.request.contextPath}/profile/seller.do">도소매</a>
							</div>
						</li>
						<li class="nav-item dropdown">
							<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown1-2" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">커뮤니티</a>
							<div class="dropdown-menu" aria-labelledby="navbarDropdown1">
								<a class="dropdown-item" href="${pageContext.request.contextPath}/board/knowhow.do">노하우</a>
								<a class="dropdown-item" href="${pageContext.request.contextPath}/board/list.do">Q&A</a>
							</div>
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
									if (session.getValue("userId") == null) {
								%>
								<li>
									<a class="text-secondary" href="${pageContext.request.contextPath}/member/joinSelect.do">
										<i class="fas fa-user-alt"></i> 회원가입 &nbsp;|
									</a>
								</li>
								<li>
									<a class="text-secondary" href="${pageContext.request.contextPath}/member/login.do">
										<i class="fas fa-lock"></i> 로그인
									</a>
								</li>

								<%
									// 세션에 아이디값이 있을경우 다른폼을 구성
									} else {
								%>
								<li class="dropdown">
									<a class="text-secondary dropdown-toggle" href="#" id="navbarDropdown2-1" role="button" data-toggle="dropdown" data-display="static" aria-haspopup="true" aria-expanded="false">
										<span class="text-secondary mr-2">${userName}님</span>
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
	</header> -->
	<section class="mt-2">
		<div class="container">

			<table class="table table-borderless">
				<tr class="tcenter thead-light">
					<th colspan="4">
						<h4 class="font-weight-bold">커뮤니티</h4>
					</th>
				</tr>
				<tr class="tcenter border-bottom">
					<th>
						<h6 class="font-weight-bold text-info">작성자</h6>
					</th>
					<td class="text-left">
						<span>${board.writerId}</span>
					</td>
				</tr>
				<tr class="tcenter border-bottom">
					<th class="">
						<span>첨부파일</span>
					</th>
					<td colspan="4" align="left">
						<c:forEach var="file" items="${fileList}">
							<a href="filedown?fileName=${file.ofilename}" class="fileview">
								<%-- <img id="blah" src="<c:url value="/resources/uploadfile/${file.ofilename}"/>"  style="width: 50px; height: 50px;" /> --%>
								<font size="2px">${file.ofilename}</font> <font size="2px">(${file.filesize} byte)</font><br>
							</a>
						</c:forEach>
						<c:if test="${empty fileList}">
							<font color="#A6A6A6" size="2px"> 첨부된 파일이 없습니다. </font>
						</c:if>
					</td>
				</tr>
				<tr class="text-left">
					<th colspan="4">
						<span class="" style="font-size: 1.5em">${board.title}</span>
					</th>
				</tr>
				<tr class="text-left">
					<td colspan="4">
						<span>${board.content}</span>
						<c:if test="${board.writerId != userId}">
							<div class="d-flex justify-content-end mt-5">
								<button type="button" class="btn btn-light active mr-1" onclick="moveAction(4)">
									<i class="fas fa-heart"></i>&nbsp;좋아요 &nbsp;&nbsp;${board.recommendcnt}
								</button>
								<button type="button" class="btn btn-light mr-1" disabled="disabled">
									<i class="fas fa-eye"></i>&nbsp;조회수&nbsp;&nbsp;${board.viewcnt}
								</button>
							</div>
							<%-- 							<p class="tcenter">
								<a href="#" onclick="moveAction(4)">
									<i class="fas fa-thumbs-up"></i>&nbsp;좋아요 ${board.recommendcnt}
								</a>
								<span>
									<small class="text-primary">:${message}</small>
								</span>
							</p> --%>
						</c:if>
					</td>
				</tr>

				<tr class="text-right thead-light border-bottom">
					<td colspan="4">
						<span>
							<small class="text-muted font-weight-bold">${board.regDate}</small>
						</span>
					</td>
				</tr>
			</table>
		</div>
	</section>
	<section>
		<div class="container">
			<table class="table table-borderless mt-4">
				<tr class="text-left border-bottom">
					<th colspan="2">
						<h5 class="font-weight-bold">댓글</h5>
					</th>
				</tr>
				<tr class="tcenter">
					<td class="writer">
						<strong>댓글 쓰기</strong>
					</td>
					<td class="content">
						<form action="writeReply" method="post">
							<input type="hidden" id="writerId" name="writerId" value="${userName}" />
							<input type="hidden" id="bno" name="bno" value="${board.bno}" />
							<div class="form-inline">
								<textarea id="content" name="content" rows="1" class="form-control rounded w-75"></textarea>
								<input type="submit" value="확인" class="btn btn-secondary ml-2" />
							</div>
						</form>
					</td>
				</tr>
				<c:forEach var="comment" items="${replyList}">
					<tr class="tcenter ">
						<td class="font-weight-bold">
							<p>${comment.writerId}
								<c:if test="${comment.writerId == userName}">
									<br />
									<a href="#" onclick="deleteReply(${comment.rno}, ${comment.bno})">
										<span>
											<small class="text-danger font-weight-bold">삭제</small>
										</span>
									</a>
								</c:if>
							</p>
						</td>
						<td class="content" align="left">

							<p class="text-justify">${comment.content}</p>

							<div class="d-flex justify-content-start">
								<c:if test="${comment.writerId != userName}">
									<div>
										<a class="mr-2" href="#" onclick="recommendReply(${comment.rno}, ${comment.bno})">
											<small><i class="fas fa-heart"></i>&nbsp;좋아요 &nbsp;${comment.recommendcnt}</small>
										</a>
										<%-- 							<span>
										<small class="text-justify">:${message}</small>
									</span> --%>
									</div>
								</c:if>
								<div>
									<span>
										<small class="date text-muted font-weight-bold">${comment.regDate}</small>
									</span>
								</div>
							</div>


						</td>
					</tr>
				</c:forEach>
			</table>

			<div class="d-flex justify-content-end mx-3 border-top">
				<c:choose>
					<c:when test="${board.writerId == userId}">
						<div class="mt-2">
							<input type="button" value="삭제" class="btn btn-outline-secondary" onclick="moveAction(1)" />
							<input type="button" value="수정" class="btn btn-outline-secondary mx-1" onclick="moveAction(2)" />
							<input type="button" value="목록" class="btn btn-outline-secondary" onclick="moveAction(3)" />
						</div>
					</c:when>
					<c:otherwise>
						<div class="mt-2">
							<input type="button" value="목록" class="btn btn-outline-secondary" onclick="moveAction(3)" />
						</div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</section>
	<!--푸터-->
	<!-- <footer class="footer bg-light container-fluid">
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
					<!-- <a class="" href="${pageContext.request.contextPath}/admin/adminlogin.do">
						<span class="small">관리자</span>
					</a>
				</div>
			</div>
		</div>
	</footer>  -->
</body>
</html>