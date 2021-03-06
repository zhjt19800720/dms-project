var basePath = "/yijava-dms/";
var resPath = "/yijava-dms/";


var trialflow_identifier_num="300000";
var orderflow_identifier_num="200000";
var deliverflow_identifier_num="400000";
var pullStorageflow_identifier_num="500000";
var salesStorageflow_identifier_num="600000";
var adjustStorageflow_identifier_num="700000";
var exchangedflow_identifier_num="800000";
var sendproduct_identifier_num="900001";
var reciveproduct_identifier_num="900002";
var loansproduct_identifier_num="900003";
var salesproduct_identifier_num="900004";
$(function(){
	InitLeftMenu();
	
	//tabClose();
	//tabCloseEven();
});

function addTab(subtitle,url){
	if(!$('#tabs').tabs('exists',subtitle)){
		$('#tabs').tabs('add',{
			title:subtitle,
			content:createFrame(url),
			closable:true,
			width:$('#mainPanle').width()-1,
			height:$('#mainPanle').height()-10
		});
	}else{
		$('#tabs').tabs('select',subtitle);
	}
	tabClose();
}

function addTabByChild(subtitle,url){	
	var jq = top.jQuery;    
	
	if(!jq("#tabs").tabs('exists',subtitle)){
		jq("#tabs").tabs('add',{
			title:subtitle,
			content:createFrame(url),
			closable:true,
			width:$('#mainPanle',window.parent).width()-1,
			height:$('#mainPanle',window.parent).height()-10
		});
	}else{
		jq("#tabs").tabs('select',subtitle);
	}
	tabClose();
}



function createFrame(url)
{
	//var s='<div title="首页" data-options="iconCls:\'icon-help\',closable:false" style="padding:5px;overflow:hidden;">';
	 //s += '<div id="reload" class="easyui-panel" title=" " style="height:0px" data-options="tools:\'#treetool\'"></div><div style="height:2px"></div>';
	 var s= '<iframe name="mainFrame" scrolling="no" frameborder="0"  src="'+url+'" style="width:100%;height:100%;"></iframe>';
	 //s += '<div>'
	return s;
}


function InitLeftMenu()
{
	$('.menu-text a').click(function(){
		
		var tabTitle = $(this).text();
		var url = $(this).attr("url");
		addTab(tabTitle,url);
	});
}



function tabClose()
{
	/*双击关闭TAB选项卡*/
	$(".tabs-inner").dblclick(function(){
		var subtitle = $(this).children("span").text();
		if(subtitle!="首页")
			$('#tabs').tabs('close',subtitle);
	})

	$(".tabs-inner").bind('contextmenu',function(e){
		$('#mm').menu('show', {
			left: e.pageX,
			top: e.pageY,
		});
		
		var subtitle =$(this).children("span").text();
		$('#mm').data("currtab",subtitle);
		
		return false;
	});
}
function openwind(obj)
{
	
	//var tabTitle = obj.text();
	//var url = obj.attr("url");
	//addTab(tabTitle,url);
}

function formatterdate(val, row) {
	try{
		if(val!=null && val!=''){
			
			var a=val.split(" ");
            var d=a[0].split("-");
            var t=a[1].split(":");
            var date = new Date(d[0],(d[1]-1),d[2],t[0],t[1],t[2]);
	    	return date.format("yyyy-MM-dd hh:mm:ss");
		}
	}catch(e){
		return '';
	}
}


Date.prototype.format=function(fmt) {        
    var o = {        
    "M+" : this.getMonth()+1, //月份        
    "d+" : this.getDate(), //日        
    "h+" : this.getHours()%23 == 0 ? 23 : this.getHours()%23, //小时        
    "H+" : this.getHours(), //小时        
    "m+" : this.getMinutes(), //分        
    "s+" : this.getSeconds(), //秒        
    "q+" : Math.floor((this.getMonth()+3)/3), //季度        
    "S" : this.getMilliseconds() //毫秒        
    };        
    var week = {        
    "0" : "\u65e5",        
    "1" : "\u4e00",        
    "2" : "\u4e8c",        
    "3" : "\u4e09",        
    "4" : "\u56db",        
    "5" : "\u4e94",        
    "6" : "\u516d"       
    };        
    if(/(y+)/.test(fmt)){        
        fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));        
    }        
    if(/(E+)/.test(fmt)){        
        fmt=fmt.replace(RegExp.$1, ((RegExp.$1.length>1) ? (RegExp.$1.length>2 ? "\u661f\u671f" : "\u5468") : "")+week[this.getDay()+""]);        
    }        
    for(var k in o){        
        if(new RegExp("("+ k +")").test(fmt)){        
            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));        
        }        
    }        
    return fmt;        
} 
var digitArray = new Array('0','1','2','3','4','5','6','7','8','9','a','b','c','d','e','f');

function toHex( n ) {

        var result = ''
        var start = true;

        for ( var i=32; i>0; ) {
                i -= 4;
                var digit = ( n >> i ) & 0xf;

                if (!start || digit != 0) {
                        start = false;
                        result += digitArray[digit];
                }
        }

        return ( result == '' ? '0' : result );
}

function login_onclick() {
	var DevicePath,ret,n,mylen;
	try{
		var s_simnew31;
	    //创建插件或控件
	    if(navigator.userAgent.indexOf("MSIE")>0 && !navigator.userAgent.indexOf("opera") > -1)
	    {
		    s_simnew31=new ActiveXObject("Syunew3A.s_simnew3");
	    }
	    else
	    {
			s_simnew31= document.getElementById('s_simnew31');
	    }
	  
	    //查找是否存在锁,这里使用了FindPort函数
		DevicePath = s_simnew31.FindPort(0);
		if( s_simnew31.LastError!= 0 )
		{
			window.alert ( "Not Find Key ,Pls insert Key.");
			window.location.href="error/500.jsp";
			return ;
		}
		//'读取锁的ID
		
		pdata=s_simnew31.GetProduceDate(DevicePath);
		if(s_simnew31.LastError !=0){ 			
			return ;
		}
		
		$("#faccode").val(pdata);	
		
		
		ret=s_simnew31.YReadEx(0,1,"ffffffff","ffffffff",DevicePath);
		mylen =s_simnew31.GetBuf(0);
		$("#code").val(s_simnew31.YReadString(1,mylen, "ffffffff", "ffffffff", DevicePath));
       
	}catch (e) 
	{
		alert(e.name + ": " + e.message+"。可能是没有安装相应的控件或插件");
	}
}


