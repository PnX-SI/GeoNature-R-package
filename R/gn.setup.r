#' gn.setup
#'
#' Cette fonction permet de configurer la connexion à la base de données de votre instance GeoNature. Elle crée un objet nécessaire au bon fonctionnement de nombreuses autres fonctions du package, et doit être jouée au début de votre session de travail.
#' Si vous supprimez cet objet setupDB, veuillez rejouer la fonction gn.setup() pour reconfigurer la connexion à votre base.
#'
#' @param dbname nom de la base de données
#' @param host nom de l'hôte de votre base de données
#' @param port port de connexion à votre base de données 
#' @param user nom de l'utilisateur pour se connecter à votre base de données.
#'
#' @return  un object setupDB permettant aux autres fonctions du package d'établir une connexion à votre base de données GeoNature
#'
#'
#' @author Donovan Maillard <donovan.maillard@gmail.com>
#' @export
#'
#'


gn.setup <- function (dbname,host,port,user) 
	{
		if(hasArg(dbname)==FALSE) 
			{
			print("Veuillez renseigner le nom de votre base de données GeoNature :")
			dbname<-scan (what="character",nmax=1, quiet=T)
			}
		else {}
	
		if(hasArg(host)==FALSE) 
			{
			print("Veuillez renseigner l'hôte de votre base de données GeoNature :")
			host<-scan (what="character",nmax=1, quiet=T)
			}
		else {}

		if(hasArg(port)==FALSE)
			{
			print("Veuillez renseigner le port de connexion à votre base de données GeoNature :")
			port<-scan (what="integer",nmax=1,quiet=T)
			}
		else {}

		if(hasArg(user)==FALSE)
			{
			print("Veuillez renseigner le nom d'utilisateur de votre base de données GeoNature :")
			user<-scan (what="character",nmax=1,quiet=T)
			}
		else {}

	print("Veuillez renseigner le mot de passe de votre utilisateur :")
	pass<-scan (what="character",nmax=1,quiet=T)

	print("Patientez quelques secondes, nous testons la connexion...")

	connect_test <- try(dbConnect(dbDriver("PostgreSQL"), dbname = dbname,host = host, port = port,user = user, password = pass), silent=T)
 		if(is(connect_test,"try-error")) {print("La connexion à votre base de données GeoNature a échoué")}
  		else {setupDB <<- dbConnect(dbDriver("PostgreSQL"), dbname = dbname,host = host, port = port,user = user, password = pass)
  			print("La connexion à PostgreSQL a bien été configurée. Un objet setupDB a été créé, il sera nécessaire pour les autres fonctions de ce package. Si vous le supprimez, veuillez relancer la fonction gn_setup")
			}
}
