<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
    
<head>
    <title>比赛列表</title>
    <%@include file="/ninclude/back/header.jsp"%>
</head>

<body>
<!--面包屑  s-->
<div class="ued-location mgb-20">我的位置：<a href="#none">系统管理</a>&nbsp;&gt;&nbsp;<a href="#none">应用中心</a>&nbsp;&gt;&nbsp;比赛列表</div>
<!--面包屑  d-->
<div class="ued-tab js_tab">
    <div class="ued-tab-tit clearfix js_tab_tit">
        <ul class="ued-tab-1 fl clearfix">
            <li class="on1 "><a class="ued-add" href="javascript:void(0)">赛事列表</a></li>
            <li class="liQuery"><a class="ued-see" href="javascript:void(0)">添加比赛</a></li>
        </ul>
    </div>
    <div class="ued-tab-con">	
        <div class="box-n on1">
            <!-- 列表 s -->
            <input id="pageNumIn" name="pageNum" type="hidden" value="1"/>
            <div id="showList">
	        </div>
            <!-- 列表 e -->
        </div>
        <div class="box-n">
           <!-- 列表 s -->
           	<form enctype="multipart/form-data" id="matchForm">
            <table width="100%" cellspacing="0" cellpadding="0" class="ued-table-nobor mgt-15">
                <colgroup><col width="135"><col><col width="125"><col></colgroup>
                <tbody>
                	<tr>
                        <th><font color="color-3">*&nbsp;</font>赛事名称：</th>
                        <td colspan="3">
                            <input type="text" name="match.NAME" value="" class="ued-text-2" maxlength="30">
                            <p class="color-3 fs-14" id="name_msg"></p>     
                        </td>
                    </tr>
                    <tr>
                        <th><font color="color-3">*&nbsp;</font>图片：</th>
                        <td>
                             <input type="hidden" name="match.IMG" id="imgPath" class="ued-text-2" maxlength="30" >
                             <input id="imgForUpload" name="imgForUpload" type="file" multiple="multiple">
                             <p class="color-3 fs-14" id="img_path_msg"></p>  
                        </td>
                    </tr>
                    <tr>
                    	<th>图片预览：</th>
                        <td><img id="showImg" alt="" src=""></td>
                    </tr>
                    <tr>
                       	<th><font color="color-3">*&nbsp;</font>赛制：</th>
                        <td colspan="3">
                        	<input class="inp-radio" type="radio" name="match.TYPE" checked="checked" value="1"><span class="b-radio mgr-30"><b></b>单败</span>
                            <input class="inp-radio" type="radio" name="match.TYPE"  value="2"><span class="b-radio"><b></b>双败</span>
                            <input class="inp-radio" type="radio" name="match.TYPE"  value="3"><span class="b-radio"><b></b>单败plus</span>
                            <input class="inp-radio" type="radio" name="match.TYPE"  value="4"><span class="b-radio"><b></b>双败plus</span>
                        </td>
                    </tr>
                    <tr>
                        <th><font color="color-3">*&nbsp;</font>第三名争夺赛：</th>
                        <td  colspan="3">
	                       	<input class="inp-radio" type="radio" name="match.THIRD" unit="年" value="1"><span class="b-radio mgr-30"><b></b>是</span>
	                        <input class="inp-radio" type="radio" name="match.THIRD" checked="checked" unit="半年" value="0"><span class="b-radio"><b></b>否</span>
	                    </td>
                    </tr>
                    <tr>
                        <th><font color="color-3">*&nbsp;</font>开始时间：</th>
                        <td  colspan="3">
                             <div class="ued-time-2 fl"><input type="text" name="match.START_DATE" onclick="WdatePicker()" class="Wdate"></div>
                             <p class="color-3 fs-14" id="start_time_msg"></p> 
                        </td>
                    </tr>
                    <tr>
                        <th><font color="color-3">*&nbsp;</font>最大参赛人数：</th>
                        <td colspan="3">
                            <input type="text" name="match.MAX_PLAYER" value="" class="ued-text-2" maxlength="30">
                            <p class="color-3 fs-14" id="max_player_msg"></p>    
                        </td>
                    </tr>
                    <tr>
                        <th><font color="color-3">*&nbsp;</font>描述：</th>
                        <td colspan="3">
                            <textarea style="width:80%;" name="match.DESCRIPTION" class="ued-textarea"></textarea>
                            <p class="color-3 fs-14" id="description_msg"></p> 
                        </td>
                    </tr>
                </tbody>
            </table>
            </form>
            <div class="mgt-25 tc"><button class="ued-button-2 mgr-25" onclick="update()">保存</button><button class="ued-button-3" onclick="back()">重置</button></div>
            <!-- 列表 e -->
        </div>
    </div>
</div>
</body>
<script type="text/javascript" src="${ctx}/back-ui/local-ui/backMatch.js"></script>
</html>
