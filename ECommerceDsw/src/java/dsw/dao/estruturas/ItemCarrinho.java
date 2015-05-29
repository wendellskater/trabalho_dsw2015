/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dsw.dao.estruturas;

/**
 *
 * @author Wendell
 */
public class ItemCarrinho {

    private int id;
    private Carrinho carrinho;
    private Produto produto;
    private int quantidade;
    private double valor;

    /**
     * @return the id
     */
    public int getId() {
        return id;
    }

    /**
     * @param id the id to set
     */
    public void setId(int id) {
        this.id = id;
    }

    /**
     * @return the carrinho
     */
    public Carrinho getCarrinho() {
        
        if(this.carrinho == null){
           this.carrinho = new Carrinho();
        }
        return carrinho;
    }

    /**
     * @param carrinho the carrinho to set
     */
    public void setCarrinho(Carrinho carrinho) {
        this.carrinho = carrinho;
    }

    /**
     * @return the produto
     */
    public Produto getProduto() {
        if(this.produto == null){
           this.produto = new Produto();
        }
        return produto;
    }

    /**
     * @param produto the produto to set
     */
    public void setProduto(Produto produto) {
        this.produto = produto;
    }

    /**
     * @return the quantidade
     */
    public int getQuantidade() {
        return quantidade;
    }

    /**
     * @param quantidade the quantidade to set
     */
    public void setQuantidade(int quantidade) {
        this.quantidade = quantidade;
    }

    /**
     * @return the valor
     */
    public double getValor() {
        return valor;
    }

    /**
     * @param valor the valor to set
     */
    public void setValor(double valor) {
        this.valor = valor;
    }

}
