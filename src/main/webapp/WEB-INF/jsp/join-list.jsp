<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<!DOCTYPE HTML>
<!--
	Dopetrope by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
	<head>
		<title>Dopetrope by HTML5 UP</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="/assets/css/main.css" />
		<script src="/assets/js/jquery.min.js"></script>
		
<script type="text/javascript">

$(document).ready(function() {
	
	$('input[name="search-area"]').change(function(){
		//console.log('search-area-change');
		var value = $(this).val();
		var checked = $(this).prop('checked');
		var $label = $(this).next();
		
		//console.log(value + ', ' + checked + ', ' + $label);
		
		if(value === 'all' && checked){ // 전국에 체크
			$('input[name="search-area"]').each(function() {
				//console.log($(this).val());
				if($(this).val() != 'all'){
					$(this).prop('checked', false);
				}
			});
		}else if(value === 'all' && !checked){
			
		}else if(value != 'all'){
			$("#search-area-all").prop('checked', false);
		}
	});
});

</script>
		
	</head>
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
								<li><a href="right-sidebar.html">정보수정</a></li>
								<li><a href="no-sidebar.html">공지사항</a></li>
								<li><a href="no-sidebar.html">내방관리</a></li>
								<li><a href="no-sidebar.html">문의하기</a></li>
								<li><a href="no-sidebar.html">탈퇴하기</a></li>
							</ul>
						</nav>

					<!-- Intro -->
						<section id="intro" class="container">
						
							<h2>조인방 목록</h2>
						
							<div class="col-4 col-12-medium">
							<section class="first">
								<form method="post" action="#">
									<div class="row">
									    <!-- 찾기 
										<div class="col-12 col-12-small">
											<input type="text" name="name" id="name" placeholder="방제목" />
										</div>-->
										<!-- 
										<div class="col-3 col-12-small">
											<ul class="actions">
												<li><input type="submit" value="조회하기" /></li>
											</ul>
										</div>
										 -->
										 
										<!-- 지역 
										<div class="col-6 col-12-small">
											<select>
												<option>지역선택</option>
												<option value="1100000000">서울특별시</option>
												<option value="2600000000">부산광역시</option>
												<option value="2700000000">대구광역시</option>
												<option value="2800000000">인천광역시</option>
												<option value="2900000000">광주광역시</option>
												<option value="3000000000">대전광역시</option>
												<option value="3100000000">울산광역시</option>
												<option value="3611000000">세종특별자치시</option>
												<option value="4100000000">경기도</option>
												<option value="4300000000">충청북도</option>
												<option value="4400000000">충청남도</option>
												<option value="4600000000">전라남도</option>
												<option value="4700000000">경상북도</option>
												<option value="4800000000">경상남도</option>
												<option value="5000000000">제주특별자치도</option>
												<option value="5100000000">강원특별자치도</option>
												<option value="5200000000">전북특별자치도</option>
											</select>
										</div>-->
										
										<!-- 일자선택
										<div class="col-2 col-4-small">
											<input type="text" name="name" id="name" placeholder="조인년도" maxlength="4" />
										</div>
										<div class="col-2 col-4-small">
											<input type="text" name="name" id="name" placeholder="조인월" />
										</div>
										<div class="col-2 col-4-small">
											<input type="text" name="name" id="name" placeholder="조인일" />
										</div> -->
										
										<!-- Break -->
										<div class="col-2 col-4-small">
											<input type="checkbox" id="search-area-all" name="search-area" value="all" checked>
											<label for="search-area-all">전국</label>
										</div>
										<div class="col-2 col-4-small">
											<input type="checkbox" id="search-area-11" name="search-area" value="11">
											<label for="search-area-11">서울</label>
										</div>
										<div class="col-2 col-4-small">
											<input type="checkbox" id="search-area-26" name="search-area" value="26">
											<label for="search-area-26">부산</label>
										</div>
										<div class="col-2 col-4-small">
											<input type="checkbox" id="search-area-27" name="search-area" value="27">
											<label for="search-area-27">대구</label>
										</div>
										<div class="col-2 col-4-small">
											<input type="checkbox" id="search-area-28" name="search-area" value="28">
											<label for="search-area-28">인천</label>
										</div>
										<div class="col-2 col-4-small">
											<input type="checkbox" id="search-area-29" name="search-area" value="29">
											<label for="search-area-29">광주</label>
										</div>
										<div class="col-2 col-4-small">
											<input type="checkbox" id="search-area-30" name="search-area" value="30">
											<label for="search-area-30">대전</label>
										</div>
										<div class="col-2 col-4-small">
											<input type="checkbox" id="search-area-31" name="search-area" value="31">
											<label for="search-area-31">울산</label>
										</div>
										<div class="col-2 col-4-small">
											<input type="checkbox" id="search-area-3611" name="search-area" value="3611">
											<label for="search-area-3611">세종</label>
										</div>
										<div class="col-2 col-4-small">
											<input type="checkbox" id="search-area-41" name="search-area" value="41">
											<label for="search-area-41">경기</label>
										</div>
										<div class="col-2 col-4-small">
											<input type="checkbox" id="search-area-43" name="search-area" value="43">
											<label for="search-area-43">충북</label>
										</div>
										<div class="col-2 col-4-small">
											<input type="checkbox" id="search-area-44" name="search-area" value="44">
											<label for="search-area-44">충남</label>
										</div>
										<div class="col-2 col-4-small">
											<input type="checkbox" id="search-area-46" name="search-area" value="46">
											<label for="search-area-46">전남</label>
										</div>
										<div class="col-2 col-4-small">
											<input type="checkbox" id="search-area-47" name="search-area" value="47">
											<label for="search-area-47">경북</label>
										</div>
										<div class="col-2 col-4-small">
											<input type="checkbox" id="search-area-48" name="search-area" value="48">
											<label for="search-area-48">경남</label>
										</div>
										<div class="col-2 col-4-small">
											<input type="checkbox" id="search-area-50" name="search-area" value="50">
											<label for="search-area-50">제주</label>
										</div>
										<div class="col-2 col-4-small">
											<input type="checkbox" id="search-area-51" name="search-area" value="51">
											<label for="search-area-51">강원도</label>
										</div>
										<div class="col-2 col-4-small">
											<input type="checkbox" id="search-area-52" name="search-area" value="52">
											<label for="search-area-52">전북도</label>
										</div>
										
										<!-- Break
										<div class="col-2 col-4-small">
											<input type="radio" id="demo-priority-low" name="demo-priority" checked>
											<label for="demo-priority-low">성별무관</label>
										</div>
										<div class="col-2 col-4-small">
											<input type="radio" id="demo-priority-normal" name="demo-priority">
											<label for="demo-priority-normal">남성</label>
										</div>
										<div class="col-2 col-4-small">
											<input type="radio" id="demo-priority-high" name="demo-priority">
											<label for="demo-priority-high">여성</label>
										</div>
										 -->
										<!-- Break
										<div class="col-3 col-6-small">
											<input type="radio" id="demo-priority-low2" name="demo-priority2" checked>
											<label for="demo-priority-low2">18홀</label>
										</div>
										<div class="col-3 col-6-small">
											<input type="radio" id="demo-priority-normal2" name="demo-priority2">
											<label for="demo-priority-normal2">9홀</label>
										</div>
										 -->
										
										<!--
										<div class="col-12">
											<input type="text" name="subject" id="subject" placeholder="Subject" />
										</div>
										<div class="col-12">
											<textarea name="message" id="message" placeholder="Message"></textarea>
										</div>
										
										<div class="col-12">
											<ul class="actions">
												<li><input type="submit" value="조회하기" /></li>
												<li><input type="reset" value="Clear Form" class="alt" /></li>
											</ul>
										</div>-->
									</div>
								</form>
								</section>
							</div>
							
							<footer>
								<ul class="actions">
									<li><a href="#" class="button large">조회하기</a></li>
									<li><a href="/JoinInsert" class="button alt large">방만들기</a></li>
								</ul>
							</footer>
							
						</section>

				</section>


			<!-- Footer -->
				<section id="footer">
					<div class="container">
						<div class="row">
							<div class="col-12 col-12-medium">
								<section>
								
								<c:set var="cntChk" value="0" />
								<c:forEach items="${joinList}" var="joinList">
								
									<c:set var="joinDate" value="${fn:split(joinList.joinDate,'-')}" />
									
									<c:if test="${cntChk ne joinDate[1]}">
									
										<c:if test="${cntChk ne '0'}">
										</ul>
										</c:if>
										
										<header>
											<h2>${joinDate[0]}년 ${joinDate[1]}월</h2>
										</header>
										<ul class="dates">
										<c:set var="cntChk" value="${joinDate[1]}" />
									</c:if>
									
											<li>
												<span class="date">${joinDate[1]} <strong>${joinDate[2]}</strong></span>
												<h3><a href="#">
													<c:if test="${joinList.anyoneChk eq 'N'}">[비밀방]</c:if> ${joinList.joinName}</a></h3>
												<h5><c:out value="${joinList.areaListStr}" /></h5>
												<p>
													${joinList.teeupTime}부, 
													<c:choose>
														<c:when test="${joinList.gender eq 'not'}">
														성별무관,
														</c:when>
														<c:when test="${joinList.gender eq 'male'}">
														남성만,
														</c:when>
														<c:when test="${joinList.gender eq 'female'}">
														여성만,
														</c:when>
													</c:choose>
													${joinList.holeNum}홀,
													그린피 <fmt:formatNumber value="${joinList.startGreenfee}" pattern="#,###.##" />~
													<fmt:formatNumber value="${joinList.endGreenfee}" pattern="#,###.##" />원, 
													<c:choose>
														<c:when test="${joinList.strokeNum eq 'not'}">
														타수무관,
														</c:when>
														<c:when test="${joinList.strokeNum eq '70'}">
														80타미만,
														</c:when>
														<c:when test="${joinList.strokeNum eq '890'}">
														80,90타대만,
														</c:when>
														<c:when test="${joinList.strokeNum eq '100'}">
														백돌이만,
														</c:when>
													</c:choose>
													현재<c:out value="${joinList.peopleNum}" />명중 0명완료
													<c:if test="${joinList.anyoneChk eq 'N'}">
														<input type="password" name="pwd_${joinList.seq}" id="pwd_${joinList.seq}" placeholder="비밀번호" size="8" maxlength="8" class="small-input" />
													</c:if>
													<a href="#" class="button">참여하기</a>
												</p>
											</li>
									
									
								</c:forEach>
								
								</section>
							</div>
							
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