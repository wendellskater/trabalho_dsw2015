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
<form method="POST">
        <section class="conteudo">

            <div class="divLogin">                        
                <p><label for="username">Nome de usuário</label></p>
                <p><input type="text" name="login" style="width:280px" /></p>
                <br />  
                <p><label for="password">Senha</label></p>
                <p><input type="password" name="senha" style="width:280px" /></p>
                <br />
                <div class="botao"><a href="javascript:void(0)" onclick="document.forms[0].submit();">Login</a></div>                     
            </div>
</form>                    



<jsp:include flush="true" page="footer.jsp"></jsp:include>