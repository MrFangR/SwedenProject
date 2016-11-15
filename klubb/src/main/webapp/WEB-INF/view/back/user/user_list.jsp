<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
	<title>精简开店后台管理系统</title>
    <%@include file="/ninclude/back/header.jsp"%>
</head>

<body>
	<div class="ued-location mgb-20">我的位置：用户留言</div>
	
	<div class="ued-tab js_tab">
	    <div class="ued-tab-tit clearfix js_tab_tit">
	        <div class="ued-pack fr" id="ued-pack">收起查询条件</div>
	        <ul class="ued-tab-1 fl clearfix">
	            <li class="liQuery on1"><a class="ued-see" href="javascript:void(0)">查询</a></li>
	        </ul>
	    </div>
	    <div class="ued-tab-con">
	        <div class="box-n on1">
	            <div id="ued-packBox">
	            	<form enctype="multipart/form-data" id="qryForm">
	                <table width="100%" cellspacing="0" cellpadding="0" class="ued-table-nobor mgt-15">
	                    <colgroup>
	                    	<col width="15%"><col width="35%">
	                    	<col width="15%"><col>
	                    </colgroup>
	                    <tbody>
	                        <tr>
	                            <th>手机号：</th>
	                            <td>
	                            	<input id="phone" type="text" name="phone" class="ued-text-2" maxlength="30"/>
	                            </td>
	                            <th>状态：</th>
	                            <td>
	                                <div style="width:180px;" class="ued-select-2 js_select">
	                                    <span class="ued-sel-txt">全部</span>
	                                    <a class="ued-sel-open"></a>
	                                    <div class="ued-option" style="display: none;" id="statusSelect">
	                                    	<a href="javascript:void(0);" onclick="chgStatus('')">全部</a>
	                                    	<a href="javascript:void(0);" onclick="chgStatus(0)">未读</a>
	                                    	<a href="javascript:void(0);" onclick="chgStatus(1)">已读</a>
	                                    </div>
	                                </div>
	                            </td>
	                        </tr>
	                    </tbody>
	                </table>
	                
	                <input id="status" name="status" type="hidden" value=""/>
	                <input id="pageNum" name="pageNum" type="hidden" value="1"/>
	                </form>
	                <div class="mgt-25 tc">
	                	<button class="ued-button-2 mgr-25" onclick="qry(1)">查询</button>
	                	<button class="ued-button-3" onclick="reset()">重置</button>
	                </div>
	            </div>
	            
	            <div id="showLst"></div>
	        </div>
	    </div>
	</div>
</body>
	<script type="text/javascript" src="${ctx}/back-ui/local-ui/backContact.js"></script>
</html>
