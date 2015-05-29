<%-- 
    Document   : index
    Created on : May 29, 2015, 10:24:28 AM
    Author     : Wendell
--%>
<%@page import="java.net.URLEncoder"%>
<%@page import="dsw.operacoes.Operacoes"%>
<%@page import="dsw.dao.estruturas.Comprador"%>
<%@page import="dsw.dao.estruturas.Carrinho"%>
<%@page import="java.util.Currency"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="dsw.dao.estruturas.Produto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dsw.dao.ProdutoDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Comprador comprador = (Comprador) session.getAttribute("loggedUser");
    boolean isUsuarioLogado = comprador != null;


    NumberFormat formatoMoeda = NumberFormat.getCurrencyInstance();

    formatoMoeda.setCurrency(Currency.getInstance("BRL"));
    ProdutoDao pDao = new ProdutoDao();
    ArrayList<Produto> produtos = pDao.consultar(new Produto());
%>
<jsp:include flush="true" page="header.jsp"></jsp:include>
    <h1>Home - Listagem de Produtos</h1>

    <table>
    <% if (produtos.size()
                != 0) {%>

    <tr>                    
        <th>
            Nome
        </th>
        <th>
            Categoria
        </th>

        <%if (isUsuarioLogado) {%>
        <th align="right">
            Preço Unitário
        </th>  
        <%}%>        

    </tr>
    <%}%>

    <form method="POST" action="carrinho.jsp">
        <input type="hidden" name="action" value="adicionar_item"> 
        <input type="hidden" name="produto_id" id="produto_id" value=""> 
        <input type="hidden" name="quantidade" value="1">         
        <%for (Produto produto : produtos) {%>
        <tr>
            <td><%=produto.getNome()%></td>
            <td><%=produto.getCategoria()%></td>
            <td align="right"><%=formatoMoeda.format(produto.getValor())%></td>
            <%if (isUsuarioLogado) {%>
            <td><button  name="adicionar_<%=produto.getId()%>" onclick="document.getElementById('produto_id').value = <%=produto.getId()%>;
                    document.forms[0].submit();">Adicionar no Carrinho</button></td>
                <%}%>
        <tr>
            <%}%>
            </table>
    </form>
    <jsp:include flush="true" page="footer.jsp"></jsp:include>
