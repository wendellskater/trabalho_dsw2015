/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dsw.dao.estruturas;

import java.util.ArrayList;
import java.util.Date;

/**
 *
 * @author Wendell
 */
public class Carrinho {

    private Comprador comprador;
    private Date dataCompra;
    private double valorTotal;
    private int id;
    private ArrayList<ItemCarrinho> items;

    /**
     * @return the comprador
     */
    public Comprador getComprador() {

        if (this.comprador == null) {
            this.comprador = new Comprador();
        }

        return comprador;
    }

    /**
     * @param comprador the comprador to set
     */
    public void setComprador(Comprador comprador) {
        this.comprador = comprador;
    }

    /**
     * @return the dataCompra
     */
    public Date getDataCompra() {
        return dataCompra;
    }

    /**
     * @param dataCompra the dataCompra to set
     */
    public void setDataCompra(Date dataCompra) {
        this.dataCompra = dataCompra;
    }

    /**
     * @return the valorTotal
     */
    public double getValorTotal() {
        return valorTotal;
    }

    /**
     * @param valorTotal the valorTotal to set
     */
    public void setValorTotal(double valorTotal) {
        this.valorTotal = valorTotal;
    }

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
     * @return the items
     */
    public ArrayList<ItemCarrinho> getProdutosCarrinho() {
        if (items == null) {
            this.items = new ArrayList<>();
        }
        return items;
    }

    /**
     * @param items the items to set
     */
    public void setProdutosCarrinho(ArrayList<ItemCarrinho> items) {
        this.items = items;
    }
}
