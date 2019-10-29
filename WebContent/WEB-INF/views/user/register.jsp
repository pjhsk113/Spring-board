<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>list</title>
</head>
<script type="text/javascript">
$j(document).ready(function(){
	var Check = false;
	$j("#checkId").on("click",function(){
		var param = $j('#userId').val();
		$j.ajax({
		    url : "/user/checkId.do",
		    dataType: "json",
		    type: "GET",
		    data:{"userId": param},
		    success: function(data, textStatus, jqXHR)
		    {
		    	if(data > 0){
		    		alert("중복 된 아이디입니다.");
		    	}else if(data == -1){
		    		alert("아이디를 입력하세요.");
		    	}else{
		    		alert("사용가능한 아이디입니다.");
		    		Check = true;
		    	}
				
		    },
		    error: function (jqXHR, textStatus, errorThrown)
		    {
		    	alert("중복확인 실패");
		    }
		});
	});
	
	$j(".password").on("input",function(e){
		e.preventDefault();
		var pw=$j("#userPw").val();
		var pwCheck=$j("#userPwCheck").val();
		
		if(!pw || pw==""){
			$j("#pwAlert").html("<div id='pwAlert'><div>");
		 	$j("#userPwCheck").attr('pwCheck','0');
			return false;
		}else if(pw.length>=6){
			if(pwCheck ==""){
				$j("#pwAlert").html("<div id='pwAlert'><div>");
			 	$j("#userPwCheck").attr('pwCheck','0');
			 	return false;
			}else if(pw!=pwCheck) {
				$j("#userPwCheck").blur(function(){
			 		$j("#userPwCheck").val('');
			 	 });
			 	$j("#pwAlert").html("<div id='pwAlert' style='float:left; font-size:15px; color:#FF0000'>비밀번호가 다릅니다.<div>");
			 	$j("#userPwCheck").attr('pwCheck','0');
				return false;
		 	}else if(pw==pwCheck) {
		 		$j("#userPwCheck").blur(function(){
			 		$j("#userPwCheck").val(pw);
			 	 });
				$j("#pwAlert").html("<div id='pwAlert'><div>");
			 	$j("#userPwCheck").attr('pwCheck','1');
			 	return true;
		 	}
		}
	 });
	
	$j("#userName").on("input",function(e){
		e.preventDefault();
		var name=$j("#userName").val();
		var regex= /^[\uac00-\ud7a3+]*$/;
		if(!name || name==""){
			$j("#nameAlert").html("<div id='nameAlert'><div>");
		 	$j("#userName").attr('nameCheck','0');
			return false;
		}else{
			if(regex.test(name)){
				$j("#userName").blur(function(){
			 		$j("#userName").val(name);
			 	 });
				$j("#nameAlert").html("<div id='nameAlert'><div>");
			 	$j("#userName").attr('nameCheck','1');
			}else{
			 	$j("#nameAlert").html("<div id='nameAlert' style='float:left; font-size:15px; color:#FF0000'>한글만 입력가능합니다.<div>");
			 	$j("#userName").attr('nameCheck','0');
			 	$j("#userName").blur(function(){
			 		$j("#userName").val("");
			 	 });
			 	return false;
			}
		}
	});
	$j("#userId").on("keyup", function() {
		$j(this).val($j(this).val().replace(/[^a-zA-Z|0-9]/g,""));
		Check = false;
	});
	$j("#userName").on("keyup", function() {
		$j(this).val($j(this).val().replace(/[^\uac00-\ud7a3]/g,""));
	});
	$j(".userPhNum").on("keyup", function() {
		$j(this).val($j(this).val().replace(/[^0-9]/g,""));
	});
	
	$j("#userAddr1").on("keyup", function() {
		$j(this).val($j(this).val().replace(/[^0-9]/g,""));
		$j(this).val($j(this).val().replace(/\B(?=(\d{3})+(?!\d))/g,"-"));
	});
	
	$j("#join").on("click",function(){
		var IdVal = $j("#userId").val();
		var PwVal = $j("#userPw").val();
		var PwCheckVal = $j("#userPwCheck").val();
		var NameVal = $j("#userName").val();
		var Ph2Val = $j("#userPhone2").val();
		var Ph3Val = $j("#userPhone3").val();
		var PostVal = $j("#userAddr1").val();
		var regExp = /^\d{3}-\d{3}$/;
		
			if(Check == false){
				alert("중복체크를 해주세요.");
				$j("#userId").focus();
				return false;
			}
			else if(IdVal == null || IdVal ==""){
				alert("ID를 입력하세요");
				$j("#userId").focus();
				return false;
			}else if(IdVal.length > 15){
				alert("ID는 15자 이하로만 등록 가능합니다.");
				$j("#userId").focus();
				return false;
			}
	
			if(PwVal==null || PwVal==""){
				alert("비밀번호를 입력하세요");
				$j("#userPw").focus();
				return false;
			}else if(PwCheckVal==null || PwCheckVal==""){
				alert("비밀번호 확인은 필수항목입니다");
				$j("#userPwCheck").focus();
				return false;
			}else if(PwVal.length <6){
				alert("비밀번호는 6자리 이상 입력해주세요.");
				$j("#userPw").focus();
				return false;
			}else if(PwVal != PwCheckVal){
				alert("비밀번호가 다릅니다.");
				$j("#userPwCheck").focus();
				return false;
			}
			
			if(NameVal==null || NameVal==""){
				alert("이름을 입력하세요.");
				$j("#userName").focus();
				return false;
			}else if(NameVal.length > 7){
				alert("이름은 7자 이하로만 등록 가능합니다.");
				$j("#userName").focus();
				return false;
			}
			
			if((Ph2Val==null || Ph2Val=="") || Ph2Val.length < 4){
				alert("중간번호를 입력하세요.");
				$j("#userPhone2").focus();
				return false;
			}else if((Ph3Val==null || Ph3Val=="") || Ph3Val.length < 4){
				alert("끝번호를 입력하세요.");
				$j("#userPhone3").focus();
				return false;
			}
			
			if(PostVal==null || PostVal==""){
				alert("우편번호를 입력하세요.");
				$j("#userAddr1").focus();
				return false;
			}else if(!regExp.test(PostVal)){
				alert("우편번호 형식이 다릅니다.");
				$j("#userAddr1").focus();
				return false;
			}
			
			$frm = $j('.registerForm :input');
			var param = $frm.serialize();
			
			$j.ajax({
			    url : "/user/userJoin.do",
			    dataType: "json",
			    type: "POST",
			    data : param,
			    success: function(data, textStatus, jqXHR)
			    {
					alert("가입완료");
					
					alert("메세지:"+data.success);
					
					location.href = "/board/boardList.do";
			    },
			    error: function (jqXHR, textStatus, errorThrown)
			    {
			    	alert("가입실패");
			    }
			});	
	});
});
</script>
<body>
<form class="registerForm">
<table  align="center">
	<tr>
		<td align="left">	
			<a href="/board/boardList.do">List</a>
		</td>
	</tr>
	<tr>
		<td>
			<table id="registerTable" border = "1">
				<tr>
					<td width="80" align="center">
						id 
					</td>
					<td width="300">
						<input name="userId" id="userId" type="text" size="20"> 
						<button type="button" name="checkId" id="checkId">중복확인</button>
					</td>
				</tr>
				<tr>
					<td width="80" align="center">
						pw
					</td>
					<td width="300">
						<input class="password" name="userPw" id="userPw" type="password" size="25" minlength="6" maxlength="12"> 
					</td>
				</tr>
				<tr>
					<td width="80" align="center">
						pw check
					</td>
					<td width="300">
						<input class="password" name="userPwCheck" id="userPwCheck" type="password" size="25" pwCheck="0" size="10" minlength="6" maxlength="12">
						<div id="pwAlert"><div>
					</td>
				</tr>
				<tr>
					<td width="80" align="center" maxlength="6">
						name
					</td>
					<td width="300">
						<input name="userName" id="userName" type="text" size="25" nameCheck="0">
						<div id="nameAlert"><div>
					</td>
				</tr>
				<tr>
					<td width="80" align="center">
						phone
					</td>
					<td width="300">
						<select name="userPhone1" id="userPhone1">
							<c:forEach var="item" items="${codeList}">
								<option value="${item.codeId}">${item.codeName}</option>
							</c:forEach>
						</select>-
						<input class="userPhNum" name="userPhone2" id="userPhone2" type="text" size="1" minlength="4" maxlength="4" >-
						<input class="userPhNum" name="userPhone3" id="userPhone3" type="text" size="1" minlength="4" maxlength="4" >
					</td>
				</tr>
				<tr>
					<td width="80" align="center">
						postNo
					</td>
					<td width="300">
						<input name="userAddr1" id="userAddr1" type="text" size="25" maxlength="7"> ex)123-234
					</td>
				</tr>
				<tr>
					<td width="80" align="center">
						address
					</td>
					<td width="300">
						<input name="userAddr2"  id="userAddr2" type="text" size="25" maxlength="75"> 
					</td>
				</tr>
				<tr>
					<td width="80" align="center">
						company
					</td>
					<td width="300">
						<input name="userCompany" id="userCompany" type="text" size="25" maxlength="30" > 
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td align="right">
			<a href ="#" id="join">Join</a>
		</td>
	</tr>
</table>
</form>	
</body>
</html>