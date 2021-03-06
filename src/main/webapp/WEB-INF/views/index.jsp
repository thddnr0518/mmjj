<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="include/mainHeader.jsp" %>

<section id="nino-slider" class="carousel slide container" data-ride="carousel" style="padding-top: 100px; z-index: 4;">
	
	
	
	<!-- 랭크 -->
 	<%-- <div class="customBoard">
		<div class="panel panel-default">
			<div class="panel-heading">Files</div>
			<div class="panel-body">
				<div class="uploadFile">
				  	<c:forEach items="${rank }" var="rank">
						<input type="text" value="${rank.viewcnt}" name="viewcnt"><br>
						<input type="text" value="${rank.title}" name="title"><br>
						<input type="text" value="${rank.bno}" name="bno"><br>
						<input type="text" value="${rank.uuid}" id="uploadPath3"><br>
						<input type="text" value="${rank.uploadPath}" id="uploadPath2"><br>
						<input type="text" value="${rank.fileName}" id="uploadPath4"><br>
						<input type="text" value="${contextPath}${rank.imgSrc}${rank.uploadPath}\s_${rank.uuid}_${rank.fileName}"><br>
						<img alt="랭크이미지" src="${contextPath}${rank.imgSrc}${rank.uploadPath}\s_${rank.uuid}_${rank.fileName}"><br>
					</c:forEach>
					<ul>
					</ul>
				</div>
				<div class="uploadResult"> 
					<ul>
					</ul>
				</div>
			</div>
		</div>
	</div> --%>
	
 <!-- 한달 이내 인기글 시작 -->
	<div class="carousel-inner" role="listbox">
		<c:forEach items="${rank}" var="rank" varStatus="status">
			<div class="item ${ status.first ? 'active' : ''}">
				<h2 class="nino-sectionHeading" >
					<span class="nino-subHeading">
						<img class="rankImg" alt="등수 이미지" src="${contextPath}/resources/img/${status.count }.png">
						${rank.title}
					</span>
					<img class="preview3" alt="랭크이미지"  src="${contextPath}${rank.imgSrc}${rank.uploadPath}\s_${rank.uuid}_${rank.fileName}" >
				</h2>
				<a href="${contextPath}/board/read?bno=${rank.bno}" class="bttn">Go to Show</a>
			</div>
		</c:forEach>
		<div class="item">
			<h2 class="nino-sectionHeading">
				<span class="nino-subHeading">Shop</span>
				Welcome <br>
			</h2>
			<a href="#" class="bttn">Go to Park</a>
		</div>
	</div>
<!-- 한달 이내 인기글 끝 -->	 
	
	<!-- Indicators -->
	<ol class="carousel-indicators clearfix">
		<li data-target="#nino-slider" data-slide-to="0" class="active">
			<div class="inner">
				<span class="number">01</span> First	
			</div>
		</li>
		<li data-target="#nino-slider" data-slide-to="1">
			<div class="inner">
				<span class="number">02</span> Seconds	
			</div>
		</li>
		<li data-target="#nino-slider" data-slide-to="2">
			<div class="inner">
				<span class="number">03</span> Third	
			</div>
		</li>
		<li data-target="#nino-slider" data-slide-to="3">
			<div class="inner">
				<span class="number">04</span> Animal Park
			</div>
		</li>
	</ol>
</section>
</header>


	<!-- MMJJ 시작 -->
	<!-- 그달의 인기글 시작 -->
	 <section id="board">
		<div class="container">
			<h2 class="nino-sectionHeading">
				<span class="nino-subHeading"></span>
			</h2>
			<p class="nino-sectionDesc">전달의 인기글 탑3</p>
			<div class="sectionContent">
				<div class="row nino-hoverEffect">
					<c:forEach items="${monthRank}" var="monthRank" varStatus="status">
						<div class="col-md-4 col-sm-4">
							<div class="item ${ status.first ? 'active' : ''}">
								<a class="overlay" href="${contextPath}/board/read?bno=${monthRank.bno}">
									<span class="content">
										View
									</span>
									<img style="width: 300px; height: 200px;" src="${contextPath}${monthRank.imgSrc}${monthRank.uploadPath}\s_${monthRank.uuid}_${monthRank.fileName}" alt="최근 게시글1">
								</a>
							</div>
						</div>
					</c:forEach>
				</div>
				<div style="padding-top: 20px; text-align: right; color: #566270;">
					<a href="${contextPath }/board/list" class="mbttn">Show More...</a>
				</div>
			</div>
		</div>		
	</section>
	<!-- 그 달의 인기글 끝 -->
	
	<!-- 랭킹 높은 게시글 시작 -->
	 <section id="ranking">
		<div class="container">
			<h2 class="nino-sectionHeading">
				<span class="nino-subHeading">MMJJ Ranking</span>
				<!-- 명예의 전당 -->
			</h2>
			<p class="nino-sectionDesc">각 부문 랭킹 3대장 </p>
			<div class="sectionContent">
				<div class="row nino-hoverEffect">
			
					<c:forEach items="${rank}" var="rank" varStatus="status">
						<div class="col-md-4 col-sm-4">
							<div class="item ${ status.first ? 'active' : ''}">
								<a class="overlay" href="${contextPath}/board/read?bno=${rank.bno}">
									<span class="content">
										View
									</span>
									<img style="margin: 0 auto;" width="300px" height="200px" src="${contextPath}${rank.imgSrc}${rank.uploadPath}\s_${rank.uuid}_${rank.fileName}" alt="최근 게시글1">
								</a>
							</div>
						</div>
					</c:forEach>
				</div>
				<div style="padding-top: 20px; text-align: right; color: #566270;">
					<a href="${contextPath }/rank" class="mbttn">Show More...</a>
				</div>
			</div>
		</div>		
	</section>	
	<!-- 랭킹 높은 게시글 끝 -->
	<!-- MMJJ 끝 -->
	
	<!-- 샵 시작 -->
	 <section id="shop">
		<div class="container">
			<h2 class="nino-sectionHeading">
				<span class="nino-subHeading">Shop</span>
			</h2>
			<p class="nino-sectionDesc">매출 3대장</p>
			<div class="sectionContent">
				<div class="row nino-hoverEffect">
					<c:forEach items="${rank}" var="rank" varStatus="status">
					<div class="col-md-4 col-sm-4">
					<img alt="등수 이미지" src="${contextPath}/resources/img/${status.count }.png" class="rankImg">
						<div class="item ${ status.first ? 'active' : ''}">
							<a class="overlay" href="${contextPath}/board/read?bno=${rank.bno}">
								<span class="content">
									${rank.title}
								</span>
								<img class="preview3" src="${contextPath}${rank.imgSrc}${rank.uploadPath}\s_${rank.uuid}_${rank.fileName}" alt="최근 게시글1">
							</a>
						</div>
					</div>
					</c:forEach>
				</div>
				<div style="padding-top: 20px; text-align: right; color: #566270;">
					<a href="${contextPath }/product/list" class="mbttn">Show More...</a>
				</div>
			</div>
		</div>		
	</section>	
	<!-- 샵 끝 -->
	
	<!-- Animal Park 시작-->
	<%-- <section id="nino-portfolio">
		<div class="container">
			<h2 class="nino-sectionHeading">
				<span class="nino-subHeading">Park of Animal</span>
				need of our animal
			</h2>
			<p class="nino-sectionDesc">
				동물들을 위해 조성된 공원입니다.<br>
				사랑하는 동물들에게 필요한 것이 있다면 여기서 찾아보세요. 
			</p>
		</div>
		<div class="sectionContent">
			<ul class="nino-portfolioItems">
				<li class="item">
					<a class="nino-prettyPhoto" rel="prettyPhoto[gallery1]" title="Development Mobile" href="${contextPath }/resources/mogo/images/our-work/img-1.jpg">
						<img src="${contextPath }/resources/mogo/images/our-work/img-1.jpg" />
						<div class="overlay">
							<div class="content">
								<i class="mdi mdi-crown nino-icon"></i>
								<h4 class="title">Park</h4>
								<span class="desc">산책으로 스트레스를 날려보세요.</span>
							</div>
						</div>
					</a>
				</li>
				<li class="item">
					<a class="nino-prettyPhoto" rel="prettyPhoto[gallery1]" title="Development Mobile" href="${contextPath }/resources/mogo/images/our-work/img-2.jpg">
						<img src="${contextPath }/resources/mogo/images/our-work/img-2.jpg" />
						<div class="overlay">
							<div class="content">
								<i class="mdi mdi-cube-outline nino-icon"></i>
								<h4 class="title">Cafe</h4>
								<span class="desc">멈뭄미 : "먀몸"<br>고먐미 : "멈멈"</span>
							</div>
						</div>
					</a>
				</li>
				<li class="item">
					<a class="nino-prettyPhoto" rel="prettyPhoto[gallery1]" title="Development Mobile" href="${contextPath }/resources/mogo/images/our-work/img-3.jpg">
						<img src="${contextPath }/resources/mogo/images/our-work/img-3.jpg" />
						<div class="overlay">
							<div class="content">
								<i class="mdi mdi-desktop-mac nino-icon"></i>
								<h4 class="title">물건 파는 Shop</h4>
								<span class="desc">Flex.</span>
							</div>
						</div>
					</a>
				</li>
				<li class="item">
					<a class="nino-prettyPhoto" rel="prettyPhoto[gallery1]" title="Development Mobile" href="${contextPath }/resources/imogo/mages/our-work/img-4.jpg">
						<img src="${contextPath }/resources/mogo/images/our-work/img-4.jpg" />
						<div class="overlay">
							<div class="content">
								<i class="mdi mdi-flower nino-icon"></i>
								<h4 class="title">Beauty</h4>
								<span class="desc">날개가 옷이더라?</span>
							</div>
						</div>
					</a>
				</li>
				<li class="item">
					<a class="nino-prettyPhoto" rel="prettyPhoto[gallery1]" title="Development Mobile" href="${contextPath }/resources/mogo/images/our-work/img-5.jpg">
						<img src="${contextPath }/resources/mogo/images/our-work/img-5.jpg" />
						<div class="overlay">
							<div class="content">
								<i class="mdi mdi-gamepad-variant nino-icon"></i>
								<h4 class="title">Hospital</h4>
								<span class="desc">이상 행동을 한다면 꼭 들려주세요.</span>
							</div>
						</div>
					</a>
				</li>
				<li class="item">
					<a class="nino-prettyPhoto" rel="prettyPhoto[gallery1]" title="Development Mobile" href="${contextPath }/resources/mogo/images/our-work/img-6.jpg">
						<img src="${contextPath }/resources/mogo/images/our-work/img-6.jpg" />
						<div class="overlay">
							<div class="content">
								<i class="mdi mdi-gnome nino-icon"></i>
								<h4 class="title">Animal Pharmacy</h4>
								<span class="desc">"병원에서 진단을 받기 힘들다면..."</span>
							</div>
						</div>
					</a>
				</li>
				<li class="item">
					<a class="nino-prettyPhoto" rel="prettyPhoto[gallery1]" title="Development Mobile" href="${contextPath }/resources/mogo/images/our-work/img-7.jpg">
						<img src="${contextPath }/resources/mogo/images/our-work/img-7.jpg" />
						<div class="overlay">
							<div class="content">
								<i class="mdi mdi-guitar-electric nino-icon"></i>
								<h4 class="title">Pet Hotel</h4>
								<span class="desc">당분간 출장을 가야한다면?</span>
							</div>
						</div>
					</a>
				</li>
			</ul>
		</div>
	</section> --%>
	<!-- Animal Park 끝-->
	
	 <!-- About (연혁) 시작 -->
	<%-- <section id="About">
		<div class="container">
			<h2 class="nino-sectionHeading">
				<span class="nino-subHeading">Who we are</span>
				Meet our team
			</h2>
			<p class="nino-sectionDesc">
				Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. 
			</p>
			<div class="sectionContent">
				<div class="row nino-hoverEffect">
					<div class="col-md-4 col-sm-4">
						<div class="item">
							<div class="overlay" href="#">
								<div class="content">
									<a href="#" class="nino-icon"><i class="mdi mdi-facebook"></i></a>
									<a href="#" class="nino-icon"><i class="mdi mdi-twitter"></i></a>
									<a href="#" class="nino-icon"><i class="mdi mdi-pinterest"></i></a>
									<a href="#" class="nino-icon"><i class="mdi mdi-instagram"></i></a>
								</div>
								<img src="${contextPath }/resources/mogo/images/our-team/img-1.jpg" alt="">
							</div>
						</div>
						<div class="info">
							<h4 class="name">Matthew Dix</h4>
							<span class="regency">Graphic Design</span>
						</div>
					</div>
					<div class="col-md-4 col-sm-4">
						<div class="item">
							<div class="overlay" href="#">
								<div class="content">
									<a href="#" class="nino-icon"><i class="mdi mdi-facebook"></i></a>
									<a href="#" class="nino-icon"><i class="mdi mdi-twitter"></i></a>
									<a href="#" class="nino-icon"><i class="mdi mdi-pinterest"></i></a>
									<a href="#" class="nino-icon"><i class="mdi mdi-instagram"></i></a>
								</div>
								<img src="${contextPath }/resources/mogo/images/our-team/img-2.jpg" alt="">
							</div>
						</div>
						<div class="info">
							<h4 class="name">Christopher Campbell</h4>
							<span class="regency">Branding/UX design</span>
						</div>
					</div>
					<div class="col-md-4 col-sm-4">
						<div class="item">
							<div class="overlay" href="#">
								<div class="content">
									<a href="#" class="nino-icon"><i class="mdi mdi-facebook"></i></a>
									<a href="#" class="nino-icon"><i class="mdi mdi-twitter"></i></a>
									<a href="#" class="nino-icon"><i class="mdi mdi-pinterest"></i></a>
									<a href="#" class="nino-icon"><i class="mdi mdi-instagram"></i></a>
								</div>
								<img src="${contextPath }/resources/mogo/images/our-team/img-3.jpg" alt="">
							</div>
						</div>
						<div class="info">
							<h4 class="name">Michael Fertig </h4>
							<span class="regency">Developer</span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section> --%>
	 <!-- About (연혁) 끝 -->
<%@ include file="include/footer.jsp" %>
