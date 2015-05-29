/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dsw.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author Administrador
 */
public class DataSource {

    private Connection con;

    public DataSource(String bd) {
        String url, user, pass;
        url = "jdbc:mysql://localhost:3306/" + bd;
        user = "root";
        pass = "root";
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection(url, user, pass);
        }catch (SQLException e) {
            System.err.println("Falha na Conexao com o BD");
            System.err.println(e);
            System.exit(1);
        } 
        catch (ClassNotFoundException e) {
            System.err.println("Erro de driver");
            System.err.println(e);
            System.exit(1);
        }
    }

    public Connection getCon() {
        return con;
    }
}
