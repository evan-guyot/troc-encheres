package fr.eni.trocenchere.bo;

import java.time.LocalDate;
import java.time.LocalDateTime;

public class Enchere {
	private int noEnchere;
	private LocalDateTime dateEnchere;
	private int montantEnchere;
	private Utilisateur acheteur;
	
	
	public Enchere(int noEnchere, LocalDateTime dateEnchere, int montantEnchere, Utilisateur acheteur) {
		super();
		this.noEnchere = noEnchere;
		this.dateEnchere = dateEnchere;
		this.montantEnchere = montantEnchere;
		this.acheteur = acheteur;
		
	}
	public Enchere(LocalDateTime dateEnchere, int montantEnchere, Utilisateur acheteur) {
		
		
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
	public LocalDateTime getDateEnchere() {
		return dateEnchere;
	}
	public void setDateEnchere(LocalDateTime dateEnchere) {
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
