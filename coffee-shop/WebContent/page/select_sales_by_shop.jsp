<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<h3>매장별총판매액</h3>
<table border=1>
<tr>
	<td>매장코드</td>
	<td>매장명</td>
	<td>매장별 판매액</td>
</tr>

<%
	try {
		Class.forName("oracle.jdbc.OracleDriver");
		Connection conn = DriverManager.getConnection
		("jdbc:oracle:thin:@//localhost:1521/xe", "system", "1234");
		
		String query = "SELECT shop.scode, shop.sname, sum(salelist.amount * product.cost) " +
				  "FROM tbl_shop_01 shop, tbl_salelist_01 salelist, tbl_product_01 product " +
				  "WHERE product.pcode = salelist.pcode " +
				    "AND salelist.scode = shop.scode " +
				 " GROUP BY shop.scode, shop.sname " +
				  "ORDER BY shop.scode ASC "; 
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery(query);
		while (rs.next()) {
			%>
				<tr>
					<td><% out.println(rs.getString(1)); %></td>
					<td><% out.println(rs.getString(2)); %></td>
					<td><% out.println(rs.getInt(3)); %></td>
				</tr>
			<%
		}
		stmt.close();
		conn.close();
	}
	catch (Exception e) {
		e.printStackTrace();
	}
%>
</table>