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
    <form method="POST" action="carrinho.jsp">
        <input type="hidden" name="action" value="adicionar_item"> 
        <input type="hidden" name="produto_id" id="produto_id" value=""> 
        <input type="hidden" name="quantidade" value="1">         

        <section class="conteudo">

            <h2>Listagem de Produtos</h2>


            <table class="table">
                <thead>
                    <tr>                    
                        <th>
                            Nome
                        </th>
                        <th>
                            Categoria
                        </th>
                    <%if (isUsuarioLogado) {%>
                    <th >
                        Preço Unitário
                    </th>  
                    <%}%>        
                    <th align="right"></th>
                </tr>

            </thead>
            <tbody>
                <%for (Produto produto : produtos) {%>

                <tr>
                    <td class="centralizado"><%=produto.getNome()%></td>
                    <td class="centralizado"><%=produto.getCategoria()%></td>
                    <td class="centralizado"><%=formatoMoeda.format(produto.getValor())%></td>
                    <%if (isUsuarioLogado) {%>
                    <td class="centralizado">
                        <div class="botao">
                            <a href="javascript:void(0)" onclick="document.getElementById('produto_id').value = <%=produto.getId()%>;
                                    document.forms[0].submit();">Adicionar no Carrinho</a>
                        </div>                        
                    </td>
                    <%}%>
                <tr>
                    <%}%>
            </tbody>
        </table>
    </section>
</form>
<jsp:include flush="true" page="footer.jsp"></jsp:include>
