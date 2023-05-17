package fr.eni.trocenchere.bo;

import java.time.LocalDate;

public class Enchere {
	private int noEnchere;
	private LocalDate dateEnchere;
	private int montantEnchere;
	private Utilisateur acheteur;
	
	
	public Enchere(int noEnchere, LocalDate dateEnchere, int montantEnchere, Utilisateur acheteur) {
		super();
		this.noEnchere = noEnchere;
		this.dateEnchere = dateEnchere;
		this.montantEnchere = montantEnchere;
		this.acheteur = acheteur;
		
	}
	
	public int getNoEnchere() {
		return noEnchere;
	}
	public void setNoEnchere(int noEnchere) {
		this.noEnchere = noEnchere;
	}
	public LocalDate getDateEnchere() {
		return dateEnchere;
	}
	public void setDateEnchere(LocalDate dateEnchere) {
		this.dateEnchere = dateEnchere;
	}
	public int getMontantEnchere() {
		return montantEnchere;
	}
	public void setMontantEnchere(int montantEnchere) {
		this.montantEnchere = montantEnchere;
	}
	public Utilisateur getUtilisateur() {
		return acheteur;
	}
	public void setUtilisateur(Utilisateur utilisateur) {
		this.acheteur = utilisateur;
	}
	
	
	
}
