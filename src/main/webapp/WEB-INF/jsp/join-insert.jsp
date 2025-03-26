<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
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

		$('#anyone').change(function() {
			if(this.checked){
				$("#pwd").attr("disabled", true);
			}else{
				$("#pwd").attr("disabled", false);
			}
		});
		
		$("#pwd").keyup(function() {
			
			let pwd = $("#pwd").val();
			$("form .warning").css("color", 'red');
			//console.log( pwd.search(/[a-z]/ig) );
			if(pwd.length < 4 || pwd.length > 20){
				$("#pwdWarning").text('비밀번호는 최소 4개부터 20개 까지입니다.');	
			}else if(pwd.search(/\s/) != -1){
				$("#pwdWarning").text('비밀번호는 공백 없이 입력해주세요!');
			}else{
				$("form .warning").css("color", 'blue');
				$("#pwdWarning").text('올바른 비밀번호 입니다.');
			}
			
			$("#pwdWarning").show();
		});
		
		$('#join_exp').on('input', function() {
            var textLength = $(this).val().length;
            $('#charCount').text(textLength + ' 글자');
        });
		
	});
	
	function sidoChange() {
		
	//	console.log( $("#sidoSelect").val() );
		$("#sidoWarning").hide();
		
		/* 구에 데이터삽입 */
		$.ajax({
			type: 'get',
			url: '/sidoSelect',
		//	dataType: 'text',
			data : {sidoCode:$("#sidoSelect").val()},
			success:function(data){
				
				$("select[name='guCode'] option").remove();
				
				$("#guCode").append("<option value=''>전체시군선택</option>");
				
				for(var i=0; i<data.guList.length; i++){
				//	console.log(data.guList[i].name);
					$("#guCode").append("<option value='"+data.guList[i].code+"'>"+data.guList[i].name+"</option>");
				}
			},
			error:function(request, status, error){
				console.log('error!!!'+error);
			}
		});
	} 
	
	function areaAdd(){
	//	console.log( $("#sidoSelect").val() + ', '+ $("#guCode").val());
		$("#sidoWarning").hide();
		$("#guWarning").hide();
		
		if($("#sidoSelect").val() === ''){
			$("#sidoWarning").text('시도를 선택하세요!');
			$("#sidoWarning").show();
		//	alert('시도를 선택하세요!');
			$("#sidoSelect").focus();
		}else{
		//	console.log( $("areaTxt").length );
			
			let html = '';
			if($("#guCode").val() === ''){ // 시도입력
			//	console.log('li len:'+ $("#sidoAddUl li").length);
				let chk = true;
				// 시도 중복체크
				if($("#sidoAddUl li").length > 0){
				
					$('#sidoAddUl li').each(function(index) {
		            //    console.log($(this).attr('id')+', Index: ' + index + ', Text: ' + $(this).text());
		                if( $("#sidoSelect").val() === $(this).attr('id') ){
		                	//alert('이미 입력된 시도입니다.');
		                	$("#sidoWarning").text('이미 입력된 시도입니다!');
		        			$("#sidoWarning").show();
		                	chk = false;
		                //	break;
		                }
		            });
				}
				
				if(chk){
					html = "<li id='"+$("#sidoSelect :selected").val()+"'>"+$("#sidoSelect :selected").text()+
					"<input type='button' value='삭제' onclick='deleteSido("+$("#sidoSelect :selected").val()+");' id='small-btn' /></li>";
					$("#sidoAddUl").append(html);
				}
				
				
			}else{	// 시군입력
				
				let chk = true;
				if($("#gugunAddUl li").length > 0){
					
					$('#gugunAddUl li').each(function(index) {
						if( $("#sidoSelect").val() + '-' + $("#guCode").val() === $(this).attr('id') ){
							//alert('이미 입력된 구군입니다.');
							$("#guWarning").text('이미 입력된 구군입니다!');
		        			$("#guWarning").show();
							chk = false;
						}
					});
				}
				
				if(chk){
					html = "<li id='"+$("#sidoSelect :selected").val()+'-'+$("#guCode :selected").val()+"'>"+$("#sidoSelect :selected").text()+' '+$("#guCode :selected").text()+
					//" <a href='javascript:deleteSido(\""+$("#sidoSelect :selected").val()+'-'+$("#guCode :selected").val()+"\");'>X</a></li>";
					"<input type='button' value='삭제' onclick='deleteSido(\""+$("#sidoSelect :selected").val()+'-'+$("#guCode :selected").val()+"\");' id='small-btn' /></li>";
					$("#gugunAddUl").append(html);
				}
				
			}
			
			//$("#areaAddBtn").after(html);
			
		}
		
		
		
	}
	
	function deleteSido(id){
		//console.log('delete:'+id);
		$("#sidoWarning").hide();
		$("#guWarning").hide();
		
		$("#"+id).remove();
	}
	
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
								<li><a href="no-sidebar.html">이용안내</a></li>
								<li><a href="no-sidebar.html">내방관리</a></li>
								<li><a href="no-sidebar.html">문의하기</a></li>
								<li><a href="no-sidebar.html">탈퇴하기</a></li>
							</ul>
						</nav>


					<!-- Intro -->
						<section id="intro" class="container">
						
							<h2>조인방만들기</h2>
							
							<form method="post" name="joinInsertFrm" id="joinInsertFrm" onsubmit="return joinInsertChk();" action="JoinInsert">
							
							<div class="col-4 col-12-medium">
							
								<section class="first">
								
									<div class="row">
									
									    <!-- 방제목 -->
										<div class="col-12 col-12-small">
											<input type="text" name="joinName" id="joinName" placeholder="방제목" maxlength="50" />
											<p id="joinNameWarning" class="warning" style="display:none;">방제목을 입력하세요!</p> 
										</div>
										
										<!-- 비밀번호 -->
										<div class="col-8 col-8-small">
											<input type="password" name="pwd" id="pwd" placeholder="비밀번호(최소4자리 부터 20자리까지)" disabled="disabled" maxlength="20" />
											<p id="pwdWarning" class="warning" style="display:none;"></p> 
										</div> 
										<div class="col-4 col-4-small" style="text-align:left;">
											<input type="checkbox" id="anyone" name="anyone" checked="checked" >
											<label for="anyone">누구나</label>
										</div>
										
										<!-- 지역 -->
										<div class="col-4 col-4-small">
											<select onchange="sidoChange();" id="sidoSelect" name="sidoSelect">
												<option value="">시도선택</option>
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
											<p id="sidoWarning" class="warning" style="display:none;"></p> 
										</div>
										
										<div class="col-4 col-4-small">
											<select name="guCode" id="guCode">
												<option value="">전체시군선택</option>
											</select>
											<p id="guWarning" class="warning" style="display:none;"></p>
										</div>
										
										<div class="col-4 col-4-small" id="areaAddBtn">
											<ul class="actions">
												<li><input type="button" value="지역추가" onclick="areaAdd();" /></li>
											</ul>
										</div>
										
										<!-- 지역추가영역 -->
										<div class="col-6 col-6-small">
											<ul id="sidoAddUl">
											</ul>
										</div>
										
										<div class="col-6 col-6-small">
											<ul id="gugunAddUl">
											</ul>
										</div>
										
										
										<!-- 조인일자선택 -->
										<div class="col-4 col-4-small">
											<select name="joinYear" id="joinYear">
												<option value="">조인년도</option>
												<option value="2025">2025년</option>
											</select>
										</div>
										<div class="col-4 col-4-small">
											<select name="joinMonth" id="joinMonth">
												<option value="">조인월</option>
												<option value="1">1월</option>
												<option value="2">2월</option>
												<option value="3">3월</option>
												<option value="4">4월</option>
												<option value="5">5월</option>
												<option value="6">6월</option>
												<option value="7">7월</option>
												<option value="8">8월</option>
												<option value="9">9월</option>
												<option value="10">10월</option>
												<option value="11">11월</option>
												<option value="12">12월</option>
											</select>
										</div>
										<div class="col-4 col-4-small">
											<select name="joinDay" id="joinDay">
												<option value="">조인일</option>
												<option value="1">1일</option>
												<option value="2">2일</option>
												<option value="3">3일</option>
												<option value="4">4일</option>
												<option value="5">5일</option>
												<option value="6">6일</option>
												<option value="7">7일</option>
												<option value="8">8일</option>
												<option value="9">9일</option>
												<option value="10">10일</option>
												<option value="11">11일</option>
												<option value="12">12일</option>
												<option value="13">13일</option>
												<option value="14">14일</option>
												<option value="15">15일</option>
												<option value="16">16일</option>
												<option value="17">17일</option>
												<option value="18">18일</option>
												<option value="19">19일</option>
												<option value="20">20일</option>
												<option value="21">21일</option>
												<option value="22">22일</option>
												<option value="23">23일</option>
												<option value="24">24일</option>
												<option value="25">25일</option>
												<option value="26">26일</option>
												<option value="27">27일</option>
												<option value="28">28일</option>
												<option value="29">29일</option>
												<option value="30">30일</option>
												<option value="31">31일</option>
											</select>
										</div>
										
										<!-- 조인일자에러출력 -->
										<div class="col-12 col-12-small">
											<p id="joinDateWarning" class="warning" style="display:none;"></p>
										</div>
										
										<!-- 성별 -->
										<div class="col-2 col-4-small">
											<input type="radio" id="gender-not" name="gender" value="not" checked>
											<label for="gender-not">성별무관</label>
										</div>
										<div class="col-2 col-4-small">
											<input type="radio" id="gender-male" name="gender" value="male">
											<label for="gender-male">남성</label>
										</div>
										<div class="col-2 col-4-small">
											<input type="radio" id="gender-female" name="gender" value="female">
											<label for="gender-female">여성</label>
										</div>
										
										<!-- 홀수 -->
										<div class="col-3 col-6-small">
											<input type="radio" id="holenum-18" name="hole_num" value="18" checked>
											<label for="holenum-18">18홀</label>
										</div>
										<div class="col-3 col-6-small">
											<input type="radio" id="holenum-9" name="hole_num" value="9">
											<label for="holenum-9">9홀</label>
										</div>
										
										<!-- 시간대 -->
										<div class="col-4 col-4-small">
											<input type="radio" id="teeup_time-1" name="teeup_time" value="1" checked>
											<label for="teeup_time-1">1부</label>
										</div>
										<div class="col-4 col-4-small">
											<input type="radio" id="teeup_time-2" name="teeup_time" value="2">
											<label for="teeup_time-2">2부</label>
										</div>
										<div class="col-4 col-4-small">
											<input type="radio" id="teeup_time-3" name="teeup_time" value="3">
											<label for="teeup_time-3">3부</label>
										</div>
										
										<!-- 희망그린피 -->
										<div class="col-4 col-4-small">
											<input type="text" name="start_greenfee" id="start_greenfee" placeholder="희망시작그린피" maxlength="11" />
											<p id="startGreenFee" class="warning" style="display:none;" />
										</div>
										<div class="col-2 col-2-small">
										원 부터
										</div>
										<div class="col-4 col-4-small">
											<input type="text" name="end_greenfee" id="end_greenfee" placeholder="희망종료그린피" maxlength="11" />
											<p id="endGreenFee" class="warning" style="display:none;" />
										</div>
										<div class="col-2 col-2-small">
										원 까지
										</div>
										
										<!-- 조인인원 -->
										<div class="col-4 col-4-small">
											<input type="radio" id="people_num-4" name="people_num" value="4" checked>
											<label for="people_num-4">4명</label>
										</div>
										<div class="col-4 col-4-small">
											<input type="radio" id="people_num-3" name="people_num" value="3">
											<label for="people_num-3">3명</label>
										</div>
										<div class="col-4 col-4-small">
											<input type="radio" id="people_num-2" name="people_num" value="2">
											<label for="people_num-2">2명</label>
										</div>
										
										<div class="col-12 col-12-small">
										<textarea rows="" cols="" placeholder="조인 설명글" name="join_exp" id="join_exp" maxlength="500"></textarea>
										<p id="charCount" class="warning">0 글자 (최대 500글자)</p>
										</div>
										
									</div>
								</section>
								
							</div>
							
							<footer>
								<ul class="actions">
									<li><a href="javascript:addSubmit();" class="button large">추가하기</a></li>
									<li><a href="/JoinList" class="button alt large">취소하기</a></li>
								</ul>
							</footer>
							
							<input type="hidden" name="area_list" id="area_list" value="" />
							<input type="hidden" name="join_date" id="join_date" value="" />
							</form>
							
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

<script type="text/javascript">


function joinInsertChk(){
	console.log('--------joinInsertChk-------------');
	
	if($("#joinName").val() === ''){
		$("#joinNameWarning").show();
		$("#joinName").focus();
		return false;
	}
	
	if(!$("#anyone").prop("checked") && $("#pwd").val() === ''){
		$("#pwdWarning").text('비밀번호를 입력하세요!');
		$("#pwdWarning").show();
		$("#pwd").focus();
		return false;
	}
	
	if(!$("#anyone").prop("checked") && $("#pwd").val() != '' && ($("#pwd").val().length < 4 || $("#pwd").val().length > 20)){
		$("#pwdWarning").text('비밀번호는 최소 4부터 최대 20자리 입니다!');
		$("#pwdWarning").show();
		$("#pwd").focus();
		return false;
	}
	
	if($("#sidoAddUl li").length === 0 && $("#gugunAddUl li").length === 0){
		$("#sidoWarning").text('최소 1개의 선호지역을 추가하셔야 합니다!');
		$("#sidoWarning").show();
		$("#sidoSelect").focus();
		return false;
	}else{
		let area_list = '';
		
		$('#sidoAddUl li').each(function() {
		    var liId = $(this).attr('id');
		    area_list += liId + ',';
		  });
		
		$('#gugunAddUl li').each(function() {
		    var liId = $(this).attr('id');
		    area_list += liId + ',';
		  });
		
		$("#area_list").val(area_list);
	}
	
	if($("#joinYear").val() === '' || $("#joinMonth").val() === '' || $("#joinDay").val() === ''){
		$("#joinDateWarning").text('조인할 날짜를 선택해주세요!');
		$("#joinDateWarning").show();
		$("#joinYear").focus();
		return false;
	}else{
		if(new Date() > new Date($("#joinYear").val() + '-' + $("#joinMonth").val()+'-'+ $("#joinDay").val())){
			$("#joinDateWarning").text('조인할 날짜는 오늘 이후여야 합니다!');
			$("#joinDateWarning").show();
			$("#joinYear").focus();
			return false;
		}else{
			$("#join_date").val( $("#joinYear").val() + '-' + $("#joinMonth").val()+'-'+ $("#joinDay").val() );
		}
	}
	
	if($("#start_greenfee").val() === ''){
		$("#startGreenFee").text('시작 그린피를 입력하세요!'); 
		$("#startGreenFee").show();
		$("#start_greenfee").focus();
		return false;
	}
	
	if($("#end_greenfee").val() === ''){
		$("#endGreenFee").text('종료 그린피를 입력하세요!'); 
		$("#endGreenFee").show();
		$("#end_greenfee").focus();
		return false;
	}
	
	return true;
}


function addSubmit(){
	
	$("#joinNameWarning").hide();
	$("#pwdWarning").hide();
	$("#joinDateWarning").hide();
	$("#startGreenFee").hide();
	$("#endGreenFee").hide();
	
	$("form .warning").css("color", 'red');
	//console.log( $("#anyone").prop("checked") );
	//console.log($("#sidoAddUl li").length);
	
	$("#joinInsertFrm").submit();
	
}


const input = document.querySelector('#start_greenfee');
input.addEventListener('keyup', function(e) {
  let value = e.target.value;
  value = Number(value.replaceAll(',', ''));
  if(isNaN(value)) {
    input.value = 0;
  }else {
    const formatValue = value.toLocaleString('ko-KR');
    input.value = formatValue;
  }
})

const input2 = document.querySelector('#end_greenfee');
input2.addEventListener('keyup', function(e) {
  let value = e.target.value;
  value = Number(value.replaceAll(',', ''));
  if(isNaN(value)) {
    input2.value = 0;
  }else {
    const formatValue = value.toLocaleString('ko-KR');
    input2.value = formatValue;
  }
})

</script>

		<!-- Scripts -->
			
			<script src="/assets/js/jquery.dropotron.min.js"></script>
			<script src="/assets/js/browser.min.js"></script>
			<script src="/assets/js/breakpoints.min.js"></script>
			<script src="/assets/js/util.js"></script>
			<script src="/assets/js/main.js"></script>

	</body>
</html>