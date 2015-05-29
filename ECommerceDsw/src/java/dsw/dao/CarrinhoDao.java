/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dsw.dao;

import dsw.dao.estruturas.Carrinho;
import dsw.dao.estruturas.Comprador;
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
public final class CarrinhoDao {

    protected final Connection con;
    private String sqlConsultarUm;
    private String sqlConsultar;
    private String sqlInserir;
    private String sqlAtualizar;
    private String sqlRemover;

    public CarrinhoDao() {
        con = new DataSource("trabalho_dsw2015").getCon();
        this.setSqlConsultarUm("SELECT * FROM carrinho WHERE id = ?");
        this.setSqlConsultar("SELECT * FROM carrinho WHERE id = coalesce(?, id) and comprador_id = coalesce(?, comprador_id); ");
        this.setSqlInserir("INSERT INTO carrinho (comprador_id, data_compra, valor_total) VALUES ( ?, ?, ? )");
        this.setSqlAtualizar("UPDATE carrinho SET comprador_id = ?, data_compra = ?, valor_total = ? WHERE id = ?");
        this.setSqlRemover("DELETE FROM carrinho WHERE id = ? ");
        
    }

    public ArrayList<Carrinho> consultar(Carrinho parametros) {

        ArrayList<Carrinho> res = new ArrayList<>();
        String command = getSqlConsultar();
        try {
            PreparedStatement stmt = con.prepareStatement(command);
            
            Util.setInt(stmt, 1, parametros.getId());
            Util.setInt(stmt, 2, parametros.getComprador().getId());
            
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Carrinho obj = fromResultsetToObject(rs);
                res.add(obj);
            }
        } catch (SQLException e) {
            System.err.println("Falha na insercao");
            System.err.println(e);
        }
        return res;
    }

    public boolean inserir(Carrinho parametros) {
        String sql = getSqlInserir();
        try {
            PreparedStatement stmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            
            Util.setInt(stmt, 1, parametros.getComprador().getId());
            Util.setDate(stmt, 2, parametros.getDataCompra());
            Util.setDouble(stmt, 3, parametros.getValorTotal());
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

    public boolean atualizar(Carrinho parametros) {
        String sql = getSqlAtualizar();
        try {
            PreparedStatement stmt = con.prepareStatement(sql);
 
            Util.setInt(stmt, 1, parametros.getComprador().getId());
            Util.setDate(stmt, 2, parametros.getDataCompra());
            Util.setDouble(stmt, 3, parametros.getValorTotal());
            Util.setInt(stmt, 4, parametros.getId());
            stmt.execute();
        } catch (SQLException ex) {
            System.err.println("Falha na atualização.");
            System.err.println(ex);
            return false;
        }
        return true;
    }

    public boolean remover(Carrinho parametros) {
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

    protected Carrinho fromResultsetToObject(ResultSet rs) {
        Carrinho obj = new Carrinho();
        try {
            obj.setId(rs.getInt("id"));
            
            Comprador c = new Comprador();
            c.setId(rs.getInt("comprador_id"));
            obj.setComprador(c);
            
            obj.setDataCompra(rs.getDate("data_compra"));
            obj.setValorTotal(rs.getDouble("valor_total"));
        } catch (SQLException e) {
            Logger.getLogger(CarrinhoDao.class.getName()).log(Level.SEVERE, null, e);
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
