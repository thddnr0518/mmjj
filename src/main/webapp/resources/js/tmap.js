$(document).ready(function(){
	
	var map = new Tmapv2.Map("map_div",{
		center: new Tmapv2.LatLng(35.138145027916586, 126.90623825585016),
		zoom: 15
	});
	
	var marker = new Tmapv2.Marker({
		position: new Tmapv2.LatLng(35.14430828428361, 126.90538492701423),
		icon : "http://tmapapis.sktelecom.com/upload/tmap/marker/pin_r_m_s.png",
		iconSize : new Tmapv2.Size(24, 38),
		map: map
	});

	var marker2 = new Tmapv2.Marker({
		position: new Tmapv2.LatLng(35.13674495882167, 126.91211052304664),
		icon : "http://tmapapis.sktelecom.com/upload/tmap/marker/pin_r_m_e.png",
		iconSize : new Tmapv2.Size(24, 38),
		map: map
	});
	
	var testmarker = new Tmapv2.Marker(
		{
			icon : "http://tmapapis.sktelecom.com/upload/tmap/marker/pin_b_m_a.png",
			iconSize : new Tmapv2.Size(24, 38),
			map : map
		});
	
	map.addListener("click",function onClick(evt) {
		var mapLatLng = evt.latLng;
		
		testmarker.setMap(map);

		var markerPosition = new Tmapv2.LatLng(
				mapLatLng._lat, mapLatLng._lng);

		testmarker = new Tmapv2.Marker(
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
	
	$("#btn_select").click(function() {
		var searchKeyword = $('#searchKeyword').val(); // 검색 키워드
		$.ajax({
			method : "GET", // 요청 방식
			url : "https://apis.openapi.sk.com/tmap/pois?version=1&format=json&callback=result", // url 주소
			async : false, // 동기설정
			data : { // 요청 데이터 정보
				"appKey" : "l7xx852093963c6040128a600131b505fa8a", // 발급받은 Appkey
				"searchKeyword" : searchKeyword, // 검색 키워드
				"resCoordType" : "EPSG3857", // 요청 좌표계
				"reqCoordType" : "WGS84GEO", // 응답 좌표계
				"count" : 10 // 가져올 갯수
			},
			success : function(response) {
				var resultpoisData = response.searchPoiInfo.pois.poi;

				// 2. 기존 마커, 팝업 제거
				if (markerArr.length > 0) {
					for(var i in markerArr) {
						markerArr[i].setMap(null);
					}
					markerArr = [];
				}
				
				if (labelArr.length > 0) {
					for (var i in labelArr) {
						labelArr[i].setMap(null);
					}
					labelArr = [];
				}

				var innerHtml = ""; // Search Reulsts 결과값 노출 위한 변수
				//맵에 결과물 확인 하기 위한 LatLngBounds객체 생성
				var positionBounds = new Tmapv2.LatLngBounds(); 

				// 3. POI 마커 표시
				for (var k in resultpoisData) {
					// POI 마커 정보 저장
					var noorLat = Number(resultpoisData[k].noorLat);
					var noorLon = Number(resultpoisData[k].noorLon);
					var name = resultpoisData[k].name;
					
					// POI 정보의 ID
					var id = resultpoisData[k].id;

					// 좌표 객체 생성
					var pointCng = new Tmapv2.Point(
							noorLon, noorLat);
					
					// EPSG3857좌표계를 WGS84GEO좌표계로 변환
					var projectionCng = new Tmapv2.Projection.convertEPSG3857ToWGS84GEO(
							pointCng);

					var lat = projectionCng._lat;
					var lon = projectionCng._lng;

					// 좌표 설정
					var markerPosition = new Tmapv2.LatLng(
							lat, lon);

					// Marker 설정
					marker = new Tmapv2.Marker(
						{
							position : markerPosition, // 마커가 표시될 좌표
							//icon : "http://tmapapis.sktelecom.com/upload/tmap/marker/pin_b_m_a.png",
							icon : "http://tmapapis.sktelecom.com/upload/tmap/marker/pin_b_m_"
									+ k
									+ ".png", // 아이콘 등록
							iconSize : new Tmapv2.Size(
									24, 38), // 아이콘 크기 설정
							title : name, // 마커 타이틀
							map : map // 마커가 등록될 지도 객체
						});

					// 결과창에 나타날 검색 결과 html
					innerHtml += "<li><div><img src='http://tmapapis.sktelecom.com/upload/tmap/marker/pin_b_m_" + k + ".png' style='vertical-align:middle;'/><span>"
							+ name
							+ "</span>  <button type='button' name='sendBtn' onClick='poiDetail("
							+ id
							+ ");'>상세보기</button></div></li>";
					
					// 마커들을 담을 배열에 마커 저장
					markerArr.push(marker);
					positionBounds.extend(markerPosition); // LatLngBounds의 객체 확장
				}

				$("#searchResult").html(innerHtml); //searchResult 결과값 노출
				map.panToBounds(positionBounds); // 확장된 bounds의 중심으로 이동시키기
				map.zoomOut();
			},
			error : function(request, status, error) {
				console.log("code:"
						+ request.status + "\n"
						+ "message:"
						+ request.responseText
						+ "\n" + "error:" + error);
			}
		});
	});
	console.log(map._status.center);
	document.getElementById('tempLat').value = map._status.center._lat;
	document.getElementById('tempLng').value = map._status.center._lng;
			
});