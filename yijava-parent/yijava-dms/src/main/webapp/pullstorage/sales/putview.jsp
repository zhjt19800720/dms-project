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
<body LEFTMARGIN=0 TOPMARGIN=0 MARGINWIDTH=0 MARGINHEIGHT=0>
		<div id="p" class="easyui-panel" title="">
			<div style="margin: 10px 0;"></div>
			<div style="padding-left: 10px; padding-right: 10px">
				<div class="easyui-panel" title="查询条件">
					<div style="padding: 10px 0 10px 60px">
						<form id="ff" method="post">
							<table>
								<tr>
									<td>分销出库单号:</td>	
									<td><input class="easyui-validatebox" type="text" name="pull_storage_code"></input></td>
									<!-- 此处查询需要修改，如果是经销商，必须查询子经销商 -->
									<td width="100">收货经销商:</td>
									<td>
										<input class="easyui-combobox" name="fk_put_storage_party_id" id="fk_put_storage_party_id" style="width:150px" maxLength="100" class="easyui-validatebox"
						             			data-options="
							             			url:'${basePath}api/userDealerFun/list?d_id=${user.fk_department_id}&u_id=${user.id}',
								                    method:'get',
								                    valueField:'dealer_id',
								                    textField:'dealer_name',
								                    panelHeight:'auto'
						            			"/>
									</td>
									<td width="50">状态:</td>
									<td width="270">										
										<input name="status" class="easyui-combobox" data-options="
											valueField: 'id',
											textField: 'value',
											data: [{
												id: '0',
												value: '未提交'
											},{
												id: '1',
												value: '在途'
											},{
												id: '2',
												value: '成功'
											},{
												id: '3',
												value: '取消'
											},]" />
									</td>
								</tr>
								<tr>
									<td width="100">开始时间:</td>
									<td width="270">
										<input name="pull_start_date" id="put_start_date" class="easyui-datebox"></input>
									</td>
									<td width="100">结束时间:</td>
									<td width="270">
										 <input name="pull_end_date" id="put_end_date" class="easyui-datebox"></input>
									</td>
								</tr>
							</table>
						</form>
					</div>
					<div style="text-align: right; padding: 5px">
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>   
					</div>
				</div>
			</div>
			<div style="margin: 10px 0;"></div>
			<div style="padding-left: 10px; padding-right: 10px">
				<table id="dg" title="查询结果" style="height:370px" url="${basePath}api/pullstorage/paging" method="get"
					rownumbers="true" singleSelect="true" pagination="true" sortName="id" pagination="true" 
					iconCls="icon-search" sortOrder="asc" toolbar="#tbPullStorage">
					<thead>
						<tr>
							<th data-options="field:'id',width:240,align:'center'" hidden="true">id</th>
							<th data-options="field:'put_storage_party_name',width:240,align:'center'" sortable="true">收货经销商</th>
							<th data-options="field:'pull_storage_code',width:200,align:'center'" sortable="true">分销出库单号</th>
							<th data-options="field:'pull_storage_party_name',width:240,align:'center'" sortable="true">分销方</th>
							<th data-options="field:'total_number',width:80,align:'center'" sortable="true">总数量</th>
							<th data-options="field:'pull_storage_date',width:150,align:'center'" sortable="true">出库时间</th>
							<th data-options="field:'pull_storage_party_name',width:150,align:'center'" sortable="true">出库人</th>
							<th data-options="field:'status',width:80,align:'center'" formatter="formatterStatus" sortable="true">单据状态</th>
							<th data-options="field:'custom',width:80,align:'center'" formatter="formatterDetail">明细</th>
						</tr>
					</thead>
				</table>
			</div>
			<div id="tbPullStorage">
				<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newEntity()">添加</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editEntity()">编辑</a>
        		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="destroyEntity()">删除</a>
			</div>
			<div style="margin: 10px 0;"></div>
			<div id="w" class="easyui-window" data-options="minimizable:false,maximizable:false,modal:true,closed:true,iconCls:'icon-manage'" style="width:300px;height:200px;padding:10px;">
			<form id="ffadd" action="" method="post" enctype="multipart/form-data">
				<table>
					<tr>
					<!-- 此处查询需要修改，如果是经销商，必须查询子经销商 -->
						<td>收货经销商:</td>
						<td>
							<input hidden="true" id="type" name="type" value="1"/>
							<input hidden="true" id="put_storage_party_code" name="put_storage_party_code"></input>
						    <input class="easyui-combobox" name="fk_put_storage_party_id" id="fk_put_storage_party_id" style="width:150px" maxLength="100" class="easyui-validatebox"
						             			data-options="
							             			url:'${basePath}api/userDealerFun/list?d_id=${user.fk_department_id}&u_id=${user.id}',
								                    method:'get',
								                    valueField:'dealer_id',
								                    textField:'dealer_name',
								                    panelHeight:'auto',
								                    onSelect:function functionS(s){
														$('#pul_storage_code').val(s.deliver_code);
													}
						            			"/>
						</td>
					</tr>
					<tr>
						<td>收货人:</td>
						<td>
							<input class="easyui-validatebox" disabled="disabled" name="receive_linkman" id="receive_linkman" value="aa" style="width:150px" maxLength="100">
						</td>
					</tr>
					<tr>
						<td>收货电话:</td>
						<td>
							<input class="easyui-validatebox" disabled="disabled" name="receive_linkphone" id="receive_linkphone" style="width:150px" maxLength="100">
						</td>
					</tr>
				</table>
			</form>
			<div style="margin: 10px 0;"></div>
			<div style="text-align: right; padding: 5px">
				<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="saveEntity()">确定</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="$('#w').window('close')">取消</a>					   
			</div>
		</div>
		</div>
		<div id="dlgPullStorageDetail" class="easyui-dialog" title="订单明细" style="width:950px;height:auto;padding:5px 5px 5px 5px;"
            modal="true" closed="true" buttons="#dlg-buttons">
            <div class="easyui-panel" style="width:925px;" style="margin: 10px 0;">
					<form id="ffPullStorageDetail" method="post">
							<table>
								<tr>
									<td width="100">经销商:</td>
									<td>
						            	<input class="easyui-validatebox" readonly="readonly" type="text" name="pull_storage_party_name"></input>
									</td>
									<td>出货单号:</td>	
									<td><input class="easyui-validatebox" readonly="readonly" type="text" name="pull_storage_code"></input></td>
									<td>出货时间:</td>	
									<td><input class="easyui-validatebox" readonly="readonly" type="text" name="pull_storage_date"></input></td>
								</tr>
								<tr>
									<td width="100">收货经销商:</td>
									<td>
						            	<input class="easyui-validatebox" readonly="readonly" type="text" name="put_storage_party_name"></input>
									</td>
									<td width="50">状态:</td>
									<td width="270">				
										<input name="status" class="easyui-combobox" data-options="
											valueField: 'id',
											textField: 'value',
											data: [{
												id: '0',
												value: '未提交'
											},{
												id: '1',
												value: '在途'
											},{
												id: '2',
												value: '成功'
											},{
												id: '3',
												value: '取消'
											},]" />
									</td>
								</tr>
							</table>
					</form>
			</div>
			<div style="margin: 10px 0;"></div>
			<div style="padding-left: 10px; padding-right: 10px">
				<table id="dgDetail" class="easyui-datagrid" title="明细信息" style="height:370px" method="get"
					 rownumbers="true" singleSelect="true" pagination="true" sortName="id" sortOrder="desc" toolbar="#tbPullStorageDetail">
					<thead>
						<tr>
							<th data-options="field:'fk_storage_id',width:100,align:'center'" hidden="true"></th>
							<th data-options="field:'storage_name',width:100,align:'center'" sortable="true">仓库</th>
							<th data-options="field:'product_item_number',width:100,align:'center'" sortable="true">产品编码</th>
							<th data-options="field:'batch_no',width:200,align:'center'" sortable="true">产品批次</th>
							<th data-options="field:'valid_date',width:100,align:'center'" sortable="true">有效日期</th>
							<th data-options="field:'inventory_number',width:80,align:'center'" sortable="true">库存量</th>
							<th data-options="field:'sales_numberr',width:80,align:'center'" sortable="true">销售数量</th>
						</tr>
					</thead>
				</table>
				<div id="tbPullStorageDetail">    
				    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" id="savePullStorageDetail" onclick="newPullStorageDetailEntity();">添加产品</a>    
				    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" id="delPullStorageDetail" onclick="removePullStorageDetailEntity();">删除产品</a>    
				</div>
			</div>
			<div style="margin: 10px 0;"></div>
		</div>
		<div id="dlg-buttons">
	        <a id="saveEntityBtn" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="alert('提交后将不能在修改，确定提交吗？')">提交</a>
	        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlgPullStorageDetail').dialog('close')">取消</a>
	    </div>
		<div id="dlgProduct" class="easyui-dialog" style="width:800px;height:495px;padding:5px 5px 5px 5px;"
            modal="true" closed="true" buttons="#dlgProduct-buttons">
				<div class="easyui-panel" title="查询条件" style="width:775px;">
						<div style="padding: 10px 0 0 30px">
							<form id="ffdetail" method="post">
								<table>
									<tr>
										<td>仓库:</td>	
										<td width="100px"><input class="easyui-validatebox" type="text" name="storage_name" id="storage_name" ></input></td>
										<td>产品编号:</td>	
										<td width="100px"><input class="easyui-validatebox" type="text" name="product_item_number" id="product_item_number" ></input></td>
										<td>产品批次:</td>	
										<td width="100px"><input class="easyui-validatebox" type="text" name="batch_no" id="batch_no" ></input></td>
									</tr>
								</table>
							</form>
						</div>
						<div style="text-align: right; padding:5px">
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearchProduct()">查询</a>   
						</div>
					</div>
				<div style="margin: 10px 0;"></div>
					<table id="dgProduct" class="easyui-datagrid" title="查询结果" style="height:300px" method="get"
					rownumbers="true" singleSelect="true" pagination="true" sortName="item_number" sortOrder="desc" toolbar="#tbProduct">
						<thead>
							<tr>
								<th data-options="field:'storage_name',width:100,align:'center'" sortable="true">仓库</th>
								<th data-options="field:'product_item_number',width:100,align:'center'" sortable="true">产品编号</th>
								<th data-options="field:'product_name',width:150,align:'center'" sortable="true">产品名称</th>
								<th data-options="field:'batch_no',width:150,align:'center'" sortable="true">批次</th>
								<th data-options="field:'inventory_number',width:80,align:'center'" sortable="true">库存量</th>
								<th data-options="field:'valid_date',width:80,align:'center'" sortable="true">有效日期</th>
							</tr>
						</thead>
					</table>
		</div>
		<div style="margin: 10px 0;"></div>
	    <div id="dlgProduct-buttons">
	        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="newProductNumEntity()">添加产品</a>
	        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlgProduct').dialog('close')">取消</a>
	    </div>
		<div id="dlgProductSum" class="easyui-dialog" style="width:300px;height:300px;padding:5px 5px 5px 5px;"
	            modal="true" closed="true" buttons="#dlgProductSum-buttons">
		        <form id="fm3" action="" method="post" enctype="multipart/form-data">
					      <table> 
					      	     
					      	     <tr>
					             	<td>仓库:</td>
					             	<input name="fk_storage_id" hidden="true" class="easyui-validatebox" style="width:150px;">
					             	<td><input name="storage_name" readonly="true" class="easyui-validatebox" style="width:150px;"></td>
					            </tr>
					    		<tr>
					             	<td>出库单号:</td>
					             	<td><input name="pull_storage_code" readonly="true" class="easyui-validatebox" style="width:150px;"></td>
					            </tr>
					            <tr>
					             	<td>产品编码:</td>
					             	<td><input name="product_item_number" readonly="true" class="easyui-validatebox" style="width:150px"></td>
					            </tr>
					            <tr>
					             	<td>产品名称</td>
					             	<td><input name="product_name" readonly="true" class="easyui-validatebox" style="width:150px"></td>
					            </tr>
					            <tr>
					             	<td>批次</td>
					             	<td><input name="batch_no" readonly="true" class="easyui-validatebox" style="width:150px"></td>
					            </tr>
					            <tr>
					             	<td>单价</td>
					             	<td><input name="money" readonly="true" class="easyui-validatebox" style="width:150px"></td>
					            </tr>
					            <tr>
					             	<td>库存量:</td>
					             	<td><input name="inventory_number" readonly="true" class="easyui-numberbox" style="width:150px"></td>
					             </tr>
						        <tr>
					             	<td>数量:</td>
					             	<td><input name="sales_numberr" id="sales_numberr" class="easyui-numberbox" style="width:150px" 
									data-options="required:true"></td>
					             </tr>
					      </table>    	
		        </form>
	    </div>
	    <div id="dlgProductSum-buttons">
	        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="savePullStorageDetailEntity();">保存</a>
	        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlgProductSum').dialog('close')">取消</a>
	    </div>
	<script type="text/javascript">
		var status;
		var pull_storage_code;
		var fk_pull_storage_party_id=${user.fk_dealer_id};
		$(function() {
			var pager = $('#dg').datagrid().datagrid('getPager'); 
			pager.pagination();
		})
		function formatterDetail(value, row, index){
			return '<span style="color:red;cursor:pointer" onclick="openPullStorageDetail(\''+index+'\')">明细</span>'; 
		}
		function doSearch(){
		    $('#dg').datagrid('load',{
		    	filter_ANDS_pull_storage_code:$('#ff input[name=pull_storage_code]').val(),
		    	filter_ANDS_fk_pull_storage_party_id: $('#ff input[name=fk_pull_storage_party_id]').val(),
		    	filter_ANDS_fk_put_storage_party_id: $('#ff input[name=fk_put_storage_party_id]').val(),
		    	
		    	filter_ANDS_status: $('#ff input[name=status]').val(),
		    	filter_ANDS_pull_start_date: $('#ff input[name=pull_start_date]').val(),
		    	filter_ANDS_pull_end_date: $('#ff input[name=pull_end_date]').val(),
		    });
		}
		function formatterStatus(value, row, index){
			if(value=='0')
				return '<span>未提交</span>'; 
			else if(value=='1')
				return '<span>在途</span>'; 
			else if(value=='2')
				return '<span>成功</span>'; 
			else if(value=='3')
				return '<span>取消</span>'; 
		}
		function newEntity()
		{
			clearForm();
			$('#w').dialog('open').dialog('setTitle','添加信息');
			url =basePath+'api/pullstorage/save';
			$('#w').window('open');
		}		
		function saveEntity() {
			$('#ffadd').form('submit', {
			    url:url,
			    method:"post",
			    onSubmit: function(){
			        return $(this).form('validate');
			    },
			    success:function(msg){
			    	var jsonobj = $.parseJSON(msg);
			    	if(jsonobj.state==1){
			    		clearForm();
				    	$('#w').window('close');
				    	var pager = $('#dg').datagrid().datagrid('getPager');
				    	pager.pagination('select');	
			    	}else{
			    		$.messager.alert('提示','Error!','error');	
			    	}
			    }
			});
		}
		function editEntity()
		{
			var row = $('#dg').datagrid('getSelected');
			if (row){
				$('#w').dialog('open').dialog('setTitle','更新信息');
			    $('#ffadd').form('load', row);
				url = basePath+'api/pullstorage/updateAddress';
				$('#w').window('open');
			}else
			{
				$.messager.alert('提示','请选中某个订单!','warning');
			}
		}
		function destroyEntity()
		{
			var row = $('#dg').datagrid('getSelected');
			if (row){
				if(row.status=='0'){
				    $.ajax({
						type : "POST",
						url :basePath+'api/pullstorage/remove?id='+row.id,
						error : function(request) {
							$.messager.alert('提示','抱歉,删除错误!','error');	
						},
						success:function(msg){
						    var jsonobj = $.parseJSON(msg);
        					if (jsonobj.state == 1) {
        						 pull_storage_code=undefined;
        	                     $('#dg').datagrid('reload');
        	                     $('#dgDetail').datagrid('loadData', {total: 0, rows: [] });
        	                     $('#dgDetail').datagrid({
        	         				title:'包含产品'
        	         			 });
        					}else{
        						$.messager.alert('提示','抱歉,删除错误!','error');	
        					}
						}	
					});
				}else{
					$.messager.alert('提示','无法删除已提交的订单!','error');
				}
			}else
			{
				$.messager.alert('提示','请选中某个订单!','warning');
			}
		}
		function clearForm(){
			$('#ffadd').form('clear');
		}
		function clearPullStorageDetailForm(){
			$('#fm3').form('clear');
		}
		//open订单项
		function openPullStorageDetail(index){
			$('#dg').datagrid('selectRow',index);
			var row = $('#dg').datagrid('getSelected');
			$('#ffPullStorageDetail').form('load',row);
			$('#ffPullStorageInfo').form('load',row);
			$('#dlgPullStorageDetail').dialog('open');
            $('#dgDetail').datagrid('loadData', {total: 0, rows: []});
            pull_storage_code = row.pull_storage_code;
			status=row.status;
			$('#dgDetail').datagrid({
				url : basePath + "api/pullstoragedetail/paging",
				queryParams: {
					filter_ANDS_pull_storage_code : pull_storage_code
				}
			});
			if(status!='0'){
				$('#savePullStorageDetail').linkbutton('disable');
				$('#delPullStorageDetail').linkbutton('disable');
			}else{
				$('#savePullStorageDetail').linkbutton('enable');
				$('#delPullStorageDetail').linkbutton('enable');
			}
		}
		//订单项
		function removePullStorageDetailEntity()
		{
			var row = $('#dgDetail').datagrid('getSelected');
			if (row){
				if(status=='0'){
				    $.ajax({
						type : "POST",
						url :basePath+'api/pullstoragedetail/remove?oc='+row.pull_storage_code+'&id='+row.id,
						error : function(request) {
							$.messager.alert('提示','抱歉,删除错误!','error');	
						},
						success:function(msg){
						    var jsonobj = $.parseJSON(msg);
        					if (jsonobj.state == 1) {
        	                     $('#dgDetail').datagrid('reload');
        	                     $('#dg').datagrid('reload');
        					}else{
        						$.messager.alert('提示','抱歉,删除错误!','error');	
        					}
						}
					});
				}else{
					$.messager.alert('提示','无法删除已提交的单据!','error');
				}
			}else
			{
				$.messager.alert('提示','请选中某个产品!','warning');
			}
		}
		function newPullStorageDetailEntity()
		{
			if(typeof(pull_storage_code) != "undefined"){
				$('#dlgProduct').dialog('open').dialog('setTitle','['+pull_storage_code+']产品列表');
				$('#dgProduct').datagrid({
					 url:basePath+'api/product/paging',
					 queryParams: {
						filter_ANDS_dealer_id : dealer_id
					 }
				});
			}else
			{
				$.messager.alert('提示','请选中某个订单!','warning');
			}
		}
		function newProductNumEntity() {
			clearPullStorageDetailForm();
			var row = $('#dgProduct').datagrid('getSelected');
			if(row){
				$("#fm3 input[name=pull_storage_code]").val(pull_storage_code);
				$("#fm3 input[name=product_item_number]").val(row.product_item_number);
				$("#fm3 input[name=product_name]").val(row.product_name);
				$("#fm3 input[name=batch_no]").val(row.batch_no);	
				$("#fm3 input[name=money]").val(row.money);	
				$("#fm3 input[name=inventory_number]").val(row.inventory_number);	
				$("#fm3 input[name=fk_storage_id]").val(row.fk_storage_id);	
				$("#fm3 input[name=storage_name]").val(row.storage_name);
				$('#dlgProductSum').dialog('open').dialog('setTitle','添加产品');
			}else
			{
				$.messager.alert('提示','请选中某个产品!','warning');
			}
		}
		function savePullStorageDetailEntity(){
			var row = $('#dgProduct').datagrid('getSelected');
			if(row){
				$('#fm3').form('submit', {
					url :basePath+'api/pullstoragedetail/save',
				    method:"post",
				    onSubmit: function(){
				        return $(this).form('validate');
				    },
				    success:function(msg){
				    	var jsonobj = $.parseJSON(msg);
				    	if(jsonobj.state==1){
							 $('#dlgProductSum').dialog('close');     
		                     $('#dgDetail').datagrid('reload');
		                     $('#dg').datagrid('reload');
				    	}else if(jsonobj.state==2){
				    		$.messager.alert('提示','不可重复添加一个批次!','error');	
				    	}else{
				    		$.messager.alert('提示','Error!','error');	
				    	}
				    }
				});					
			}else
			{
				$.messager.alert('提示','请选中某个产品!','warning');
			}
		}
		function doSearchProduct(){
		    $('#dgProduct').datagrid('load',{
		    	filter_ANDS_storage_name: $("#ffdetail input[name=storage_name]").val(),
		    	filter_ANDS_product_item_number: product_item_number,
		    	filter_ANDS_batch_no: $("#ffdetail input[name=batch_no]").val()
		    });
		}
		function formatterIs_pullstorage (value, row, index) { 
			return value==1?"<span style='color:green'>是</span>":"<span style='color:red'>否</span>";
		} 
	</script>
</body>
</html>