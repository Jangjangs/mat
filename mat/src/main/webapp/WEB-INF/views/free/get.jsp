<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<%@ include file="../includes/header.jsp"%>
<div id="main">
	<form method="post" action="" id="frm">
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
		<input type="hidden" name="bno" value="${board.bno}">
		<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
		<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
		<input type="hidden" name="type" value="${pageMaker.cri.type }">
		<input type="hidden" name="keyword" value="${pageMaker.cri.keyword }">
		
		<div class="fields">
			<div class="field">
				<label for="category">카테고리</label> 
				<span>${board.category }</span>
			</div>
			<div class="field">
				<label for="title">제목</label>
				<span>${board.title }</span>
			</div>
			<div class="field">
				<label for="writer">작성자</label>
				<span>${board.writer }</span>
			</div>
			<div class="field">
				<label for="content">내용</label>
				<% pageContext.setAttribute("newLineChar", "\n"); %>
				<span>${fn:replace(board.content, newLineChar, '<br>')}</span>
			</div>
				<div class="field">
				<label for="regDate">작성일</label>
				<span><fmt:formatDate value="${board.regDate}" pattern="yy-MM-dd HH:mm:ss"/> </span>
			</div>
			
		</div>
		<ul class="actions">
		
			<sec:authentication property="principal" var="pinfo"/>
			<sec:authorize access="isAuthenticated()">
			<c:if test="${pinfo.username eq board.writer }">
			<li><a href="update${pageMaker.cri.listLink}&bno=${board.bno }" class="button primary">글 수정</a></li>
			<li><button type="button" id="del_btn" class="button primary">글 삭제</button></li>
			</c:if>
			</sec:authorize>
			<li><a href="list${pageMaker.cri.listLink}&bno=${board.bno }" class="button primary">글 목록 보기</a></li>
		</ul>
	</form>
	<div>
	<sec:authorize access="hasAnyRole('USER','MEMBER','ADMIN')">
		<div>
			<form action="">
				<span>총 댓글 수:</span>
				<div>
					<textarea name="reply" id="reply" placeholder="댓글을 입력해주세요." rows="3"></textarea>
				</div>
				<input type="text" name="replyer" id="replyer" value="<sec:authentication property='principal.username'/>" readonly="readonly">
				<button type="button" id="newreply_btn" class="button primary">댓글등록</button>
			</form>
		</div>
		</sec:authorize>
		<div id="comments">
	
		</div>
		<div class="pagination"></div>
	</div>
</div>
		
<script>
function update_btn(t){
	console.log("수정버튼");
	let replyer = $('#replyer').val();
	
	let reply = $(t).data("reply");
	let rno = $(t).data("rno");
	let originalReplyer = $(t).data("replyer");
	
	if(!replyer){
			alert("로그인 후 수정 가능합니다.");
			return;
		}
		if(replyer != originalReplyer){
        
        alert("자신이 작성한 댓글만 수정이 가능합니다");
        getList();
        return;
    }
	
	var commentsView = '';
	commentsView += '<div id="rno'+rno+'">';
	commentsView += '<form onsubmit="return false;">';
	commentsView += '<div><button class="button small" id="update_reply">수정</button>';
	commentsView += '<button class="button small cencel_btn" >취소</button></div>';
	commentsView += '<input type="hidden" name="rno" id="rno" value="'+rno+'"/>';
	commentsView += '<div><textarea name="reply" id="reply2">'+reply+'</textarea></div>';
	commentsView += '<div><input type=hidden id=replyer value="'+replyer+'"/></div>';
	commentsView += '</form>';
	commentsView += '</div>';
	
	$('#rno'+rno).replaceWith(commentsView);
	$('#reply2').focus();
} 



var pageNum = 1;

function showReplyPage(replyCnt){
	var endNum = Math.ceil(pageNum / 10.0) * 10;
	var startNum = endNum - 9;

	var prev = startNum != 1;
	var next = false;

	if (endNum * 10 >= replyCnt) {
		endNum = Math.ceil(replyCnt / 10.0);
	}
	if (endNum * 10 < replyCnt) {
		next = true;
	}

	var str = "";
	
	if (prev) {
		str += ' <li> ';
		str += ' <a href="'+ (startNum - 1)	+ '" aria-label="Previous" class="btn_pagination previous" ';
		str += ' <span aria-hidden="true">Prev</span> ';
		str += ' </a> ';
		str += ' </li> ';
	}

	for (let i = startNum; i <= endNum; i++) {
		if (pageNum == i) {
			str += ' <li  style="float:left;"> ';
			str += ' <a>' + i + '</a> ';
			str += ' </li> ';
		} else {
			str += '<li style="float:left;">';
			str += '<a href="'+i+'" class="btn_pagination">' + i + '</a> ';
			str += ' </li> ';
		}
	}
	if (next) {
		str += '<li>';
		str += '<a href = "' + (endNum + 1)
				+ '" aria-label="Next" class="btn_pagination next">';
		str += ' <span aria-hidden="true">Next</span> ';
		str += '</a>';
		str += '</li>';
	}

	$('.pagination').html(str);
}

function getList(){
	$.ajax({
		type : "GET",
		url : "/replies/pages/${board.bno}/"+pageNum+".json",
		contentType:"application/json",
		success : function(res){
			console.log(res);
			let html = '';
			for(let i = 0; i < res.list.length; i++){
				html += '<div id="rno'+res.list[i].rno+'" style="margin-bottom:45px;">';
				html += '<div>';
				html += '<div style="float:right;" >';
				html += '<button class="button small dropdown">';
				html += '<img alt="menu" src="/resources/images/kebab.png" style="width:1rem; height:1.5rem%;">';
				html += '</button>';
				html += '<div style="display:none;" class="dropbtn">';
				html += '<div><button data-reply="'+res.list[i].reply+'" data-rno="'+res.list[i].rno+'"';
				html += 'data-replyer="'+res.list[i].replyer+'" class="button small" id="update_reply" onmousedown="update_btn(this);">수정</button></div>';
				html += '<div><button data-rno="'+res.list[i].rno+'" data-replyer="'+res.list[i].replyer+'" class="button small" id="del_reply" >삭제</button></div>';
				html += '</div>';
				html += '</div>';
				html += '</div>';
				html += '<div><span>댓글 내용:'+res.list[i].reply+'</span></div>';
				html += '<div><span>아이디:'+res.list[i].replyer+'</span>';
				html += '<span style="float:right;">'+(new Date(res.list[i].replyDate).toLocaleString())+'</span></div>';
				html += '<br></div>';
			
			}
			
			$("#comments").html(html);
			
			showReplyPage(res.replyCnt);
			
		},
		error : function(XMLHttpRequest, textStatus, errorThrown){
			console.log("통신실패");
		}
	});
	
	$("#reply").val('');
}
$(document).ready(function(){
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}"
	var dropdown = $(".dropdown");
	
	getList();
	
	$(document).on("click",".cencel_btn",function(){
		getList();
	});
	
	$(document).on("click",".dropdown",function(){
		console.log("click");
		$(this).next("div").show();
		
	});
	
	$(document).on("mouseup",function(e){
		//console.log("click");
		console.log(dropdown.has(e.dropdown).length);
		if(dropdown.has(event.target).length == 0){
			$(".dropbtn").hide();
		}
	});
	
	$("input[type=submit]").on("click",function(e){
		e.preventDefault();
	});

	
	$("#del_btn").on("click",function(){
		$("form").attr("action","delete");
		if(confirm("정말로 삭제하시겠습니까?"))
			$("#frm").submit();
	});
	
	$("#newreply_btn").on("click",function(){
		let bno = '${board.bno}';
		let reply = $("#reply").val();
		let replyer = $("#replyer").val();

		let data = {bno:bno,
				reply:reply,
				replyer:replyer};
		
		if(reply == ''){
			alert("댓글을 입력해주세요.")
		}else if (replyer == ''){
			alert("댓글 작성자를 입력해주세요.")
		} else{
			$.ajax({
				type : "POST",
				url : "/replies/new",
				contentType:"application/json",
				data : JSON.stringify(data),
				beforeSend:function(xhr){
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				success : function(res){
					console.log(res);
					
					if(res == 'success'){
						getList();
					}
				},
				error : function(XMLHttpRequest, textStatus, errorThrown){
					console.log("통신실패");
				}
			});
		}
		
	});
	
  	$(document).on("click","#update_reply",function(){
 		let rno = $('#rno').val();
 		console.log(rno);
 		let bno = '${board.bno}';
 		let reply = $("#reply2").val();
 		let replyer = $('#replyer').val();
 		console.log("댓글작성자:"+replyer);
 		
 		//console.log("uprno:"+rno);
 		//console.log("upbno:"+bno);
 		//console.log("upreplykkk:"+reply);
 		//console.log("upreplyer:"+replyer);
 		
 	 	let data = {bno:bno,
 				reply:reply,
 				replyer:replyer};
 		if(reply == ''){
 			alert("댓글을 입력해주세요.");
 		} else if(replyer == ''){
 			alert("로그인후에 수정가능합니다");
 		} else{
 			$.ajax({
				type : "PUT",
				url : "/replies/"+rno,
				contentType:"application/json",
				data : JSON.stringify(data),
				beforeSend:function(xhr){
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				success : function(res){
					console.log(res);
					
					if(res == 'success'){
						getList();
					}
				},
				error : function(XMLHttpRequest, textStatus, errorThrown){
					console.log("통신실패");
				}
			});
 		} 
 	});
  	
  	$(document).on("click","#del_reply",function(){
  		let rno = $(this).data("rno");
  		//console.log("번호:"+rno);
  		let replyer = $('#replyer').val();
  		let originalReplyer = $(this).data("replyer");
  		//console.log("삭제 댓글 작성자:"+originalReplyer);
  		//console.log("현재 로그인 아이디"+replyer);
  		if(!replyer){
  			alert("로그인 후 삭제 가능합니다.");
  			return;
  		}
  		if(replyer != originalReplyer){
            
            alert("자신이 작성한 댓글만 삭제가 가능합니다");
            getList();
            return;
        }
  		if(confirm("정말로 삭제하시겠습니까?")){
  			$.ajax({
				type : "DELETE",
				url : "/replies/"+rno,
				data : JSON.stringify({rno:rno, replyer:replyer}),
				contentType:"application/json",
				beforeSend:function(xhr){
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				success : function(res){
					console.log(res);
					
					if(res == 'success'){
						getList();
					}
				},
				error : function(XMLHttpRequest, textStatus, errorThrown){
					console.log("통신실패");
				}
			});
  		}
  	});
  	
  	$(document).on("click",".btn_pagination",function(e){
  		e.preventDefault();
  		pageNum = $(this).attr("href");
  		getList();
  	});
});
</script>
<%@ include file="../includes/footer.jsp"%>