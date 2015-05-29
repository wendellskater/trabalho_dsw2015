<%-- 
    Document   : historico
    Created on : May 29, 2015, 2:12:55 PM
    Author     : Marcelo
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
<h1>Histórico de Compras</h1>

<h2>Veja histórico de suas compras</h2>

<table>
                <%for (Carrinho carrinho : carrinhos) {%>
                <table width="70%" >
                    <tr>
                        <th align="center">#</th>
                        <th align="center">Usuário</th>
                        <th align="center">Data</th>
                        <th align="right">Valor Total</th>
                    </tr>

                    <tr>
                        <td align="center"><%=carrinho.getId()%></td>
                        <td align="center"><%=loggedUser.getNomeUsuario()%></td>
                        <td align="center"><%=new SimpleDateFormat("dd/MM/yyyy").format(carrinho.getDataCompra())%></td>
                        <td align="right"><%=formatoMoeda.format(carrinho.getValorTotal())%></td>
                    </tr>
                </table>
                    <h4>Detalhe</h4>
                <table width="70%" border="1" bordercolor="red">
                    <tr>
                        <th>Nome</th>
                        <th>R$ Unitário</th>
                        <th>Quantidade</th>
                        <th>R$ Total</th>
                    </tr>
                    <%for (ItemCarrinho itemCarrinho : carrinho.getProdutosCarrinho()) {
                    %>
                    <tr>
                        <td ><%=itemCarrinho.getProduto().getNome()%></td>
                        <td ><%=formatoMoeda.format(itemCarrinho.getProduto().getValor())%></td>
                        <td ><%=itemCarrinho.getQuantidade()%></td>
                        <td ><%=formatoMoeda.format(itemCarrinho.getValor())%></td>
                        
                    </tr>
                    <%}%>
                </table>
                <br><br><br><br>
                <%}%>
</table>
<jsp:include flush="true" page="footer.jsp"></jsp:include>
