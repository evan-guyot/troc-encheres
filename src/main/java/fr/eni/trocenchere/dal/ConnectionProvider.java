package fr.eni.trocenchere.dal;

import java.sql.Connection;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class ConnectionProvider {
    private static Context context;
    private static DataSource datasource;
    private static boolean initialisationOK = true;

    static {
        try {
            context = new InitialContext();
            datasource = (DataSource)context.lookup("java:comp/env/jdbc/pool_cnx");
        } catch (NamingException var1) {
            var1.printStackTrace();
            initialisationOK = false;
        }

    }

    public ConnectionProvider() {
    }

    public static Connection connection() throws Exception {
        if (initialisationOK) {
            return datasource.getConnection();
        } else {
            throw new Exception("Echec de l'initialisation de la connexion JDBC");
        }
    }
}