<form id="fregisterform" name="joinForm" method=post  Action='editUser' onsubmit='return Check_Form()' >

<table width="600px" cellpadding="0" cellspacing="0" align=center>
  <!-- <tr><td><img src="${pageContext.request.contextPath}/resources/img/cont_joinform.gif" border=0></td></tr>  -->
  <tr><td><span class="member">MEMBER</span><span class="join">&nbsp;Update&nbsp;</span>

  <%if( request.getAttribute("errMsg") != null) { %>
		  <span class="ecomment">| * 정보수정에 실패하였습니다! 다시 진행하여 주십시오. </span></td></tr>
  <% } else{ %>
	    <span class="comment">| * 아래 회원정보를 수정하여 주십시오.</span></td></tr>
  <% } %>

</table>

<table width="600px" cellpadding="0" cellspacing="0" align=center class="table01">
<colgroup>
  <col width="150">
  <col width="*">
</colgroup>
  <tr>
    <td class="tle">아이디</td>
	<td class="cont">
	<div class="col-md-4">
	<input  maxlength=20 size=20 id='reg_mb_id' name="userid" class="ed" required readonly value="${userVO.userid}" />
	<span id="message"></span></div>
	<p class="cmt mg_t5"> * 영문자, 숫자, _ 만 입력 가능. 최소 3자이상 입력하세요.</p>
	<input type="hidden" id="flag" name="flag" value="false">
	</td>
  </tr>
  <tr>
    <td class="tle">비밀번호</td>
	<td class="cont"><input class=ed type=password name="passwd" size=20 maxlength="20" required  placeholder="password-1" value=""></td>
  </tr>
  <tr>
    <td class="tle">비밀번호 확인</td>
	<td class="cont"><input class=ed type=password name="passwd_re" size=20 maxlength=20 required placeholder="password-2" value=""></td>
  </tr>
  <tr>
    <td class="tle">이름</td>
	<td class="cont"><input name="name" placeholder="name" class="ed2" class="ed" required value="${userVO.name}" readonly > <span class='cmt'>* 공백없이 한글만 입력 가능</span>
	</td>
  </tr>
  <tr>
    <td class="tle">E-mail</td>
	<td class="cont">
	<input class=ed type=text id='reg_mb_email' name='email' size=38 maxlength=100  required  value="${userVO.email}">
	<span id='msg_mb_email'></span>
	</td>
  </tr>
  <tr>
    <td class="tle">생년월일</td>
	<td class="cont"><input class='ed' type='text' id='birth' name='birthday' size='10' maxlength='10' minlength='10' required value="${userVO.birthday}"></td>
  </tr>
  <tr>
    <td class="tle">전화번호</td>
	<td class="cont"><input class=ed type=text name='phone' size=21 maxlength=20 required placeholder='전화번호' value="${userVO.phone}"></td>
  </tr>
  <tr>
    <td class="tle">주소</td>
	<td class="cont">
	<table width="330" border="0" cellspacing="0" cellpadding="0" class="nobd">
	  <tr>
	    <td height="25" class="nobd">
		<input class=ed type=text id="zip" name="zip" required value="${userVO.zip}">  
		
		<a href="javascript:;" Onclick='DaumPostcode()'><img src="${pageContext.request.contextPath}/resources/img/btn_postsearch.gif" border=0 align=absmiddle></a>
		</td>
	  </tr>
	  <tr>
	    <td height="25" colspan="2" class="nobd"><input class=ed type=text id="addr1" name="addr1" size=60  required value="${userVO.addr1}"></td>
	  </tr>
	  <tr>
	    <td height="25" colspan="2" class="nobd"><input class=ed type=text id='addr2' name='addr2' size=60 required value="${userVO.addr2}"></td>
	  </tr>
	</table>
	</td>
  </tr>
</table>

<div align=center class="mg_t20"><input type="submit" class="myButton" value="정보수정"  ></div>
</form>