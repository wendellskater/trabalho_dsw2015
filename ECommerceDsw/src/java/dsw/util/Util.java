/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dsw.util;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Types;
import java.util.Date;

/**
 *
 * @author Marcelo
 */
public class Util {

    public static String getBoxedString(String parametro) {
        return (parametro != null && !parametro.trim().isEmpty()) ? parametro : null;
    }

    public static Integer getBoxedInteger(int parametro) {
        return parametro > 0 ? parametro : null;
    }

    public static Double getBoxedDouble(double parametro) {
        return parametro > 0 ? parametro : null;
    }

    public static java.sql.Date fromJavaDateToSqlDate(java.util.Date jDate) {
        java.sql.Date sDate = null;
        if (jDate != null) {
            sDate = new java.sql.Date(jDate.getTime());
        }
        return sDate;
    }

    public static void setInt(PreparedStatement stmt, int i, int valor) throws SQLException {
        if (getBoxedInteger(valor) == null) {
            stmt.setNull(i, Types.NULL);
        } else {
            stmt.setInt(i, valor);
        }
    }

    public static void setDate(PreparedStatement stmt, int i, Date valor) throws SQLException {
        if (valor == null) {
            stmt.setNull(i, Types.NULL);
        } else {
            stmt.setDate(i, fromJavaDateToSqlDate(valor));
        }
    }

    public static void setDouble(PreparedStatement stmt, int i, double valor) throws SQLException {
        if (getBoxedDouble(valor) == null) {
            stmt.setNull(i, Types.NULL);
        } else {
            stmt.setDouble(i, valor);
        }
    }

    public static void setString(PreparedStatement stmt, int i, String valor) throws SQLException {
        if (getBoxedString(valor) != null) {
            stmt.setString(i, getBoxedString(valor));
        } else {
            stmt.setNull(i, Types.NULL);
        }
    }

}
