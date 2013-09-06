<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
        <a href="#" onclick="collapseAll()">CollapseAll</a>  
        <a href="#" class="easyui-linkbutton" onclick="saveAuthorze()" data-options="plain:true,iconCls:'icon-cancel'">ok</a> 
        <a href="#" onclick="expandAll()">ExpandAll</a>
		<div id="p" class="easyui-panel">
			<form id="ffauthorze" action="" method="post" enctype="multipart/form-data">
				<input type="hidden" value="${roleid}" id="roleid" name="roleid"/>
				<table id="treegrid"></table>
				 <div data-options="region:'south',border:false" style="text-align:right;padding:5px 0;">  
	                <a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="resize()">Ok</a>  
	                <a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="resize()">Cancel</a>  
	            </div>  
			</form>
		</div>
	<script type="text/javascript">
	$(function() {
		var roleid=$("#roleid").val();
		$('#treegrid').treegrid({
            height:452,  
            nowrap: false,  
            rownumbers: true,  
            animate:true,  
            collapsible:true,  
            url:basePath+'api/sysmenu/authorzelist?roleid='+roleid,  
            idField:'id',
            treeField:'menu_name',	
            frozenColumns:[[
                {title:'名称',field:'menu_name',width:200} 
            ]],  
            columns:[[
                {field:'list',title:'功能',width:250,rowspan:2,
                	formatter:function(value){
                		var str="";
                		if (typeof(value) != "undefined")
	                    for(var i=0;i<value.length;i++){
	                    	str+='<span style="cursor:pointer;"><input type="checkbox" '+(value[i].checkbox==true?'checked':'')+' name="function" value ="'+value[i].id+'|'+value[i].fk_menu_id+'"/>'+value[i].fun_name+'</span>';
	                    }
            			return str;
                    }
                },
                {field:'remark',title:'备注',width:200,rowspan:2}
            ]]
        });
	});
	function collapseAll(){  
        var node = $('#treegrid').treegrid('getSelected');  
        if (node){  
            $('#treegrid').treegrid('collapseAll', node.code);  
        } else {  
            $('#treegrid').treegrid('collapseAll');  
        }  
    }  
    function expandAll(){
        var node = $('#treegrid').treegrid('getSelected');  
        if (node){  
            $('#treegrid').treegrid('expandAll', node.code);  
        } else {  
            $('#treegrid').treegrid('expandAll');  
        }  
    }  
    function saveAuthorze() {
		$.ajax({
			type : "POST",
			url : basePath+'api/sysmenu/saveauthorze',
			data : $('#ffauthorze').serialize(),
			error : function(request) {
				alert("更新失败，请稍后再试！");
			},
			success:function(msg){
				alert(msg);
			    var jsonobj= eval('('+msg+')');  
			    if(jsonobj.state==1)
			    {
			    	clearForm();
			    	$('#authorizW').window('close');
			    }
			}
		});
	}
    function clearForm(){
		$('#ffauthorze').form('clear');
	}
	</script>