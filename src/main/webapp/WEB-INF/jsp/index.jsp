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
                    <div class="card">
                        <img class="card-img-top" src="https://picsum.photos/200/300" alt="Card image cap">
                        <div class="card-body">
                            <h5 class="card-title">Card title</h5>
                            <p class="card-text">Some quick example text to build on the card title and make
                                up the bulk of the card's content.</p>
                        </div>
                        <ul class="list-group list-group-flush">
                            <li class="list-group-item">Cras justo odio</li>
                            <li class="list-group-item">Dapibus ac facilisis in</li>
                            <li class="list-group-item">Vestibulum at eros</li>
                        </ul>
                        <div class="card-body">
                            <a href="#" class="card-link">Card link</a>
                            <a href="#" class="card-link">Another link</a>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
    </div>
</div>
</body>
</html>