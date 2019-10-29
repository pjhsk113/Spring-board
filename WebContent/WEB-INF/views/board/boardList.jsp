<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>list</title>
</head>
<body>
<table  align="center">
	<tr>
		<td >
			<table id="boardTable">
				<tr>
				<c:choose>
					<c:when test="${userInfo != null}">
						<td width="80" align="center">
							${userInfo.userName}
						</td>
						
					</c:when>
					<c:otherwise>
						<td width="80" align="center">
							<a href="/user/userLogin.do">Login</a>
						</td>
						<td width="40" align="center">
							<a href="/user/register.do">Join</a>
						</td>
					</c:otherwise>
				</c:choose>
					
					<td width="300" align="right">
						total : ${totalCnt}
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td>
			<table id="boardTable" border = "1">
				<tr>
					<td width="80" align="center">
						Type
					</td>
					<td width="40" align="center">
						No
					</td>
					<td width="300" align="center">
						Title
					</td>
				</tr>
				<c:forEach items="${boardList}" var="list">
					<tr>
						<td align="center">
							${list.codeName}
						</td>
						<td>
							${list.boardNum}
						</td>
						<td>
							<a href = "/board/${list.boardType}/${list.boardNum}/boardView.do?pageNo=${pageNo}">${list.boardTitle}</a>
						</td>
					</tr>
				</c:forEach>
			</table>
		</td>
	</tr>
	<tr>
		<c:choose>
			<c:when test="${userInfo !=null}">
				<td align="right">
					<a href ="/board/boardWrite.do">글쓰기</a>
					<a href ="/user/userLogout.do" id="userLogout">로그아웃</a>
				</td>
			</c:when>
			<c:otherwise>
				<td align="right">
					<a href ="" onclick="if(alert('비회원은 글쓰기가 불가능합니다. 로그인 해주세요.'));"type="submit">글쓰기</a>
				</td>
			</c:otherwise>
		</c:choose>
		
	</tr>
	<tr>
		<td>
		<form method="get" action="boardList.do" id="boardForm">
		<input type="checkbox" class="search" name="searchAll" id="check_all" >전체
		<c:forEach var="item" items="${codeList}">
			<input type="checkbox" class="search" name="search" id="search" value="${item.codeId}">${item.codeName}
		</c:forEach>
		
		<button type="submit" id="submitId">조회</button>
		</form>
		</td>
	</tr>
</table>
<script type="text/javascript">
	$j(document).ready(function(){
		$j("#submitId").on("click", function() {
			$j('#check_all').attr('disabled', false);
			$j("#boardForm").submit();
		})
		$j("#check_all").click(function(){ 
			
			if($j("#check_all").is(":checked")){
				$j(".search").prop("checked", true);
			}
			else { 
				$j(".search").prop("checked", false); 
			} 
		});
		
		$j(".search").click(function(){
			var checkedBoxCnt=$j("input[name='search']:checked").length;
			var checkBoxCnt =$j("input[name='search']").length;
			if(checkedBoxCnt==checkBoxCnt){
				$j("#check_all").prop("checked", true);
			}else{
				$j("#check_all").prop("checked", false);
			}
		})
	});
	
</script>	
</body>
</html>