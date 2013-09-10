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
									<td></td>
									<td>仓库名称:</td>
									<td>
										<input class="easyui-validatebox" type="text" name="storage_name" id="storage_name" data-options="required:false"></input>
									</td>
									<td></td>
									<td>地址:</td>
									<td>
										<input class="easyui-validatebox" type="text" name="address" id="address" data-options="required:false"></input>
									</td>
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
				<table id="dg" class="easyui-datagrid" title="查询结果" style="height: 430px"  method="get"
					rownumbers="true" singleSelect="true" pagination="true" sortName="dealer_id" sortOrder="desc" toolbar="#tb">
					<thead>
						<tr>
							<th field="storage_name" width="200" align="center" sortable="true">仓库名称</th>
							<th field="province" width="100" align="center" sortable="true">省份</th>
							<th field="city" width="100" align="center" sortable="true">城市</th>
							<th field="category_id" width="100" align="center" hidden="true"></th>
							<th field="category_name" width="100" align="center" sortable="true">仓库类型</th>
							<th field="status" width="100" align="center"  formatter="formatterStatus" sortable="true">状态</th>
							<th field="postcode" width="100" align="center" sortable="true">邮编</th>
							<th field="address" width="200" align="center" sortable="true">地址</th>
							<th field="area" width="200" align="center" sortable="true">区或乡</th>
							<th field="phone" width="100" align="center" sortable="true">电话</th>
							<th field="tex" width="100" align="center" sortable="true">邮编</th>
						</tr>
					</thead>
				</table>
				<div id="tb">    
				    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newEntity();">添加</a>    
				    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit"  plain="true" onclick="updateEntity();">编辑</a>     
				    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="deleteEntity();">删除</a>    
				</div> 
			</div>
			<div style="margin: 10px 0;"></div>
		</div>
   <div id="dlg" class="easyui-dialog" style="width:360px;height:480px;padding:5px 5px 5px 5px;"
            modal="true" closed="true" buttons="#dlg-buttons">
		<form id="ffadd" action="" method="post" enctype="multipart/form-data">
	        	<input type="hidden" name="id">
				         	  <table>
				             	<tr>
				             		<td>仓库名称:</td>
				             		<td>
				             		    <input class="easyui-validatebox" type="text" name="storage_name" id="storage_name" data-options="required:true"></input>
				             		</td>
				             	</tr>
				             	<tr>
				             		<td>仓库类型:</td>
				             		<td>
						            	<input name="category_id" class="easyui-combobox" data-options="
											required:true,
											valueField: 'id',
											textField: 'value',
											data: [{
												id: '1',
												value: '默认仓库'
											},{
												id: '2',
												value: '医院仓库'
											},{
												id: '3',
												value: '其他仓库'
											},{
												id: '4',
												value: '子经销商仓库'
											}]" />	             		
				             		</td>
				             	</tr>
				             	<tr>
				             		<td>仓库状态:</td>
				             		<td>
				             		    <input type="radio" name="status" value="0" checked="true" checked/> 有效  <input type="radio" name="status" value="1" />无效
				             		</td>
				             	</tr>
				             	<tr>
				             		<td>复制医院信息:</td>
				             		<td>
				             		    <input type="checkbox" id="copy_hospital" onclick="copyhospital()" value="0" checked="true"/> 
				             		</td>
				             	</tr>
				             	<tr>
				             		<td>仓库所在医院名称:</td>
				             		<td>
				             		    <input class="easyui-validatebox" disabled="disabled" type="text" name="hospital_name" id="hospital_name" data-options="required:false"></input>
				             		    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="disabled:true,iconCls:'icon-reload'" onclick="searchHospital()" id="searchHospital">查询</a>
				             		</td>
				             	</tr>
				             	<tr>
				             		<td>省份:</td>
				             		<td>
				             		    <input class="easyui-validatebox" type="text" name="province" id="province" data-options="required:false"></input>
				             		</td>
				             	</tr>
				             	<tr>
				             		<td>城市:</td>
				             		<td>
				             		    <input class="easyui-validatebox" type="text" name="city" id="city" data-options="required:false"></input>
				             		</td>
				             	</tr>
				             	<tr>
				             		<td>区或乡:</td>
				             		<td>
				             		    <input class="easyui-validatebox" type="text" name="area" id="area" data-options="required:false"></input>
				             		</td>
				             	</tr>
				             	<tr>
				             		<td>地址:</td>
				             		<td>
				             		    <input class="easyui-validatebox" type="text" name="address" id="address" data-options="required:false"></input>
				             		</td>
				             	</tr>
				             	<tr>
				             		<td>邮编:</td>
				             		<td>
				             		    <input class="easyui-validatebox" type="text" name="postcode" id="postcode" data-options="required:false"></input>
				             		</td>
				             	</tr>
				             	<tr>
				             		<td>电话:</td>
				             		<td>
				             		    <input class="easyui-validatebox" type="text" name="phone" id="phone" data-options="required:false"></input>
				             		</td>
				             	</tr>
				             	<tr>
				             		<td>传真:</td>
				             		<td>
				             		    <input class="easyui-validatebox" type="text" name="tex" id="tex" data-options="required:false"></input>
				             		</td>
				             	</tr>
				         </table>        	
	        </form>
    </div>
    <div id="dlg-buttons">
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveEntity();">保存</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">取消</a>
    </div>

	<script type="text/javascript">
	 	var url;
		
		function newEntity(){
		    $('#dlg').dialog('open').dialog('setTitle','仓库添加');
		    $('#ffadd').form('clear');
		    url = basePath +  'api/storage/save';
		}
	    function updateEntity(){
	         var row = $('#dg').datagrid('getSelected');
	         if (row){
	            $('#dlg').dialog('open').dialog('setTitle','仓库更新');
	            $('#ffadd').form('load',row);
	            url = basePath + 'api/storage/update';
	         }else{
				$.messager.alert('提示','请选中数据!','warning');				
			 }	
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
						 $('#dlg').dialog('close');     
	                     $('#dg').datagrid('reload');
			    	}else{
			    		$.messager.alert('提示','Error!','error');	
			    	}
			    }		
			});	
		}
		
		 function deleteEntity(){
	           var row = $('#dg').datagrid('getSelected');
	            if (row){
	                $.messager.confirm('Confirm','是否确定删除?',function(r){
	                    if (r){
	            			$.ajax({
	            				type : "POST",
	            				url : basePath + 'api/storage/delete',
	            				data : {id:row.id},
	            				error : function(request) {
	            					$.messager.alert('提示','Error!','error');	
	            				},
	            				success : function(data) {
	            					var jsonobj = $.parseJSON(data);
	            					if (jsonobj.state == 1) {  
	            	                     $('#dg').datagrid('reload');
	            					}
	            				}
	            			});                    	
	                    }
	                });
	            }else{
					$.messager.alert('提示','请选中数据!','warning');				
				 }	
	        }
		  
		function doSearch(){
		    $('#dg').datagrid('load',{
		    	filter_ANDS_storage_name: $('#storage_name').val(),
		    	filter_ANDS_address: $('#address').val()
		    });
		}
		function formatterStatus(value, row, index){
			if(value=='0')
				return '<span>有效</span>'; 
			else(value=='1')
				return '<span>无效</span>';  
		}
		function copyhospital(){
			if($('#copy_hospital').attr("checked")){
				$('#searchHospital').linkbutton({disabled:false});
				$('#hospital_name').removeAttr("disabled");
			}else{
				$('#searchHospital').linkbutton({disabled:true});
				$('#hospital_name').attr("disabled","disabled");
			}
		}
		function searchHospital() {
			var hospitalname= ${'#hospital_name'}.val();
			$.ajax({
				type : "POST",
				url : basePath + 'api/hospital/readByName',
				data : { name:hospitalname},
				error : function(request) {
					$.messager.alert('提示','Error!','error');	
				},
				success : function(data) {
					var jsonobj = $.parseJSON(data);
					if (jsonobj.state == 1) {
						$('#ffadd').form('load', data);
					}
				}
			});
		}
		$(function() {
			$('#dg').datagrid({
				  url : basePath +"api/storage/paging" 
			});
		});
	</script>
</body>
</html>