<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<h3>상품별총판매액</h3>
<table border=1>
<tr>
	<td>상품코드</td>
	<td>상품명</td>
	<td>상품별 판매액</td>
</tr>

<%
	try {
		Class.forName("oracle.jdbc.OracleDriver");
		Connection conn = DriverManager.getConnection
		("jdbc:oracle:thin:@//localhost:1521/xe", "system", "1234");
		
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery("SELECT product.pcode, product.name, SUM(product.cost * salelist.amount) " +
                					"FROM tbl_product_01 product, tbl_salelist_01 salelist " +
                					"WHERE product.pcode = salelist.pcode " +
                					"GROUP BY product.pcode, product.name " +
                					"ORDER BY SUM(product.cost * salelist.amount) DESC");
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