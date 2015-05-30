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
        <title>Teste E-Commerce</title>
        <meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
        <meta charset="utf-8">                
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="css/normalize.css">
        <link rel="stylesheet" href="css/main.css">
        <link rel="stylesheet" href="css/style.css">
        <script src="js/modernizr-2.8.3.min.js"></script>
    </head>

    <body>

        <header>            
            <nav>
                <div class="logotipo">
                    <a href="javascript:void(0)">ecommerce</a>
                </div>
                <ul>
                    <li><a href="/ECommerceDsw/">Listagem de Produtos</a>&nbsp;&nbsp;|</li>
                        <%if (!usuarioLogado) {%>
                    <li><a href="login.jsp">Login</a>&nbsp;&nbsp;|</li>
                        <%} else {%>
                    <li><a href="sair.jsp"><b><%=loggedUser.getNomeUsuario()%></b> (Sair)</a>&nbsp;&nbsp;|</li>
                    <li><a href="carrinho.jsp">Carrinho</a>&nbsp;&nbsp;|</li>
                    <li><a href="historico.jsp">Histórico de Compras</a></li>
                        <%}%>                
                </ul>
                <div class="clearfix"></div>            
            </nav>
        </header>
        <%if (request.getParameter("flash") != null) {%>
        <section class="mensagem-display">
            <div class="<%= (request.getParameter("kind").equals("success") ? "mensagem-sucesso" : "mensagem-erro")%>"><%=request.getParameter("flash")%></div>
        </section>
        <%}%>
        <%if (!usuarioLogado) {%>
        <section class="mensagem-display">
        <div class="mensagem-atencao">Para montar seu carrinho é necessário estar logado. Utilize um dos seguintes logins: professor:professor, wendell:wendell ou cliente:cliente </div>
        </section>
        <%}%>



