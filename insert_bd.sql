INSERT INTO UTILISATEURS VALUES ('TomDu44', 'Gentereau', 'Tom', 'tgentereau@yahoo.com', '0215568457','rue des baobabs','85140','Potatoville','tom44',400, 0);
INSERT INTO UTILISATEURS VALUES ('JeanneLaBg', 'Bonbeurre', 'Jeanne', 'jbonbeurre@ygmail.com', '0285749654','allée des gens heureux','75420','Babouinland','jeannette',2500, 0);
INSERT INTO UTILISATEURS VALUES ('Totoche', 'Charlier', 'Christophe', 'ccharlier@yahoo.com', '068754842','rue tabaga','13540','Taratata','tom44',400, 0);

INSERT INTO CATEGORIES VALUES ('Jouets');
INSERT INTO CATEGORIES VALUES ('Véhicules');
INSERT INTO CATEGORIES VALUES ('Vêtements');
INSERT INTO CATEGORIES VALUES ('Meubles');
INSERT INTO CATEGORIES VALUES ('Autres');

INSERT INTO ARTICLES_VENDUS VALUES ('Trottinette qui va vite','Super trot de 2015 en moyen état qui va encore méga viiiite !!', '19/05/2023','26/05/2023',300,150,2,1);
INSERT INTO ARTICLES_VENDUS VALUES ('Barbie en mode sexy','Ma super barbie troo kawai UwU toute rose et mignonne que j ai depuis 6ans', '19/05/2023','01/06/2023',25,5,2,1);
INSERT INTO ARTICLES_VENDUS VALUES ('Comode', 'Je vends la commode de ma belle mère (une femme pas très commode cependant) bon état et un peu poussiéreuse (tout autant que ma belle mère cette fois ci)','16/05/2023','15/06/2023',400,105,3,4);
INSERT INTO ARTICLES_VENDUS VAlUES ('Pull en laine Hulk','Mon pull térifiant Hulk, ca donne trop de charisme pour draguer des minettes','03/06/2023','15/06/2023',25,8,1,2)
INSERT INTO ARTICLES_VENDUS VAlUES ('Pull en laine Cars Rouge','Mon pull trop cool de Cars, Edition spécial super boost acheté a DisneyLand Paris','06/05/2023','17/05/2023',30,5,1,2)

INSERT INTO RETRAITS VALUES (1,'rue de la tartinade','69140', 'Lyon');
INSERT INTO RETRAITS VALUES (2,'rue de la tartinade','69140', 'Lyon');
INSERT INTO RETRAITS VALUES (3,'rue de la moissonerie','50470', 'Cherbourg');
INSERT INTO RETRAITS VALUES (4,'rue des baobabs','05140', 'Potatoville');
INSERT INTO RETRAITS VALUES (5,'rue des baobabs','5140', 'Potatoville');

INSERT INTO ENCHERES VALUES (CONVERT(datetime, '2023-05-22 10:34:23', 120), 175,1,3);
INSERT INTO ENCHERES VALUES (CONVERT(datetime, '2023-05-22 19:38:59', 120) ,185,1,3);
INSERT INTO ENCHERES VALUES (CONVERT(datetime, '2023-05-12 18:47:31', 120) ,5,4,2);