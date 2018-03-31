


layui.define(['common','api','form','layer','laytpl'],function(exports){
	var common = layui.common;
	var api = layui.api;
	var laytpl = layui.laytpl;
	var $ = layui.jquery;
	var form = layui.form();
	var layer = layui.layer;
	var laytpl = layui.laytpl;
	
	//监听提交
  	form.on('submit(formDemo)', function(data){
    		api.editType(data.field,function(res){
    			if(res.code == 0){
    				layer.alert(res.msg, {
			          icon: 1,
			          time: 1000,
			          end:function(){
			          	location.href = 'type.html';
			          }
			    });
    			} else {
    				layer.msg(res.msg || res.code, {
					shift: 6
				});
    			}
    		});
    		return false;
  	});
  	
  	
  	var action = {
  		getType:function(){
  			var id = common.getUrlParam("id");
  			var params = {
  				id:id
  			}
  			api.getType(params,function(res){
  				console.log(res);
  				if(res.code == 0){
	    				laytpl($("#template").html()).render(res.data,function(html){
	    					$("#content-cnt").html(html);
	    					form.render();
	    				});
	    			} else {
	    				layer.msg(res.msg || res.code, {
						shift: 6
					});
	    			}
  			});
  		}
  	}
  	
  	action.getType();
	
	exports('type-edit',{});
	
});