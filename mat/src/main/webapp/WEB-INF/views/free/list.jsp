<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    <%@taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ include file="../includes/header.jsp"%>
<div id="main">
	<div class="table-wrapper">
		<div style="display:inline-block; float:left;">
			
				<form id="searchForm">
				<div style="display:flex;">
					<select name="type" style="min-width:10px; width:13rem;">
						<option value="">선택</option>
						<option value="T">제목</option>
						<option value="C">내용</option>
						<option value="W">작성자</option>
						<option value="TC">제목+내용</option>
						<option value="TCW">전체</option>
					</select>
					<input type="text" name="keyword" style="width:20rem;">				
					<button class="btn primary">검색</button>
					</div>
				</form>
				</div>
				<sec:authorize access="hasAnyRole('USER','MEMBER','ADMIN')">
				<div style="text-align: right; margin-bottom: 1rem;">
				<a href="insert" class="button primary">게시판 글쓰기</a>
				</div>
				</sec:authorize>

		<table class="alt">
			<colgroup>
				<col style="width: 5rem">
				<col style="width: 8rem">
				<col style="width: 8rem">
				<col style="">
				<col style="width: 5rem">
			</colgroup>
			<thead>
				<tr>
					<th>글번호</th>
					<th>작성일</th>
					<th>수정일</th>
					<th>제목</th>
					<th>조회수</th>

				</tr>
			</thead>
			<tbody>
				<c:set value="0" var="listCnt" />
				<c:set value="${pageMaker.total }" var="total" />
				<c:forEach items="${list }" var="notice">
					<tr style="text-align: center;">
						<td>${total }</td>
						<td><fmt:formatDate value="${notice.regDate }"
								pattern="yy-MM-dd" /></td>
						<td><fmt:formatDate value="${notice.updateDate }"
								pattern="yy-MM-dd" /></td>
						<td><a href="get${pageMaker.cri.listLink}&bno=${notice.bno }">${notice.title }</a>
						<c:if test="${notice.replyCnt gt 0 }">
							<span>[<c:out value="${notice.replyCnt}"/>]</span>
						</c:if></td>
						<td>${notice.hit }</td>
					</tr>
					<c:set value="${total-1 }" var="total" />
					<c:set value="${listCnt+1 }" var="listCnt" />
				</c:forEach>

				<c:if test="${listCnt eq 0 }">
					<tr>
						<td colspan="5">등록된 글이 없습니다.</td>
					</tr>
				</c:if>
			</tbody>

		</table>
		<div class="pagination" style="display:block; text-align:center;">
			<c:if test="${pageMaker.prev }">
				<a href="${pageMaker.startPage-1 }" class="btn_page previous">Prev</a>
			</c:if>
			<c:forEach begin="${pageMaker.startPage }"
				end="${pageMaker.endPage }" var="num">
				<c:if test="${pageMaker.cri.pageNum eq num }">
					<a class="btn_page active">${num}</a>
				</c:if>

				<c:if test="${pageMaker .cri.pageNum ne num}">
					<a href="${num}" class="btn_page">${num}</a>
				</c:if>
			</c:forEach>
			<c:if test="${pageMaker.next }">
				<a href="${pageMaker.endPage+1}" class="btn_page next">Next</a>
			</c:if>
		</div>
	</div>

		<div>
			<form id="frm">
				<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
				<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
				<input type="hidden" name="type" value="${pageMaker.cri.type }">
				<input type="hidden" name="keyword" value="${pageMaker.cri.keyword }">
			</form>
		</div>
</div>
<script>
$(document).ready(function(){
	$(".btn_page").on("click",function(e){
		e.preventDefault();
		console.log("페이지:"+$(this).attr("href"));
		let href = $(this).attr("href");
		$("input[name=pageNum]").val(href);
		$("#frm").submit();
	
	});
	
});
</script>

<%@ include file="../includes/footer.jsp"%>