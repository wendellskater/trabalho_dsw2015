<%-- 
    Document   : carrinho
    Created on : May 29, 2015, 2:08:15 PM
    Author     : Marcelo
--%>

<%@page import="java.net.URLEncoder"%>
<%@page import="dsw.operacoes.Operacoes"%>
<%@page import="dsw.dao.ProdutoDao"%>
<%@page import="dsw.dao.estruturas.Produto"%>
<%@page import="java.util.Currency"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="dsw.dao.estruturas.Carrinho"%>
<%@page import="dsw.dao.estruturas.ItemCarrinho"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dsw.dao.estruturas.Comprador"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Comprador comprador = new Comprador();
    Carrinho carrinho = new Carrinho();

    if (session.getAttribute("loggedUser") != null) {
        comprador = (Comprador) session.getAttribute("loggedUser");
    } else {
        comprador = null;
    }

    if (session.getAttribute("cart") != null) {
        carrinho = (Carrinho) session.getAttribute("cart");
    } else {
        session.setAttribute("cart", carrinho);
    }

    if (request.getParameter("action") != null && request.getParameter("action").equals("adicionar_item")) {

        int quantidade = Integer.parseInt(request.getParameter("quantidade"));
        Produto produto = new Produto();
        produto.setId(Integer.parseInt(request.getParameter("produto_id")));

        String mensagem = Operacoes.adicionarItem(carrinho, comprador, produto, quantidade);

        if (mensagem.equals("")) {
            if (quantidade > 0) {
                mensagem = URLEncoder.encode("Produto adicionado com sucesso ao carrinho!");
            } else {
                mensagem = URLEncoder.encode("Produto removido com sucesso do carrinho!");
            }
            response.sendRedirect("/ECommerceDsw/carrinho.jsp?kind=success&flash=" + mensagem);
        } else {
            response.sendRedirect("/ECommerceDsw/carrinho.jsp?kind=error&flash=" + URLEncoder.encode(mensagem));
        }
    }

    ArrayList<ItemCarrinho> items = carrinho.getProdutosCarrinho();
    ProdutoDao produtoDao = new ProdutoDao();

%>

<jsp:include flush="true" page="header.jsp"></jsp:include>

    <h1>Carrinho</h1>

    <form method="POST">
        <input type="hidden" name="action" value="adicionar_item"> 
        <input type="hidden" name="produto_id" id="produto_id" value=""> 
        <input type="hidden" name="quantidade" id="quantidade" value="">         

        <table>
            <tr>                    
                <th>
                    Nome
                </th>
                <th>
                    Preço Unitário
                </th>  
                <th>
                    Quantidade
                </th>
                <th>
                    Preço
                </th>
            </tr>
        <%double valorTotal = 0;%>
        <%
            NumberFormat formatoMoeda = NumberFormat.getCurrencyInstance();
            formatoMoeda.setCurrency(Currency.getInstance("BRL"));

            for (ItemCarrinho itemPedido : items) {
                Produto produto = itemPedido.getProduto();
                produto = produtoDao.consultar(produto).get(0);
        %>
        <tr>
            <td><%=produto.getNome()%></td>
            <%--<td><%=produto.getCategoria().getDescricao()%></td>--%>
            <td><%=formatoMoeda.format(produto.getValor())%></td>
            <td>
                <%=itemPedido.getQuantidade()%>
                <input type="button" value="Adicionar" name="adicionar_<%=produto.getId()%>" onclick="document.getElementById('quantidade').value = 1;
                        document.getElementById('produto_id').value = <%=produto.getId()%>;
                        document.forms[0].submit();">
                <input type="button" value="Remover" name="remover_<%=produto.getId()%>" onclick="document.getElementById('quantidade').value = -1;
                        document.getElementById('produto_id').value = <%=produto.getId()%>;
                        document.forms[0].submit();"> 
            </td>
            <td><%=formatoMoeda.format(itemPedido.getQuantidade() * produto.getValor())%></td>
            <%
                valorTotal += itemPedido.getQuantidade() * produto.getValor();
            %>
        <tr>
            <%}%>
    </table>
    <input type="button" onclick="salvarCarrinho();" value="Ëfetivar compra">
</form>
<script>

    var salvarCarrinho = function () {
        if (confirm('Deseja fechar compra?'))
            document.location.replace('efetivarcompra.jsp');
    };

</script>
<jsp:include flush="true" page="footer.jsp"></jsp:include>
