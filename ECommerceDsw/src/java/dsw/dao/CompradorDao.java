/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dsw.dao;

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
public final class CompradorDao {

    protected final Connection con;
    private String sqlConsultarUm;
    private String sqlConsultar;
    private String sqlInserir;
    private String sqlAtualizar;
    private String sqlRemover;

    public CompradorDao() {
        con = new DataSource("trabalho_dsw2015").getCon();
        this.setSqlConsultarUm("SELECT * FROM comprador WHERE id = ?");
        this.setSqlConsultar("SELECT * FROM comprador WHERE id = coalesce(?, id) and nome_usuario = coalesce(?, nome_usuario) and senha = coalesce(?, senha); ");
        this.setSqlInserir("INSERT INTO comprador (nome_usuario, senha) VALUES ( ?, ?)");
        this.setSqlAtualizar("UPDATE comprador SET senha = ? WHERE id = ?");
        this.setSqlRemover("DELETE FROM comprador WHERE id = ? ");

    }

    public ArrayList<Comprador> consultar(Comprador parametros) {

        ArrayList<Comprador> res = new ArrayList<>();
        String command = getSqlConsultar();
        try {
            PreparedStatement stmt = con.prepareStatement(command);

            Util.setInt(stmt, 1, parametros.getId());
            Util.setString(stmt, 2, parametros.getNomeUsuario());
            Util.setString(stmt, 3, parametros.getSenha());

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Comprador obj = fromResultsetToObject(rs);
                res.add(obj);
            }
        } catch (SQLException e) {
            System.err.println("Falha na insercao");
            System.err.println(e);
        }
        return res;
    }

    public boolean inserir(Comprador parametros) {
        String sql = getSqlInserir();
        try {
            PreparedStatement stmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            Util.setString(stmt, 1, parametros.getNomeUsuario());
            Util.setString(stmt, 2, parametros.getSenha());
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

    public boolean atualizar(Comprador parametros) {
        String sql = getSqlAtualizar();
        try {
            PreparedStatement stmt = con.prepareStatement(sql);

            Util.setString(stmt, 1, parametros.getSenha());
            Util.setInt(stmt, 2, parametros.getId());
            stmt.execute();
        } catch (SQLException ex) {
            System.err.println("Falha na atualização.");
            System.err.println(ex);
            return false;
        }
        return true;
    }

    public boolean remover(Comprador parametros) {
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

    protected Comprador fromResultsetToObject(ResultSet rs) {
        Comprador obj = new Comprador();
        try {
            obj.setId(rs.getInt("id"));
            obj.setNomeUsuario(rs.getString("nome_usuario"));
            obj.setSenha(rs.getString("senha"));
        } catch (SQLException e) {
            Logger.getLogger(CompradorDao.class.getName()).log(Level.SEVERE, null, e);
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
