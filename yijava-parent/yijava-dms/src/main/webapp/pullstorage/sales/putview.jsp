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
									<input class="easyui-validatebox" type="hidden" name="type" id="type" value="1"/>
									<td width="200">分销出库单号:</td>	
									<td><input class="easyui-validatebox" type="text" name="pull_storage_code"></input></td>
									<td width="150">经销商:</td>
									<td>
										<c:choose>
										       <c:when test="${user.fk_dealer_id!='0'}">
													<input class="easyui-validatebox" disabled="disabled" id="put_storage_party_name" value="${user.dealer_name}" style="width:150px" maxLength="100">
													<input class="easyui-validatebox" type="hidden" name="fk_put_storage_party_id" id="fk_put_storage_party_id" value="${user.fk_dealer_id}" style="width:150px" maxLength="100">					       	
										       </c:when>
										       <c:otherwise>
										       		<input class="easyui-combobox" name="dealer_id" id="dealer_id" style="width:150px" maxLength="100" class="easyui-validatebox"
								             			data-options="
									             			url:'${basePath}api/userDealerFun/list?t_id=${user.teams}&u_id=${user.id}',
										                    method:'get',
										                    valueField:'dealer_id',
										                    textField:'dealer_name',
										                    panelHeight:'auto'
								            			"/>
										       </c:otherwise>
										</c:choose>
									</td>
									<td width="50">状态:</td>
									<td width="270">										
										<input name="status" class="easyui-combobox" data-options="
											valueField: 'id',
											textField: 'value',
											data:[{
												id: '0',
												value: '未提交'
											},{
												id: '3',
												value: '在途'
											},{
												id: '4',
												value: '成功'
											}]" />
									</td>
								</tr>
								<tr>
									<td width="100">开始时间:</td>
									<td width="270">
										<input name="put_start_date" id="put_start_date" class="easyui-datebox"></input>
									</td>
									<td width="100">结束时间:</td>
									<td width="270">
										 <input name="put_end_date" id="put_end_date" class="easyui-datebox"></input>
									</td>
								</tr>
							</table>
						</form>
					</div>
					<div style="text-align: right; padding: 5px">
						<restrict:function funId="67">
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
						</restrict:function>   
					</div>
				</div>
			</div>
			<div style="margin: 10px 0;"></div>
			<div style="padding-left: 10px; padding-right: 10px">
				<table id="dg" title="查询结果" style="height:370px" method="get"
					rownumbers="true" singleSelect="true" pagination="true" sortName="id" pagination="true" 
					iconCls="icon-search" sortOrder="asc">
					<thead>
						<tr>
							<th data-options="field:'id',width:10,align:'center'" hidden="true">id</th>
							<th data-options="field:'put_storage_party_name',width:200,align:'center'" sortable="true">经销商</th>
							<th data-options="field:'pull_storage_code',width:100,align:'center'" sortable="true">分销出库单号</th>
							<th data-options="field:'pull_storage_party_name',width:200,align:'center'" sortable="true">分销方</th>							
							<th data-options="field:'put_storage_code',width:100,align:'center'" hidden="true">收货单号</th>
							<th data-options="field:'total_number',width:80,align:'center'" sortable="true">总数量</th>
							<th data-options="field:'pull_storage_date',width:100,align:'center'" sortable="true">分销时间</th>
							<th data-options="field:'put_storage_date',width:100,align:'center'" sortable="true">收货时间</th>
							<th data-options="field:'status',width:80,align:'center'" formatter="formatterStatus" sortable="true">单据状态</th>
							<th data-options="field:'custom',width:80,align:'center'" formatter="formatterDetail">明细</th>
						</tr>
					</thead>
				</table>
			</div>
			<div style="margin: 10px 0;"></div>
		</div>
		<div id="dlgPullStorageDetail" class="easyui-dialog" title="明细" style="width:950px;height:auto;padding:5px 5px 5px 5px;"
            modal="true" closed="true" buttons="#dlg-buttons">
            <div class="easyui-panel" style="width:925px;" style="margin: 10px 0;">
					<form id="ffPullStorageDetail" method="post">
							<table>
								<tr>
									<td width="100">经销商:</td>
									<td>
						            	<input class="easyui-validatebox" readonly="readonly" type="text" name="put_storage_party_name"></input>
									</td>
									<td width="150">收货单号:</td>
									<td>
						            	<input class="easyui-validatebox" readonly="readonly" type="text" name="put_storage_code"></input>
									</td>
									<td width="100">状态:</td>
									<td width="270">				
										<input name="status" readonly="readonly" class="easyui-combobox" data-options="
											valueField: 'id',
											textField: 'value',
											data:[{
												id: '0',
												value: '未提交'
											},{
												id: '3',
												value: '在途'
											},{
												id: '4',
												value: '成功'
											}]" />
									</td>
								</tr>
								<tr>
									<td width="100">分销方:</td>
									<td>
						            	<input class="easyui-validatebox" readonly="readonly" type="text" name="pull_storage_party_name"></input>
									</td>
									<td width="150">分销出货单号:</td>	
									<td><input class="easyui-validatebox" readonly="readonly" type="text" name="pull_storage_code"></input></td>
									<td>分销时间:</td>	
									<td><input class="easyui-validatebox" readonly="readonly" type="text" name="pull_storage_date"></input></td>
								</tr>
							</table>
					</form>
			</div>
			<div style="margin: 10px 0;"></div>
			<div >
				<table id="dgDetail" class="easyui-datagrid" title="查询结果" style="height:370px" method="get"
					 rownumbers="true" singleSelect="true" pagination="true" sortName="id" sortOrder="desc">
					<thead>
						<tr>
							<th data-options="field:'fk_storage_id',width:100,align:'center'" hidden="true"></th>
							<th data-options="field:'storage_name',width:100,align:'center'" sortable="true">仓库</th>
							<th data-options="field:'product_item_number',width:100,align:'center'" sortable="true">产品编码</th>
							<th data-options="field:'batch_no',width:200,align:'center'" sortable="true">产品批次</th>
							<th data-options="field:'valid_date',width:100,align:'center'" sortable="true">有效日期</th>
							<th data-options="field:'inventory_number',width:80,align:'center'" sortable="true">库存量</th>
							<th data-options="field:'sales_number',width:80,align:'center'" sortable="true">销售数量(EA)</th>
							<th data-options="field:'product_sn',width:100,align:'center',editor:'datebox'" formatter="formatterProductSn">序列号</th>
						</tr>
					</thead>
				</table>
			</div>
			<div style="margin: 10px 0;"></div>
		</div>
		<div id="dlg-buttons">
			 <restrict:function funId="69">
		        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" id="submitPutStorage" onclick="submitPutStorage()">确认收货</a>
		     </restrict:function>
	        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlgPullStorageDetail').dialog('close')">取消</a>
	    </div>
	     <div id="dlgProductSn" class="easyui-dialog" style="width:475px;height:415px;padding: 5px 5px 5px 5px;"
            modal="true" closed="true">
				<table id="dgProductSn"  class="easyui-datagrid" title="查询结果" style="height:365px;width:450px;" method="get"
					rownumbers="true" singleSelect="true" pagination="true" sortName="id"
						pagination="true" iconCls="icon-search" sortOrder="asc">
					<thead>
						<tr>
							<th data-options="field:'product_sn',width:200,align:'center'" sortable="true">序列号</th>
							<th data-options="field:'last_time',width:200,align:'center'" sortable="true">更新时间</th>
						</tr>
					</thead>
				</table>
    	</div>
	<script type="text/javascript">
		var status;
		var pull_storage_code;
		var put_storage_code;
		$(function() {
			var pager = $('#dg').datagrid().datagrid('getPager'); // get the pager of datagrid
			pager.pagination();  
		})
		function formatterDetail(value, row, index){
			return '<span style="color:red;cursor:pointer" onclick="openPullStorageDetail(\''+index+'\')">明细</span>'; 
		}
		function doSearch(){
			$('#dg').datagrid({
				  url : basePath +"api/putstorage/paging",
				  queryParams: {
					 	filter_ANDS_pull_storage_code:$('#ff input[name=pull_storage_code]').val(),
				    	filter_ANDS_fk_put_storage_party_id: $('#ff input[name=fk_put_storage_party_id]').val(),
				    	filter_ANDS_status: $('#ff input[name=status]').val(),
				    	filter_ANDS_type: $('#ff input[name=type]').val(),
				    	filter_ANDS_put_start_date: $('#ff input[name=put_start_date]').val(),
				    	filter_ANDS_put_end_date: $('#ff input[name=put_end_date]').val(),
				  }
			});
		}
		function formatterStatus(value, row, index){
			if(value=='0')
				return '<span>未提交</span>'; 
			else if(value=='3')
				return '<span>在途</span>'; 
			else if(value=='4')
				return '<span>成功</span>'; 
		}
		//open订单项
		function openPullStorageDetail(index){
			$('#dg').datagrid('selectRow',index);
			var row = $('#dg').datagrid('getSelected');
			$('#ffPullStorageDetail').form('load',row);
			$('#dlgPullStorageDetail').dialog('open');
            $('#dgDetail').datagrid('loadData', {total: 0, rows: []});
            pull_storage_code = row.pull_storage_code;
            put_storage_code = row.put_storage_code;
			status=row.status;
			$('#dgDetail').datagrid({
				url : basePath + "api/pullstoragedetail/detailpaging",
				queryParams: {
					filter_ANDS_pull_storage_code : pull_storage_code
				},
				onLoadSuccess:function(data){ 
					  $(".productSnBtn").linkbutton({ plain:true, iconCls:'icon-manage' });
				}
			});
			if(status=='3'){
				$('#submitPutStorage').linkbutton('enable');
			}else{
				$('#submitPutStorage').linkbutton('disable');
			}
		}
		function submitPutStorage(){
			if(typeof(pull_storage_code) != "undefined")
			var row = $('#dg').datagrid('getSelected');
			if (row){
				$.ajax({
					type : "POST",
					url :basePath+'api/putstorage/submit',
					data:{pull_storage_code:pull_storage_code,put_storage_code:put_storage_code,id:row.id},
					error : function(request) {
						$.messager.alert('提示','抱歉,提交错误!','error');	
					},
					success:function(msg){
					    var jsonobj = $.parseJSON(msg);
			 			if (jsonobj.state == 1) {
			 	              $('#dg').datagrid('reload');
			 	              $('#dlgPullStorageDetail').dialog('close')
			 			}else{
			 				$.messager.alert('提示','抱歉,提交错误!','error');	
			 			}
					}
				});
			}
		}
		function formatterIs_pullstorage (value, row, index) { 
			return value==1?"<span style='color:green'>是</span>":"<span style='color:red'>否</span>";
		}
		function formatterProductSn (value, row, index) { 
			return '<a class="productSnBtn" href="javascript:void(0)"  onclick="openProductSn('+index+')" ></a>';
		}
		//SN明细
		function openProductSn(index){
			$('#dgDetail').datagrid('selectRow',index);
			var row = $('#dgDetail').datagrid('getSelected');
			$('#dlgProductSn').dialog('open').dialog('setTitle','产品下序列号');
			fk_pull_storage_detail_id = row.id;
			batch_no = row.batch_no;
			fk_storage_id = row.fk_storage_id;
			$('#dgProductSn').datagrid('loadData', {total: 0, rows: []});
			$('#dgProductSn').datagrid({
				url : basePath + "api/pullstorageprodetail/paging",
				queryParams: {
					filter_ANDS_pull_storage_code: pull_storage_code,
					filter_ANDS_fk_storage_id : fk_storage_id	,
					filter_ANDS_batch_no : batch_no
				}
			});
		}
	</script>
</body>
</html>