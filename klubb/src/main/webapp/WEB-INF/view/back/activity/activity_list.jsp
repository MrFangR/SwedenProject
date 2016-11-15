<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
	<title>精简开店后台管理系统</title>
    <%@include file="/ninclude/back/header.jsp"%>
</head>

<body>
	<div class="ued-location mgb-20">我的位置：活动列表</div>
	
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
	                            <th>活动标题：</th>
	                            <td>
	                            	<input id="titleIn" type="text" name="title" class="ued-text-2" maxlength="30"/>
	                            </td>
	                        </tr>
	                    </tbody>
	                </table>
	                <input id="pageNumIn" name="pageNum" type="hidden" value="1"/>
	                <input id="pageSizeIn" name="pageSize" type="hidden" value="6"/>
	                </form>
	                <div class="mgt-25 tc">
	                	<button class="ued-button-2 mgr-25" onclick="qry()">查询</button>
	                	<button class="ued-button-3" onclick="reset()">重置</button>
	                </div>
	            </div>
	            <div id="showLst"></div>
	            <!--分页 start-->
				<div class="paging mgtb-15 clearfix" id="pageDiv">
				</div>
              	<!--分页 end--> 
	        </div>
	    </div>
	</div>
</body>
	<script type="text/javascript" src="${ctx}/back-ui/local-ui/backActivity.js"></script>
</html>
