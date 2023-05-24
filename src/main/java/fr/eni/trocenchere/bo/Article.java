package fr.eni.trocenchere.bo;

import java.time.LocalDate;
import java.util.regex.Pattern;

public class Article {
	private int noArticle;
	private String nom;
	private String description;
	private LocalDate dateDebutEnchere;
	private LocalDate dateFinEnchere;
	private int miseAPrix;
	private int prixVente;
	private boolean etatVente;
	private Categorie categorie;
	private Utilisateur utilisateur;
	private Enchere enchere;
	private Retrait retrait;

	
	
	
	
	public Article(int noArticle, String nom, String description, LocalDate dateDebutEnchere, LocalDate dateFinEnchere,
			int miseAPrix, int prixVente, boolean etatVente) {
		super();
		this.noArticle = noArticle;
		this.nom = nom;
		this.description = description;
		this.dateDebutEnchere = dateDebutEnchere;
		this.dateFinEnchere = dateFinEnchere;
		this.miseAPrix = miseAPrix;
		this.prixVente = prixVente;
		this.etatVente = etatVente;
	}

	public Article(String nom, String description, LocalDate dateDebutEnchere, LocalDate dateFinEnchere,
			int miseAPrix, int prixVente, boolean etatVente, Utilisateur utilisateur, Categorie categorie, Enchere enchere, Retrait retrait) {
		this.nom = nom;
		this.description = description;
		this.dateDebutEnchere = dateDebutEnchere;
		this.dateFinEnchere = dateFinEnchere;
		this.miseAPrix = miseAPrix;
		this.prixVente = prixVente;
		this.etatVente = etatVente;
		this.utilisateur = utilisateur;
		this.categorie = categorie;
		this.enchere = enchere;
		this.retrait = retrait;
	}
	
	public Article(int noArticle, String nom, String description, LocalDate dateDebutEnchere, LocalDate dateFinEnchere,
			int miseAPrix, int prixVente, boolean etatVente, Utilisateur utilisateur, Categorie categorie, Enchere enchere, Retrait retrait) {
		this.noArticle = noArticle;
		this.nom = nom;
		this.description = description;
		this.dateDebutEnchere = dateDebutEnchere;
		this.dateFinEnchere = dateFinEnchere;
		this.miseAPrix = miseAPrix;
		this.prixVente = prixVente;
		this.etatVente = etatVente;
		this.utilisateur = utilisateur;
		this.categorie = categorie;
		this.enchere = enchere;
		this.retrait = retrait;
	}
	
	public Categorie getCategorie() {
		return categorie;
	}

	public void setCategorie(Categorie categorie) {
		this.categorie = categorie;
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

	public Enchere getEnchere() {
		return enchere;
	}

	public void setEnchere(Enchere enchere) {
		this.enchere = enchere;
	}

	public Retrait getRetrait() {
		return retrait;
	}

	public void setRetrait(Retrait retrait) {
		this.retrait = retrait;
	}

	public StringBuilder isValid() {
		StringBuilder errors = new StringBuilder();

		if(nom.trim().length() < 3) {
			errors.append("Le nom de votre article doit être plus long! Soyez plus précis.<br />");
		}
		if(nom.length() > 29) {
			errors.append("Le nom de votre article est trop court! Vous êtes un peu trop bavard.<br />");
		}
		if(description.trim().length() < 10) {
			errors.append("Votre description est trop courte! Ne gardez pas votre langue dans votre poche.<br />");
		}	
		if(description.length() > 299) {
			errors.append("Votre description est trop longue! Vous êtes bavard commme une mouette ma parole.<br />");
		}		
		if(miseAPrix < 1) {
			errors.append("Votre mise à prix doit être au minimum égale à 1 P$! Demandez plus de flouz.<br />");
		}
		if(dateDebutEnchere.isBefore(LocalDate.now())) {
			errors.append("Les enchères ne peuvent pas commencer avant aujourd'hui! Ne vivez pas dans le passé.<br />");			
		}
		if(dateFinEnchere.isBefore(LocalDate.now())) {
			errors.append("Les enchères ne peuvent pas se terminer avant aujourd'hui! Projetez vous plus dans le futur.<br />");			
		}
		if(dateDebutEnchere.isAfter(dateDebutEnchere)) {
			errors.append("La date de début des enchères ne peut pas être supérieur à celle de fin! C'est le serpant qui se mort la queue mon cher.<br />");			
		}
		if(retrait.getRue().trim().length() < 3 ) {
			errors.append("Préciser le type/nom de rue du retrait! On va pas vendre vos données à la russie quand même. <br />");
		}
		if(!Pattern.matches("[0-9]{5}", retrait.getCodePostal().trim())) {
			errors.append("Le code postal est incorrect! En CINQ chiffres.<br />");
		}
		if(retrait.getVille().trim().length() < 3 ) {
			errors.append("Préciser le nom de la ville du retrait! Faut bien qu'on le récupère quelque part.<br />");
		}
		
		return errors;	
	}
}
