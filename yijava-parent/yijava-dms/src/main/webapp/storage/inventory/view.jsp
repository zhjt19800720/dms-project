<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/base.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/common/head.jsp"%>
</head>
<body LEFTMARGIN=0 TOPMARGIN=0 MARGINWIDTH=0 MARGINHEIGHT=0>
		<div id="p" class="easyui-panel" title="">
			<div style="margin: 10px 0;"></div>
			<div style="padding-left: 10px; padding-right: 10px">

				<div class="easyui-panel" title="查询条件">
					<div style="padding: 10px 0 10px 60px">
						<form id="ffquery" method="post">
							<table>
								<tr>
									<td width="50">经销商:</td>
									<td width="270">
										<c:choose>
										       <c:when test="${user.fk_dealer_id!='0'}">
													<input class="easyui-validatebox" disabled="disabled" id="dealer_name" value="${user.dealer_name}" style="width:200px" maxLength="100">
													<input class="easyui-validatebox" type="hidden" name="dealer_id" id="dealer_id" value="${user.fk_dealer_id}" style="width:200px" maxLength="100">					       	
										       </c:when>
										       <c:otherwise>
										       		<input class="easyui-combobox" name="dealer_id" id="dealer_id" style="width:200px" maxLength="100" class="easyui-validatebox"
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
									<td></td>
									<td width="80">仓库:</td>
									<td width="270"><input class="easyui-validatebox" type="text" name="storage_name" id="storage_name" data-options="required:false"></input></td>
								</tr>
								<tr>
									<td>型号:</td>
									<td><input class="easyui-validatebox" type="text" name="models" id="models" data-options="required:false"></input></td>
									<td></td>
									<td>批号/序列号:</td>
									<td><input class="easyui-validatebox" type="text" name="batch_no" id="batch_no" data-options="required:false"></input></td>
								</tr>
							</table>
						</form>
					</div>
					<div style="text-align: right; padding: 5px">
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="doSearch()">查询</a>			   
					</div>
				</div>
			</div>

			<div style="margin: 10px 0;"></div>

			<div style="padding-left: 10px; padding-right: 10px">
				<table id="dg"  title="查询结果" style="height: 340px" method="get"
					rownumbers="true" singleSelect="true" pagination="true" sortName="id" sortOrder="desc" toolbar="#tb">
					<thead>
						<tr>
							<th field="dealer_name" width="180" align="left" sortable="true">经销商</th>
							<th field="storage_name" width="180" align="left" sortable="true">仓库</th>
							<th field="product_item_number" width="60" align="left" sortable="true">产品编号</th>
							<th field="product_cname" width="120" align="left" sortable="true">产品中文名称</th>
							<th field="models" width="120" align="left" sortable="true">规格</th>
							<th field="batch_no" width="100" align="left" sortable="true">批号/序列号</th>
							<th field="valid_date" width="100" align="left" sortable="true" >有效期</th>
							<th field="inventory_number" width="100" align="left" sortable="true">产品数量（EA）</th>
							
							<th data-options="field:'product_sn',width:100,align:'center',editor:'datebox'" formatter="formatterProductSn">序列号</th>
						</tr>
					</thead>
				</table>
				<div id="tb">     
<!-- 				    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-save"  plain="true" onclick="updateEntity();">编辑</a>        -->
				</div> 
			</div>
			<div style="margin: 10px 0;"></div>
		</div>


		<div id="dlgProductSn" class="easyui-dialog" title="明细" style="width:950px;height:auto;padding:5px 5px 5px 5px;"
            modal="true" closed="true" buttons="#dlg-buttons">
				<div class="easyui-panel" title="查询条件" style="width:925px;" style="margin: 10px 0;">
					<div style="padding: 10px 0 10px 60px">
						<form id="fm" method="post">
							<table>
								<tr>
									<td>序列号:</td>
									<td><input class="easyui-validatebox" type="text" name="product_sn" id="product_sn" data-options="required:false"></input></td>
								</tr>
							</table>
						</form>
					</div>
					<div style="text-align: right; padding: 5px">
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="doSearchSn()">查询</a>			   
					</div>
				</div>
			<div style="margin: 10px 0;"></div>
					<table id="dgProductSn" class="easyui-datagrid" title="明细信息" style="height:330px" method="get"
						 rownumbers="true" singleSelect="true" pagination="true" sortName="id" sortOrder="desc">
						<thead>
							<tr>
							<th data-options="field:'product_sn',width:240,align:'center'" sortable="true">序列号</th>
							</tr>
						</thead>
					</table>
		</div>
		<div id="dlg-buttons">
	        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlgProductSn').dialog('close')">取消</a>
	    </div>
	<script type="text/javascript">
	 	var url;
		$('#dg').datagrid({
			url : basePath + "api/storageDetail/paging",
			onLoadSuccess:function(data){ 
				  $(".productSnBtn").linkbutton({ plain:true, iconCls:'icon-manage' });
			 }
		});
		function formatterProductSn (value, row, index) { 
			 	return '<a class="productSnBtn" href="javascript:void(0)"  onclick="openProductSn('+index+')" ></a>';
		}
		function doSearch(){
		    $('#dg').datagrid('load',{
		    	filter_ANDS_dealer_id: $('#ffquery input[name=dealer_id]').val(),
		    	filter_ANDS_storage_name: $('#storage_name').val(),
		    	filter_ANDS_product_item_number: $('#product_item_number').val(),
		    	filter_ANDS_batch_no: $('#batch_no').val(),
		    	filter_ANDS_models: $('#models').val()
		    });
		}
		var fk_dealer_id ;
		var fk_storage_id;
		var batch_no;
		var models;
		var valid_date;
		function openProductSn(index){
			$('#dg').datagrid('selectRow',index);
			var row = $('#dg').datagrid('getSelected');
			$('#dlgProductSn').dialog('open').dialog('setTitle','产品下序列号');
			$('#fm').form('clear');
			batch_no = row.batch_no;
			fk_storage_id = row.fk_storage_id;
			fk_dealer_id = row.fk_dealer_id;
			models  = row.models;
			valid_date = row.valid_date;
			$('#dgProductSn').datagrid('loadData', {total: 0, rows: []});
			$('#dgProductSn').datagrid({
				url : basePath + "api/storageProDetail/paging",
				queryParams: {
					filter_ANDS_fk_dealer_id : fk_dealer_id,
					filter_ANDS_fk_storage_id : fk_storage_id	,
					filter_ANDS_batch_no : batch_no,
					filter_ANDS_models : models,
					filter_ANDS_valid_date : valid_date,
					filter_ANDS_status : 1,
				}
			});
		}
		function doSearchSn(){
		    $('#dgProductSn').datagrid('load',{
		    	filter_ANDS_product_sn: $('input[name=product_sn]').val(),
				filter_ANDS_fk_dealer_id : fk_dealer_id,
				filter_ANDS_fk_storage_id : fk_storage_id	,
				filter_ANDS_batch_no : batch_no,
				filter_ANDS_valid_date : valid_date,
				filter_ANDS_status : 1
		    });
		}
	</script>
</body>
</html>
