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
	var formObj = $("#modifyForm");
	
	$("button").on("click", function(e) {
		e.preventDefault(); 
		 
		var operation = $(this).data("oper");
		 
		console.log(operation);
		 
		if(operation === "remove") {
			formObj.attr("action", "${contextPath}/product/remove");
		} else if(operation === "list") {
			//move to list
			formObj.attr("action", "${contextPath}/product/list").attr("method","get");
			
			var pageNumTag = $("input[name='pageNum']").clone();
			var amountTag = $("input[name='amount']").clone();
			var keywordTag = $("input[name='keyword']").clone();
			var typeTag = $("input[name='type']").clone();
			
			formObj.empty();
			
			formObj.append(pageNumTag);
			formObj.append(amountTag);
			formObj.append(keywordTag);
			formObj.append(typeTag);
			//self.location = "${contextPath}/board/list";
		
			//return;      
		} else if (operation === "modify") {
			
	        console.log("submit clicked");
	        
	        var str = "";
	        
	        $(".uploadResult ul li").each(function(i, obj){
	          
	          var jobj = $(obj);
	          
	          console.dir(jobj);
	          
	          str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
	          str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
	          str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
	          str += "<input type='hidden' name='attachList["+i+"].filetype' value='"+ jobj.data("type")+"'>";
	          
	        });
	        
	        formObj.append(str).submit();
		}
		
		formObj.submit();
	});
});
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
		  
	var maxSize = 5242880; //5MB

	function checkExtension(fileName, fileSize) {
		
		pathpoint = fileName.lastIndexOf('.');
		filepoint = fileName.substring(pathpoint+1,fileName.length);
		fileType = filepoint.toLowerCase();
		
		console.log(fileType);
		
		if(fileType=='jpg'||fileType=='gif'||fileType=='png'||fileType=='jpeg'){
			
		} else if(fileType=='bmp') {
			
			upload = confirm('BMP 파일은 웹상에서 사용하기엔 적절한 이미지가 아닙니다. \n그래도 계속 하시겠습니까?');
			
			if(!upload){
				
				$("input[type='file']").val("");
				
				return false;
			}
		} else if(fileSize >= maxSize) {
			
			alert("파일 사이즈 초과");
			
			$("input[type='file']").val("");
			
			return false;
		} else {
			
			alert("이미지 파일만 선택할 수 있습니다.");
			
			$("input[type='file']").val("");
			
			return false;
		}
		
		return true;
	}

	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	
	$("input[name='uploadFile']").change(function(e){
		
		var formData = new FormData();
		
		var inputFile = $("input[name='uploadFile']");
		
		var files = inputFile[0].files;
		
		for(var i = 0; i < files.length; i++){

			if(!checkExtension(files[i].name, files[i].size) ){
				return false;
			}
			
			formData.append("uploadFile", files[i]);
		}
		
		$.ajax({
			url: "${contextPath}/uploadAjaxAction",
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
	
	// 일반 이미지 미리보기
	function showUploadResult(uploadResultArr) {
		
	    if(!uploadResultArr || uploadResultArr.length == 0) { 
	    	return;
	    }
		    
	    var uploadUL = $(".uploadResult ul");
	    var str ="";

	    $(uploadResultArr).each(function(i, obj) {
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
	    });
		    
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

	// 대표이미지 미리보기
	$("#productImg").change(function(){
		
		if(this.files && this.files[0]) {
			
			var reader = new FileReader;
			
			reader.onload = function(data) {
				$(".select_img img").attr("src", data.target.result).width(130);   
				$(".select_img img").attr("src", data.target.result).height(130);  
			}
		reader.readAsDataURL(this.files[0]);
		}
	});
});
</script>
		</div>
	</header>
<section>
	<form role="form" action="${contextPath}/product/modify?${_csrf.parameterName}=${_csrf.token}" method="post" autocomplete="off" enctype="multipart/form-data" id="modifyForm">
	
		<input type="hidden" name="productNo" value="${pDto.productNo}">
		<input type="hidden" name="productImg" value="${pDto.productImg}">
		<input type="hidden" name="productThumb" value="${pDto.productThumb}">
		<input type="hidden" name="pageNum" value="${cri.pageNum}">
		<input type="hidden" name="amount" value="${cri.amount}">
		<input type="hidden" name="type" value="${cri.type}">
		<input type="hidden" name="keyword" value="${cri.keyword}">
		
		<div class="customBoard">
			<div class="customBoard1">
				<div class="customBoard2">
					<div class="file_box">
						<label for="productImg">
						대표이미지
							<img src="${contextPath}/resources/img/gallery-icon.png" alt="파일 찾기">
						</label>
						<input type="file" id="productImg" name="file" accept="image/*" >
					</div>
				</div>
				<div class="customBoard3">
					<div class="select_img" >
						<img src="${contextPath}/resources${pDto.productThumb}" style="width: 130px; height: 130px;"/>
					</div>
				</div>
			</div>
			
			<div class="customBoard1" style="margin-top: 10px;">
				<div class="customBoard2">
					<div class="file_box">
						<label for="attachImg">
							일반 이미지
							<img src="${contextPath}/resources/img/gallery-icon.png" alt="파일 찾기">
						</label>
						<input id="attachImg" type="file" name="uploadFile" multiple="multiple" accept="image/*">
					</div>
				</div>
				<div class="customBoard3">
					<div class="uploadResult"> 
						<ul>
						
						</ul>
			        </div>
				</div>
			</div>
		</div>

		<div class="customBoard">
		    <div class="panel panel-default">
		      
		      <!-- /.panel-heading -->
		      <div class="panel-body">
		
					<div class="form-group">
						<label for="productName">상품명</label>
						<input name="productName" maxlength="66" class="form-control" value="${pDto.productName }">
					</div>
		
					<div class="form-group">
						<label for="productPrice">상품가격</label>
						<input name="productPrice" type="number" min="5" max="9999" class="form-control" value="${pDto.productPrice }">
					</div>
					
					<div class="form-group">
						<label for="productCnt">상품수량</label>
						<input name="productCnt" type="number" min="50" max="99999" step="50" class="form-control" value="${pDto.productCnt }">
					</div>
					
					<div class="form-group">
						<label for="deleveryPrice">배송비</label>
						<input name="deleveryPrice" type="number" min="0" max="99" class="form-control" value="${pDto.deleveryPrice }">
					</div>
					
					<div class="form-group">
					  	<label for="productContent">상품소개</label>
					  	<textarea name="productContent" maxlength="333" class="form-control" rows="3">${pDto.productContent }
					  	</textarea>
					</div>
					
					<div class="form-group">
						<label>판매회사</label>
						<input name="sallerId" value='<sec:authentication property="principal.username" />'class="form-control" readonly="readonly" type="text">
					</div>
					
					<sec:authentication property="principal" var="prin"/>
					<sec:authorize access="isAuthenticated()">
						<c:if test="${prin.username eq pDto.sallerId }">
							<button type="submit" data-oper="modify" class="btn btn-default">Modify</button>
							<button type="submit" data-oper="remove" class="btn btn-danger">Remove</button>
						</c:if>
					</sec:authorize>		
					<button type="submit" data-oper="list" class="btn btn-info">List</button>
		      </div>
		
		    </div>
		</div>
	</form>
</section>

<%@include file="../include/footer.jsp"%>