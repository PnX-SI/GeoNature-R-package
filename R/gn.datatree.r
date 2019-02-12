#' gn.datatree
#'
#' Cette fonctin permet de visualiser les éléments de la base de donnée accessible pour réaliser une requête.
#'
#' @param setupDB contient une liste des différents paramètres avec les éléments suivants:
#'
#'  dbname= nom de la base,
#'  host= hôte,
#'  port= port,
#'  name= utilisateur et
#'  password= mot de passe.
#'
#' @return un plot interactif permettant de visualiser dans la structure de la base.
#' @usage datatree(setupDB)
#'
#'
#' @author Rémy Moine <remymoine95@gmail.com>
#' @export

gn.datatree<-function(setupDB){

  con <- DBI::dbConnect(DBI::dbDriver("PostgreSQL"), dbname = setupDB$dbname,
                 host = setupDB$host, port = setupDB$port,
                 user=setupDB$user, password=setupDB$password)

# extraction des informations sur la base de données
organisation<-DBI::dbGetQuery(con, "SELECT  * FROM  information_schema.column_privileges;")

invisible(DBI::dbDisconnect(con))

sel<-which(organisation$grantee==setupDB$user)

plot<-collapsibleTree::collapsibleTree(organisation[sel,c(4:6)],
                width = 1800,height=1000,
                hierarchy = c("table_schema",
                              "table_name",
                              "column_name"),
                fill="blue",
                root=setupDB$dbname)
plot
}

