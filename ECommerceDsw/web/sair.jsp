<%-- 
    Document   : sair
    Created on : May 18, 2015, 1:21:01 PM
    Author     : Wendell
--%>

<%@page import="java.net.URLEncoder"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    session.removeAttribute("loggedUser");
    session.removeAttribute("cart");
    response.sendRedirect("/ECommerceDsw/?kind=success&flash=" + URLEncoder.encode("Logout com sucesso!"));
%>