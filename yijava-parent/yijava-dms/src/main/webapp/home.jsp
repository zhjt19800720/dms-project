<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/base.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@include file="/common/head.jsp"%>
</head>
<body class="easyui-layout">	
	<div data-options="region:'west',split:true,title:'公司信息'"
		style="width: 150px; padding: 10px;">海利欧斯经销商管理系统
	</div>
	<div
		data-options="region:'east',split:true,collapsed:false,title:'待处理事项',tools:'#treetool'"
		style="width: 200px; padding: 10px;">
			<ul id="tochecktree" class="easyui-tree" data-options="url:'${basePath}api/flowrecord/tocheck',method:'get',animate:true"></ul>
	</div>	
	<div id="mainPanle11" data-options="iconCls:'icon-info',region:'center',title:'公告及通知'">		
		<div title="公告及通知" data-options="iconCls:'icon-info',closable:false" style="padding:2px;overflow:hidden;" id="home">
			<div style="">
				<table id="dg"  title="查询结果" style="height: 630px"  method="get"
					rownumbers="true" singleSelect="true" pagination="true" sortName="publish_date" sortOrder="desc" toolbar="#tb">
					<thead>
						<tr>
							<th field="title" width="200" align="center" sortable="true">标题</th>
							<th field="realname" width="100" align="center" sortable="true">发布人</th>
							<th field="status_name" width="100" align="center"  sortable="true">发布状态</th>
							<th field="publish_date" width="150" align="center" sortable="true">发布时间</th>
							<th field="validity_date" width="150" align="center" sortable="true">有效期</th>
							<th field="level_name" width="100" align="center"  sortable="true">紧急程度</th>
							<th field="dealer_id" width="100" align="center"  sortable="true" formatter="formatterInfo">详细</th>							
						</tr>
					</thead>
				</table>
			</div>
		   <div id="dlgInfo" class="easyui-dialog" style="width:703px;height:450px;padding: 5px 5px 5px 5px;"
		            modal="true" closed="true">
		         <form id="fmInfo" method="post" novalidate enctype="multipart/form-data">
		         <div class="easyui-tabs" style="width:680px;height: auto;">
		         	 <div title="基本信息" style="padding: 5px 5px 5px 5px;" >
				        <div data-options="region:'center'" style="background:#fafafa;overflow:hidden">  
				         	  <table border="0">
										<tr>
											<td>重要性:</td>
											<td><input name="level_name"  type="text" required="true" style="width:80px;"/></td>
					             			<td>有效期:</td>
					             			<td><input name="validity_date" class="easyui-datebox" type="text" style="width:100px;"></td>
											<td>状态:</td>
											<td><input name="status_name" type="text" required="true" style="width:80px;"/></td>
					             	</tr>            	
					             	<tr >
					             		<td>标题:</td>
					             		<td colspan="5"><input name="title" style="width:250px" maxLength="30" class="easyui-validatebox" required="true"></td>
					             	</tr>             	
					              	<tr>
					             		<td>公告内容:</td>
					             		<td colspan="5"><textarea name="content" cols="65" style="height:220px;"></textarea></td>
					             	</tr>
					            </table>					
				        </div>  
				    </div> 
		 		</div>
		 		</form>
		   </div>
		</div>
	</div>	
	<div id="treetool">
		<a href="javascript:void(0)" class="icon-reload" onclick="javascript:checkReload();"></a>		
	</div>
	
<script type="text/javascript">
$(document).ready(function(){
	$('#mm1').menu();  
});
$('#tochecktree').tree({
	onClick: function(node){
		if(node.id==trialflow_identifier_num)
		{
			var tabTitle = "试用管理";
			var url = "trial/view.jsp";
			
			
			
			addTabByChild(tabTitle,url);
		}			
	}
});
function checkReload()
{  
	$('#tochecktree').tree('reload');
	
}
var dealer_id = ${user.fk_dealer_id};

	$('#dg').datagrid({
		  url : basePath +"api/notice/paging" ,
		  queryParams: {
				filter_ANDS_status_id : 3,
				filter_ANDS_dealer_id : dealer_id
		  },
		  onLoadSuccess:function(data){ 
			  $(".infoBtn").linkbutton({ plain:true, iconCls:'icon-manage' });
		  }
	});
function formatterInfo(value, row, index){
	v = "'"+ row.notice_id + "','" + index+"'";
	return '<a class="infoBtn" href="javascript:void(0)"  onclick="showEntity(' + v + ')" ></a>';
}
function showEntity(notice_id,index){
	$('#dg').datagrid('selectRow',index);
	var row = $('#dg').datagrid('getSelected');
	if (row) {
		$('#dlgInfo').dialog('open').dialog('setTitle', '公告详细');
		$('#fmInfo').form('load', row);
		$.getJSON(basePath + "api/noticeDealer/update?id="+row.notice_id,function(result){});				
	}
}
</script>
</body>
</html>