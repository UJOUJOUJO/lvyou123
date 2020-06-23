<%@ page language="java"  pageEncoding="gb2312"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ page language="java" import="java.sql.*" %>
<jsp:useBean id="connDbBean" scope="page" class="db.db"/>
<html>
  <head>
    <base href="<%=basePath%>">
    <title>自驾游线路</title><LINK href="CSS.css" type=text/css rel=stylesheet><script language="javascript" src="js/Calendar.js"></script>
  </head>
  <%
String sql;
ResultSet RS_result;
%>
  <body >
  <p>已有自驾游线路列表：</p>
  <form name="form1" id="form1" method="post" action="">
   搜索: 线路编号：<input name="xianlubianhao" type="text" id="xianlubianhao" /> 线路名称：<input name="xianlumingcheng" type="text" id="xianlumingcheng" /> 目的地：<input name="mudedi" type="text" id="mudedi" />交通工具：<select name='jiaotonggongju' id='jiaotonggongju'><option value="">所有</option></select>出行时间：<input name="chuxingshijian1" type="text" id="chuxingshijian1"  value='' onClick="getDate(form1.chuxingshijian1,'2')" need="1" size="10" />-<input name="chuxingshijian2" type="text" id="chuxingshijian2"  value='' onClick="getDate(form1.chuxingshijian2,'2')" need="1" size="10"  /> 发布人：<input name="faburen" type="text" id="faburen" />
     <input type="submit" name="Submit" value="查找" />
</form>

<table width="100%" border="1" align="center" cellpadding="3" cellspacing="1" bordercolor="00FFFF" style="border-collapse:collapse">  
  <tr>
    <td width="30" align="center" bgcolor="CCFFFF">序号</td>
    <td bgcolor='#CCFFFF'>线路编号</td><td bgcolor='#CCFFFF'>线路名称</td><td bgcolor='#CCFFFF'>出发地</td><td bgcolor='#CCFFFF'>目的地</td><td bgcolor='#CCFFFF'>交通工具</td><td bgcolor='#CCFFFF'>费用</td><td bgcolor='#CCFFFF'>出行时间</td><td bgcolor='#CCFFFF'>备注</td><td bgcolor='#CCFFFF'>发布人</td>
    <td width="138" align="center" bgcolor="CCFFFF">添加时间</td>
    <td width="60" align="center" bgcolor="CCFFFF">操作</td>
  </tr>
  <%
  int curpage=1;//当前页
				int page_record=10;//每页显示的记录数
				int zgs=0;
				int zys=0;
				//用下面的方法（sql查询完成，速度快）
				String hsgnpage=request.getParameter("page");
				String fysql="select count(id) as ss from zijiayouxianlu where faburen='"+request.getSession().getAttribute("username")+"'";
				ResultSet RS_resultfy=connDbBean.executeQuery(fysql);
  while(RS_resultfy.next()){
  zgs=Integer.parseInt(RS_resultfy.getString("ss"));
  zys=zgs/page_record+1;
  }
				if (hsgnpage!=null)
				{
				curpage=Integer.parseInt(request.getParameter("page"));//获取传递的值，需要显示的页
				}
				else
				{
				curpage=1;
				}
				if (curpage==0)
				{
					curpage=1;
				}
				if(curpage>zys)
				{
					curpage=zys;
				}
   sql="";
  sql="select top "+page_record+" * from zijiayouxianlu where faburen='"+request.getSession().getAttribute("username")+"' and id not in (select top "+((curpage-1)*page_record)+" id from zijiayouxianlu where faburen='"+request.getSession().getAttribute("username")+"' order by id desc) ";
  
if(request.getParameter("xianlubianhao")=="" ||request.getParameter("xianlubianhao")==null ){}else{sql=sql+" and xianlubianhao like '%"+new String(request.getParameter("xianlubianhao").getBytes("8859_1"))+"%'";}
if(request.getParameter("xianlumingcheng")=="" ||request.getParameter("xianlumingcheng")==null ){}else{sql=sql+" and xianlumingcheng like '%"+new String(request.getParameter("xianlumingcheng").getBytes("8859_1"))+"%'";}
if(request.getParameter("mudedi")=="" ||request.getParameter("mudedi")==null ){}else{sql=sql+" and mudedi like '%"+new String(request.getParameter("mudedi").getBytes("8859_1"))+"%'";}
if(request.getParameter("jiaotonggongju")=="所有" ||request.getParameter("jiaotonggongju")==null ){}else{sql=sql+" and jiaotonggongju like '%"+new String(request.getParameter("jiaotonggongju").getBytes("8859_1"))+"%'";}
if (request.getParameter("chuxingshijian1")==""  ||request.getParameter("chuxingshijian1")==null ) {}else{sql=sql+" and chuxingshijian >= '"+new String(request.getParameter("chuxingshijian1").getBytes("8859_1"))+"'";}
if (request.getParameter("chuxingshijian2")==""  ||request.getParameter("chuxingshijian2")==null ) {}else {sql=sql+" and chuxingshijian <= '"+new String(request.getParameter("chuxingshijian2").getBytes("8859_1"))+"'";}
if(request.getParameter("faburen")=="" ||request.getParameter("faburen")==null ){}else{sql=sql+" and faburen like '%"+new String(request.getParameter("faburen").getBytes("8859_1"))+"%'";}
  sql=sql+" order by id desc";
  RS_result=connDbBean.executeQuery(sql);
 String id="";
 String xianlubianhao="";String xianlumingcheng="";String chufadi="";String mudedi="";String jiaotonggongju="";String feiyong="";String chuxingshijian="";String beizhu="";String faburen="";
 String addtime="";
 int i=0;
 
 
 
 
 
 while(RS_result.next()){
 i=i+1;
 id=RS_result.getString("id");
xianlubianhao=RS_result.getString("xianlubianhao");xianlumingcheng=RS_result.getString("xianlumingcheng");chufadi=RS_result.getString("chufadi");mudedi=RS_result.getString("mudedi");jiaotonggongju=RS_result.getString("jiaotonggongju");feiyong=RS_result.getString("feiyong");chuxingshijian=RS_result.getString("chuxingshijian");beizhu=RS_result.getString("beizhu");faburen=RS_result.getString("faburen");
 addtime=RS_result.getString("addtime");
 
 
%>
  <tr>
    <td width="30" align="center"><%=i %></td>
    <td><%=xianlubianhao %></td><td><%=xianlumingcheng %></td><td><%=chufadi %></td><td><%=mudedi %></td><td><%=jiaotonggongju %></td><td><%=feiyong %></td><td><%=chuxingshijian %></td><td><%=beizhu %></td><td><%=faburen %></td>
    <td width="138" align="center"><%=addtime %></td>
    <td width="90" align="center"><a href="zijiayouxianlu_updt.jsp?id=<%=id%>">修改</a>  <a href="del.jsp?id=<%=id %>&tablename=zijiayouxianlu" onClick="return confirm('真的要删除？')">删除</a> <a href="zijiayouxianludetail.jsp?id=<%=id%>" target="_blank">详细</a></td>
  </tr>
  	<%
  }
   %>
</table><br>
以上数据共<%=i %>条,<a style="cursor:hand" onClick="javascript:window.print();">打印本页</a>
<p align="center">&nbsp;共<%=zgs%>条记录&nbsp;&nbsp;<%=page_record %>条/页　<a href="zijiayouxianlu_list2.jsp?page=1">首页</a>　<a href="zijiayouxianlu_list2.jsp?page=<%= curpage-1%>">上一页</a>　<A href="zijiayouxianlu_list2.jsp?page=<%= curpage+1%>">下一页</A>　<a href="zijiayouxianlu_list2.jsp?page=<%=zys %>">尾页</A>　当前第<FONT color=red><%=curpage %></FONT>页/共<FONT color=red><%=zys %></FONT>页</p>

  </body>
</html>

