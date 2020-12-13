<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath == '/' ? '' : pageContext.request.contextPath }" scope="application" />

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
	function showImage(fileCallPath) {
		//alert(fileCallPath);
		$(".bigPictureWrapper").css("display","flex").show();
	  
		$(".bigPicture")
		.html("<img src='${contextPath}/display?fileName=" + fileCallPath + "'>")
		.animate({width:'100%', height: '100%'}, 1000);
	}

	$(document).ready(function() {
		var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		var maxSize = 5242880; 

		function checkExtension(fileName, fileSize) {
			if (fileSize >= maxSize) {
				alert("파일 사이즈 초과");
				return false;
			}

			if (regex.test(fileName)) {
				alert("해당 종류의 파일은 업로드할 수 없습니다.");
				return false;
			}
			return true;
		}

		var cloneObj = $(".uploadDiv").clone();
		
		$("#uploadBtn").on("click", function(e) {
			var formData = new FormData();
			var inputFile = $("input[name='uploadFile']");
			var files = inputFile[0].files;
			console.log(files);
			
			for (var i = 0; i < files.length; i++) {
				if (!checkExtension(files[i].name, files[i].size)) {
					return false;
				}
				formData.append("uploadFile", files[i]);
			}
			
			$.ajax({
				url : "${contextPath}/uploadAjaxAction",
				processData : false,
				contentType : false,
				data : formData,
				type : "POST",
				dataType : "json",
				success : function(result) {
					console.log(result);
					showUploadedFile(result);
					$(".uploadDiv").html(cloneObj.html());
				}
			}); // $.ajax
		});		
		
		var uploadResult = $(".uploadResult ul");
		
		function showUploadedFile(uploadResultArr) {
			var str = "";
			$(uploadResultArr).each(function(i, obj) {
				if (!obj.image) {
					var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
					var fileLink = fileCallPath.replace(new RegExp(/\\/g), "/");
					
					str += "<li><div><a href='${contextPath}/download?fileName=" + fileCallPath +"'>" + 
						  "<img src='${contextPath}/resources/img/attach.png'>" + obj.fileName + "</a>" +
					      "<span data-file=\'" + fileCallPath + "\' data-type='file'>x</span>" + 
					      "</div></li>";
				} else {
					var fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
					var originPath = obj.uploadPath + "\\" + obj.uuid + "_" + obj.fileName;
					
					originPath = originPath.replace(new RegExp(/\\/g), "/");
					
					str += "<li><a href=\"javascript:showImage(\'" + originPath + "\')\">" + 
						  "<img src='${contextPath}/display?fileName=" + fileCallPath + "'></a>" + 
						  "<span data-file=\'" + fileCallPath + "\' data-type='image'>x</span>" + 
						  "</li>";
				}
			});
			
			uploadResult.append(str);
		}
		
		$(".bigPictureWrapper").on("click", function(e) {
			$(".bigPicture").animate({width:"0%", height: "0%"}, 1000);
			
			setTimeout(() => {
				$(this).hide();
			}, 1000);
			
			// IE 11 대응
			/* setTimeout(function() {
				$(".bigPictureWrapper").hide();
			}, 1000); */
		});
		
		$(".uploadResult").on("click","span", function(e) {
			var targetFile = $(this).data("file");
			var type = $(this).data("type");
			
			console.log(targetFile);
			
			$.ajax({
				url: "${contextPath}/deleteFile",
				data: {fileName: targetFile, type:type},
				dataType:"text",
				type: "POST",
				success: function(result){
					alert(result);

					targetLi.remove();
				}
			});
		});
	});
</script>
</head>
<body>
	<h1>Upload With Ajax</h1>
	<div class='bigPictureWrapper'>
		<div class='bigPicture'>
  		</div>
	</div>
	
	<div class="uploadDiv">
		<input type="file" name="uploadFile" multiple="multiple">
	</div>
	
	<div class="uploadResult">
		<ul>
		
		</ul>
	</div>
	<button id="uploadBtn">Upload</button>
</body>
</html>
