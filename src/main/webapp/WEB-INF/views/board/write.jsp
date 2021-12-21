<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>새 글 쓰기</title>
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
	width: 24px;
	height: 24px;
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

.table th {
	font-family: 'Nanum Gothic', sans-serif;
	font-size: 0.938em;
	font-weight: 700;
}

.table td span {
	font-family: 'Gothic A1', sans-serif;
	font-size: 0.813em;
	font-weight: 500;
	color: gray;
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
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<!-- 구글 icon -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script type="text/javascript">
	function writeFormCheck() {
		if ($("#title").val() == null || $("#title").val() == "") {
			alert("제목을 입력해 주세요!");
			$("#title").focus();
			return false;
		}

		if ($("#content").val() == null || $("#content").val() == "") {
			alert("내용을 입력해 주세요!");
			$("#content").focus();
			return false;
		}
		return true;
	}
</script>
</head>

<body class="">
	<div class="container mt-5">
		<h3 class="text-center">글 작성</h3>
		<form action="write" method="post" onsubmit="return writeFormCheck()" enctype="multipart/form-data">
			<table class="table table-bordered">
				<tr class="thead-light">
					<th class="tcenter ">
						<label for="subject">제목</label>
					</th>
					<td>
						<input type="text" id="title" name="title" class="form-control" />
						<input type="hidden" id="writer" name="writer" value="${userName}" />
						<!-- 세션변수 -->
						<input type="hidden" id="writerId" name="writerId" value="${userid}" />
					</td>
				</tr>
				<tr class="thead-light">
					<th class="tcenter">
						<label for="content">내용</label>
					</th>
					<td>
						<textarea id="content" name="content" rows="8" class="form-control w-100"></textarea>
					</td>
				</tr>
				<tr class="thead-light">
					<th class="tcenter ">
						<label for="file">첨부파일</label>
					</th>
					<td>
						<input type="file" id="file" name="file" multiple />
						<span class="date">&nbsp;&nbsp;*&nbsp;임의로 파일명이 변경될 수 있습니다.</span>
					</td>
				</tr>
			</table>
			<br />
			<div class="row justify-content-center">
				<input type="reset" value="재작성" class="btn btn-outline-secondary" />
				<input type="submit" value="확인" class="btn btn-outline-secondary mx-1" />
				<input type="button" value="목록" class="btn btn-outline-secondary" onclick="location.href='list';" />
			</div>
		</form>
	</div>
</body>
</html>