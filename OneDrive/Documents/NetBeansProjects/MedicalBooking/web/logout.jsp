<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page session="true" %>
<%
    // Destroy session
    session.invalidate();

    // Redirect to login page
    response.sendRedirect("login.jsp");
%>
