<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page import="fr.eni.trocenchere.bo.Article" %>
<%@ page import="fr.eni.trocenchere.bo.Categorie" %>
<%@ page import="fr.eni.trocenchere.bo.Enchere" %>
<%@ page import="fr.eni.trocenchere.bo.Utilisateur" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="article" scope="page" value="${articleCourrant}"/>
<c:set var="connectedUserId" scope="page" value="${connectedUserId}"/>
<%
Utilisateur utilisateur = (Utilisateur) request.getAttribute("utilisateur");
Integer idConnectedUser = (int) request.getSession().getAttribute("connectedUserId");
Article article = (Article) request.getAttribute("articleCourrant");
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
	            <a href="<c:out value="utilisateur?id=${connectedUserId}" />" class="btn btn-primary" role="button" aria-pressed="true">
	            	Voir mon profil
	           	</a>
	            <a href="DeconnectionUtilisateur" class=" btn btn-secondary" role="button" aria-pressed="true">
	               Se déconnecter
	            </a>
	        </div>
		</div>
    	<div class="col-12">
	    <h1 style="text-align: center;">Enchère remporté pour
            <c:choose>
                <c:when test="${article.getEnchere() != null}">
                    <span style="color: blue; font-weight: 500;">
                        <c:out value="${article.getEnchere().getMontantEnchere()}" />
                    </span>
                    Pokédolar par
                    <c:out value="${article.getEnchere().getUtilisateur().getPseudo()}" />
                </c:when>
                <c:otherwise>
                    Personne n'a voulu de cette objet
                </c:otherwise>
            </c:choose>
	    </h1>
    </div>
        <div class="col-md-8 mx-auto mt-5">
            <div class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
                <div class="col-auto d-none d-lg-block">
                    <img class="tailleImage" src="https://picsum.photos/200/200"
                         alt="Card image cap">
                </div>
                <div class="col py-4 d-flex flex-column position-static">
                    <h3 class="mb-3">
                        Détail de vente pour : <c:out value="${article.getNom()}" />
                    </h3>
                    <div class="dpf">
                        <div class="bold">Description:</div>
                        <p class="card-text"><c:out value="${article.getDescription()}" /></p>
                    </div>
                    <div class="dpf">
                        <div class="bold">Catégorie:</div>
                        <p class="card-text"><c:out value="${article.getCategorie().getLibelle()}" /></p>
                    </div>
                    <div class="dpf">
                        <div class="bold">Meilleure offre:</div>
                        <c:choose>
                            <c:when test="${article.getEnchere() != null}">
                                <p class="card-text">
									<span style="color: blue; font-weight: 500;">
										<c:out value="${article.getEnchere().getMontantEnchere()}" />
									</span>
                                    <span>
										Pokédolar par
									</span>
                                    <span>
										<c:out value="${article.getEnchere().getUtilisateur().getPseudo()}" />
									</span>
                                </p>
                            </c:when>
                            <c:otherwise>
                                <p class="card-text">Pas d'enchère faite à cette heure</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="dpf">
                        <div class="bold">Mise à prix:</div>
                        <p class="card-text">
                            <c:out value="${article.getMiseAPrix()}" />
                        </p>
                    </div>
                    <div class="dpf">
                        <div class="bold">Fin de l'enchère:</div>
                        <p class="card-text">
                            <c:out value="${article.getDateFinEnchere()}" />
                        </p>
                    </div>
                    <div class="dpf">
                        <div class="bold">Retrait:</div>
                        <p class="card-text">
                            <c:out value="${article.getRetrait().getRue()}" />
                            <c:out value="${article.getRetrait().getCodePostal()}" />
                            <c:out value="${article.getRetrait().getVille()}" />
                        </p>
                    </div>
                    <div class="dpf">
                        <div class="bold">Vendeur:</div>
                        <a href="<%=request.getContextPath() + "/utilisateur?id=" + article.getUtilisateur().getNoUtilisateur()%>">
							<span>
								<c:out value="${article.getUtilisateur().getPseudo()}" />
							</span>
                        </a>
                    </div>
                </div>
            </div>
            <div class="mx-auto">
            	<form method="post" action="FinEnchere">
            	<input type="hidden" value="<%= article.getNoArticle() %>" name="idArticleForCollecte">
            		<%if(!(Boolean)request.getAttribute("collectee")){ %>
		            <input type="submit" class="btn btn-primary w-25" value=" Retrait article "/>
		            <% } %>
		            <a href="/TrocEncheres/" class="btn btn-light w-25">Retour</a>
	            </form>
            </div>
           
        </div>
    </div>
</div>
    
</body>
<style>
    .dpf {
        display: flex;
        gap: 10px;
    }

    .bold {
        font-weight: bold;
    }
</style>
</html>