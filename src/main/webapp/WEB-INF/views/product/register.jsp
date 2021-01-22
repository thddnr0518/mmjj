<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<%@include file="../include/header.jsp"%>
<c:set var="contextPath" value="${pageContext.request.contextPath == '/' ? '' : pageContext.request.contextPath }" scope="application" />

<style>
	.uploadResult {
		width: 100%;
		background-color: gray;
	}
	
	.uploadResult ul {
		display: flex;
		flex-flow: row;
		justify-content: center;
		align-items: center;
	}
	
	.uploadResult ul li {
		list-style: none;
		padding: 10px;
	}
	
	.uploadResult ul li img {
		width: 100px;
	}
	
	.bigPictureWrapper {
	  position: absolute;
	  display: none;
	  justify-content: center;
	  align-items: center;
	  top:0%;
	  width:100%;
	  height:100%;
	  background-color: gray; 
	  z-index: 100;
	}
	
	.bigPicture {
	  position: relative;
	  display:flex;
	  justify-content: center;
	  align-items: center;
	}
	
	.bigPicutre img {
		width: 600px;
	}
</style>

<script type="text/javascript">
function fileCheck(obj){
	pathpoint = obj.value.lastIndexOf('.');
	filepoint = obj.value.substring(pathpoint+1,obj.length);
	filetype = filepoint.toLowerCase();
	if(filetype=='jpg'||filetype=='gif'||filetype=='png'||filetype=='jpeg'||filetype=='bmp'){
		
	} else {
		alert("이미지 파일만 선택할 수 있습니다.");
		parentObj = obj.parentNode
		node = parentObj.replaceChild(obj.cloneNode(true),obj);
		return false;
	}
	if(filetype=='bmp'){
		upload = confirm('BMP 파일은 웹상에서 사용하기엔 적절한 이미지가 아닙니다. \n그래도 계속 하시겠습니까?');
		if(!upload) return false;
	}
}
</script>

<script type="text/javascript">
$(document).ready(function() {
	var formObj = $("form[role='form']");
	
	$("button[type='submit']").on("click", function(e){
		e.preventDefault();
		    
		console.log("submit clicked");
		var str = "";
		    
		$(".uploadResult ul li").each(function(i, obj){
			var jobj = $(obj);
		      
			console.dir(jobj);
			console.log("-------------------------");
			console.log(jobj.data("filename"));
		      
			str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].filetype' value='"+ jobj.data("type")+"'>";
		});
		    
		console.log(str);
		formObj.append(str).submit();
	});
		  
	var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	var maxSize = 5242880; //5MB

	function checkExtension(obj) {
		
		fileType = obj.type.substring(0,5);

		if(fileType=="image"){
			
		}else if(fileType=='bmp'){
			
			upload = confirm('BMP 파일은 웹상에서 사용하기엔 적절한 이미지가 아닙니다. \n그래도 계속 하시겠습니까?');
			
			if(!upload){
				
				$("input[type='file']").val("");
				
				return false;
			}
		}else if(obj.size >= maxSize) {
			
			alert("파일 사이즈 초과");
			
			$("input[type='file']").val("");
			
			return false;
		}else{
			
			alert("이미지 파일만 선택할 수 있습니다.");
			
			$("input[type='file']").val("");
			
			return false;
		}
		
		return true;
	}

	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	
	$("input[type='file']").change(function(e){
		
		var formData = new FormData();
		    
		var inputFile = $("input[name='uploadFile']");

		var files = inputFile[0].files;
		
		
		if(!checkExtension(files[0]) ){
			return false;
		}
		
		formData.append("uploadFile", files[0]);
		
		$.ajax({
			url: "${contextPath}/oneUploadAjaxAction",
			processData: false, 
			contentType: false,
			beforeSend: function(xhr){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			data: formData,
			type: "POST",
			dataType:"json",
			success: function(result){
				showUploadResult(result); // 업로드 결과 처리 함수
			}
		}); //$.ajax
	});  

	function showUploadResult(obj) {
		    
	    if(!obj || obj.length == 0) { 
	    	return;
	    }
		    
	    var uploadUL = $(".uploadResult ul");
	    var str ="";
		    
		if(obj.image){
			var fileCallPath = encodeURIComponent(obj.uploadPath+ "/s_" + obj.uuid + "_" + obj.fileName);
			str += "<li data-path='" + obj.uploadPath + "'";
			str +=" data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "' data-type='" + obj.image + "'"
			str +" ><div>";
			str += "<span> " + obj.fileName + "</span>";
			str += "<button type='button' data-file=\'" + fileCallPath + "\' "
			str += "data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
			str += "<img src='${contextPath}/display?fileName=" + fileCallPath + "'>";
			str += "</div>";
			str +"</li>";
		} else {
			var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);			      
		    var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
			      
			str += "<li "
			str += "data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "' data-type='" + obj.image + "' ><div>";
			str += "<span> " + obj.fileName + "</span>";
			str += "<button type='button' data-file=\'" + fileCallPath + "\' data-type='file' " 
			str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
			str += "<img src='${contextPath}/resources/img/attach.png'></a>";
			str += "</div>";
			str +"</li>";
			alert("이미지파일만 가능합니다.");
			return;
		}
		    
		uploadUL.append(str);
	}

	$(".uploadResult").on("click", "button", function(e) {
		
		console.log("delete file");
		      
		var targetFile = $(this).data("file");
		var type = $(this).data("type");
		var targetLi = $(this).closest("li");
		    
		$.ajax({
			url: "${contextPath}/deleteFile",
			data: {fileName: targetFile, type:type},
			beforeSend: function(xhr){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			dataType:"text",
			type: "POST",
			success: function(result){
				alert(result);
				$("input[type='file']").val("");
				targetLi.remove();
			}
		}); //$.ajax
	});

});
</script>
		</div>
	</header>
<section>

<div class="customBoard">
    <div class="panel panel-default">

      <div class="panel-heading">Product Register</div>
      <!-- /.panel-heading -->
      <div class="panel-body">

        <form role="form" action="${contextPath}/product/register" method="post">
        
			<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
			
			<div class="form-group">
			  <label>상품명</label> <input class="form-control" name="prodName" maxlength="66">
			</div>
			
			<div class="form-group">
			  <label>상품 설명</label>
			  <textarea class="form-control" rows="3" name="prodContent" maxlength="333"></textarea>
			</div>
			
			<div class="form-group">
			  <label>Writer</label> <input class="form-control" name="writer"
			  value='<sec:authentication property="principal.username"/>' readonly="readonly">
			</div>
			<button type="submit" class="btn btn-default">Submit
			  Button</button>
			<button type="reset" class="btn btn-default">Reset Button</button>
        </form>

      </div>

    </div>
</div>

<div class="customBoard">
    <div class="panel panel-default">

      <div class="panel-heading">File Attach</div>
      <!-- /.panel-heading -->
      <div class="panel-body">
        <div class="form-group uploadDiv">
            <input type="file" name="uploadFile" multiple accept="image/*">
        </div>
        
        <div class="uploadResult"> 
          <ul>
          
          </ul>
        </div>
        
        
      </div>

    </div>
</div>
</section>

<%@include file="../include/footer.jsp"%>