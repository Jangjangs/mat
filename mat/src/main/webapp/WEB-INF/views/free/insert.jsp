<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<%@ include file="../includes/header.jsp"%>
<div id="main">
	<form method="post" action="" id="frm">
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
		<div class="fields">
			<div class="field">
				<label for="category">카테고리</label> <input type="text" name="category"
					id="category" readonly="readonly" value="자유게시판"/>
			</div>
			<div class="field">
				<label for="title">제목</label> <input type="text" name="title"
					id="title" />
			</div>
			<div class="field">
				<label for="writer">작성자</label> <input type="text" name="writer"
					id="writer" value='<sec:authentication property="principal.username"/>' readonly="readonly"/>
			</div>
			<div class="field">
				<label for="content">내용</label>
				<textarea name="content" id="content" rows="3"></textarea>
			</div>
		</div>
		<ul class="actions">
			<li><input type="submit" value="글 쓰기" /></li>
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