<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardView</title>
</head>

<script type="text/javascript">
	$j(document).ready(function(){
		
		$j("#delete").on("click",function(){
			$j.ajax({
			    url : "/board/boardDel.do?boardType=${board.boardType}&boardNum=${board.boardNum}",
			    dataType: "json",
			    type: "GET",
			    success: function(data, textStatus, jqXHR)
			    {
					alert("삭제완료");
					alert("메세지:"+data.success);
					location.href = "/board/boardList.do";
			    },
			    error: function (jqXHR, textStatus, errorThrown)
			    {
			    	alert("삭제실패");
			    }
			});
		});
	});
</script>
<body>
<table align="center">
	<tr>
		<td>
			<table border ="1">
				<tr>
					<td width="120" align="center">
					Title
					</td>
					<td width="400">
					${board.boardTitle}
					</td>
				</tr>
				<tr>
					<td height="300" align="center">
					Comment
					</td>
					<td>
					${board.boardComment}
					</td>
				</tr>
				<tr>
					<td align="center">
					Writer
					</td>
					<td>
					${board.userName}
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<c:choose>
			<c:when test="${userInfo != null}">
				<td align="right">
					<a href="/board/boardEdit.do?boardType=${board.boardType}&boardNum=${board.boardNum}">수정</a>
					<a href="#" id="delete">삭제</a>
					<a href="/board/boardList.do">List</a>
				</td>
			</c:when>
			<c:otherwise>
				<td align="right">
					<a href="/board/boardList.do">List</a>
				</td>
			</c:otherwise>
		</c:choose>
	</tr>
</table>	
</body>
</html>