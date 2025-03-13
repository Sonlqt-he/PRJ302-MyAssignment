<%-- 
    Document   : dashboard
    Created on : Mar 4, 2025, 5:35:28 PM
    Author     : LTSon
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Leave.DBUtil, Leave.Leave, java.util.*" %>
<%  
    if(session.getAttribute("user_id") == null) {
        response.sendRedirect("login.html");
        return;
    }
    String fullName = (String) session.getAttribute("full_name");
    String role = (String) session.getAttribute("role");
    int userId = (Integer) session.getAttribute("user_id");
    
    DBUtil dbUtil = new DBUtil();
    ArrayList<Leave> leaves = dbUtil.getLeaveDB().listByUserId(userId);
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Trang chủ</title>
     <style>
        body { font-family: Arial, sans-serif; margin: 0; background-color: #f0f0f0; }
        .container { max-width: 800px; margin: 20px auto; padding: 20px; background-color: white; border-radius: 8px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); }
        .header { text-align: center; margin-bottom: 20px; }
        h1 { font-size: 28px; margin: 0; }
        p { font-size: 16px; color: #555; }
        .action-button { display: inline-block; padding: 10px 20px; background-color: #4CAF50; color: white; text-decoration: none; border-radius: 4px; margin: 5px; }
        .action-button:hover { background-color: #45a049; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 10px; text-align: left; }
        th { background-color: #f2f2f2; }
        .cancel-btn { background-color: #ff4444; color: white; border: none; padding: 5px 10px; border-radius: 4px; cursor: pointer; }
        .cancel-btn:hover { background-color: #cc0000; }
        .logout { text-align: right; margin-top: 20px; }
        .logout a { color: #ff4444; text-decoration: none; }
        .logout a:hover { text-decoration: underline; }
    </style>
    </head>
<body>
    <div class="container">
        <div class="header">
            <h1>X Company</h1>
            <p>Xin chào, <%= fullName %></p>
            <div>
                <a href="create-leave.jsp" class="action-button">Tạo đơn xin nghỉ phép</a>
                <% if ("manager".equalsIgnoreCase(role)) { %>
                    <a href="manage-leave.jsp" class="action-button">Kiểm tra đơn</a>
                <% } %>
            </div>
        </div>
    <h2>Các đơn đã nộp gần đây</h2>
<table>
        <tr><th>Ngày nộp</th><th>Loại nghỉ</th><th>Thời gian</th><th>Trạng thái</th><th>Hành động</th></tr>
            <% for (Leave leave : leaves) { %>
    <tr>
        <td><%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(leave.getSubmittedAt()) %></td>
        <td><%= leave.getLeaveType() %></td>
        <td><%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(leave.getStartDate()) %> - <%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(leave.getEndDate()) %></td>
        <td><%= leave.getStatus() %></td>
        <td>
    <% if ("Chờ duyệt".equals(leave.getStatus())) { %>
        <form action="cancel-leave" method="post" style="display:inline;">
            <input type="hidden" name="leave_id" value="<%= leave.getId() %>">
            <button type="submit" class="cancel-btn" onclick="return confirm('Bạn có chắc muốn hủy đơn này?')">Hủy</button>
        </form>
        <% } %>
        </td>
    </tr>
<% } if (leaves.isEmpty()) { %>
    <tr><td colspan="5">Chưa có đơn nào.</td></tr>
        <% } %>
</table>
<div class="logout">
            <a href="logout">Đăng xuất</a>
        </div>
    </div>
</body>
</html>
