<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${pageContext.request.contextPath}/resources/css/board.css" rel="stylesheet" type="text/css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<title>글 수정 : ${board.title}</title>

<script type="text/javascript">
	function writeformCheck() {
		if ($("#title".val() == null || $("#title").var() == ""){
			alert("제목을 입력해 주세요!");
			$("#title").focus();
			return false;
		}
		if ($("#content".val() == null || $("#content").var() == ""){
			alert("내용을 입력해 주세요!");
			$("content").focus();
			return false;
		}
		return true;
	}
</script>

</head>
<body>
	<div class="wrapper">
		<h3>글 수정</h3>
		<form action="modify" method="post" onsubmit="return writeformCheck()" enctype="multipart/form-data">
			<table class="boardWrite">
				<tr>
					<th>제목</th>
					<td align="left">
						<input type="text" id="title" name="title" class="boardSubject" value="${board.title}"/>
						<input type="hidden" id="writer" name="writer" value="${username}" /> 	<!– 세션변수 ->
						<input type="hidden" id="writerId" name="writerId" value="${userid}" />
						<input type="hidden" id="bno" name="bno" value="${board.bno}" />
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td align="left"><textarea id="content" name="content" class="boardContent">${board.content}</textarea></td>			
				</tr>
				<tr>
					<th><label for="file">첨부파일</label></th>
					<td align="left">
						<c:forEach var="file" items="${fileList}">	     
						     <p>  <input type="checkbox" name="fileno" value="<c:out value="${file.fno}"/>">
						     <c:out value="${file.ofilename}"/> <c:out value="(${file.filesize} byte)"/><span class="date">&nbsp;&nbsp;*&nbsp; ✔-삭제</span>
						         </p> 
					    </c:forEach>
					    <c:if test="${empty fileList}">
					         <font color="#A6A6A6" size="2px"> 첨부된 파일이 없습니다. </font>
					    </c:if>
					</td>			
				</tr>	
				<tr>
					<th><label for="file">파일수정</label></th>
					<td align="left"><input type="file" id="file" name="file" multiple /><span class="date">&nbsp;&nbsp;*&nbsp;파일명이 변경될 수 있습니다.</span></td>			
				</tr>	
		
			</table>
		
			<br />
			<input type="reset" value="재작성" class="writeBt"/>
			<input type="submit" value="확인" class="writeBt"/>	
		</form>
	</div>
</body>
</html>