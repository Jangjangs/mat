<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE HTML>
<!--
	Massively by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
	<head>
		<title>mattam</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="/resources/assets/css/main.css" />
		<noscript><link rel="stylesheet" href="/resources/assets/css/noscript.css" /></noscript>
		<script src="/resources/assets/js/jquery.min.js"></script>
		<script src="/resources/assets/js/jquery.scrollex.min.js"></script>
		<script src="/resources/assets/js/jquery.scrolly.min.js"></script>
			<!-- build:js /admin/resources/assets/js/core.min.js -->
		<script src="/resources/libs/bower/jquery/dist/jquery.js"></script>
		<script src="/resources/libs/bower/jquery-ui/jquery-ui.min.js"></script>
		<script src="/resources/libs/bower/jQuery-Storage-API/jquery.storageapi.min.js"></script>
		<script src="/resources/libs/bower/bootstrap-sass/assets/javascripts/bootstrap.js"></script>
		<script src="/resources/libs/bower/jquery-slimscroll/jquery.slimscroll.js"></script>
		<script src="/resources/libs/bower/perfect-scrollbar/js/perfect-scrollbar.jquery.js"></script>
		<script src="/resources/libs/bower/PACE/pace.min.js"></script>
			
			    <style>
.map_wrap, .map_wrap * {margin:0;padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:12px;}
.map_wrap a, .map_wrap a:hover, .map_wrap a:active{color:#000;text-decoration: none;}
.map_wrap {position:relative;width:100%;height:500px;}
#menu_wrap {position:absolute;top:0;left:0;bottom:0;width:250px;margin:10px 0 30px 10px;padding:5px;overflow-y:auto;background:rgba(255, 255, 255, 0.7);z-index: 1;font-size:12px;border-radius: 10px;}
.bg_white {background:#fff;}
#menu_wrap hr {display: block; height: 1px;border: 0; border-top: 2px solid #5F5F5F;margin:3px 0;}
#menu_wrap .option{text-align: center;}
#menu_wrap .option p {margin:10px 0;}  
#menu_wrap .option button {margin-left:5px;}
#placesList li {list-style: none;}
#placesList .item {position:relative;border-bottom:1px solid #888;overflow: hidden;cursor: pointer;min-height: 65px;}
#placesList .item span {display: block;margin-top:4px;}
#placesList .item h5, #placesList .item .info {text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}

#placesList .info .gray {color:#8a8a8a;}
#placesList .info .jibun {padding-left:26px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png) no-repeat;}
#placesList .info .tel {color:#009900;}
#placesList .item .markerbg {float:left;position:absolute;width:36px; height:37px;margin:10px 0 0 10px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png) no-repeat;}
#pagination {margin:10px auto;text-align: center;}
#pagination a {display:inline-block;margin-right:10px;}
#pagination .on {font-weight: bold; cursor: default;color:#777;}

</style>

	</head>
	<body class="is-preload">

		<!-- Wrapper -->
			<div id="wrapper" class="fade-in">

				<!-- Intro -->
					<div id="intro">
						<h1>맛탐</h1>
						<p>맛집 탐구</p>
						<ul class="actions">
							<li><a href="#header" class="button icon solid solo fa-arrow-down scrolly">Continue</a></li>
						</ul>
					</div>

				<!-- Header -->
					<header id="header">
						<a href="/" class="logo">Main</a>
					</header>

				<!-- Nav -->
					<nav id="nav">
						<ul class="links">
							<li><a href="/">메인</a></li>
							<li><a href="/notice/list">공지사항</a></li>
							<li><a href="/free/list">자유 게시판</a></li>
						</ul>
						<ul class="icons">
							<sec:authorize access="isAnonymous()">
								<li><a href="/customLogin"><span class="label">로그인</span></a></li>
							</sec:authorize>
							<sec:authorize access="isAuthenticated()">
								<li><a href="/customLogout"><span class="label">로그아웃</span></a></li>
							</sec:authorize>
						</ul>
					</nav>


    