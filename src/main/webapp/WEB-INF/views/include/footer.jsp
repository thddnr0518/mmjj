<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<footer id="footer">
	<div class="container">
		<div class="nino-copyright">Copyright &copy; 2020 <a target="_blank" href="#" title="MMJJ.com - 소유 및 권한은 MMJJ Corporate에 있습니다.">MMJJ.com</a>.
		<br/> All Rights Reserved.<br/><br/>문의 : O O O @ gmail.com </div>
	</div>
</footer>

    <!-- <form action="" id="nino-searchForm">
    	<input type="text" placeholder="Search..." class="form-control nino-searchInput">
    	<i class="mdi mdi-close nino-close"></i>
    </form> -->
    
    <!-- Scroll to top ================================================== -->
	<a href="#" id="nino-scrollToTop">Go to Top</a>
    
<!-- 모달 -->
<div id="custom_modal" class="custom_modal">
	<!-- 모달 닫기 -->
	<span id="custom_modalClose" class="custom_modalClose" onclick="modal_close();">&times;</span>
	<!-- 로그인 모달 -->
	<div id="loginForm" class="custom_modal-content">
		<form action="${contextPath }/login" id="login" method="post" name="login">
			<input type="hidden" name="access" value="true">
			<input type="hidden" id="contextPath" value="${contextPath }">
			<div style="text-align: center; margin: 0 auto;">
				<img alt="로그인 상단 이미지" src="${contextPath }/resources/img/MM.png" width="300px;">
			</div>
			<div style="margin: 0 auto; margin-top: 10px; margin-bottom: 30px;text-align: center; width: 50%;">
				<div>
			        <span class="box">
			            <input type="text" id="inputID" name="inputid" class="int" maxlength="15" placeholder="아이디">
			        </span>
		        </div>
		        <div style="margin-top: 20px;">
			        <span class="box">
			            <input type="password" id="inputPWD" name="inputpwd" class="int" maxlength="15" placeholder="비밀번호">
			        </span>
			        <span id="loginChkMessage"></span>
			    </div>
			</div>
			<div style="margin: 20px;">
				<div style="text-align:center; display: flex; border-bottom: solid 1px #58C9B9; border-radius: 0;">
					<span style="flex: 1;" class="clck">아이디 / 비밀번호 찾기</span>
				</div>
				<div style="text-align:center; display: flex;">
					<span style="flex: 1; font-size: 20px">회원이 아니신가요..?<span class="clck" onclick="modal_join();"> 회원가입</span>
				</div>
			</div>
			<input type="hidden" id="token" data-token-name="${_csrf.headerName}" placeholder="Password" value="${_csrf.token}">
			<div class="btnJoin" id="login_btn">
			    <span>로그인</span>
			</div>
		</form>
	</div>
	<!-- joinForm 모달 -->
	<div id="joinForm" class="custom_modal-content">
		<form action="${contetxtPath }/memeber/join" id="join" method="post" name="joinfrm" style="margin: 30px 15% 15% 15%;">
			<fieldset>
				<!-- 로고 -->
				<div style="text-align: center;">
					<img alt="회원가입 상단 이미지" src="${contextPath }/resources/img/MM.png" width="300px;">
				</div>
				<div class="FormSize">
					<!-- ID -->
					<div>
				        <h3><label for="userid">아이디</label></h3>
				        <span class="box int_pass">
				            <input type="text" id="userid" name="userid" class="int" maxlength="20" autocomplete="off" autofocus="autofocus">
				            <span id="succesID" style="position: absolute;top: 19px;right: 5px;font-size: 12px;display: none;">사용 가
				            능</span>
				        </span>
				        <span class="error_next_box"></span>
				    </div>
					<!-- PW1 -->
				    <div>
				        <h3><label for="userpw">비밀번호</label></h3>
				         <span class="box int_pass">
				            <input type="password" id="userpw" name="userpw" class="int" maxlength="16">
				            <span id="alertTxt">사용불가</span>
				            <img src="${contextPath }/resources/img/naver/m_icon_pass.png" id="pwd_img" class="pwdImg">
				        </span>
				        <span class="error_next_box"></span>
				    </div>
				    <!-- PW2 -->
				    <div>
				        <h3><label for="pwdChk">비밀번호 재확인</label></h3>
				         <span class="box int_pass">
				            <input type="password" id="pwdChk" name="pwdChk" class="int" maxlength="16" disabled="disabled">
				            <img src="${contextPath }/resources/img/naver/m_icon_check_disable.png" id="pwdChk_img" class="pwdImg">
				        </span>
				        <span class="error_next_box"></span>
				    </div>
				    <!-- NickName -->
				    <div>
				        <h3><label for="nickName">닉네임</label></h3>
				        <span class="box">
				            <input type="text" id="nickName" name="nickName" class="int" maxlength="10" autocomplete="off">
				        </span>
				        <span class="error_next_box"></span>
				    </div>
				    <!-- EMAIL -->
				        <h3><label for="email1">본인확인 이메일</label></h3>
				        <div id="email_wrap">
				        	<div id="email_1">
						        <span class="box">
						            <input type="text" id="email1" name="email1" class="int" maxlength="30" placeholder="email ID" autocomplete="off">
						        </span>
					        </div>
					        <div id="email_2">
					        	<span class="box">
					        		<p>@</p>
					        	</span>
						    </div>
						    <div id="email_3">
						    	<span class="box">
							        <input id="email2" name="email2" class="int" maxlength="30" list="domains" placeholder="입력or선택" autocomplete="off">
							        <datalist id="domains">
							            <option value="naver.com">
							            <option value="daum.net">
							            <option value="gmail.com">
							        </datalist>
							    </span>
						    </div>
						</div>
						<span class="error_next_box">이메일 주소를 다시 확인해주세요.</span>
				    <!-- NAME -->
				    <div>
				        <h3><label for="name">이름</label></h3>
				        <span class="box">
				            <input type="text" id="userName" name="userName" class="int" maxlength="10" autocomplete="off">
				        </span>
				        <span class="error_next_box"></span>
				    </div>
				    <!-- BIRTH -->
				    <div>
				        <h3><label for="yy">생년월일</label></h3>
				        <div id="bir_wrap">
				            <!-- BIRTH_YY -->
				            <div id="bir_yy">
				                <span class="box">
				                    <input type="text" id="yy" name="yy" class="int" maxlength="4" placeholder="년(4자)" autocomplete="off">
				                </span>
				            </div>
				            <!-- BIRTH_MM -->
				            <div id="bir_mm">
				                <span class="box">
				                    <select id="mm" name="mm" class="sel">
				                        <option>월</option>
				                        <option value="01">1</option>
				                        <option value="02">2</option>
				                        <option value="03">3</option>
				                        <option value="04">4</option>
				                        <option value="05">5</option>
				                        <option value="06">6</option>
				                        <option value="07">7</option>
				                        <option value="08">8</option>
				                        <option value="09">9</option>                                    
				                        <option value="10">10</option>
				                        <option value="11">11</option>
				                        <option value="12">12</option>
				                    </select>
				                </span>
				            </div>
				            <!-- BIRTH_DD -->
				            <div id="bir_dd">
				                <span class="box">
				                    <input type="text" id="dd" name="dd" class="int" maxlength="2" placeholder="일" autocomplete="off">
				                </span>
				            </div>
				        </div>
				        <span class="error_next_box"></span>    
				    </div>
				    <!-- GENDER -->
				    <div>
				        <h3><label for="gender">성별</label></h3>
				        <span class="box">
				            <select id="gender" name="gender" class="sel">
				                <option>성별</option>
				                <option value="M">남자</option>
				                <option value="F">여자</option>
				            </select>
				        </span>
				        <span class="error_next_box">필수 정보입니다.</span>
				    </div>
				
				    <!-- ADDRESS -->
				    <div>
				    	<h3>
					    	<label onclick="sample4_execDaumPostcode()">주소</label>
					    	<span class="clck" style="float: right;" onclick="sample4_execDaumPostcode()">우편번호찾기</span>
				    	</h3>
				    	<span class="box" style="width: 30%;">
							<input type="text" id="sample4_postcode" placeholder="우편번호" name="zipNum"class="int" autocomplete="off">
				        </span>
				        <div id="road_wrap">
				        	<div id="road-A">
						        <span class="box">
									<input type="text" id="sample4_roadAddress" placeholder="도로명주소" name="addr1"class="int" autocomplete="off">
						        </span>
						    </div>
						    <div id="road-B">
						        <span class="box">
									<input type="text" id="sample4_detailAddress" placeholder="상세주소" name="addr2"class="int" autocomplete="off">
								</span>
							</div>
				        </div>
				        <div id="jibun_wrap" style="display: none;">
				        	<div id="jibun-A">
						        <span class="box">
									<input type="text" id="sample4_jibunAddress" placeholder="지번주소"class="int" autocomplete="off">
						        </span>
						    </div>
						    <div id="jibun-B">
						        <span class="box">
									<input type="text" id="sample4_extraAddress" placeholder="참고항목"class="int" autocomplete="off" >
								</span>
							</div>
					    </div>
					    <span id="guide" style="color:#999;display:none"></span>
					</div>
				    <!-- PHONE -->
				    <div>
				        <h3><label for="phone">휴대전화</label></h3>
				        <span class="box">
				            <input type="tel" id="phone" class="int" name="phone" maxlength="12" placeholder="전화번호 입력" autocomplete="off">
				        </span>
				        <span class="error_next_box"></span>    
				    </div>
				    <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
				    <input type="hidden" name="email" value="">
				    <input type="hidden" name="birth" value="">
				    <input type="hidden" name="addr" value="">
					<!-- JOIN BTN-->
			        <div class="btnJoin" onclick="go_save();" style="margin:0 auto; margin-top:20px; margin-bottom: 20px;">
			            <span>가입하기</span>
			        </div>
			        <!-- CANCLE BTN -->
			        <div class="btnJoin" onclick="modal_close();">
			            <span>취소</span>
			        </div>
				</div>
			</fieldset>
		</form>
	</div>
	<!-- 약관동의 모달창 -->
	<div id="contract" class="custom_modal-content">
		<h2 style="text-align: center; margin-top: 20px;">사용자 약관</h2><br>
		<div style="text-align: center;">
			<textarea style="width: 90%; height: 350px;" rows="10">
제1장 총칙
제1조(목적)

이 약관은 한국지식재산협회 사이트(이하 "당 사이트"라 합니다)가 제공하는 모든 서비스(이하"서비스")의 이용조건 및 절차, 이용자와 당 사이트의 권리, 의무, 책임사항과 기타 필요한 사항을 규정함을 목적으로 합니다.
제2조(약관의 효력 및 변경)

① 이 약관은 서비스 메뉴 및 당 사이트에 게시하여 공시함으로써 효력을 발생합니다.
② 당 사이트는 약관의 규제에 관한 법률, 전자거래 기본법, 전자서명법, 정보통신망이용촉진 및 정보보호이용 등에 관한 법률 등 관련법을 위배하지 않는 범위에서 이 약관을 개정할 수 있습니다.
③ 당 사이트가 약관을 개정할 경우에는 적용일자 및 개정사유를 명시하여 현행약관과 함께 당 사이트의 초기화면에 그 적용일자 7일 이전부터 적용일자 전일까지 공지합니다.
④ 당 사이트는 이용자가 본 약관 내용에 동의하는 것을 조건으로 이용자에게 서비스를 제공할 것이며, 이용자가 본 약관의 내용에 동의하는 경우, 당 사이트의 서비스 제공 행위 및 이용자의 서비스 사용 행위에는 본 약관이 우선적으로 적용될 것입니다.
⑤ 이 약관에 동의하는 것은 정기적으로 웹을 방문하여 약관의 변경사항을 확인하는 것에 동의함을 의미합니다. 변경된 약관에 대한 정보를 알지 못해 발생하는 이용자의 피해는 당 사이트에서 책임지지 않습니다.
⑥ 회원은 변경된 약관에 동의하지 않을 경우 회원 탈퇴(해지)를 요청할 수 있으며, 변경된 약관의 효력 발생일로부터 7일 이후에도 거부의사를 표시하지 아니하고 서비스를 계속 사용할 경우 약관의 변경 사항에 동의한 것으로 간주됩니다.
제3조(약관 외 준칙)

본 약관에 명시되지 않은 사항은 전기통신기본법, 전기통신사업법, 정보통신윤리위원회심의규정, 정보통신 윤리강령, 프로그램보호법 및 기타 관련 법령의 규정에 의합니다.
제4조(용어의 정의)

이 약관에서 사용하는 용어의 정의는 다음과 같습니다.
① 이용자: 서비스 이용을 신청하고 당 사이트가 이를 승낙하여 회원ID를 발급 받은 자를 말합니다.
② 회원ID: 이용자 식별과 서비스 이용을 위하여 이용자가 선정하고 당 사이트가 부여하는 영문자와 숫자의 조합을 말합니다.
③ 비밀번호: 이용자와 회원ID가 일치하는지를 확인하고 통신상의 자신의 비밀보호를 위하여 이용 자신이 선정한 영문자와 숫자의 조합을 말합니다.
④ 탈퇴(해지) : 이용자가 이용계약을 종료 시키는 행위 및 의사표시를 말합니다.
⑤ 본 약관에서 정의하지 않은 용어는 개별서비스에 대한 별도약관 및 이용규정에서 정의합니다.
제 2장 이용신청 및 승낙
제5조(이용계약의 성립 및 단위)

① 이용계약은 서비스 이용희망자의 이용신청에 대해 당 사이트가 이용승낙을 함으로써 성립됩니다.
② 이용계약은 회원ID 단위로 체결하며 계약단위는 한 개 이상의 회원ID로 합니다.
③ 서비스의 대량이용 또는 서비스 이용이 특별한 경우에는 별도 이용계약에 의하여 제공하며, 당 사이트의 정책상 단체가입이 필요한 경우에는 단체가입 기본계약에 의하여 제공합니다.
제6조(이용신청)

① 서비스 이용희망자는 본 이용약관 내용에 대한 동의와 당 사이트의 소정양식의 이용신청서를 제출하거나 서비스 또는 전화 등 을 통하여 이용신청을 할 수 있습니다.
② "당 사이트"의 서비스 이용희망자는 반드시 실명인증서비스를 통해 본인이 신청하여야 하며, "당 사이트"는 이용자에 "당 사이트"의 이용약관과 개인정보취급방침의 동의을 받아 가입처리를 하여야 합니다.
제7조(이용신청의 승낙)

① 당 사이트는 제6조의 규정에 의한 서비스 이용희망자에 대하여 업무수행상 또는 기술상 지장이 없는 경우에는 원칙적으로 접 수 순서에 따라 이용신청을 승낙합니다.
② 당 사이트가 이용신청을 승낙하는 때에는 이용자에게 서비스 및 전화 등을 통하여 다음 각호의 사항을 통지합니다.
1.회원ID
2.서비스 제공 개시일
3.서비스 요금 등에 관한 사항
4.이용자의 책임, 의무 및 권익보호 등에 관한 사항
제8조(이용신청에 대한 불승낙과 승낙의 제한)

① 당 사이트가 다음 각 호에 해당하는 사항을 인지하였을 경우에는 서비스 이용신청을 승낙하지 아니합니다.
1.타인명의의 신청
2.이용신청서의 내용을 허위로 기재하였을 때
3.신용정보의 이용과 보호에 관한 법률에 의한 신용정보집중기관에 PC통신,인터넷서비스의 신용불량자로 등록되어 있는 경우
4.기타 이용신청자의 귀책사유로 이용승낙이 곤란한 경우
② 당 사이트는 다음 각 호에 해당하는 경우 이용신청에 승낙을 제한할 수 있고, 이 사유가 해소될 때 까지 승낙을 하지 않을 수 있습니다.
1.설비에 여유가 없는 경우
2.기술상 지장이 있는 경우
③ 당 사이트는 제1항 또는 제2항의 규정에 의하여 이용신청이 불승낙 되거나 승낙을 제한하는 경우에는 이를 이용 신청자 또는 그 대리인에게 알려야 합니다. 다만 고의 또는 과실 등 이용신청자에게 책임 있는 사유로 통지할 수 없는 경우에는 그러하지 아니합니다.
제9조(회원 ID 변경 불가 )

이용자가 회원 ID에 대한 변경요청을 할 지라도 일단 등록된 회원ID는 변경 할 수 없습니다.
제 3장 서비스제공 및 이용
제10조(서비스 제공 개시일)

서비스 계약 체결 즉시 서비스가 개시됩니다
제11조(서비스 이용시간)

① 서비스 이용은 당 사이트의 업무상 또는 기술상 특별한 지장이 없는 한 연중 무휴, 1일 24시간을 원칙으로 합니다. 다만, 당 사이트는 데이타베이스 별로 이용가능시간을 정할 수 있으며, 이 경우 그 내용은 당 사이트가 정하여 서비스에 게시하거나 별도로 공시하는 바에 따릅니다.
② 제1항의 규정에도 불구하고 정기점검 등의 필요로 당 사이트가 정한 날 또는 시간은 예외적으로 서비스 이용을 제한할 수 있습니다.
제 4장 계약당사자의 의무
제12조(당 사이트의 의무)

① 당 사이트는 제11조 및 제16조 제1항에서 정한 사유 이외에는 이 약관에서 정한 바에 따라 계속적, 안정적으로 서비스를 제공 할 의무가 있습니다.
② 당 사이트는 서비스 제공설비를 항상 운용 가능한 상태로 유지보수 하여야 하며, 설비에 장애가 발생하거나 또는 멸실 된 때에는 지체 없이 이를 수리, 복구 하여야 합니다. 취득한 이용자의 개인신상정보를 본인의 사전 승낙 없이 타인(당 사이트 이외의 자)에게 누설 또는 배포할 수 없으며, 당 사이트의 서비스 관련 업무 이외의 상업적 목적으로 사용할 수 없습니다. 다만, 다음 각 호의 1에 해당하는 경우에는 그러하지 아니합니다.
1.관계법령에 의한 수사상의 목적으로 관계기관으로부터 요구 받은 경우
2.정보통신윤리위원회 요청이 있는 경우
④ 당 사이트는 이용자로부터 제기되는 의견이나 불만이 정당하다고 인정할 경우에는 즉시 처리하여야 합니다. 다만, 즉시 일정을 서비스 또는 전화, 서면 등으로 통보하여야 합?약사항의 변경 및 해지 등 이용자의 계약관련 절차 및 내용 등에 있어 이용자의 편의를 제공하도록 노력합니다.
제13조(이용자의 의무)

① 이용자는 이 약관 및 관계법령을 준수하여야 하며, 기타 당 사이트의 업무수행에 지장을 초래하는 행위를 하여서는 아니됩니다.
② 이용자는 주소 및 연락처 등 이용신청사항이 변경된 경우에는 메일 또는 전화 등을 통하여 이를 즉시 당 사이트에 알려야 합니다.
③ 이용자는 서비스를 이용하여 얻은 정보를 당 사이트의 승낙 없이 복사,복제, 개조, 번역하여 타인에게 제공하여서는 아니됩니다.
④ 이용자는 당 사이트에서 승낙한 경우를 제외하고는 서비스를 이용하여 영업활동을 할 수 없습니다.
⑤ 이용자는 다음 각호에 해당하는 행위를 하여서는 아니되며, 만약 이에 해당하는 경우 당 사이트는 게시물을 삭제하거나 서비스의 전부 또는 일부의 이용을 제한할 수 있습니다.
⑥ 이용자는 이 약관 및 관계법령을 준수하여야 하며, 기타 당 사이트의 업무수행에 지장을 초래하는 행위를 하여서는 아니됩니다.
1.범죄행위를 목적으로 하거나 범죄행위를 교사하는 행위
2.반국가적 행위의 수행을 목적으로 하는 행위
3.선량한 풍속, 기타 사회질서를 해하는 행위
4.타인의 명예를 손상시키거나 불이익을 주는 행위
5.정보통신설비의 오동작이나 정보 등의 파괴를 유발시키는 해킹, 컴퓨터 바이러스 프로그램 등의 유포행위
6.다른 이용자 또는 제3자의 지적재산권을 침해하는 행위
7.수신자의 의사에 반하여 광고성 정보를 지속적으로 전송하거나 서비스의 안정적 운영에 지장을 초래하는 다량의 자료 송수신, 게시물 등록, 기타 건전한 서비스 이용에 반하는 행위
⑦ 당 사이트의 이용자는 주민등록번호 관련 [주민등록법 제37조]를 준수하여야 합니다. * 주민등록법에 의해 타인의 주민번호를 도용하여 온라인 회원가입을 하는 등 다른 사람의 주민등록번호를 부정사용자는 3년 이하의 징역 또는 1천 만원 이하의 벌금이 부과될 수 있습니다.[관련 법률 : 주민등록법 제37조 제8~9항(개정일 2008. 12. 26)]
제14조(서비스 이용책임)

① 이용자는 자기 책임하에 서비스를 이용하며, 서비스자료의 취사 선택 또는 서비스 이용으로 불이익이 발생하더라도 이에 대한 책임은 이용자에게 있습니다.
② 이용자가 서비스를 이용하여 게시 또는 전송한 자료의 내용에 관하여 발생되는 책임은 이용자에게 있습니다.
③ 이용자에게 통보된 회원ID와 비밀번호의 관리 및 이용상의 부주의로 인하여 발생되는 과실 또는 제3자에 의한 부정사용 등에 대한 책임은 이용자에게 있습니다. 다만, 당 사이트의 관리상 중과실이 있는 경우에는 그러하지 아니합니다.
제15조(양도 등의 금지)

이용자는 서비스 이용권리를 타인에게 대여, 양도 또는 증여 등을 할 수 없으며, 또한 질권의 목적으로도 사용할 수 없습니다.
제 5장 서비스 이용제한 및 정지
제16조(서비스의 중지 및 중지에 대한 공지)

① 당 사이트 서비스에 보관되거나 전송된 메시지 및 기타 통신 메시지 등의 내용이 국가의 비상사태, 정전, 당 사이트의 관리 범위 외의 서비스 설비 장애 및 기 타 불가항력에 의하여 보관되지 못하였거나 삭제된 경우, 전송되지 못한 경우 및 기타 통신 데이터의 손실이 있을 경우에 당 사이트는 관련 책임을 부담하지 아니합니다.
② 당 사이트가 정상적인 서비스 제공의 어려움으로 인하여 일시적으로 서비스를 중지하여야 할 경우에는 서비스 중지 1주일 전에 홈페이지에 서비스 중지사유 및 일시를 공지한 후 서비스를 중지할 수 있으며, 이 기간 동안 이용자가 공지내용을 인지하지 못한 데 대하여 당 사이트는 책임을 부담하지 아니합니다. 부득이한 사정이 있을 경우 위 사전 공지기간은 감축되거나 생략될 수 있습니다. 또한 위 서비스 중지에 의하여 본 서비스에 보관되거나 전송된 메시지 및 기타 통신 메시지 등의 내용이 보관되지 못하였거나 삭제된 경우, 전송되지 못한 경우 및 기타 통신 데이터의 손실이 있을 경우에 대하여도 당 사이트는 책임을 부담하지 아니합니다.
③ 당 사이트의 사정으로 서비스를 영구적으로 중단하여야 할 경우에는 제 2 항에 의거합니다. 다만, 이 경우 사전 공지기간은 1개월로 합니다.
④ 당 사이트는 사전 공지 후 서비스를 일시적으로 수정, 변경 및 중단할 수 있으며, 이에 대하여 이용자 또는 제3자에게 어떠한 책임도 부담하지 아니합니다.
⑤ 당 사이트는 긴급한 시스템 점검, 증설 및 교체 등 부득이한 사유로 인하여 예고 없이 일시적으로 서비스를 중단할 수 있으며, 새로운 서비스로의 교체 등 당 사이트가 적절하다고 판단하는 사유에 의하여 현재 제공되는 서비스를 완전히 중단할 수 있습니다.
⑥ 당 사이트는 국가비상사태, 정전, 서비스 설비의 장애 또는 서비스 이용의 폭주 등으로 정상적인 서비스 제공이 불가능할 경우, 서비스의 전부 또는 일부를 제한하거나 중지할 수 있습니다. 다만 이 경우 그 사유 및 기간 등을 이용자에게 사전 또는 사후에 공지합니다.
⑦ 당 사이트는 당 사이트가 통제할 수 없는 사유로 인한 서비스중단의 경우(시스템관리자의 고의·과실 없는 디스크장애, 시스템다운 등)에 사전통지가 불가능하며 타인(PC통신회사, 기간통신사업자 등)의 고의·과실로 인한 시스템중단 등의 경우에는 통지하지 않습니다.
⑧ 당 사이트는 서비스를 특정범위로 분할하여 각 범위 별로 이용가능시간을 별도로 지정할 수 있습니다. 다만 이 경우 그 내용을 공지합니다.
제17조(서비스 이용제한 및 처리절차)

당 사이트는 다음 각 호에 해당하는 경우 서비스 전부 또는 일부의 이용을 제한할 수 있습니다.
1. 제13조에서 규정한 이용자의 의무를 이행하지 않은 경우
2. 타인의 명의 또는 가명을 이용하여 신청한 경우, 신청서의 내용을 허위로 기재하여 서비스 이용승낙을 득한 경우
3. 타인의 회원ID를 부정하게 사용하는 경우
4. 전기통신 관련 볍령 등에 위배되는 경우
5. 정보통신윤리위원회가 윤리심의에 따라 일정한 제재조치를 권고한 경우
제18조(이용자의 게시물 제한)

당 사이트는 이용자가 게시하거나 등록하는 서비스 내의 내용물이 다음 각 사항에 해당된다고 판단되는 경우에 사전 통지 없이 삭제할 수 있습니다.
1. 회사, 다른 이용자 또는 제 3자를 비방하거나 중상모략으로 명예를 손상시키는 내용인 경우
2. 공공질서 및 미풍약속에 위반되는 내용인 경우
3. 범죄적 행위에 결부된다고 인정되는 내용인 경우
4. 당 사이트 또는 제 3자의 저작권 등 기타 권리를 침해하는 경우
5. 기타 관계 법령이나 당 사이트에서 정한 규정에 위배되는 경우
제 6장 서비스 이용 해지
제19조서비스 이용계약의 해지)

① 이용자가 서비스 이용계약을 해지하고자 할 때에는 본인이 직접 메일 또는 전화 등을 통하여 당 사이트에 신청하여야 합니다.
②당 사이트는 이용자가 제17조에서 규정한 서비스 이용제한사항을 위반하고도 소정의 제한기간 내에 제한 사유를 해소하지 않았거나, 정당한 사유 없이 의견진술에 응하지 않은 경우에는 이용계약을 해지할 수 있습니다.
③ 제2항에 의해 해지된 이용자에 대하여는 일정기간 제7장 개인정보 보호
제20조(이용자 정보 사용에 대한 동의)

① 이용자의 개인정보에 대해서는 당 사이트의 개인정보 취급방침이 적용됩니다.
② 당 사이트의 회원 정보는 다음과 같이 수집, 사용, 관리, 보호됩니다.
1. 개인정보의 수집 : 당 사이트는 이용자의 당 사이트 서비스 가입 시 이용자가 제공하는 정보를 통하여 개인 정보를 수집합니다.
2. 개인정보의 사용 : 당 사이트는 당 사이트 서비스 제공과 관련해서 수집된 이용자의 신상정보를 본인의 승낙 없이 제3자에게 누설, 배포하지 않습니다. 단, 신용정보의 이용 및 보호에 관한 법률, 전기통신기본법, 전기통신사업법, 지방세법, 소비자보호법, 한국은행법, 형사소송법 등 기타 관계 법률에 특별한 규정에 의한 경우, 당 사이트에 대한 통계작성(고객만족도조사 포함), 학술연구 또는 시장조사를 위하여 필요한 경우로서 특정 개인을 식별할 수 없는 형태로 제공하는 경우, 이용자가 당 사이트에 제공한 개인정보를 스스로 공개한 경우에는 그러하지 않습니다.
3. 개인정보의 관리 : 이용자는 개인정보의 보호 및 관리를 위하여 서비스의 개인정보관리에서 수시로 이용자의 개인정보를 수정/삭제할 수 있습니다. 수신되는 정보 중 불필요하다고 생각되는 부분도 변경/조정할 수 있습니다.
4. 개인정보의 보호 : 이용자의 개인정보는 오직 이용자만이 열람/수정/삭제 할 수 있으며, 이는 전적으로 이용자의 ID와 비밀번호에 의해 관리되고 있습니다. 따라서 타인에게 이용자의 ID와 비밀번호를 알려주어서는 안되며, 작업 종료 시에는 반드시 로그아웃 하고, 웹 브라우저의 창을 닫아야 합니다.(이는 타인과 컴퓨터를 공유하는 인터넷 카페나 도서관 같은 공공장소에서 컴퓨터를 사용하는 경우에 이용자의 정보보호를 위하여 필요한 사항입니다)
③ 이용자가 당 사이트에 본 약관에 따라 이용신청을 하는 것은 당 사이트가 본 약관에 따라 신청서에 기재된 회원정보를 수집, 이용하는 것에 동의하는 것으로 간주됩니다.
④ "당 사이트"는 개인정보 보호를 위하여 관리자를 한정하여 그 수를 최소화하며 이용자의 개인정보의 분실, 도난, 유출, 변조 등으로 인한 이용자의 손해에 대하여 모든 책임을 집니다.
⑤ 이용자는 언제든지 "당 사이트"가 가지고 있는 자신의 개인정보에 대해 열람 및 오류정정을 요구할 수 있으며 "당 사이트"는 이에 대해 지체 없이 필요한 조치를 취할 의무를 집니다. 이용자가 오류의 정정을 요구한 경우에는 "당 사이트"는 그 오류를 정정할 때까지 당해 개인정보를 이용하지 않습니다.
⑥ 당 사이트로부터 개인정보를 제공받은 제3자는 개인정보의 수집목적 또는 제공받은 목적을 달성한 때에는 당해 개인정보를 지체 없이 파기합니다.
제21조(사용자의 정보 보안)

① 이용자가 당 사이트 서비스 가입 절차를 완료하는 순간부터 이용자는 입력한 정보의 비밀을 유지할 책임이 있으며, ID와 비밀번호를 사용하여 발생하는 모든 결과에 대한 책임은 이용자에게 있습니다.
② ID와 비밀번호에 관한 모든 관리의 책임은 이용자에게 있으며, 이용자의 ID나 비밀번호가 부정하게 사용되었다는 사실을 발견한 경우에는 즉시 당 사이트에 신고하여야 합니다. 신고를 하지 않음으로 인해 발생하는 모든 책임은 이용자 본인에게 있습니다.
③ 이용자는 당 사이트 서비스의 사용 종료 시 마다 정확히 로그아웃(Log-out)해야 하며, 로그아웃 하지 아니하여 제3자가 이용자에 관한 정보를 도용하는 등의 결과로 인해 발생하는 손해 및 손실에 대하여 당 사이트는 책임을 부담하지 아니합니다.
제 7장 사이트 소유권
제22조(당 사이트의 소유권)

① 당 사이트가 제공하는 서비스, 그에 필요한 소프트웨어, 이미지, 로고, 디자인, 정보 등과 관련된 지적재산권 및 기타 권리는 한국지식재산협회에 소유권이 있습니다.
② 당 사이트가 명시적으로 승인한 경우를 제외하고는 전항의 소정의 각 재산에 대한 전부 또는 일부의 수정, 대여, 대출, 판매, 배포, 제작, 양도, 재라이선스, 담보권 설정 행위, 상업적 이용 행위를 할 수 없으며, 제3자로 하여금 이와 같은 행위를 하도록 허락할 수 없습니다.
제23조(면책조항)

① 당 사이트는 서비스에 표출된 어떠한 의견이나 정보에 대해 확신이나 대표할 의무가 없으며 이용자나 제3자에 의해 표출된 의견을 승인하거나 반대하거나 수정 하지 않습니다.
② 당 사이트는 어떠한 경우라도 이용자가 서비스에 담긴 정보에 의존해 얻은 이득이나 입은 손해에 대해 책임이 없습니다.
③ 당 사이트는 이용자간 또는 이용자와 제3자간에 서비스를 매개로 하여 물품거래 혹은 금전적 거래 등과 관련 하여 어떠한 책임도 부담하지 아니하고, 이용자가 서비스의 이용과 관련하여 기대하는 이익에 관련하여 책임을 부담하지 않습니다.
제24조(손해배상)

당 사이트는 무료로 제공되는 서비스와 관련하여 회원에게 어떠한 손해가 발생하더라도 당 사이트가 고의로 행한 범죄행위를 제외하고 이에 대하여 책임을 부담하지 아니합니다.
제25조(관할법원)

본 서비스 이용과 관련하여 발생한 분쟁에 대해 소송이 제기될 경우 한국지식재산협회의 소재지에 있는 관할 법원으로 합니다.
제 8장 기타
제1조(시행일)

이 약관은 2008년 8월 22일부터 시행합니다.
				</textarea>
		</div>
		<div style="display: flex; text-align: center;">
			<span style="flex: 1;" class="clck" onclick="go_next();">동의 </span>
			<span style="border-left: solid 1px;"></span>
			<span style="flex: 1;" class="clck" onclick="alert('약관의 동의하지 않으시면 회원가입을 진행하실 수 없습니다.');"> 동의안함</span>
		</div>
	</div>
	
	<div id="111" class="custom_modal-content">
		여기는 아이디 비번찾기 폼111<br>
		여기는 아이디 비번찾기 폼111<br>
		여기는 아이디 비번찾기 폼111<br>
	</div>
	<div id="222" class="custom_modal-content">
		여기는 아이디 비번찾기 폼222<br>
		여기는 아이디 비번찾기 폼222<br>
		여기는 아이디 비번찾기 폼222<br>
	</div>
</div>
    
	<!-- javascript -->
	<script type="text/javascript" src="${contextPath }/resources/mogo/js/jquery.min.js"></script>
	<script type="text/javascript" src="${contextPath }/resources/vendor/bootstrap/js/bootstrap.min.js"></script>
	<%-- <script type="text/javascript" src="${contextPath }/resources/mogo/js/isotope.pkgd.min.js"></script>
	<script type="text/javascript" src="${contextPath }/resources/mogo/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="${contextPath }/resources/mogo/js/jquery.hoverdir.js"></script>
	<script type="text/javascript" src="${contextPath }/resources/mogo/js/modernizr.custom.97074.js"></script>
	<script type="text/javascript" src="${contextPath }/resources/mogo/js/unslider-min.js"></script>
	<script type="text/javascript" src="${contextPath }/resources/mogo/js/template.js"></script> --%>
	<script type="text/javascript" src="${contextPath }/resources/js/join.js"></script>
	<script type="text/javascript" src="${contextPath }/resources/js/Modal.js"></script>
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	
</body>
</html>