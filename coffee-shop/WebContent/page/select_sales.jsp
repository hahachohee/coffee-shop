<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<h3>매출액확인</h3>
<table border=1>
<tr>
	<td>비번호</td>
	<td>상품코드</td>
	<td>판매날짜</td>
	<td>매장코드</td>
	<td>상품명</td>
	<td>판매수량</td>
	<td>총판매액</td>
</tr>

<%
	try {
		Class.forName("oracle.jdbc.OracleDriver");
		Connection conn = DriverManager.getConnection
		("jdbc:oracle:thin:@//localhost:1521/xe", "system", "1234");
		
		Statement stmt = conn.createStatement();
		
		String query = "SELECT salelist.saleno, product.pcode, salelist.saledate, shop.scode, " +
			       "product.name, salelist.amount, SUM(salelist.amount * product.cost) " +
			       "FROM tbl_product_01 product, tbl_salelist_01 salelist, tbl_shop_01 shop " +
			      "WHERE salelist.scode = shop.scode " +
			        "AND salelist.pcode = product.pcode " +
			      "GROUP BY salelist.saleno, product.pcode, salelist.saledate, salelist.scode, product.name, " +
			     "salelist.amount, shop.scode " +
			      "ORDER BY salelist.saleno ASC";
		
		ResultSet rs = stmt.executeQuery(query);
		
		while (rs.next()) {
			%>
				<tr>
					<td><% out.println(rs.getInt(1)); %></td>
					<td><% out.println(rs.getString(2)); %></td>
					<td><% out.println(rs.getString(3)); %></td>
					<td><% out.println(rs.getString(4)); %></td>
					<td><% out.println(rs.getString(5)); %></td>
					<td><% out.println(rs.getInt(6)); %></td>
					<td><% out.println(rs.getInt(7)); %></td>
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