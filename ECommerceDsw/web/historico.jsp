<%-- 
    Document   : historico
    Created on : May 29, 2015, 2:12:55 PM
    Author     : Wendell
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Currency"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="dsw.dao.estruturas.ItemCarrinho"%>
<%@page import="dsw.dao.estruturas.Carrinho"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dsw.dao.estruturas.Comprador"%>
<%@page import="dsw.operacoes.Operacoes"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%

    NumberFormat formatoMoeda = NumberFormat.getCurrencyInstance();
    formatoMoeda.setCurrency(Currency.getInstance("BRL"));

    Comprador loggedUser = new Comprador();
    boolean usuarioLogado = false;
    if (session.getAttribute("loggedUser") != null) {
        loggedUser = (Comprador) session.getAttribute("loggedUser");
        usuarioLogado = true;
    } else {
        loggedUser = null;
    }

    ArrayList<Carrinho> carrinhos = Operacoes.obterHistoricoDeCompras(loggedUser);
%>
<jsp:include flush="true" page="header.jsp"></jsp:include>
    <section class="conteudo">
        <h2>Histórico de Compras</h2>

        <h3>Veja histórico de suas compras</h3>

        <table>
        <%for (Carrinho carrinho : carrinhos) {%>
        <h4>Pedido: #<%=carrinho.getId()%></h4>

        <table class="table" >
            <thead>
                <tr>
                    <th class="centralizado">#</th>
                    <th class="centralizado">Usuário</th>
                    <th class="centralizado">Data</th>
                    <th class="centralizado">Valor Total</th>
                </tr>
            <thead>
            <tbody>
                <tr>
                    <td class="centralizado"><%=carrinho.getId()%></td>
                    <td class="centralizado"><%=loggedUser.getNomeUsuario()%></td>
                    <td class="centralizado"><%=new SimpleDateFormat("dd/MM/yyyy").format(carrinho.getDataCompra())%></td>
                    <td class="centralizado"><%=formatoMoeda.format(carrinho.getValorTotal())%></td>
                </tr>
            </tbody>
        </table>
        <h4>Detalhe do Pedido</h4>
        <table class="table">
            <thead>
                <tr>
                    <th>Nome</th>
                    <th>R$ Unitário</th>
                    <th>Quantidade</th>
                    <th>R$ Total</th>
                </tr>
            </thead>
            <tbody>
                <%for (ItemCarrinho itemCarrinho : carrinho.getProdutosCarrinho()) {
                %>
                <tr>
                    <td class="centralizado"><%=itemCarrinho.getProduto().getNome()%></td>
                    <td class="centralizado"><%=formatoMoeda.format(itemCarrinho.getProduto().getValor())%></td>
                    <td class="centralizado"><%=itemCarrinho.getQuantidade()%></td>
                    <td class="centralizado"><%=formatoMoeda.format(itemCarrinho.getValor())%></td>

                </tr>
                <%}%>
            </tbody>
        </table>
        <br><br><br><br>
        <%}%>
    </table>
</section>
<jsp:include flush="true" page="footer.jsp"></jsp:include>
