<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="utf-8">
<title>로그인 화면</title>

<!-- Bootstrap CSS and JS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>

<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>

<script type="text/javascript">
    $( function() {
		
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$("#userId").focus();
		
		//==>"Login"  Event 연결
		$("#loginBtn").on("click", function() {

			var id=$("input:text").val();
			var pw=$("input:password").val();
			
			if(id == null || id.length <1) {
				alert('ID 를 입력하지 않으셨습니다.');
				$("input:text").focus();
				return;
			}
			
			if(pw == null || pw.length <1) {
				alert('패스워드를 입력하지 않으셨습니다.');
				$("input:password").focus();
				return;
			}
			
			////////////////////////////////////////////////// 추가 , 변경된 부분 ////////////////////////////////////////////////////////////
			//$("form").attr("method","POST").attr("action","/user/login").attr("target","_parent").submit();
			////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			$.ajax( 
					{
						url : "/user/json/login",
						method : "POST" ,
						dataType : "json" ,
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						data : JSON.stringify({
							userId : id,
							password : pw
						}),
						success : function(JSONData , status) {

							//Debug...
							//alert(status);
							//alert("JSONData : \n"+JSONData);
							//alert( "JSON.stringify(JSONData) : \n"+JSON.stringify(JSONData) );
							//alert( JSONData != null );
							
							if( JSONData != null ){
								//[방법1]
								//$(window.parent.document.location).attr("href","/index.jsp");
								
								//[방법2]
								//window.parent.document.location.reload();
								
								//[방법3]
								$(window.parent.frames["topFrame"].document.location).attr("href","/layout/top.jsp");
								$(window.parent.frames["leftFrame"].document.location).attr("href","/layout/left.jsp");
								$(window.parent.frames["rightFrame"].document.location).attr("href","/user/getUser?userId="+JSONData.userId);
								
								//==> 방법 1 , 2 , 3 결과 학인
							}else{
								alert("아이디 , 패스워드를 확인하시고 다시 로그인...");
							}
						}
				}); 
				////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
							
		});
	});
	
	
	//============= 회원원가입화면이동 =============
	$( function() {
		//==> 추가된부분 : "addUser"  Event 연결
		$("#signupBtn").on("click", function() {
		    self.location = "/user/addUser";
		});

	});
    </script>
</head>

<body class="bg-light d-flex align-items-center vh-100">

	<div class="container">
		<div class="row justify-content-center">
			<div class="col-md-6">
				<div class="card border-0 shadow-lg">
					<div class="card-body">
						<div class="row">
							<div
								class="col-md-6 d-flex align-items-center justify-content-center">
								<img src="/images/logo-spring.png" class="img-fluid">
							</div>
							<div class="col-md-6">
								<h3 class="mb-4">로그인</h3>
								<div class="mb-3">
									<label for="userId" class="form-label">아이디</label> <input
										type="text" class="form-control" name="userId" id="userId"
										maxLength="50">
								</div>
								<div class="mb-3">
									<label for="password" class="form-label">패스워드</label> <input
										type="password" class="form-control" name="password"
										maxLength="50">
								</div>
								<div class="d-grid gap-2">
									<button type="button" id="loginBtn" class="btn btn-primary">로그인</button>

									<button type="button" id="signupBtn" class="btn btn-outline-secondary">회원가입</button>

								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>
