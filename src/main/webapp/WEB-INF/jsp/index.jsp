<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>ENI - Encheres</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-6">
            <h1>ENI - Encheres</h1>
        </div>
        <div class="col-6">
            <a href="">s'inscrire</a>
            <a href="">se connecter</a>
        </div>
        <div class="col-12">
            <h2 class="text-center">
                Liste des enchères
            </h2>
        </div>
        <div class="col-12">
            <form action="<%=request.getContextPath() + "/"%>" method="POST" class="mt-5">
                <div class="row">
                    <div class="col-12 col-md-6">
                        <div class="form-label">
                            <label for="article">Filtres :</label>
                            <input type="text" name="article" id="article" placeholder="le nom de l'article contient">
                        </div>
                        <div class="form-label">
                            <label for="categorie">Catégories :</label>
                            <select name="categorie" id="categorie">
                                <option value="décoration">décoration</option>
                                <option value="voitures">voitures</option>
                                <option value="location">location</option>
                                <option value="informatique">informatique</option>
                            </select>
                        </div>

                    </div>
                    <div class="col-12 col-md-6">
                        <button class="btn btn-primary" type="submit">Rechercher</button>
                    </div>
                </div>
            </form>
        </div>
        <div class="col-12 col-md-6">
            <ul class="list-unstyled">
                <li>
                    <div class="p-5 border border-dark">
                        <div class="row">
                            <div class="col-12 col-md-4">
                                <img src="https://picsum.photos/200/300" alt="image article"
                                     class="figure-img img-fluid rounded">
                            </div>
                            <div class="col-12 col-md-8">
                                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Consectetur cumque et nisi
                                    optio porro quaerat! Eligendi laboriosam molestias nesciunt odit?</p>
                                <p><span class="font-weight-bold">Prix : </span> Lorem ipsum dolor sit amet,
                                    consectetur.</p>
                                <p><span class="font-weight-bold">Fin de l'enchère : </span> Lorem ipsum dolor sit amet,
                                    consectetur.</p>
                                <p><span class="font-weight-bold">Vendeur : </span> Lorem ipsum dolor sit amet,
                                    consectetur.</p>
                            </div>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
    </div>
</div>
</body>
</html>