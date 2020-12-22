<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../include/header.jsp"%>
<style>
	.uploadResult {
		width:100%;
		background-color: gray;
	}
	
	.uploadResult ul{
		display:flex;
		flex-flow: row;
		justify-content: center;
		align-items: center;
	}
	
	.uploadResult ul li {
		list-style: none;
		padding: 10px;
		align-content: center;
		text-align: center;
	}
	
	.uploadResult ul li img{
		width: 100px;
	}
	
	.uploadResult ul li span {
		color:white;
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
		background:rgba(255,255,255,0.5);
	}
	
	.bigPicture {
		position: relative;
		display:flex;
		justify-content: center;
		align-items: center;
	}
	
	.bigPicture img {
		width:600px;
	}
</style>
		</div>
	</header>
<section>

<div class="customBoard">
    <div class="panel panel-default">

      <div class="panel-heading">Board Read Page</div>
      <!-- /.panel-heading -->
      <div class="panel-body">

         <div class="form-group">
           <label>Bno</label> <input class="form-control" name="bno" value="${board.bno }" readonly="readonly">
         </div>

         <div class="form-group">
           <label>Title</label> <input class="form-control" name="title" value="${board.title }" readonly="readonly">
         </div>

         <div class="form-group">
           <label>Text area</label>
           <textarea class="form-control" rows="3" name="content" readonly="readonly">${board.content }</textarea>
         </div>

         <div class="form-group">
           <label>Writer</label> <input class="form-control" name="writer" value="${board.writer }" readonly="readonly">
         </div>
         <sec:authentication property="principal" var="prin"/>
         <sec:authorize access="isAuthenticated()">
	         <c:if test="${prin.username eq board.writer }">
		         <button data-oper="modify" class="btn btn-default">Modify</button>
	         </c:if>
         </sec:authorize>
         
		 <button data-oper="list" class="btn btn-info">List</button>
		 
		 <form id="operForm" action="${contextPath}/boad/modify" method="get">
			<input type="hidden" id="bno" name="bno" value="${board.bno}">
			<input type="hidden" id="pageNum" name="pageNum" value="${cri.pageNum}">
			<input type="hidden" id="amount" name="amount" value="${cri.amount}">
			<input type="hidden" name="type" value="${cri.type}">
			<input type="hidden" name="keyword" value="${cri.keyword}">
		 </form>
      </div>
      <!--  end panel-body -->

    </div>
    <!--  end panel-body -->
</div>
<!-- /.row -->

<div class="customBoard">
	<div class='bigPictureWrapper'>
		<div class='bigPicture'>
		</div>
	</div>
</div>

<div class="customBoard">
	<div class="panel panel-default">
		<div class="panel-heading">Files</div>
		<div class="panel-body">
		  
			<div class="uploadResult"> 
				<ul>
				</ul>
			</div>
		</div>
	</div>
</div>

<div class="customBoard">
	<div class="panel panel-default">
		<div class="panel-heading">
			<i class="fa fa-comments fa-fw"></i> Reply
		
			<sec:authorize access="isAuthenticated()">
				<button id='addReplyBtn' class='btn btn-primary btn-xs pull-right'>New Reply</button>
			</sec:authorize>
		         
		</div> 
		     
		<div class="panel-body">        
			<ul class="chat">
			</ul>
		</div>
	<div class="panel-footer"></div>
	</div>
</div>

<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
            </div>
            <div class="modal-body">
            	<div class="form-group">
            		<label>ReplyText</label>
            		<input class="form-control" name="replytext" value="New Reply!!!!" autocomplete="off" maxlength="333">
            	</div>
            	<div class="form-group">
	       			<input class="form-control" name="replyer" value="replyer" type="hidden">
					<input class="form-control" name="replyDate" value="2018-01-01 13:13" type="hidden">
				</div>
            </div>
			<div class="modal-footer">
        		<button id="modalModifyBtn" type="button" class="btn btn-warning">Modify</button>
        		<button id="modalRemoveBtn" type="button" class="btn btn-danger">Remove</button>
        		<button id="modalRegisterBtn" type="button" class="btn btn-primary">Register</button>
        		<button id="modalCloseBtn" type="button" class="btn btn-default">Close</button>
      		</div>          
    	</div>
          <!-- /.modal-content -->
	</div>
<!-- /.modal-dialog -->
</div>
 <!-- /.modal -->
</section>

<script type="text/javascript" src="${contextPath}/resources/js/reply.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	var bnoValue = '<c:out value="${board.bno}"/>';
	var replyUL = $(".chat");
	
	showList(1);
	
	function showList(page) {

		console.log("show list " + page);
		
		replyService.getList(
		{bno:bnoValue, contextPath:"${contextPath}", page: page || 1 },
		function(replyCnt, list) {

			console.log("list ****");
			console.log("replyCnt : " + replyCnt);
			console.log("list : " + list);
			console.log(list);

			if(page == -1){
				pageNum = Math.ceil(replyCnt/10.0);
				showList(pageNum);
				return;
			}
			  
			var str="";
			 
			if(list == null || list.length == 0){
				replyUL.html("");
				
				return;
			}
			 
			for (var i = 0, len = list.length || 0; i < len; i++) {
				str +="<li class='left clearfix' data-rno='"+list[i].rno+"'>";
				str +="  <div><div class='header'><strong class='primary-font'>["
					+ list[i].rno+"] "+list[i].replyer+"</strong>";
				str +="    <small class='pull-right text-muted'>"
					+ replyService.displayTime(list[i].updatedate)+"</small></div>";
				str +="    <p>"+list[i].replytext+"</p></div></li>";
			}
			 
			replyUL.html(str);
			 
			showReplyPage(replyCnt);
		});//end function
	}//end showList
	
    var pageNum = 1;
    var replyPageFooter = $(".panel-footer");
    
    function showReplyPage(replyCnt) {
    	var endNum = Math.ceil(pageNum / 10.0) * 10;
    	var startNum = endNum - 9;
    	
    	var prev = startNum != 1;
    	var next = false;
    	
    	if(endNum * 10 >= replyCnt) {
    		endNum = Math.ceil(replyCnt/10.0);
    	}
    	
    	if(endNum * 10 < replyCnt) {
    		next = true;
    	}
    	
    	var str = "<ul class='pagination pull-right'>";
    	
    	if(prev) {
    		str+= "<li class='page-item'><a class='page-link' href='"+(startNum -1)+"'>Previous</a></li>";
    	}
    	
    	for(var i = startNum ; i <= endNum; i++) {
    		var active = pageNum == i? "active":"";
    		
    		str+= "<li class='page-item "+active+" '><a class='page-link' href='"+i+"'>"+i+"</a></li>";
    	}
    	
    	if(next) {
    		str+= "<li class='page-item'><a class='page-link' href='"+(endNum + 1)+"'>Next</a></li>";
    	}
    	
    	str += "</ul></div>";
    	
    	/* console.log(str); */
    	
    	replyPageFooter.html(str);
    }
     
    replyPageFooter.on("click","li a", function(e) {
    	e.preventDefault();
    	console.log("page click ****");
    	
    	var targetPageNum = $(this).attr("href");
    	
    	console.log("targetPageNum: " + targetPageNum);
    	
    	pageNum = targetPageNum;
    	
    	showList(pageNum);
     });     
	
    var modal = $(".modal");
    var modalInputReplyText = modal.find("input[name='replytext']");
    var modalInputReplyer = modal.find("input[name='replyer']");
    var modalInputReplyDate = modal.find("input[name='replyDate']");
    
    var modalModifyBtn = $("#modalModifyBtn");
    var modalRemoveBtn = $("#modalRemoveBtn");
    var modalRegisterBtn = $("#modalRegisterBtn");

    var replyer = null;

    <sec:authorize access="isAuthenticated()">
    	replyer = '<sec:authentication property="principal.username"/>';
    </sec:authorize>

    var csrfHeaderName = "${_csrf.headerName}";
    var csrfTokenValue = "${_csrf.token}";
    
  	//Ajax spring security header...
    $(document).ajaxSend(function(e, xhr, options){
		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
    });
    
    $("#modalCloseBtn").on("click", function(e){

    	console.log("modal close click ****");
        
    	modal.modal("hide");
    });
    
    $("#addReplyBtn").on("click", function(e){

    	console.log("add click ****");
    	
    	modal.find("input").val("");
    	modal.find("input[name='replyer']").val(replyer);
    	modalInputReplyDate.closest("div").hide();
    	modal.find("button[id !='modalCloseBtn']").hide();
    	
    	modalRegisterBtn.show();
    	
    	$(".modal").modal("show");
    });
    
    // 새로운 댓글 처리
    modalRegisterBtn.on("click", function(e) {

    	console.log("register click ****");
        
    	var reply = {
    			replytext: modalInputReplyText.val(),
    			replyer:modalInputReplyer.val(),
    			contextPath:"${contextPath}",
    			bno:bnoValue
    		};
    	
        replyService.add(reply, function(result){
            
        	alert(result);
        	
        	modal.find("input").val("");
        	modal.modal("hide");
        	
        	showList(-1);
        });
	});
    
    $(".chat").on("click", "li", function(e){
    	var rno = {
    	    rno : $(this).data("rno"),
    	    contextPath:"${contextPath}"
    	};

    	console.log("reply click ****");
		
    	replyService.get(rno, function(reply){
        	
    		modalInputReplyText.val(reply.replytext);
    		modalInputReplyer.val(reply.replyer);
    		modalInputReplyDate.val(replyService.displayTime(reply.regdate))
    		.attr("readonly","readonly");
    		modal.data("rno", reply.rno);
    		
    		modal.find("button[id !='modalCloseBtn']").hide();

    		if(replyer == reply.replyer){
    			modalModifyBtn.show();
        		modalRemoveBtn.show();
    		}else{
        		modalModifyBtn.hide();
        		modalRemoveBtn.hide();
        	}
    		
    		$(".modal").modal("show");
    	});
    });
    
    modalModifyBtn.on("click", function(e){

    	var originalReplyer = modalInputReplyer.val();

    	var reply = {
    			rno:modal.data("rno"), 
    			replytext: modalInputReplyText.val(),
    			replyer:originalReplyer,
    			contextPath:"${contextPath}"};
    	
    	if(!replyer){
			alert("로그인후 수정이 가능합니다.")
			modal.modal("hide");
			return;
		}


    	if(replyer != originalReplyer){
			alert("자신이 작성한 댓글만 수정이 가능합니다.");
			modal.modal("hide");
			return;
		}

		console.log("modify ****");
			
    	replyService.update(reply, function(result) {
    		alert(result);
     	    modal.modal("hide");
     	    showList(pageNum);
     	});
    });

    modalRemoveBtn.on("click", function (e) {

    	var rno = {
    	   	rno : modal.data("rno"),
    	   	contextPath:"${contextPath}"
    	};
		
		var originalReplyer = modalInputReplyer.val();
    	
		if(!replyer){
			alert("로그인후 삭제가 가능합니다.")
			modal.modal("hide");
			return;
		}

		if(replyer != originalReplyer){
			alert("자신이 작성한 댓글만 삭제가 가능합니다.");
			modal.modal("hide");
			return;
		}

		console.log("remove ****");
		
		replyService.remove(rno, originalReplyer, function(result) {
    		alert(result);
    		modal.modal("hide");
    		showList(pageNum);
    	});
    });
});
</script>
<script type="text/javascript">
$(document).ready(function() {
	var operForm = $("#operForm");
		$("button[data-oper='modify']").on("click", function(e){
	  	operForm.attr("action","${contextPath}/board/modify").submit();
	});
	
	$("button[data-oper='list']").on("click", function(e){
		operForm.find("#bno").remove();
		operForm.attr("action","${contextPath}/board")
		operForm.submit();
	});
});
</script>

<script>
$(document).ready(function() {
	  (function() {
	  	var bno = "${board.bno}";
	    console.log("bno --> " + bno);
	    $.getJSON("${contextPath}/board/getAttachList", {bno: bno}, function(arr) {
	        
	       console.log(arr);
	       
	       var str = "";
	       
	       $(arr).each(function(i, attach){
	       
	         if(attach.filetype){
	           var fileCallPath =  encodeURIComponent(attach.uploadPath+ "/s_" + attach.uuid +"_" + attach.fileName);
	           
	           str += "<li data-path='" + attach.uploadPath + "' data-uuid='" + attach.uuid + "' data-filename='" + attach.fileName + "' data-type='" + attach.filetype + "' ><div>";
	           str += "<img src='${contextPath}/display?fileName=" + fileCallPath+"'>";
	           str += "</div>";
	           str +"</li>";
	         } else {
	           str += "<li data-path='" + attach.uploadPath + "' data-uuid='" + attach.uuid + "' data-filename='" + attach.fileName + "' data-type='" + attach.filetype+"' ><div>";
	           str += "<span> "+ attach.fileName + "</span><br/>";
	           str += "<img src='${contextPath}/resources/img/attach.png'></a>";
	           str += "</div>";
	           str +"</li>";
	         }
	       });
	       
	       $(".uploadResult ul").html(str);
	     });//end getjson
	  })();//end function
	  
	  $(".uploadResult").on("click","li", function(e){
	      
	    console.log("view image");
	    
	    var liObj = $(this);
	    
	    var path = encodeURIComponent(liObj.data("path")+"/" + liObj.data("uuid")+"_" + liObj.data("filename"));

	    if(liObj.data("type")){
	      showImage(path.replace(new RegExp(/\\/g),"/"));
	    } else {
	      self.location ="${contextPath}/download?fileName=" + path;
	    }
	    
	  });
	  
	  function showImage(fileCallPath){
	    $(".bigPictureWrapper").css("display","flex").show();
	    
	    $(".bigPicture")
	    .html("<img src='${contextPath}/display?fileName="+fileCallPath+"' >")
	    .animate({width:"100%", height: "100%"}, 1000);
	    
	  }

	  $(".bigPictureWrapper").on("click", function(e){
	    $(".bigPicture").animate({width:"0%", height: "0%"}, 1000);
	    setTimeout(function(){
	      $(".bigPictureWrapper").hide();
	    }, 1000);
	  });
	});

</script>
<%@include file="../include/footer.jsp"%>