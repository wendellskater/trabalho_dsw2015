<%-- 
    Document   : checkout
    Created on : May 18, 2015, 8:10:41 PM
    Author     : Wendell
--%>
<%@page import="dsw.operacoes.Operacoes"%>
<%@page import="dsw.dao.CarrinhoDao"%>
<%@page import="dsw.dao.estruturas.Carrinho"%>
<%@page import="dsw.dao.estruturas.Comprador"%>
<%@page import="java.util.logging.Logger"%>
<%@page import="java.util.logging.Level"%>
<%@page import="java.util.Date"%>
<%@page import="java.net.URLEncoder"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String mensagem = URLEncoder.encode("Compra realizada com sucesso");
    String kind = "success";

    try {
        Comprador comprador = new Comprador();
        Carrinho cart = new Carrinho();

        if (session.getAttribute("loggedUser") != null) {
            comprador = (Comprador) session.getAttribute("loggedUser");
        } else {
            comprador = null;
        }

        if (session.getAttribute("cart") != null) {
            cart = (Carrinho) session.getAttribute("cart");
        }

        CarrinhoDao pDao = new CarrinhoDao();
        try {
            Operacoes.realizarCheckout(comprador, cart);
            session.removeAttribute("cart");
        } catch (Exception ex) {
            mensagem = URLEncoder.encode(ex.getMessage());
            kind = "error";
        }

        response.sendRedirect("/ECommerceDsw/?kind=" + kind + "&flash=" + mensagem);
    } catch (Exception ex) {
        mensagem = URLEncoder.encode(ex.getMessage());
        kind = "error";
        response.sendRedirect("/ECommerceDsw/?kind=" + kind + "&flash=" + mensagem);

    }

%>