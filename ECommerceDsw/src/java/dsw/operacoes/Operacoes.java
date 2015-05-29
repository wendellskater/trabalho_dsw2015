/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dsw.operacoes;

import dsw.dao.CarrinhoDao;
import dsw.dao.CompradorDao;
import dsw.dao.ItemCarrinhoDao;
import dsw.dao.ProdutoDao;
import dsw.dao.estruturas.Carrinho;
import dsw.dao.estruturas.Comprador;
import dsw.dao.estruturas.ItemCarrinho;
import dsw.dao.estruturas.Produto;
import java.util.ArrayList;
import java.util.Date;

/**
 *
 * @author Marcelo
 */
public class Operacoes {

    public static Comprador efetuarLogin(String login, String senha) {
        CompradorDao cDao = new CompradorDao();
        Comprador c = new Comprador();
        c.setNomeUsuario(login);
        c.setSenha(senha);
        ArrayList<Comprador> compradores = cDao.consultar(c);
        Comprador comprador;
        if (compradores.size() > 0) {
            comprador = compradores.get(0);
        } else {
            comprador = null;
        }

        return comprador;
    }

    public static ArrayList<Carrinho> obterHistoricoDeCompras(Comprador comprador) {
        
        CarrinhoDao cDao = new CarrinhoDao();
        ItemCarrinhoDao icDao = new ItemCarrinhoDao();
        ProdutoDao pDao = new ProdutoDao();
        
        Carrinho parametro = new Carrinho();
        parametro.setComprador(comprador);
        
        ArrayList<Carrinho> carrinhos = cDao.consultar(parametro);
        
        
        
        for(Carrinho c : carrinhos){
            ItemCarrinho parametroCarrinho = new ItemCarrinho();
            parametroCarrinho.setCarrinho(c);
            ArrayList<ItemCarrinho> items = icDao.consultar(parametroCarrinho);
            
            for(ItemCarrinho ic : items){
                ic.setProduto(pDao.consultar(ic.getProduto()).get(0));
            }
            
            c.setProdutosCarrinho(items);
        }
        
        
        
        return carrinhos;
    }

    public static String adicionarItem(Carrinho carrinho, Comprador comprador, Produto produto, int quantidade) {
        String retorno = "";
        try {
            
            carrinho.setComprador(comprador);
            ArrayList<ItemCarrinho> items = carrinho.getProdutosCarrinho();
            ItemCarrinho item = new ItemCarrinho();            
            item.setCarrinho(carrinho);
            item.setProduto(produto);
            item.setQuantidade(quantidade);

            int indice = 0;
            boolean found = false;
            for (int i = 0; i < items.size(); ++i) {
                if (items.get(i).getProduto().getId() == produto.getId()) {
                    found = true;
                    indice = i;
                }
            }

            if (found) {
                item = items.get(indice);

                item.setQuantidade(item.getQuantidade() + quantidade);
            } else {
                item.setQuantidade(quantidade);
                items.add(item);
            }

            for (int i = 0; i < items.size(); ++i) {
                if (items.get(i).getQuantidade() == 0) {
                    items.remove(i);
                    break;
                }

            }

            carrinho.setProdutosCarrinho(items);

        } catch (Exception ex) {
            retorno = ex.getMessage();
        }

        return retorno;
    }
    public static void realizarCheckout(Comprador loggedUser, Carrinho cart) throws Exception {

        if (loggedUser == null) {
            throw new Exception("Usuário não está logado");
        }

        if (cart == null) {
            throw new Exception("Nenhum produto no carrinho!");
        }

        if (cart.getProdutosCarrinho().isEmpty()) {
            throw new Exception("Nenhum produto no carrinho");
        }

        ArrayList<ItemCarrinho> items = cart.getProdutosCarrinho();

        ItemCarrinhoDao icDao = new ItemCarrinhoDao();
        ProdutoDao pDao = new ProdutoDao();
        CarrinhoDao cDao = new CarrinhoDao();
        
        for (ItemCarrinho item : items) {
            //CALCULO O VALOR TOTAL.
            Produto produto = item.getProduto();
            produto = pDao.consultar(produto).get(0);
            item.setProduto(produto);
            cart.setValorTotal(cart.getValorTotal() + (item.getQuantidade() * item.getProduto().getValor()));
        }

        cart.setDataCompra(new Date());

        if (cDao.inserir(cart)) {
            for (ItemCarrinho item : items) {
                item.setCarrinho(cart);
                item.setValor(item.getQuantidade() * item.getProduto().getValor());
                if (!icDao.inserir(item)) {
                    throw new Exception("Problemas ao registrar sua compra");
                }
            }
        }

    }    

}
