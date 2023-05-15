package fr.eni.trocenchere.dal.jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import fr.eni.trocenchere.dal.Settings;

public class JdbcTools {
	private static String url;
	private static String login;
	private static String mdp;

	static {
		url = Settings.getProperty("url");
		login = Settings.getProperty("login");
		mdp = Settings.getProperty("password");
	}

	public static Connection getConnection() throws SQLException {
		return DriverManager.getConnection(url, login, mdp);
	}
}
