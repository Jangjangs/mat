<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>
<div id="main">
	<article class="post featured">
		<!-- Posts -->
		<section class="posts">
			<div id="scrolltop">
				<h1>경상북도 대표음식점</h1>
				<div class="table-wrapper">
					<table id="food">
						<thead>
							<tr>
								<th>연번</th>
								<th>업소명</th>
								<th>전화번호</th>
								<th>주소</th>
							</tr>
						</thead>
						<tbody>

						</tbody>

					</table>
				</div>
				<div style="text-align: center;" class="pagination">
					<ul id="foodpage" style="list-style: none; display: flex;">

					</ul>
				</div>
			</div>

			<div style="float: left">
				<form method='post' onsubmit="return false;">
					<span>현재 페이지</span> <input type="submit" name="pageNum" value="">
				</form>
			</div>
		</section>
	</article>
</div>

<script>
	var pageNum = 1;
	function showListPage(totalCount) {
		var endNum = Math.ceil(pageNum / 10.0) * 10;
		var startNum = endNum - 9;

		var prev = startNum != 1;
		var next = false;

		if (endNum * 10 >= totalCount) {
			endNum = Math.ceil(totalCount / 10.0);
		}
		if (endNum * 10 < totalCount) {
			next = true;
		}

		var str = "";
		if (prev) {
			str += ' <li> ';
			str += ' <a href="'
					+ (startNum - 1)
					+ '" aria-label="Previous" class="btn_pagination previous" ';
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

		$('#foodpage').html(str);
		//	console.log(str);
	}

	$(document).on("click", ".btn_pagination", function(e) {
		e.preventDefault();
		pageNum = $(this).attr("href");
		//$('#food > tbody:last').empty();
		getList();
		var offset = $("#scrolltop").offset();
		$('html, body').animate({
			scrollTop : offset.top
		}, 100);

	});
	function getList() {
		$
				.ajax({
					type : "GET",
					url : "http://api.odcloud.kr/api/3068464/v1/uddi:75badfa7-ff76-4deb-a5bf-c664df0f4e99?page="
							+ pageNum
							+ "&perPage=10&serviceKey=MVhp%2B2QLgpxUMGSim8B6OuSXb66J5X5pG1TkLLQLXor8LhXJzLYFDvD07RrJxuPGWJJXga3%2BscuR1mvhzI5oFg%3D%3D",
					data : {},
					success : function(res) {
						console.log(res);
						let html = "";
						for (let i = 0; i < res.data.length; i++) {
							html += '<tr>';
							html += '<td>' + res.data[i].연번 + '</td>';
							html += '<td>' + res.data[i].업소명 + '</td>';
							html += '<td>' + res.data[i].전화번호 + '</td>';
							html += '<td>' + res.data[i].주소 + '</td>';
							html += '</tr>';
						}
						//$('#food > tbody:last').append(html);
						$('#food > tbody').html(html);
						console.log(res.totalCount);
						showListPage(res.totalCount);
						$('input[name=pageNum]').attr('value', pageNum);
					}
				});
	}
	$(document).ready(function() {
		getList();

	});
</script>
<%@ include file="../includes/footer.jsp" %>