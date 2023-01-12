<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
		<sec:authorize access="hasRole('ROLE_ADMIN')">
			<li><a href="update${pageMaker.cri.listLink}&bno=${board.bno }" class="button primary">글 수정</a></li>
			<li><button type="button" id="del_btn" class="button primary">글 삭제</button></li>
		</sec:authorize>
			<li><a href="list${pageMaker.cri.listLink}&bno=${board.bno }" class="button primary">글 목록 보기</a></li>
		</ul>
	</form>

</div>
		
<script>

	$(document).ready(function() {
			$(document).on("click", "#del_btn",function() {
				console.log("삭제");
				$("form").attr("action", "delete");
				if (confirm("정말로 삭제하시겠습니까?"))
					$("#frm").submit();
			
		});
	});
</script>
<%@ include file="../includes/footer.jsp"%>