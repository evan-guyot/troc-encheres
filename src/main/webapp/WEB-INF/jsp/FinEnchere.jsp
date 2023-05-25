<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page import="fr.eni.trocenchere.bo.Article" %>
<%@ page import="fr.eni.trocenchere.bo.Categorie" %>
<%@ page import="fr.eni.trocenchere.bo.Enchere" %>
<%@ page import="fr.eni.trocenchere.bo.Utilisateur" %>
<%
    Utilisateur utilisateur = (Utilisateur) request.getAttribute("utilisateur");
Integer idConnectedUser = (int) request.getSession().getAttribute("connectedUserId");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container">
    <div class="row mb-2">
    	<div class="col-5">
            <h1>
                <a class="text-secondary text-decoration-none"
                   href="<%=request.getContextPath() + "/"%>">ENI - Encheres</a>
            </h1>
        </div>
        <div class="col-7">
	        <div class="mt-2 float-right">
	        	 <%
					if (utilisateur.isAdministrateur()) {
				%>
					<a href="PanelAdministration" class="btn btn-warning "
						role="button" aria-pressed="true" style="color:white!important;background-color:orange">Administration</a>
				<%
					}
				%>
				<a class="btn btn-success"  role="button" aria-pressed="true"  href="VendreArticle">Vendre un article</a>
	            <a href="utilisateur?id=<%=idConnectedUser%>" class="btn btn-primary" role="button" aria-pressed="true">
	            	Voir mon profil
	           	</a>
	            <a href="DeconnectionUtilisateur" class=" btn btn-secondary" role="button" aria-pressed="true">
	               Se déconnecter
	            </a>
	        </div>
		</div>
    	<div class="col-12">
    	<% Article article = (Article) request.getAttribute("articleCourrant"); %>
	    <h1 style="text-align: center;">Enchère remporté pour
	        <%
	            if (article.getEnchere() != null) {
	        %>
	
	        <span style="color: blue; font-weight: 500;"><%=article.getEnchere().getMontantEnchere()%></span>
	        Pokédolar par
	        <%=article.getEnchere().getUtilisateur().getPseudo()%>
	
	        <%
	            } else {
	        %>
	        Personne n'a voulu de cette objet
	        <%
	            }
	        %>
	    </h1>
    </div>
        <div class="col-md-8 mx-auto mt-5">
            <div
                    class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
                <div class="col-auto d-none d-lg-block">
                    <img class="tailleImage" src="https://picsum.photos/200/200"
                         alt="Card image cap">
                </div>
                <div class="col p-4 d-flex flex-column position-static">
                    <h3 class="mb-3">
                        Détail de vente pour:
                        <%=article.getNom()%>
                    </h3>

                    <div class="dpf">
                        <div class="bold">Description:</div>
                        <p class="card-text"><%=article.getDescription()%>
                        </p>
                    </div>
                    <div class="dpf">
                        <div class="bold">Catégorie:</div>
                        <p class="card-text"><%=article.getCategorie().getLibelle()%>
                        </p>
                    </div>
                    <div class="dpf">
                        <div class="bold">Meilleure offre:</div>

                        <%
                            if (article.getEnchere() != null) {
                        %>
                        <p class="card-text">
                            <span style="color: blue; font-weight: 500;"><%=article.getEnchere().getMontantEnchere()%></span>
                            Pokédolar par
                            <%=article.getEnchere().getUtilisateur().getPseudo()%>
                        </p>
                        <%
                        } else {
                        %>
                        <p class="card-text">Pas d'enchère faite à cette heure</p>
                        <%
                            }
                        %>

                    </div>
                    <div class="dpf">
                        <div class="bold">Mise à prix:</div>
                        <p class="card-text"><%=article.getMiseAPrix()%>
                        </p>
                    </div>
                    <div class="dpf">
                        <div class="bold">Fin de l'enchère:</div>
                        <p class="card-text"><%=article.getDateFinEnchere()%>
                        </p>
                    </div>
                    <div class="dpf">
                        <div class="bold">Retrait:</div>
                        <p class="card-text"><%=article.getRetrait().getRue()%>
                            <%=article.getRetrait().getCodePostal()%>
                            <%=article.getRetrait().getVille()%>
                        </p>
                    </div>
                    <div class="dpf">
                        <div class="bold">Vendeur:</div>
                        <a
                                href="<%=request.getContextPath() + "/utilisateur?id=" + article.getUtilisateur().getNoUtilisateur()%>">
                            <span><%=article.getUtilisateur().getPseudo()%></span>
                        </a>


                    </div>

                </div>
            </div>
            <a href="/TrocEncheres/" style="margin-left: 25%;" class="btn btn-light w-50">Retour</a>
        </div>
    </div>
</div>
    
</body>
<style>
    .dpf {
        display: flex;
        gap: 10px;
    }

    .grandeDiv {
        display: flex;
        justify-content: center;
        margin: 50px;
    }

    .btnn {
        display: flex;
        flex-direction: row;
        justify-content: space-evenly;
        align-items: center;
        margin-top: 20px;
    }

    .bold {
        font-weight: bold;
    }

    .messageErr {
        font-style: italic;
        color: red;
        font-weight: 800;
    }

    .inputNumber {
        height: 30px;
        width: auto;
    }

    }
</style>
</html>