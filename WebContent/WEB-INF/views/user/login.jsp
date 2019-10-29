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
	$j("#login").on("click",function(){
		var $frm = $j('.loginForm :input');
		var param = $frm.serialize();
		
		$j.ajax({
		    url : "/user/userLoginOk.do",
		    dataType: "json",
		    type: "POST",
		    data : param,
		    success: function(data, textStatus, jqXHR)
		    {
		    	if(data >0){
		    		alert("�α��εǾ����ϴ�.");
		    		location.href = "/board/boardList.do";
		    	}else if(data ==-1){
		    		alert("���̵� �Է��ϼ���.");
		    	}else if(data ==-2){
		    		alert("��й�ȣ�� �Է��ϼ���.");
		    	}else{
		    		alert("���̵� Ȥ�� ��й�ȣ�� �߸��Ǿ����ϴ�.");
		    	}
		    },
		    error: function (jqXHR, textStatus, errorThrown)
		    {
		    	alert("�α��� ����");
		    }
		});
		
	});
});

</script>
<body>
<form class="loginForm">
<table  align="center">
	<tr>
		<td align="left">	
			<a href="/board/boardList.do">List</a>
		</td>
	</tr>
	<tr>
		<td>
			<table id="loginTable" border = "1">
				<tr>
					<td width="80" align="center">
						id
					</td>
					<td width="220">
						<input name="userId" id="userId" type="text" size="20"> 
					</td>
				</tr>
				<tr>
					<td width="80" align="center">
						pw
					</td>
					<td width="220">
						<input class="password" name="userPw" id="userPw" type="password" size="20" minlength="6" maxlength="12"> 
					</td>
				</tr>
				
			</table>
		</td>
	</tr>
	<tr>
		<td align="right">
			<a href ="#" id="login">login</a>
		</td>
	</tr>
</table>
</form>	
</body>
</html>