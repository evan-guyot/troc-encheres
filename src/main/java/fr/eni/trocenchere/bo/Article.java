package fr.eni.trocenchere.bo;

import java.time.LocalDate;

public class Article {
	private int noArticle;
	private String nom;
	private String description;
	private LocalDate dateDebutEnchere;
	private LocalDate dateFinEnchere;
	private int miseAPrix;
	private int prixVente;
	private boolean etatVente;
	private int noCategorie;
	private Utilisateur utilisateur;
	
	public Article(int noArticle, String nom, String description, LocalDate dateDebutEnchere, LocalDate dateFinEnchere,
			int miseAPrix, int prixVente, boolean etatVente, Utilisateur utilisateur, int noCategorie) {
		this.noArticle = noArticle;
		this.nom = nom;
		this.description = description;
		this.dateDebutEnchere = dateDebutEnchere;
		this.dateFinEnchere = dateFinEnchere;
		this.miseAPrix = miseAPrix;
		this.prixVente = prixVente;
		this.etatVente = etatVente;
		this.utilisateur = utilisateur;
	}
	
	public int getNoCategorie() {
		return noCategorie;
	}

	public void setNoCategorie(int noCategorie) {
		this.noCategorie = noCategorie;
	}

	public Utilisateur getUtilisateur() {
		return utilisateur;
	}

	public void setUtilisateur(Utilisateur utilisateur) {
		this.utilisateur = utilisateur;
	}
	
	public int getNoArticle() {
		return noArticle;
	}
	public void setNoArticle(int noArticle) {
		this.noArticle = noArticle;
	}
	public String getNom() {
		return nom;
	}
	public void setNom(String nom) {
		this.nom = nom;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public LocalDate getDateDebutEnchere() {
		return dateDebutEnchere;
	}
	public void setDateDebutEnchere(LocalDate dateDebutEnchere) {
		this.dateDebutEnchere = dateDebutEnchere;
	}
	public LocalDate getDateFinEnchere() {
		return dateFinEnchere;
	}
	public void setDateFinEnchere(LocalDate dateFinEnchere) {
		this.dateFinEnchere = dateFinEnchere;
	}
	public int getMiseAPrix() {
		return miseAPrix;
	}
	public void setMiseAPrix(int miseAPrix) {
		this.miseAPrix = miseAPrix;
	}
	public int getPrixVente() {
		return prixVente;
	}
	public void setPrixVente(int prixVente) {
		this.prixVente = prixVente;
	}
	public boolean isEtatVente() {
		return etatVente;
	}
	public void setEtatVente(boolean etatVente) {
		this.etatVente = etatVente;
	}
}
