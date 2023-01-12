<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
</head>
<body style="background-color: #212931;">
	<h1 style="color:#ffffff;">커스텀 로그인 페이지</h1>
        <h2><c:out value="${error}"/></h2>
        <h2><c:out value="${logout}"/></h2>

        <!-- 시큐리티의 로그인 작업은 /login에서 이루어진다.
        /login 에 POST 방식으로 데이터를 보낸다. -->
        <form action="/login" method="POST">
        
        <!-- input 태그의 name 속성은 username, password 로 지정해야 한다.
        사용자의 id가 이메일이라고 해도 username 으로 지정해야한다.
        그래야 스프링 시큐리티에서 처리할 수 있다. -->
        <div>
        <input type="text" name="username" placeholder="username을 입력하세요" />
        </div>
        <div>
        <input type="password" name="password" />
        </div>
         <div>
        <input type="checkbox" name="remember-me"><span style="color:#ffffff">Remember Me</span>
    	</div>
        <input type="submit" value="로그인"/>
        
        <!-- csrf 토큰을 생성해 같이 보낸다 -->
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
      	</form>
      	
      	<a href="/member/signup" class="button primary"><span style="color:#ffffff">회원가입</span></a>
</body>
</html>