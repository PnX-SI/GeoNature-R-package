#' gn_dbextract
#'
#' Permet d'extraire des données d'une base de données géonature en se basant sur le nom de la base de données seule, les identifiants et un fichier texte fourni.
#'
#' @param nomdb nom de la base deonnée
#' @param id identifiant d'accès
#' @param pw mot de passe
#' @param req la requête à ftraiter sous forme d'un vecteur type "character".
#'
#' @return  un data.frame (tableau de données) contenant les résultats de la requête fournit en entrée
#'
#'
#' @author Remy Moine <remymoine95@gmail.com>
#' @export
#'
#'


gn_dbextract<-function(nomdb,id,pw,req){

  #nomdb="geonaturedb"
  #req=c("SELECT s.cd_nom,
  #         s.dateobs,
  #         s.id_organisme,
  #         s.effectif_total,
  #         st_x(st_transform(s.the_geom_point, 2154))::integer AS x,
  #         st_y(st_transform(s.the_geom_point, 2154))::integer AS y
  #         FROM synthese.syntheseff s
  #         WHERE cd_nom=459629 AND dateobs>='2009-01-01' AND dateobs<='2018-12-31'")

  utils::data("gn_dbnames")

  sel<-which(gn_dbnames$nom==nomdb)

  con <- RPostgreSQL::dbConnect(dbname = as.character(gn_dbnames$nom[sel]),
                   host = as.character(gn_dbnames$host[sel]) , port = as.character(gn_dbnames$port[sel]),
                   drv = as.character(gn_dbnames$driver[sel]),
                   user = as.character(id), password = as.character(pw))
  data<-DBI::dbGetQuery(con,req)
  cache<-RPostgreSQL::dbDisconnect(con)

  format(con)

  data
}
