#' gn.setup
#'
#' Cette fonction permet de configurer la connexion à la base de données de votre instance GeoNature. Cette fonction crée un objet nécessaire au bon fonctionnement de nombreuses autres fonctions du package, et doit être jouée au début de votre session de travail.
#' Si vous supprimez cet objet setupDB, veuillez rejouer la fonction gn.setup() pour reconfigurer la connexion à votre base.

gn.setup <- function () {
	print("Veuillez renseigner le nom de votre base de données GeoNature :")
	dbname<-scan (what="character",nmax=1)

	print("Veuillez renseigner l'hôte de votre base de données GeoNature :")
	host<-scan (what="character",nmax=1)

	print("Veuillez renseigner le port de connexion à votre base de données GeoNature :")
	port<-scan (what="character",nmax=1)

	print("Veuillez renseigner le nom d'utilisateur de votre base de données GeoNature :")
	user<-scan (what="character",nmax=1)

	print("Veuillez renseigner le mot de passe de votre utilisateur :")
	pass<-scan (what="character",nmax=1)

	print("Patientez quelques secondes, nous testons la connexion...")

	connect_test <- try(dbConnect(dbDriver("PostgreSQL"), dbname = dbname,host = host, port = port,user = user, password = pass), silent=T)
 		if(is(connect_test,"try-error")) {print("La connexion à votre base de données GeoNature a échoué")}
  		else {setupDB <<- dbConnect(dbDriver("PostgreSQL"), dbname = dbname,host = host, port = port,user = user, password = pass)
  			print("La connexion à PostgreSQL a bien été configurée. Un objet setupDB a été créé, il sera nécessaire pour les autres fonctions de ce package. Si vous le supprimez, veuillez relancer la fonction gn_setup")
			}
}
