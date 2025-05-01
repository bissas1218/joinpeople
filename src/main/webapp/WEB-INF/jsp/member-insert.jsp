<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<link rel="stylesheet" href="/assets/css/main.css" />
	<script src="/assets/js/jquery.min.js"></script>
</head>

<script type="text/javascript">

	function memberInsertFrmSubmit(){
		console.log('--------------memberInsertChk-------------');	
		
		if($("#identity").val() === ''){
			$("#identityWarning").show();
			$("#identity").focus();
			return false;
		}
		
		if($("#password").val() === ''){
			$("#passwordWarning").show();
			$("#password").focus();
			return false;
		}
		
		return true;
	}
	
</script>

<body class="homepage is-preload">
		<div id="page-wrapper">

			<!-- Header -->
				<section id="header">

					<!-- Logo -->
						<h1><a href="/JoinList">JOIN PEOPLE</a></h1>

					<!-- Nav -->
						<nav id="nav">
							<ul>
								<li class="current"><a href="/JoinList">Home</a></li>
								<li><a href="left-sidebar.html">로그인</a></li>
								<li><a href="/MemberInsert">회원가입</a></li>
								<li><a href="right-sidebar.html">정보수정</a></li>
								<li><a href="no-sidebar.html">공지사항</a></li>
								<li><a href="no-sidebar.html">내방관리</a></li>
								<li><a href="no-sidebar.html">문의하기</a></li>
								<li><a href="no-sidebar.html">탈퇴하기</a></li>
							</ul>
						</nav>

					<!-- Intro -->
						<section id="intro" class="container">
						
							<h2>회원가입</h2>
						
							<div class="col-4 col-12-medium">
							<section class="first">
								<form method="get" action="/memberInsert" name="memberInsertFrm" id="memberInsertFrm" onsubmit="return memberInsertChk();" action="MemberInsert">
									<div class="row">
										
										<!-- 아이디 -->
										<div class="col-12 col-12-small">
											<input type="text" name="identity" id="identity" placeholder="아이디" maxlength="10" />
											<p id="identityWarning" class="warning" style="display:none;">아이디를 입력하세요!</p> 
										</div>
										
										<!-- 비밀번호 -->
										<div class="col-12 col-12-small">
											<input type="password" name="password" id="password" placeholder="비밀번호" maxlength="20" />
											<p id="passwordWarning" class="warning" style="display:none;">비밀번호를 입력하세요!</p> 
										</div>
										
									</div>
									<input type="hidden" name="searchFrmSubmit" id="searchFrmSubmit" value="true" />
								</form>
								</section>
							</div>
							
							<footer>
								<ul class="actions">
									<li><a href="javascript:memberInsertFrmSubmit();" class="button large">가입하기</a></li>
									<li><a href="/JoinInsert" class="button alt large">최소하기</a></li>
								</ul>
							</footer>
							
						</section>

				</section>


			<!-- Footer -->
				<section id="footer">
					<div class="container">
						<div class="row">
							
							<div class="col-12">

								<!-- Copyright -->
									<div id="copyright">
										<ul class="links">
											<li>&copy; Untitled. All rights reserved.</li><li>Design: <a href="http://html5up.net">HTML5 UP</a></li>
										</ul>
									</div>

							</div>
						</div>
					</div>
				</section>

		</div>

		<!-- Scripts -->
			<script src="/assets/js/jquery.min.js"></script>
			<script src="/assets/js/jquery.dropotron.min.js"></script>
			<script src="/assets/js/browser.min.js"></script>
			<script src="/assets/js/breakpoints.min.js"></script>
			<script src="/assets/js/util.js"></script>
			<script src="/assets/js/main.js"></script>

	</body>
</html>