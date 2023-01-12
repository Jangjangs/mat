<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="../includes/header.jsp"%>
<div id="main">
	<form method="post" action="" id="frm">
		<div>
			<input type="hidden" name="bno" value="${board.bno}">
			<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
			<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
			<input type="hidden" name="type" value="${pageMaker.cri.type }">
			<input type="hidden" name="keyword" value="${pageMaker.cri.keyword }">
		</div>
		<div class="fields">
			<div class="field">
				<label for="category">카테고리</label> <input type="text" name="category"
					id="category" readonly="readonly" value="공지사항"/>
			</div>
			<div class="field">
				<label for="title">제목</label> <input type="text" name="title"
					id="title" value="${board.title }" />
			</div>
			<div class="field">
				<label for="writer">작성자</label> <input type="text" name="writer"
					id="writer" value="${board.writer }" readonly="readonly"/>
			</div>
			<div class="field">
				<label for="content">내용</label>
				<textarea name="content" id="content" rows="3" >${board.content }</textarea>
			</div>
		</div>
		<ul class="actions">
			<li><input type="submit" value="수정 완료" /></li>
			<li><a href="javascript:history.go(-2);" class="button primary">글 목록</a></li>
		</ul>
	</form>
</div>
<script>
$(document).ready(function(){
	$("input[type=submit]").on("click",function(e){
		e.preventDefault();
		let title = $("#title").val();
		let content = $("#content").val();
		let writer = $("#writer").val();
		
		if(title == ''){
			alert("제목을 입력하세요");
			return;
		}
		if(writer == ''){
			alert("작성자를 입력하세요");
			return;
		}
		if(content == ''){
			alert("내용을 입력하세요");
			return;
		}
		
		$("#frm").submit();
	});
});
</script>
<%@ include file="../includes/footer.jsp"%>