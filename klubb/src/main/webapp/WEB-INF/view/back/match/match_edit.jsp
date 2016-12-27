<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
	<title>精简开店后台管理系统</title>
    <%@include file="/ninclude/back/header.jsp"%>
</head>

<body>
	<div class="ued-location mgb-20">我的位置：比赛管理</div>
	
	<div class="ued-tab js_tab">
        <!--tab  s-->
        <div class="ued-tab-tit clearfix js_tab_tit">
            <ul class="ued-tab-1 fl clearfix">
                <li class="on1 "><a class="ued-add" href="javascript:void(0)">编辑对阵图</a></li>
                <li class="liQuery"><a class="ued-see" href="javascript:void(0)">编辑参与者</a></li>
                
            </ul>
    
        </div>
        <!--tab  e-->
        <!--tabcon  s-->
        <div class="ued-tab-con mgt-20">	
               <!--第一tab  一列是320px 目前展示5列宽为1600px  如果对阵图列数超过3需要代码判断列数给 box-n div 输入宽度 s-->
            <div class="box-n on1" style="width:1600px;">
            <!--比赛标题  s-->
            <div class="matchtitle">
               <li>第一轮</li>
               <li>第二轮</li>
               <li>第三轮</li>
               <li>半决赛</li>
               <li>决赛</li>
               <div class="clear"></div>
            </div>
            <!--比赛标题  e-->
              
                      <!--可拖动部分  s-->
                     <div class="dropbox">
                     
                    
                     
                     <!--完整模板  s-->
                    <div class="matchgroup">
                    <div class="template">
                        <h3>1</h3>
                        <div class="group" ondrop="drop(event,this)" ondragover="allowDrop(event)" draggable="true" ondragstart="drag(event, this)"><i>1</i><span>lijianghui</span><input name="" type="text" value="10"></div>
                        <div class="group" ondrop="drop(event,this)" ondragover="allowDrop(event)" draggable="true" ondragstart="drag(event, this)"><i>2</i><span>woshishui</span><input name="" type="text" value="4"></div>
                    </div>  
                    
                    <div class="template mgt-60">
                        <h3>2</h3>
                        <div class="group" ondrop="drop(event,this)" ondragover="allowDrop(event)" draggable="true" ondragstart="drag(event, this)"><i>3</i><span>第二组第一名</span><input name="" type="text" value="0"></div>
                        <div class="group" ondrop="drop(event,this)" ondragover="allowDrop(event)" draggable="true" ondragstart="drag(event, this)"><i>4</i><span>第二组第二名</span><input name="" type="text" value="1"></div>
                    </div>  
                    <div class="matchline">
                       
                       <svg  x="0" y="0" width="290px" height="76px">
                          <path d="M 228 1 L 236 1 L 236 76 " class="bracket-line"/>
                        </svg>
                        <svg  x="0" y="0"  width="290px" height="76px" style="margin-top:-6px">
                            <path d="M 228,76 L 236,76  L 236,1  L 244,1" class="bracket-line"/>
                                       
                        </svg>
                    
                    </div>
                  </div>
                  <!--完整模板  e-->  
                  
                     <!--完整模板  s-->
                    <div class="matchgroup mgt-60">
                    <div class="template">
                        <h3>3</h3>
                        <div class="group" ondrop="drop(event,this)" ondragover="allowDrop(event)" draggable="true" ondragstart="drag(event, this)"><i>1</i><span>第三组1</span><input name="" type="text" value="10"></div>
                        <div class="group" ondrop="drop(event,this)" ondragover="allowDrop(event)" draggable="true" ondragstart="drag(event, this)"><i>2</i><span>第三组2</span><input name="" type="text" value="4"></div>
                    </div>  
                    
                    <div class="template mgt-60">
                        <h3>4</h3>
                        <div class="group" ondrop="drop(event,this)" ondragover="allowDrop(event)" draggable="true" ondragstart="drag(event, this)"><i>3</i><span>第四章组1</span><input name="" type="text" value="0"></div>
                        <div class="group" ondrop="drop(event,this)" ondragover="allowDrop(event)" draggable="true" ondragstart="drag(event, this)"><i>4</i><span>第四章组2</span><input name="" type="text" value="1"></div>
                    </div>  
                    <div class="matchline">
                       
                       <svg  x="0" y="0" width="290px" height="76px">
                          <path d="M 228 1 L 236 1 L 236 76 " class="bracket-line"/>
                        </svg>
                        <svg  x="0" y="0"  width="290px" height="76px" style=" margin-top:-6px">
                            <path d="M 228,76 L 236,76  L 236,1  L 244,1" class="bracket-line"/>
                                       
                        </svg>
                    
                    </div>
                  </div>
                  <!--完整模板  e-->  
                   <!--完整模板  s-->
                    <div class="matchgroup mgt-60">
                    <div class="template">
                        <h3>5</h3>
                        <div class="group" ondrop="drop(event,this)" ondragover="allowDrop(event)" draggable="true" ondragstart="drag(event, this)"><i>1</i><span>第5组1</span><input name="" type="text" value="10"></div>
                        <div class="group" ondrop="drop(event,this)" ondragover="allowDrop(event)" draggable="true" ondragstart="drag(event, this)"><i>2</i><span>第5组2</span><input name="" type="text" value="4"></div>
                    </div>  
                    
                    <div class="template mgt-60">
                        <h3>6</h3>
                        <div class="group" ondrop="drop(event,this)" ondragover="allowDrop(event)" draggable="true" ondragstart="drag(event, this)"><i>3</i><span>第6章组1</span><input name="" type="text" value="0"></div>
                        <div class="group" ondrop="drop(event,this)" ondragover="allowDrop(event)" draggable="true" ondragstart="drag(event, this)"><i>4</i><span>第6章组2</span><input name="" type="text" value="1"></div>
                    </div>  
                    <div class="matchline">
                       
                       <svg  x="0" y="0" width="290px" height="76px">
                          <path d="M 228 1 L 236 1 L 236 76 " class="bracket-line"/>
                        </svg>
                        <svg  x="0" y="0"  width="290px" height="76px" style=" margin-top:-6px">
                            <path d="M 228,76 L 236,76  L 236,1  L 244,1" class="bracket-line"/>
                                       
                        </svg>
                    
                    </div>
                  </div>
                  <!--完整模板  e-->  
                 </div>
                 <!--可拖动部分 e-->
                 <!--生成结果第二列 s-->
                     <div class="nodrop">
                     
                      <!--完整模板  s-->
                    <div class="matchgroup mgt-80">
                    <div class="template">
                        <h3>7</h3>
                        <div class="group" ><i>1</i><span>第三组1</span><input name="" type="text" value="10"></div>
                        <div class="group" ><i>2</i><span>第三组2</span><input name="" type="text" value="4"></div>
                    </div>  
                    
                    <div class="template mgt-200">
                        <h3>8</h3>
                        <div class="group" ><i>3</i><span>第四章组1</span><input name="" type="text" value="0"></div>
                        <div class="group" ><i>4</i><span>第四章组2</span><input name="" type="text" value="1"></div>
                    </div>  
                    <div class="matchline">
                       
                       <svg  x="0" y="0" width="290px" height="140px">
                          <path d="M 228 1 L 236 1 L 236 140 " class="bracket-line"/>
                        </svg>
                        <svg  x="0" y="0"  width="290px" height="140px" style=" margin-top:-6px">
                            <path d="M 228,140 L 236,140  L 236,1  L 244,1" class="bracket-line"/>
                                       
                        </svg>
                    
                    </div>
                  </div>
                  <!--完整模板  e-->  
                  
                      <!--完整模板  s-->
                    <div class="matchgroup mgt-80">
                                      
                    <div class="template mgt-200">
                        <h3>9</h3>
                        <div class="group" ><i>3</i><span>第四章组1</span><input name="" type="text" value="0"></div>
                        <div class="group" ><i>4</i><span>第四章组2</span><input name="" type="text" value="1"></div>
                    </div>  
                    <div class="matchline">
                      
                        <svg  x="0" y="0"  width="290px" height="140px" style=" margin-top:-140px">
                            <path d="M 228,130 L 236,130  L 236,1  L 244,1" class="bracket-line"/>
                                       
                        </svg>
                    
                    </div>
                  </div>
                  <!--完整模板  e-->  
                     
                     </div>
                 <!--生成结果第二列 e-->
                   <!--生成结果第三列 s-->
                     <div class="nodrop mgt-20">
                     
                       <!--完整模板  s-->
                    <div class="matchgroup mgt-200">
                    <div class="template">
                        <h3>10</h3>
                        <div class="group" ><i>1</i><span>第三组1</span><input name="" type="text" value="10"></div>
                        <div class="group" ><i>2</i><span>第三组2</span><input name="" type="text" value="4"></div>
                    </div>  
                     <div class="matchline">
                       
                       <svg  x="0" y="0" width="290px" height="140px">
                          <path d="M 228 1 L 236 1 L 236 140 " class="bracket-line"/>
                        </svg>
                        <svg  x="0" y="0"  width="290px" height="140px" style=" margin-top:-6px">
                            <path d="M 228,140 L 236,140  L 236,1  L 244,1" class="bracket-line"/>
                                       
                        </svg>
                    
                    </div>
                   
                  </div>
                  <!--完整模板  e-->  
                  
                    <!--完整模板  s-->
                    <div class="matchgroup mgt-200">
                    <div class="template">
                        <h3>11</h3>
                        <div class="group" ><i>1</i><span>第三组1</span><input name="" type="text" value="10"></div>
                        <div class="group" ><i></i><span></span><input name="" type="text" value=""></div>
                    </div>  
                     
                   
                  </div>
                  <!--完整模板  e-->  
                     
                     </div>
                 <!--生成结果第三列 e-->
                     <!--生成结果第四列 s-->
                     <div class="nodrop mgt-160">
                     
                  
                    <!--完整模板  s-->
                    <div class="matchgroup mgt-200">
                    <div class="template">
                        <h3>12</h3>
                        <div class="group" ><i>1</i><span>第三组1</span><input name="" type="text" value="10"></div>
                        <div class="group" ><i></i><span></span><input name="" type="text" value=""></div>
                    </div>  
                     <div class="matchline">
                      
                        <svg  x="0" y="0"  width="290px" height="140px" style=" margin-top:-140px">
                            <path d="M 228,130 L 236,130  L 236,1  L 244,1" class="bracket-line"/>
                                       
                        </svg>
                    
                    </div>
                   
                  </div>
                  <!--完整模板  e-->  
                     
                     </div>
                 <!--生成结果第四列 e-->
                 
                 <!--生成结果第五列 s-->
                     <div class="nodrop mgt-20">
                     
                  
                    <!--完整模板  s-->
                    <div class="matchgroup mgt-230">
                    <div class="template">
                        <div class="group" ><i>1</i><span>第三组1</span><input name="" type="text" value="10"></div>
                    </div>  
                     
                   
                  </div>
                  <!--完整模板  e-->  
                     
                   </div>
                 <!--生成结果第五列 e-->
            </div>
             <!--第一tab  e-->
             <!--第二tab  s-->
            <div class="box-n">
                    <div id='single1' class='container'>
                        <div>1, but you can only drop me somewhere in this container. <i class="mtch_del"></i><i class="mtch_edit"></i></div>
                        <div>2If you try to drop me somewhere other than here, I'll die a fiery death. <i class="mtch_del"></i><i class="mtch_edit"></i></div>
                        <div>Item 3. <i class="mtch_del"></i><i class="mtch_edit"></i></div>
                        <div>Item 4. <i class="mtch_del"></i><i class="mtch_edit"></i></div>
                        <div>Item 5. <i class="mtch_del"></i><i class="mtch_edit"></i></div>
                        <div>Item 6. <i class="mtch_del"></i><i class="mtch_edit"></i></div>
                   </div>

                  <div class="tc" style="width:60%; margin-top:30px;"><button class="ued-button-2 js_dialog">添加人员</button></div>
             </div>
            <!--第二tab  e-->
        </div>
        <!--tabcon  e-->

</div>
  <!--弹框  s-->
 <div data-role="ued-dialog" class="ued-dialog" id="btn-dialog">
    <div class="dialog-header">
        <h3>添加参数人员</h3>
        <span class="dialog-tool">
            <a title="关闭" class="dialog-close">X</a>
        </span>
    </div>
    <div>
        <p class="pd-20 dialog-tipInfo clearfix">姓名：
        <select size="1" style="width:180px;">
          <option>昌盛</option>
          <option>lijianghui</option>
          <option>王二小</option>
       </select>
       </p>
        <div class="pd-10 tc">
            <button type="button" class="ued-button-2 mgr-25">保存</button>
            <button type="button" class="ued-button-3 dialog-close">取消</button>
        </div>
    </div>
</div>
<script type="text/javascript" src="${ctx}/back-ui/pub-ui/js/lib/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="${ctx}/back-ui/pub-ui/js/plugin/ui.js"></script>
<script type="text/javascript" src="${ctx}/back-ui/pub-ui/js/plugin/jquery.ztree.all-3.5.js"></script>
<script type="text/javascript" src="${ctx}/back-ui/pub-ui/js/plugin/dialog.js"></script>
<script type="text/javascript" src='${ctx}/back-ui/pub-ui/js/plugin/dragula.js'></script>
 <script type="text/javascript"> 
 $(function(){
	 
	  //高度设置
    var contWrapH = $("div.ued-layout").height();
    $("#ued-ztree").css("height",contWrapH-94);
	//ztree.json为你的url
	$("#ued-ztree").UED_tree();
	
	//弹出框
	$(".js_dialog").bind("click",function(){		
        $("#btn-dialog").trigger("dialog-open");
	})
	 $(".container i.mtch_del").click(function(){
		  $(this).parent().remove();
		    
		 })
	 
	 
	 })
  dragula([single1], { removeOnSpill: true });
    function allowDrop(ev)  
    {  
    ev.preventDefault();  
    }  
      
    var srcdiv = null;  
    function drag(ev,divdom)  
    {  
    srcdiv=divdom;  
    ev.dataTransfer.setData("text/html",divdom.innerHTML);  
    }  
      
    function drop(ev,divdom)  
    {  
    ev.preventDefault();  
    if(srcdiv != divdom){  
    srcdiv.innerHTML = divdom.innerHTML;  
    divdom.innerHTML=ev.dataTransfer.getData("text/html");  
    }  
    }  
    </script>  
</body>
</html>
