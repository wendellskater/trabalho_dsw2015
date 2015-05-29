<%@page import="dsw.dao.estruturas.Comprador"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Comprador loggedUser = new Comprador();
    boolean usuarioLogado = false;
    if (session.getAttribute("loggedUser") != null) {
        loggedUser = (Comprador) session.getAttribute("loggedUser");
        usuarioLogado = true;
    } else {
        loggedUser = null;
    }
%>
<html>
    <head>
        <title>E Commerce</title>
    </head>
    <body>
        <ul>
            <li>
                <a href="/ECommerceDsw/">Home - Listagem de Produtos</a>
            </li>
            <%if (!usuarioLogado) {%>
            <li>
                <a href="login.jsp">Login</a>
            </li>
            <%} else {%>
            <li>
                <a href="sair.jsp"><b><%=loggedUser.getNomeUsuario()%></b> (Sair)</a>
            </li>
            <li>
                <a href="carrinho.jsp">Carrinho</a>
            </li>
            <li>
                <a href="historico.jsp">Histórico de Compras</a>
            </li>
            <%}%>
        </ul>
        <font face="verdana" size="2">
        <%if (request.getParameter("flash") != null) {%>
        <h2 style="color: <%= (request.getParameter("kind").equals("success") ? "lightgreen" : "red")%>;"><%=request.getParameter("flash")%></h2>
        <%}%>
        </font>

