<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardWrite</title>
</head>
<script type="text/javascript">
	$j(document).ready(function(){
		$j("#submit").on("click",function(){
			var boardTypeArr = [];
			var boardTitleArr = [];
			var boardCommentArr = [];
			var boardCreatorArr = [];
			$j('select[name="boardType"]').each(function(index,item){
				boardTypeArr.push($j(this).val());
			})
			$j('input[name="boardTitle"]').each(function(index,item){
				boardTitleArr.push($j(this).val());
			})
			$j('textarea[name="boardComment"]').each(function(index,item){
				boardCommentArr.push($j(this).val());
			})
			$j('input[name="creator"]').each(function(index,item){
				boardCreatorArr.push($j(this).val());
			})
			var param = {
					"boardType" : boardTypeArr,
					"boardTitle": boardTitleArr,
					"boardComment": boardCommentArr,
					"creator"  : boardCreatorArr
			};
			
			jQuery.ajaxSettings.traditional = true;
			$j.ajax({
			    url : "/board/boardWriteAction.do",
			    dataType: "json",
			    type: "POST",
			    data : param,
			    success: function(data, textStatus, jqXHR)
			    {
					alert("작성완료");
					
					alert("메세지:"+data.success);
					
					location.href = "/board/boardList.do";
			    },
			    error: function (jqXHR, textStatus, errorThrown)
			    {
			    	alert("실패");
			    }
			});
		});
		var i = 1;
		$j("#addTable").click(function() {
		  	var clone= $j("#table_index").clone()
		  	clone.find(".boardTitle").val("");
		  	clone.find(".boardComment").val("");
		  	clone.attr('id', 'table_index'+ i).insertBefore(".add_table").find("#delete_table").each(function(){
		  		 $j(this).attr({
		  	 	      'id': function(_, id) { return id + i},
		  	 	 });
		  	});

		  	$j("#delete_table"+i).append("<input class='del_btn' type='button' id=delete"+i+" value='삭제' style=margin-left:310px;>")
		  	i++;
			$j(".del_btn").on("click",function() {
				var ch= $j(this).prop("id");
				var id = $j("#"+ch).parent().parent().parent().parent().parent().parent();
				id.remove();
			});
		});	
	});

</script>
<body>
<form class="boardWrite">
	<table align="center">
		<tr>
			<td align="right">
				<input id="addTable" type="button" value="행추가">
				<input id="submit" type="button" value="작성">
			</td>
		</tr>
		<tr class="clone_table" id="table_index">
			<td id="selector">
				<table border ="1">
					<tr>
						<td width="120" align="center">
						Type
						</td>
						<td width="400" id="delete_table">
						<select name="boardType" class="boardType">
							<c:forEach var="item" items="${codeList}">
								<option value="${item.codeId}">${item.codeName}</option>
							</c:forEach>
						</select>
						</td>
					</tr>
					<tr>
						<td width="120" align="center">
						Title
						</td>
						<td width="400">
						<input name="boardTitle" class="boardTitle" type="text" size="50" value="${board.boardTitle}"> 
						</td>
					</tr>
					<tr>
						<td height="300" align="center">
						Comment
						</td>
						<td valign="top">
						<textarea name="boardComment" class="boardComment" rows="20" cols="55">${board.boardComment}</textarea>
						</td>
					</tr>
					<tr>
						<td align="center">
						Writer
						</td>
						<td>
						<input type="hidden" name="creator" value="${userInfo.userId}">${userInfo.userId}
						</td>
					</tr>
				</table>
			</td>
		</tr>
		
		<tr class="add_table">
			<td align="right">
				<a href="/board/boardList.do">List</a>
			</td>
		</tr>
	</table>
</form>	
</body>
</html>