package fr.eni.trocenchere.bo;

import java.util.regex.Pattern;

public class Utilisateur {
	private int noUtilisateur;
	private String pseudo;
	private String nom;
	private String prenom;
	private String email;
	private String telephone;
	private String rue;
	private String codePostal;
	private String ville;
	private String motDePasse;
	private int credit;
	private boolean administrateur;
	private boolean actif;
	
	public StringBuilder isValid() 
	{ 
		StringBuilder errors = new StringBuilder(); 
		if(!Pattern.matches("[A-Za-z0-9]+", pseudo)) 
		{ 
			errors.append("Le pseudo doit être composé de chiffres et de lettres.<br />"); 
		}
		
		if(nom.trim().length() < 3 ) 
		{ 
			errors.append("Le nom est trop court.<br />"); 
		}
		if(nom.trim().length() > 30) 
		{ 
			errors.append("Le nom est trop long.<br />"); 
		}
		if(prenom.trim().length() < 3) 
		{ 
			errors.append("Le prénom est trop court.<br />"); 
		}
		if(prenom.trim().length() > 30) 
		{ 
			errors.append("Le prénom est trop long.<br />"); 
		}
		if(!Pattern.matches("([0-9]){10}", telephone)) 
		{ 
			errors.append("Format téléphone : 0606060606.<br />"); 
		}
		
		if(!Pattern.matches("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$", email)) 
		{ 
			errors.append("Format email : jeanne@hotmail.fr.<br />"); 
		}
		if(email.length() > 50) 
		{ 
			errors.append("Le mail est trop long.<br />"); 
		}
		if(rue.trim().length() < 3) 
		{ 
			errors.append("Le nom de la rue est trop court.<br />"); 
		}
		if(ville.trim().length() > 30) 
		{ 
			errors.append("Le nom de la rue est trop long.<br />"); 
		}
		if(!Pattern.matches("([0-9]){5}", codePostal)) 
		{ 
			errors.append("Le code postal doit être composé de 5 chiffres.<br />"); 
		}
		
		if(ville.trim().length() < 3) 
		{ 
			errors.append("Le nom de la ville est trop court.<br />"); 
		}
		if(ville.trim().length() > 30) 
		{ 
			errors.append("Le nom de la ville est trop long.<br />"); 
		}
		if(motDePasse.trim().length() < 3) 
		{ 
			errors.append("Le mot de passe est trop court.<br />"); 
		}
		if(motDePasse.trim().length() > 30) 
		{ 
			errors.append("Le mot de passe est trop long.<br />"); 
		}
		
		
		return errors; 
	}

	
	public Utilisateur(int noUtilisateur, String pseudo, String nom, String prenom, String email, String telephone,
			String rue, String codePostal, String ville, int credit, boolean administrateur, boolean actif) {
		super();
		this.noUtilisateur = noUtilisateur;
		this.pseudo = pseudo;
		this.nom = nom;
		this.prenom = prenom;
		this.email = email;
		this.telephone = telephone;
		this.rue = rue;
		this.codePostal = codePostal;
		this.ville = ville;
		this.credit = credit;
		this.administrateur = administrateur;
		this.actif = actif;
	}

	/*modèle utilisé pour la suppression d'utilisateur*/
	public Utilisateur( int noUtilisateur, String mdp) {
		this.noUtilisateur = noUtilisateur;
		this.motDePasse = mdp;
	}

	/*modèle utilisé pour la creation d'utilisateur*/
	public Utilisateur( String pseudo, String nom, String prenom, String email, String telephone,
			String rue, String codePostal, String ville, String mdp) {
		this.pseudo = pseudo;
		this.nom = nom;
		this.prenom = prenom;
		this.email = email;
		this.telephone = telephone;
		this.rue = rue;
		this.codePostal = codePostal;
		this.ville = ville;
		this.credit = 100;
		this.administrateur = false;
		this.motDePasse = mdp;
	}

	public Utilisateur( String pseudo, String nom, String prenom, String email, String telephone,
			String rue, String codePostal, String ville, int credit, boolean administrateur) {
		this.pseudo = pseudo;
		this.nom = nom;
		this.prenom = prenom;
		this.email = email;
		this.telephone = telephone;
		this.rue = rue;
		this.codePostal = codePostal;
		this.ville = ville;
		this.credit = credit;
		this.administrateur = administrateur;
	}
	
	/*modèle utilisé pour le login d'utilisateur*/
	public Utilisateur(int noUtilisateur, String pseudo, String nom, String prenom, String email, String telephone,
			String rue, String codePostal, String ville, int credit, boolean administrateur) {
		this(pseudo, nom, prenom, email, telephone, rue, codePostal, ville, credit, administrateur);
		this.noUtilisateur = noUtilisateur;
	}

	
	public Utilisateur(int noUtilisateur) {
		this.noUtilisateur = noUtilisateur;
	}
	


	/*modèle utilisé pour la mise à jour d'utilisateur*/
	public Utilisateur(int noUtilisateur, String pseudo, String nom, String prenom, String email, String telephone,
			String rue, String codePostal, String ville, String motDePasse) {
		this.noUtilisateur = noUtilisateur;
		this.pseudo = pseudo;
		this.nom = nom;
		this.prenom = prenom;
		this.email = email;
		this.telephone = telephone;
		this.rue = rue;
		this.codePostal = codePostal;
		this.ville = ville;
		this.motDePasse = motDePasse;
	}

	/*modèle utilisé pour get un utilisateur*/
	public Utilisateur(int noUtilisateur, String pseudo, String nom, String prenom, String email, String telephone,
			String rue, String codePostal, String ville, String motDePasse, int credit, boolean administrateur, boolean actif) {
		this(noUtilisateur, pseudo, nom, prenom, email,  telephone,rue, codePostal, ville, motDePasse);
		this.credit = credit;
		this.administrateur = administrateur;
		this.actif = actif;
	}


	public boolean isActif() {
		return actif;
	}


	public void setActif(boolean actif) {
		this.actif = actif;
	}


	public int getNoUtilisateur() {
		return noUtilisateur;
	}
	public void setNoUtilisateur(int noUtilisateur) {
		this.noUtilisateur = noUtilisateur;
	}
	public String getPseudo() {
		return pseudo;
	}
	public void setPseudo(String pseudo) {
		this.pseudo = pseudo;
	}
	public String getNom() {
		return nom;
	}
	public void setNom(String nom) {
		this.nom = nom;
	}
	public String getPrenom() {
		return prenom;
	}
	public void setPrenom(String prenom) {
		this.prenom = prenom;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getTelephone() {
		return telephone;
	}
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	public String getRue() {
		return rue;
	}
	public void setRue(String rue) {
		this.rue = rue;
	}
	public String getCodePostal() {
		return codePostal;
	}
	public void setCodePostal(String codePostal) {
		this.codePostal = codePostal;
	}
	public String getVille() {
		return ville;
	}
	public void setVille(String ville) {
		this.ville = ville;
	}
	public String getMotDePasse() {
		return motDePasse;
	}
	public void setMotDePasse(String motDePasse) {
		this.motDePasse = motDePasse;
	}
	public int getCredit() {
		return credit;
	}
	public void setCredit(int credit) {
		this.credit = credit;
	}
	public boolean isAdministrateur() {
		return administrateur;
	}
	public void setAdministrateur(boolean administrateur) {
		this.administrateur = administrateur;
	}

	@Override
	public String toString() {
		return "Utilisateur [noUtilisateur=" + noUtilisateur + ", pseudo=" + pseudo + ", nom=" + nom + ", prenom="
				+ prenom + ", email=" + email + ", telephone=" + telephone + ", rue=" + rue + ", codePostal="
				+ codePostal + ", ville=" + ville + ", motDePasse=" + motDePasse + ", credit=" + credit
				+ ", administrateur=" + administrateur + "]";
	}

}