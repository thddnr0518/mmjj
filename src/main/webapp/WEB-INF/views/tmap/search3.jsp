<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath == '/' ? '' : pageContext.request.contextPath }" scope="application" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>검색3</title>
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

   function initTmap() {
      // 1. 지역 분류 코드 API 요청
      var largeCdFlag = $("#largeCdFlag").val();
      var middleCdFlag = $("#middleCdFlag").val();
      var smallCdFlag = $("#smallCdFlag").val();

      console.log(largeCdFlag);
      console.log(middleCdFlag);
      console.log(smallCdFlag);

      $
            .ajax({
               method : "GET",
               url : "https://apis.openapi.sk.com/tmap/poi/areascode?version=1&format=json&callback=result",
               async : false,
               data : {
                  "count" : "20",
                  "page" : "1",
                  "areaTypCd" : "01",
                  "largeCdFlag" : largeCdFlag,
                  "middleCdFlag" : middleCdFlag,
                  "smallCdFlag" : smallCdFlag,
                  "appKey" : "l7xx852093963c6040128a600131b505fa8a"
               },
               success : function(response) {
                  var resultpoiAreaCodes = response.areaCodeInfo.poiAreaCodes;

                  var innerHtml = "";

                  for ( var i in resultpoiAreaCodes) {

                     var depth = resultpoiAreaCodes[i].areaDepth;
                     var cd = resultpoiAreaCodes[i].largeCd
                           + resultpoiAreaCodes[i].middleCd
                           + resultpoiAreaCodes[i].smallCd;

                     var name = resultpoiAreaCodes[i].districtName;

                     innerHtml += "<div>name:" + name + " depth:"
                           + depth + " cd:" + cd + "<\div>";
                  }

                  $("#searchResult").html(innerHtml);

               },
               error : function(request, status, error) {
                  console.log("code:" + request.status + "\n"
                        + "message:" + request.responseText + "\n"
                        + "error:" + error);
               }
            });

   }
</script>
   <body onload="initTmap()">

      <div class="clear_hr"></div>

      <div class="sample_area">
         <div class="ft_area">
            <div class="ft_select_wrap">
               <span class="ft_tit t2">대분류 설정</span>      
               <select id="largeCdFlag">
                  <option value="Y">Y</option>
                  <option value="N">N</option>
               </select>

               <span class="ft_tit t2">중분류 설정</span>      
               <select id="middleCdFlag">
                  <option value="Y">Y</option>
                  <option value="N">N</option>
               </select>

               <span class="ft_tit t2">소분류 설정</span>      
               <select id="smallCdFlag">
                  <option value="Y">Y</option>
                  <option value="N">N</option>
               </select>
               <button id="btn_select" onclick="initTmap();">적용하기</button>
            </div>
            <div class="search_rst_wrap" style="display: table;">
               <div class="search_rst">
                  <div class="title">
                     <strong>Search</strong> Results
                  </div>
                  <div class="rst_wrap">
                     <div class="rst mCustomScrollbar">
                        <ul id="searchResult" name="searchResult">
                           <li>검색결과</li>
                        </ul>
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </div>
   </body>
   </html>