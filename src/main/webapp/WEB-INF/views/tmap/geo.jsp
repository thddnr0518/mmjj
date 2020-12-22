<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath == '/' ? '' : pageContext.request.contextPath }" scope="application" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>좌표</title>
<style type="text/css">
#map_div{
	width: 500px;
	height: 300px;
}
</style>
<script type="text/javascript" src="${contextPath }/resources/js/jQuery/3.5.1/jquery-3.5.1.min.js"></script>
<script
	src="https://apis.openapi.sk.com/tmap/jsv2?version=1&appKey=l7xx852093963c6040128a600131b505fa8a"></script>
<script type="text/javascript">
	var map, marker;
	function initTmap() {

		// 1. 지도 띄우기
		map = new Tmapv2.Map("map_div", {
			center : new Tmapv2.LatLng(37.570028, 126.986072),
			zoom : 15,
			zoomControl : true,
			scrollwheel : true

		});

		// 마커 초기화
		marker1 = new Tmapv2.Marker(
				{
					icon : "http://tmapapis.sktelecom.com/upload/tmap/marker/pin_b_m_a.png",
					iconSize : new Tmapv2.Size(24, 38),
					map : map
				});

		// 2. API 사용요청
		var lon, lat;

		map.addListener("click",function onClick(evt) {
			var mapLatLng = evt.latLng;

			//기존 마커 삭제
			marker1.setMap(null);

			var markerPosition = new Tmapv2.LatLng(
					mapLatLng._lat, mapLatLng._lng);
			//마커 올리기
			marker1 = new Tmapv2.Marker(
					{
						position : markerPosition,
						icon : "http://tmapapis.sktelecom.com/upload/tmap/marker/pin_b_m_p.png",
						iconSize : new Tmapv2.Size(24, 38),
						map : map
					});

			reverseGeo(mapLatLng._lng, mapLatLng._lat);
		});

		function reverseGeo(lon, lat) {
			$.ajax({
				method : "GET",
				url : "https://apis.openapi.sk.com/tmap/geo/reversegeocoding?version=1&format=json&callback=result",
				async : false,
				data : {
					"appKey" : "l7xx852093963c6040128a600131b505fa8a",
					"coordType" : "WGS84GEO",
					"addressType" : "A10",
					"lon" : lon,
					"lat" : lat
				},
				success : function(response) {
					// 3. json에서 주소 파싱
					var arrResult = response.addressInfo;

					//법정동 마지막 문자 
					var lastLegal = arrResult.legalDong
							.charAt(arrResult.legalDong.length - 1);

					// 새주소
					newRoadAddr = arrResult.city_do + ' '
							+ arrResult.gu_gun + ' ';

					if (arrResult.eup_myun == ''
							&& (lastLegal == "읍" || lastLegal == "면")) {//읍면
						newRoadAddr += arrResult.legalDong;
					} else {
						newRoadAddr += arrResult.eup_myun;
					}
					newRoadAddr += ' ' + arrResult.roadName + ' '
							+ arrResult.buildingIndex;

					// 새주소 법정동& 건물명 체크
					if (arrResult.legalDong != ''
							&& (lastLegal != "읍" && lastLegal != "면")) {//법정동과 읍면이 같은 경우

						if (arrResult.buildingName != '') {//빌딩명 존재하는 경우
							newRoadAddr += (' (' + arrResult.legalDong
									+ ', ' + arrResult.buildingName + ') ');
						} else {
							newRoadAddr += (' (' + arrResult.legalDong + ')');
						}
					} else if (arrResult.buildingName != '') {//빌딩명만 존재하는 경우
						newRoadAddr += (' (' + arrResult.buildingName + ') ');
					}

					// 구주소
					jibunAddr = arrResult.city_do + ' '
							+ arrResult.gu_gun + ' '
							+ arrResult.legalDong + ' ' + arrResult.ri
							+ ' ' + arrResult.bunji;
					//구주소 빌딩명 존재
					if (arrResult.buildingName != '') {//빌딩명만 존재하는 경우
						jibunAddr += (' ' + arrResult.buildingName);
					}

					result = "새주소 : " + newRoadAddr + "</br>";
					result += "지번주소 : " + jibunAddr + "</br>";
					result += "위경도좌표 : " + lat + ", " + lon;

					var resultDiv = document.getElementById("result");
					resultDiv.innerHTML = result;

				},
				error : function(request, status, error) {
					console.log("code:" + request.status + "\n"
							+ "message:" + request.responseText + "\n"
							+ "error:" + error);
				}
			});

		}
	}
</script>
</head>
<body onload="initTmap();">
	<p id="result"></p>
	<div id="map_wrap" class="map_wrap3">
		<div id="map_div"></div>
	</div>
	<div class="map_act_btn_wrap clear_box"></div>
</body>
</html>