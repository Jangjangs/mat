<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body style="background-color: #212931;">
	<h1 style="color:#ffffff;">커스텀 로그인 페이지</h1>

        <!-- 시큐리티의 로그인 작업은 /login에서 이루어진다.
        /login 에 POST 방식으로 데이터를 보낸다. -->
        <form action="" method="POST">
        
        <!-- input 태그의 name 속성은 username, password 로 지정해야 한다.
        사용자의 id가 이메일이라고 해도 username 으로 지정해야한다.
        그래야 스프링 시큐리티에서 처리할 수 있다. -->
        <input type="text" name="userId" placeholder="userid를 입력하세요" />
        <input type="password" name="userPw" />
        <input type="text" name="userName" placeholder="username을 입력하세요" />
        <input type="submit" value="회원가입"/>
        
        <!-- csrf 토큰을 생성해 같이 보낸다 -->
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
      	</form>
</body>
</html>