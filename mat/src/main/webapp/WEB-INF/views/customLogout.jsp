<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Logout</title>
</head>
<body style="background-color: #212931;">
	<h1 style="color:#ffffff;">커스텀 로그아웃 페이지</h1>
   <form action="/customLogout" method="POST">
    <!-- csrf 토큰은 POST, PUT, DELETE등의 요청에 주로 사용된다 -->
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
    <button>로그아웃</button>
</form>
</body>
</html>