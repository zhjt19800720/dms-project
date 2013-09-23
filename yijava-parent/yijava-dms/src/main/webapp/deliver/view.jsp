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
									<td>订单号:</td>	
									<td><input class="easyui-validatebox" type="text" name="order_code"></input></td>
									<td>出货单号:</td>	
									<td><input class="easyui-validatebox" type="text" name="deliver_code"></input></td>
									<td width="50">状态:</td>
									<td width="270">										
										<input name="deliver_status" class="easyui-combobox" id="deliver_status"
											data-options="
												valueField: 'id',
												textField: 'value',
												panelHeight:'auto',
												data: [{
													id: '1',
													value: '全部发货'
												},{
													id: '2',
													value: '部分发货'
												}]" />
									</td>
								</tr>
<!-- 								<tr> -->
<!-- 									<td width="100">开始时间:</td> -->
<!-- 									<td width="270"> -->
<!-- 										<input name="start_date" id="start_date" class="easyui-datebox"></input> -->
<!-- 									</td> -->
<!-- 									<td width="100">结束时间:</td> -->
<!-- 									<td width="270"> -->
<!-- 										 <input name="end_date" id="end_date" class="easyui-datebox"></input> -->
<!-- 									</td> -->
<!-- 								</tr> -->
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
				<table id="dg" title="查询结果" style="height:330px"  method="get"
					rownumbers="true" singleSelect="true" pagination="true" sortName="deliver_id" pagination="true" iconCls="icon-search" 
					sortOrder="asc" toolbar="#tb">
					<thead>
						<tr>
							<th data-options="field:'deliver_code',width:150,align:'center'" sortable="true">出货单号</th>
							<th data-options="field:'dealer_name',width:150,align:'center'" sortable="true">经销商</th>
							<th data-options="field:'order_code',width:150,align:'center'" sortable="true">订单号</th>
							<th data-options="field:'order_date',width:150,align:'center'" sortable="true">下单时间</th>
							<th data-options="field:'create_date',width:150,align:'center'" sortable="true">编制时间</th>
<!-- 							<th data-options="field:'express_number',width:150,align:'center'" sortable="true">快递号</th> -->
							<th data-options="field:'deliver_status',width:80,align:'center'" formatter="formatterDeliverStatus" sortable="true">发货状态</th>
							<th data-options="field:'flow_status',width:80,align:'center'">审核状态</th>
							<th data-options="field:'custom',width:80,align:'center'" formatter="formatterDetail">明细</th>
						</tr>
					</thead>
				</table>
			</div>
			<div id="tb">
				<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="beginEntity()">发货</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="beginEntity()">填写快递</a>
			</div>
			<div style="margin: 10px 0;"></div>
		</div>
		
		
   	<div id="dlgOrder" class="easyui-dialog" style="width:703px;height:450px;padding: 5px 5px 5px 5px;"
            modal="true" closed="true" buttons="#dlg-buttonsOrder">
				<table id="dgOrder" title="订单查询结果" style="height:365px;width:680px;" method="get"
					rownumbers="true" singleSelect="true" pagination="true" sortName="id" pagination="true" iconCls="icon-search" sortOrder="asc">
					<thead>
						<tr>
							<th data-options="field:'dealer_name',width:240,align:'center'" sortable="true">经销商</th>
							<th data-options="field:'order_code',width:200,align:'center'" sortable="true">订单号</th>
							<th data-options="field:'order_status',width:80,align:'center'"  formatter="formatterStatus" sortable="true">状态</th>
							<th data-options="field:'order_date',width:150,align:'center'" sortable="true">下单时间</th>
						</tr>
					</thead>
				</table>
    </div>
    <div id="dlg-buttonsOrder">
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-redo" onclick="oneSetp();">下一步</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlgOrder').dialog('close')">取消</a>
    </div>
    
    <div id="dlgOneSetp" class="easyui-dialog" style="width:803px;height:450px;padding: 5px 5px 5px 5px;"
            modal="true" closed="true" buttons="#dlg-buttonsOneSetp">
	        <form id="fm" method="post" novalidate enctype="multipart/form-data">
	        	<input type="hidden" name="order_id" id="order_id">
	        	<input type="hidden" name="order_date" id="order_date">
	        	<input type="hidden" name="dealer_id" id="dealer_id">
			<table>
				<tr>
					<td>订单号:</td>
					<td><input class="easyui-validatebox" type="text" style="width:200px;"
						name="order_code" id="order_code" data-options="required:false" readonly="readonly"></input>
					</td>
					<td></td>
					<td>发货类型:</td>
					<td>
						<input name="deliver_status" class="easyui-combobox" id="deliver_status"
							data-options="
								required:true,
								valueField: 'id',
								textField: 'value',
								panelHeight:'auto',
								data: [
									{id: '4',value: '全部发货'},
									{id: '5',value: '部分发货'}
									]" />
					</td>
				</tr>
				<tr>
						<td>特殊说明:</td>
			             <td colspan="4"><textarea name="remark" cols="65" style="height:30px;"></textarea></td>
				</tr>
			</table>
				 <input type="hidden" name="ids" id="ids">
	        	<input type="hidden"  name="deliver_number_sums" id="deliver_number_sums">
	        	<input type="hidden"  name="deliver_dates" id="deliver_dates">
	        	<input type="hidden"  name="arrival_dates" id="arrival_dates">
	        	<input type="hidden"  name="deliver_remarks" id="deliver_remarks">
			<div style="width:755px; padding: 5px 5px 5px 5px;">
				<table id="dgOrderOneSetp" title="订单详情查询结果" style="height:330px" method="get" toolbar='#tbOneSetp'
						rownumbers="true" singleSelect="false" pagination="false" iconCls="icon-search" sortName="id" sortOrder="asc">
						<thead>
							<tr>
<!-- 							formatter="formatterCheck" -->
							<th field="id" checkBox="true"></th>
<!-- 							<th data-options="field:'product_item_number',width:100,align:'center'" sortable="true">产品编码</th> -->
							<th data-options="field:'product_name',width:100,align:'center'" sortable="true">产品名称</th>
							<th data-options="field:'models',width:65,align:'center'" sortable="true">产品规格</th>
							<th data-options="field:'order_number_sum',width:80,align:'center'" sortable="true">数量</th>
<!-- 							<th data-options="field:'order_price',width:80,align:'center'" sortable="true">订购价格</th> -->
<!-- 							<th data-options="field:'order_money_sum',width:80,align:'center'" sortable="true">小计</th> -->
<!-- 							<th data-options="field:'discount',width:80,align:'center'" sortable="true">折扣</th> -->
							<th data-options="field:'deliver_number_sum',width:80,align:'center',editor:'numberbox'">发货数量</th>
							<th data-options="field:'deliver_date',width:100,align:'center',editor:'datebox'">预计发货日期</th>
							<th data-options="field:'arrival_date',width:100,align:'center',editor:'datebox'">预计到货日期</th>
							<th data-options="field:'deliver_remark',width:150,align:'center',editor:'text'">备注</th>
							</tr>
						</thead>
					</table>
			</div>
	        </form>
	         <div id="tbOneSetp" style="height:auto">
	         	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true" onclick="$('#dgOrderOneSetp').datagrid('reload');">刷新</a>
<!-- 		        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="accept()">保存</a> -->
		    </div>
    </div>
    <div id="dlg-buttonsOneSetp">
     	<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-undo" onclick="beginEntity();">上一步</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="deliverSubmit();">提交</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlgOneSetp').dialog('close')">取消</a>
    </div>
		
		
		
	<script type="text/javascript">
		$(function() {
			$('#dg').datagrid({
				  url : basePath +"api/deliver/paging" ,
					queryParams: {
						filter_ANDS_order_status : $('#deliver_status').combobox('getValue')
					}
			});
		});
		
		function doSearch(){
		    $('#dg').datagrid('load',{
		    	filter_ANDS_order_code: $('input[name=order_code]').val(),
		    	filter_ANDS_deliver_code: $('input[name=deliver_code]').val(),
		    	filter_ANDS_deliver_status: $('input[name=deliver_status]').val(),
		    	filter_ANDS_start_date: $('input[name=start_date]').val(),
		    	filter_ANDS_end_date: $('input[name=end_date]').val(),
		    });
		}
		
		function formatterDeliverStatus(value, row, index){
			if(value=='4')
				return '<span>全部出货</span>'; 
			else if(value=='5')
				return '<span>部分出货</span>'; 
		}
		
		function formatterDetail(value, row, index){
			return '<span style="color:red;cursor:pointer" onclick="openDeliverDetail(\''+index+'\')">明细</span>'; 
		}
		
		function formatterStatus(value, row, index){
			if(value=='0')
				return '<span>未提交</span>'; 
			else if(value=='1')
				return '<span>已提交</span>'; 
			else if(value=='2')
				return '<span>驳回</span>'; 
			else if(value=='3')
				return '<span>已审核</span>'; 
			else if(value=='4')
				return '<span>已发货</span>'; 
			else if(value=='5')
				return '<span>部分发货</span>'; 
			else if(value=='6')
				return '<span>已完成</span>'; 
		}
		
		function beginEntity(){
			$('#dlgOneSetp').dialog('close');
			$('#dlgOrder').dialog('open').dialog('setTitle', '添加发货信息第一步');
			$('#dgOrder').datagrid({
				  url : basePath +"api/order/paging" ,
					queryParams: {
						filter_ANDS_order_status : 3 //审核通过的订单
					}
			});		
		}		
		
		function oneSetp(){
			var row = $('#dgOrder').datagrid('getSelected');
			if (row){
				$('#dlgOrder').dialog('close');
				$('#dlgOneSetp').dialog('open').dialog('setTitle', '添加发货信息第二部');
				$('#fm').form('clear');
				$("#order_id").val(row.id);
				$("#order_code").val(row.order_code);
				$("#order_date").val(row.order_date);
				$("#dealer_id").val(row.dealer_id);
				$('#dgOrderOneSetp').datagrid({
					url : basePath + "api/orderdetail/list",
					onClickRow: onClickRow,
					queryParams: {
						filter_ANDS_order_code : row.order_code
					}
				});
			}else{
				$.messager.alert('提示','请选中数据!','warning');
			}
		}
		
		var editIndex = undefined;
	    function endEditing(){
	          if (editIndex == undefined){return true ;}
	            if ($('#dgOrderOneSetp').datagrid('validateRow', editIndex)){
	                $('#dgOrderOneSetp').datagrid('endEdit', editIndex);
	                editIndex = undefined;
	                return true;
	            } else {
	                return false;
	            }
	      }
	     function onClickRow(index){
	            if (editIndex != index){
	                if (endEditing()){
	                    $('#dgOrderOneSetp').datagrid('selectRow', index).datagrid('beginEdit', index);
	                    editIndex = index;
	                    $('#dgOrderOneSetp').datagrid('beginEdit', index);
	                } else {
	                    $('#dgOrderOneSetp').datagrid('selectRow', editIndex);
	                }
	            }
	     }
	     

	     function endEdit(){
 			var rows = $('#dgOrderOneSetp').datagrid('getRows');
           	for ( var i = 0; i < rows.length; i++) {
           		$('#dgOrderOneSetp').datagrid('endEdit', i);
	        }
           	editIndex = undefined;
	     }
		
		function deliverSubmit(){
			endEdit();
			var isSubmit = true ; 
			var checkedItems = $('#dgOrderOneSetp').datagrid('getChecked');
			var ids = [];
			var deliver_number_sums = [];
			var deliver_dates = [];
			var arrival_dates = [];
			var deliver_remarks = [];
			$.each(checkedItems, function(index, item){
				ids.push(item.id);
			});
			if(ids.length > 0){
				var updated = $('#dgOrderOneSetp').datagrid('getChanges',"updated");
				if (updated == 0) {
					$.messager.alert('提示', '数据不能为空!', 'warning');
					isSubmit = false;
					return;
				}
				for ( var i = 0; i < updated.length; i++) {
					if ($.inArray(updated[i].id, ids) != -1) {
						if (updated[i].deliver_number_sum != "") 
							deliver_number_sums.push(updated[i].deliver_number_sum);
						if (updated[i].deliver_date != "") 
							deliver_dates.push(updated[i].deliver_date);
						if (updated[i].arrival_date != "") 
							arrival_dates.push(updated[i].arrival_date);
						deliver_remarks.push(updated[i].deliver_remark);
					}
				}
				
				if(deliver_number_sums.length != ids.length){
					isSubmit = false;
					$.messager.alert('提示', '发货数量不能为空!', 'warning');
					return;
				}
				if(deliver_dates.length != ids.length){
					isSubmit = false;
					$.messager.alert('提示', '预计发货日期不能为空!', 'warning');
					return;
				}
				if(arrival_dates.length != ids.length){
					isSubmit = false;
					$.messager.alert('提示', '预计到货日期不能为空!', 'warning');
					return;
				}
				
				if (isSubmit) {
					$("#ids").val(ids.join(","));
					$("#deliver_number_sums").val(deliver_number_sums.join(","));
					$("#deliver_dates").val(deliver_dates.join(","));
					$("#arrival_dates").val(arrival_dates.join(","));
					$("#deliver_remarks").val(deliver_remarks.join(","));
					$('#fm').form('submit', {
						url : basePath + 'api/deliver/save',
						method : "post",
						onSubmit : function() {
							return $(this).form('validate');
						},
						success : function(msg) {
							var jsonobj = $.parseJSON(msg);
							if (jsonobj.state == 1) {
								$('#dlgOneSetp').dialog('close');
								$('#dg').datagrid('reload');
							} else {
								$.messager.alert('提示', 'Error!', 'error');
							}
						}
					});
				}
			} else {
				$.messager.alert('提示', '请选中数据!', 'warning');
				isSubmit = false;
			}

		}
		

		function openDeliverDetail(index){
			alert(index)
		}
		
	</script>
</body>
</html>