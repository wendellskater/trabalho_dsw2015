<%-- 
    Document   : login
    Created on : May 29, 2015, 10:24:28 AM
    Author     : Wendell
--%>
<%@page import="java.net.URLEncoder"%>
<%@page import="dsw.dao.estruturas.Comprador"%>
<%@page import="dsw.operacoes.Operacoes"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (request.getParameter("login") != null) {
        out.print("POSTADO");
        String login = request.getParameter("login");
        String senha = request.getParameter("password");

        Comprador c = Operacoes.efetuarLogin(login, senha);

        if (c != null) {
            session.setAttribute("loggedUser", c);
            response.sendRedirect("/ECommerceDsw/?kind=success&flash=" + URLEncoder.encode("Login com sucesso!"));            
        } else {
            response.sendRedirect("/ECommerceDsw/?kind=error&flash=" + URLEncoder.encode("Login inválido"));
        }

    }
%>
<jsp:include flush="true" page="header.jsp"></jsp:include>
<h1>Login</h1>
    
<form method="POST">
    LOGIN: <input type="text" name="login"> <br>
    SENHA: <input type="password" name="senha"> <br>
    <input type="submit" value="REALIZAR LOGIN">
</form>
<jsp:include flush="true" page="footer.jsp"></jsp:include>