/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dsw.dao;

import dsw.dao.estruturas.Carrinho;
import dsw.dao.estruturas.ItemCarrinho;
import dsw.dao.estruturas.Produto;
import dsw.util.Util;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Wendell
 */
public final class ItemCarrinhoDao {

    protected final Connection con;
    private String sqlConsultarUm;
    private String sqlConsultar;
    private String sqlInserir;
    private String sqlAtualizar;
    private String sqlRemover;

    public ItemCarrinhoDao() {
        con = new DataSource("trabalho_dsw2015").getCon();
        this.setSqlConsultarUm("SELECT * FROM item_carrinho WHERE id = ?");
        this.setSqlConsultar("SELECT * FROM item_carrinho WHERE id = coalesce(?, id) and carrinho_id = coalesce(?, carrinho_id) and produto_id = coalesce(?, produto_id); ");
        this.setSqlInserir("INSERT INTO item_carrinho (carrinho_id, produto_id, quantidade, valor) VALUES ( ?, ?, ?, ?)");
        this.setSqlAtualizar("UPDATE item_carrinho SET quantidade = ?, valor = ? WHERE id = ?");
        this.setSqlRemover("DELETE FROM item_carrinho WHERE id = ? ");

    }

    public ArrayList<ItemCarrinho> consultar(ItemCarrinho parametros) {

        ArrayList<ItemCarrinho> res = new ArrayList<>();
        String command = getSqlConsultar();
        try {
            PreparedStatement stmt = con.prepareStatement(command);

            Util.setInt(stmt, 1, parametros.getId());
            Util.setInt(stmt, 2, parametros.getCarrinho().getId());
            Util.setInt(stmt, 3, parametros.getProduto().getId());

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                ItemCarrinho obj = fromResultsetToObject(rs);
                res.add(obj);
            }
        } catch (SQLException e) {
            System.err.println("Falha na insercao");
            System.err.println(e);
        }
        return res;
    }

    public boolean inserir(ItemCarrinho parametros) {
        String sql = getSqlInserir();
        try {
            PreparedStatement stmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            Util.setInt(stmt, 1, parametros.getCarrinho().getId());
            Util.setInt(stmt, 2, parametros.getProduto().getId());
            Util.setInt(stmt, 3, parametros.getQuantidade());
            Util.setDouble(stmt, 4, parametros.getValor());

            stmt.execute();

            ResultSet generatedKeys = stmt.getGeneratedKeys();

            if (generatedKeys.next()) {
                parametros.setId(generatedKeys.getInt(1));
            } else {
                throw new SQLException("Creating user failed, no ID obtained.");
            }

        } catch (SQLException e) {
            System.err.println("Falha na insercao");
            System.err.println(e);
            return false;
        }
        return true;
    }

    public boolean atualizar(ItemCarrinho parametros) {
        String sql = getSqlAtualizar();
        try {
            PreparedStatement stmt = con.prepareStatement(sql);

            Util.setInt(stmt, 1, parametros.getQuantidade());
            Util.setDouble(stmt, 2, parametros.getValor());
            Util.setInt(stmt, 3, parametros.getQuantidade());

            stmt.execute();
        } catch (SQLException ex) {
            System.err.println("Falha na atualização.");
            System.err.println(ex);
            return false;
        }
        return true;
    }

    public boolean remover(ItemCarrinho parametros) {
        String sql = getSqlRemover();
        try {
            PreparedStatement stmt = con.prepareStatement(sql);
            Util.setInt(stmt, 1, parametros.getId());
            stmt.execute();
        } catch (SQLException ex) {
            System.err.println("Falha na remoção.");
            System.err.println(ex);
            return false;
        }
        return true;
    }

    protected ItemCarrinho fromResultsetToObject(ResultSet rs) {
        ItemCarrinho obj = new ItemCarrinho();
        try {
            obj.setId(rs.getInt("id"));
            
            //carrinho_id
            //produto_id
            //quantidade
            //valor
            Carrinho c = new Carrinho();
            c.setId(rs.getInt("carrinho_id"));
            
            obj.setCarrinho(c);
            
            Produto p = new Produto();
            p.setId(rs.getInt("produto_id"));
            obj.setProduto(p);
            obj.setQuantidade(rs.getInt("quantidade"));
            obj.setValor(rs.getDouble("valor"));
            
        } catch (SQLException e) {
            Logger.getLogger(ItemCarrinhoDao.class.getName()).log(Level.SEVERE, null, e);
        }
        return obj;

    }

    protected String getSqlConsultarUm() {
        return sqlConsultarUm;
    }

    protected void setSqlConsultarUm(String sql) {
        this.sqlConsultarUm = sql;
    }

    protected String getSqlConsultar() {
        return sqlConsultar;
    }

    protected void setSqlConsultar(String sql) {
        this.sqlConsultar = sql;
    }

    protected String getSqlInserir() {
        return sqlInserir;
    }

    protected void setSqlInserir(String sql) {
        this.sqlInserir = sql;
    }

    protected String getSqlAtualizar() {
        return this.sqlAtualizar;
    }

    protected void setSqlAtualizar(String sql) {
        this.sqlAtualizar = sql;
    }

    protected String getSqlRemover() {
        return sqlRemover;
    }

    protected void setSqlRemover(String sql) {
        this.sqlRemover = sql;
    }

}
