if (typeof Globals == "undefined") {
	var Globals = {};
}


String.prototype.length = function () {
	return this.replace(/[^\x00-\xff]/g, "aa").length;
};


String.prototype.trim = function () {
	return  this.replace(/(^\s*)|(\s*$)/g,  "");  
};

Globals.innerHTML = function (_div, _html) {
	if (_div != null) {
		if (typeof _div.innerHTML != "undefined") {
			_div.innerHTML = _html;
		}else {
		  document.getElementById(_div).innerHTML=_html;
		}
	}
};

Globals.loading = function (_div) {
};




Globals.KeyValue = function (key, value) {
	this.key = key;
	this.value = value;
};

Globals.Base = function(url, div,  callback){
	this.Params = new Array();
	this.FormParams="";
	this.addParam = function (key, value) {
		for (var o in this.Params) {
			if (this.Params[o] != null && this.Params[o].key == key) {
				if (value == null) {
					this.Params[o] = null;
				} else {
					this.Params[o].value = value;
				}
				return;
			}
		}
		var o = new Globals.KeyValue(key, value);
		this.Params[this.Params.length] = o;
	};
	this.setParam = function (key, value) {
		this.addParam(key, value);
	};
	this.removeParam = function (key) {
		this.setParam(key, null);
	};
	this.getParam = function (key) {
		for (var o in this.Params) {
			if (this.Params[o] != null && this.Params[o].key == key) {
				return this.Params[o].value;
			}
		}
		return null;
	};
	
	this.sentRequest = function(){
	 Globals.loading(div);
	 var call = {
			 success:function(responseText){
				 try{ $.fallr('hide'); }catch(e){}
				 setTimeout( function(){callback.success(responseText);} ,500);
				  
				 
			 },
			 failure:function(){
				 try{ $.fallr('hide'); }catch(e){}
				 setTimeout( function(){ callback.failure();},500);
			 }
	 };
	 jQuery.ajax({
       url: url,
       type: 'POST',
       dataType: 'html',
       data: this.PostData(),
       error: call.failure,
       success: call.success
     });
	};
	
	this.PostData = function() {
		var postData = "";
		for (var o in this.Params) {
			if (this.Params[o] != null) {
				postData += this.Params[o].key + "=" + this.Params[o].value + "&";
			}
		}
		return postData + this.FormParams;
	};
		
}



Globals.Pager = function(url, div,  callback){
   Globals.Pager.superclass.constructor.call(this, url, div,  callback);  
	this.page = function(_pageNumber){
		if( typeof _pageNumber != 'undefined'){
			this.addParam("page", _pageNumber);	
		}
			
		try{
			//Globals.innerHTML("mainDiv", "<div align='center'><img alt=\"\u6b63\u5728\u8f7d\u5165...\" src=\"http://stc."+rootDomain+"/img/loading.gif\" border=0 /></div>");
		}catch(e){}

		this.sentRequest();
	};
	
};


Globals.extend = function(_child,_super){
  YAHOO.lang.extend(_child, _super);
}



Globals.extend(Globals.Pager, Globals.Base);


/** 全选 **/
Globals.checkAll = function (_name) {
	var es = document.getElementsByTagName("input");
	for (var e = 0; e < es.length; e++) {
		if (es[e].name == _name) {
			es[e].checked = true;
		}
	}
};

/** 全不选 **/
Globals.checkNone = function (_name) {
	var es = document.getElementsByTagName("input");
	for (var e = 0; e < es.length; e++) {
		if (es[e].name == _name) {
			es[e].checked = false;
		}
	}
};


/** 全选 **/
Globals.checkAllString = function (_name,id) {
	var es = document.getElementsByTagName("input");
	var ids='';
	for (var e = 0; e < es.length; e++) {
	   
		if (es[e].name == _name &&  es[e].checked == true) {
			ids+=id+"="+es[e].value+"&";
		}
	}
	return ids;
};

/** 选择个数**/
Globals.checkNumber = function (_name) {
	var es = document.getElementsByTagName("input");
	var _number =0;
	for (var e = 0; e < es.length; e++) {
		if (es[e].name == _name && es[e].checked == true ) {
			_number++;
		}
	}
	return _number;
};


/** 是否有被选择的 **/
Globals.checkIsSelect = function (_name) {
	var es = document.getElementsByTagName("input");
	for (var e = 0; e < es.length; e++) {
		if (es[e].name == _name && es[e].checked == true) {
			return true;
		}
	}
	return false;
};

Globals.radioValueByName = function(name){
   var es = document.getElementsByTagName("input");
   for (var e = 0; e < es.length; e++) {
     if ( es[e].name == name &&  es[e].checked == true) {
       return es[e].value;
     }
   }
   return null;
}


Globals.ajaxHtml = function(html){
	var hd = document.getElementsByTagName("head")[0];    
	var re = /(?:<script([^>]*)?>)((\n|\r|.)*?)(?:<\/script>)/ig;    
	var srcRe = /\ssrc=([\'\"])(.*?)\1/i;    
	var typeRe = /\stype=([\'\"])(.*?)\1/i;    
	var match;    
	while(match = re.exec(html)){    
	     var attrs = match[1];    
	     var srcMatch = attrs ? attrs.match(srcRe) : false;    
	     if(srcMatch && srcMatch[2]){    
	          var s = document.createElement("script");    
	          s.src = srcMatch[2];    
	          var typeMatch = attrs.match(typeRe);    
	          if(typeMatch && typeMatch[2]){    
	               s.type = typeMatch[2];    
	          }    
	          hd.appendChild(s);    
	      }else if(match[2] && match[2].length > 0){    
	          if(window.execScript) {    
	                  window.execScript(match[2]);    
	          } else {    
	                  window.eval(match[2]);    
	          }    
	     }    
	}
}


