#De la siguiente dirección donde se muestran los sueldos para Data Scientists

#(https://www.glassdoor.com.mx/Sueldos/data-scientist-sueldo-SRCH_KO0,14.htm), realiza las siguientes acciones:

#Extraer la tabla del HTML

#Quitar los caracteres no necesarios de la columna sueldos (todo lo que no sea número), para dejar solamente la cantidad mensual (Hint: la función gsub podría ser de utilidad)

#Asignar ésta columna como tipo numérico para poder realizar operaciones con ella

#Ahora podrás responder esta pregunta ¿Cuál es la empresa que más paga y la que menos paga?


library(rvest)
# Introducimos una direcciÃ³n URL donde se encuentre una tabla

theurl <- "https://www.glassdoor.com.mx/Sueldos/data-scientist-sueldo-SRCH_KO0,14.htm"
file <- read_html(theurl)    # Leemos el html
class(file)
# Selecciona pedazos dentro del HTML para identificar la tabla

tables <- html_nodes(file, "table") 
tables
# Hay que analizar 'tables' para determinar cual es la posiciÃ³n en la lista 
# que contiene la tabla, en este caso es la no. 4

# Extraemos la tabla de acuerdo a la posiciÃ³n en la lista

table1 <- html_table(tables[1], fill = TRUE)

table <- na.omit(as.data.frame(table1))   # Quitamos NAÂ´s que meten filas extras 
# y convertimos la lista en un data frame para su manipulaciÃ³n con R
table

str(table)  # Vemos la naturaleza de las variables
# Por Ãºltimo realizamos una conversiÃ³n de una columna tipo chr a num, se pueden 
# hacer las conversiones que se requieran
suel<-gsub("[^[:alnum:][:blank:]?]", "", table$Sueldo)
suel
suel<-gsub("mes", "", suel)
suel
suel<-gsub("MXN","",suel)
suel

table$Sueldo<-suel

table

table$Sueldo <- as.numeric(table$Sueldo)
table
str(table)
mxsuel<-which.max(table$Sueldo)
mxsuel
table[mxsuel[1],]

mins<-which.min(table$Sueldo)
table[mins[1],]

#apply(table$sueldo, margin, ...)