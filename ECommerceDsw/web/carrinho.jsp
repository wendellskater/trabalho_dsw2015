<%-- 
    Document   : carrinho
    Created on : May 29, 2015, 2:08:15 PM
    Author     : Wendell
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
    <form method="POST">
        <input type="hidden" name="action" value="adicionar_item"> 
        <input type="hidden" name="produto_id" id="produto_id" value=""> 
        <input type="hidden" name="quantidade" id="quantidade" value="">         

        <section class="conteudo">

            <h2>Carrinho</h2>

            <table class="table">
                <thead>
                    <tr>
                        <th>Nome</th>
                        <th>Preço Unitário</th>
                        <th>Quantidade</th>
                        <th>Preço Total (R$)</th>
                    </tr>
                </thead>                
                <tbody>

                <%double valorTotal = 0;%>
                <%
                    NumberFormat formatoMoeda = NumberFormat.getCurrencyInstance();
                    formatoMoeda.setCurrency(Currency.getInstance("BRL"));

                    for (ItemCarrinho itemPedido : items) {
                        Produto produto = itemPedido.getProduto();
                        produto = produtoDao.consultar(produto).get(0);
                %>

                <tr>
                    <td class="centralizado"><%=produto.getNome()%></td>
                    <td class="centralizado"><%=formatoMoeda.format(produto.getValor())%></td>
                    <td class="centralizado">
                        <div class="botao"><a href="javascript:void(0)" onclick="document.getElementById('quantidade').value = -1;
                                document.getElementById('produto_id').value = <%=produto.getId()%>;
                                document.forms[0].submit();">Remover</a></div>
                        <div class="containerNumero"><%=itemPedido.getQuantidade()%></div>
                        <div class="botao"><a href="javascript:void(0)" onclick="document.getElementById('quantidade').value = 1;
                                document.getElementById('produto_id').value = <%=produto.getId()%>;
                                document.forms[0].submit();">Adicionar</a></div>
                    </td>
                    <td class="centralizado"><%=formatoMoeda.format(itemPedido.getQuantidade() * produto.getValor())%></td>
                </tr>
                <%
                    valorTotal += itemPedido.getQuantidade() * produto.getValor();
                %>
                <%}%>                    
                <tr>
                    <td colspan="3" align="right"><b>Valor: </b></td>
                    <td align="center"><b><%=formatoMoeda.format(valorTotal)%></b></td>
                </tr>
            </tbody>                
        </table>    

        <div class="botao"><a href="javascript:void(0)" onclick="salvarCarrinho();">Ëfetivar compra</a></div>                

    </section>



</form>
<script>

    var salvarCarrinho = function () {
        if (confirm('Deseja fechar compra?'))
            document.location.replace('efetivarcompra.jsp');
    };

</script>
<jsp:include flush="true" page="footer.jsp"></jsp:include>
