/*
Grupo#4
Practica 02
1-Steven Cruz Jimenez
2-Jean Carlos Orozco Mendez
3-Cristofer Andres Marin Lazo
4-Herberth Rojas Arce
*/


/*
1.	Crear un select que concatene el nombre y el apellido dejando un espacio entre ellos debe de presentar los datos en mayúscula.
*/
--Ejercicio 1
SELECT UPPER(FIRST_NAME || ' ' || LAST_NAME) AS NOMBRE_COMPLETO
FROM EMPLOYEES;

/*
2.	Crear una dirección de correo que contenga las dos primeras letras del  nombre,  las 4 últimas del apellido  la “@” y la extensión 'example.com'
*/
SELECT LOWER(SUBSTR(FIRST_NAME, 1, 2) || SUBSTR(LAST_NAME, -4) || '@example.com') AS DIRECCION_CORREO
FROM EMPLOYEES;

/*
3.	Utilizando la función LENGTH  proceda a encontrar la longitud de cada uno de los apellidos de la tabla de EMPLOYEES.
*/
SELECT LAST_NAME, LENGTH(LAST_NAME) AS LONGITUD_APELLIDO
FROM EMPLOYEES;

/*
4.	Crear un select donde justifique  a la izquierda con el símbolo – (guión), para que la columna devuelva 15 caracteres por registro.
*/
SELECT RPAD(LAST_NAME, 15, '-') AS APELLIDO_JUSTIFICADO
FROM EMPLOYEES;

/*
5.	Crear un select donde justifique  a la derecha con el símbolo – (guión), para que la columna devuelva 15 caracteres por registro.
*/
SELECT LPAD(LAST_NAME, 15, '-') AS APELLIDO_JUSTIFICADO
FROM EMPLOYEES;

/*
6.	Crear un select donde se indique la posición de la letra indicada por el usuario en la columna first_name, se debe de presentar en pantalla además de la columna first_name y last_name.
*/
SELECT FIRST_NAME, LAST_NAME, INSTR(FIRST_NAME, 'a') AS POSICION_LETRA_A
FROM employees;

/*
7.	Crear un select donde cambie todas las letras “a” de los registros first_name y last_name  por la letra X.
*/
SELECT
REPLACE(FIRST_NAME, 'a', 'X') AS first_name_modificado,
REPLACE(LAST_NAME, 'a', 'X') AS last_name_modificado
FROM EMPLOYEES;

/*
8.	Crear un select donde se impriman los apellidos con menos de 5 letras.
*/
SELECT LAST_NAME
FROM EMPLOYEES
WHERE LENGTH(last_name) < 5;

/*
9.	Crear una select donde se redondee la suma del salario con la columna comisión de todos los empleados que tengan comisión.
*/
SELECT ROUND(SUM(SALARY + COMMISSION_PCT), 2) AS suma_salario_comision
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NOT NULL;

/*
10.	Crear una select donde se trunque el cálculo de la antigüedad expresada en meses para los empleados del departamento 80.
*/
SELECT EMPLOYEE_ID, HIRE_DATE,
TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) AS antiguedad_meses
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 80;

/*
11.	Crear un select donde imprima los nombres con vocales al inicio del nombre y en su penúltima letra. (REGEXP_LIKE)
*/
SELECT FIRST_NAME
FROM EMPLOYEES
WHERE 
    REGEXP_LIKE(first_name, '^[aeiouAEIOU]')
    AND REGEXP_LIKE(SUBSTR(FIRST_NAME, -2, 1), '[aeiouAEIOU]')

/*
12.	Crear un select que imprima los apellidos que contengan espacio en cualquier punto de su hilera. (REGEXP_LIKE)
*/
SELECT LAST_NAME
FROM EMPLOYEES
WHERE REGEXP_LIKE(LAST_NAME, ' ');

select * from employees;
/*
13.	Crear un expresión regular que muestre los apellidos que inician con D y que tengan como segunda letra una “a” o una “e” y que además no hayan espacios en blanco en el apellido, use REGEXP_LIKE.
*/
SELECT LAST_NAME
FROM EMPLOYEES
WHERE REGEXP_LIKE(LAST_NAME, '^D[ae][^ ]*$');

/*
14.	Buscar por medio de un select los nombres que tengan una o ninguna una vocal como segunda letra.
*/
SELECT FIRST_NAME
FROM EMPLOYEES
WHERE REGEXP_LIKE(FIRST_NAME, '^[^aeiouAEIOU][aeiouAEIOU]?[^aeiouAEIOU]*$');

/*
15.	Buscar por medio de un select los nombres que tengan una o más vocales como tercera letra.
*/
SELECT FIRST_NAME
FROM EMPLOYEES
WHERE REGEXP_LIKE(FIRST_NAME, '^[^aeiouAEIOU]{2}[aeiouAEIOU]');

/*
16.	Buscar por medio de un select los nombre tengan cero o más vocales como penúltima letra.
*/
SELECT FIRST_NAME 
FROM EMPLOYEES 
WHERE REGEXP_LIKE(SUBSTR(FIRST_NAME, -2, 1), '[aeiouAEIOU]*');

/*
17.	Proceda a crear la siguiente tabla en el esquema HR.

CREATE TABLE tab_caracteres
(
  id_caract     NUMBER,
  caracteres    VARCHAR2(60),
  tipo_caract   VARCHAR2(90))
;

Importar los datos de Oracle  el archivo caracteres.csv en la tabla, según el video del siguiente link: https://www.youtube.com/watch?v=lW7jhgsmpng ( min 2:35) /            https://www.youtube.com/watch?v=XFCaqEn4lsc 
*/

CREATE TABLE tab_caracteres
(
  id_caract     NUMBER,
  caracteres    VARCHAR2(60),
  tipo_caract   VARCHAR2(90)
  )
;

SELECT * FROM TAB_CARACTERES;
/*
18.	Crear un select que busque los registros con solo caracteres numéricos de la tabla tab_caracteres use REGEXP_LIKE 
*/
SELECT CARACTERES
FROM TAB_CARACTERES
WHERE REGEXP_LIKE(CARACTERES, '^[0-9]+$');

/*
19.	Crear un select que busque los registros que solo contengan letras de la tabla tab_caracteres use REGEXP_LIKE
*/
SELECT CARACTERES
FROM TAB_CARACTERES
WHERE REGEXP_LIKE(CARACTERES, '^[[:alpha:]]+$');

/*
20.	Crea un select que busque los registros que contengan alguna vocal repetida al menos 2 veces en la tabla caracteres use REGEXP_LIKE (utilice[]{m,})
*/
SELECT CARACTERES
FROM TAB_CARACTERES
WHERE REGEXP_LIKE(CARACTERES, '([aeiou])\1{1,}', 'i');

/*
21.	Crea un select que busque los registros que contengan al menos 2 espacios y máximo espacios en la tabla caracteres use REGEXP_LIKE(utilice {m,})
*/
SELECT *
FROM tab_caracteres
WHERE REGEXP_LIKE(caracteres, '(\s.*){2,}');

/*
22.	Crea un select que busque los registros que estén separados por un punto en la tabla caracteres use REGEXP_LIKE  
*/
SELECT *
FROM tab_caracteres
WHERE REGEXP_LIKE(caracteres, '\.');

/*
23.	Crear una expresión regular que valide que el dato que se evalué sea un numero entero, positivo y no tenga decimales, el separador de decimales puede ser un punto o una coma, utilice REGEXP_LIKE. 
*/
SELECT *
FROM tab_caracteres
WHERE REGEXP_LIKE(caracteres, '^[0-9]+([.,][0-9]*)?$');

/*
24.	Crear una expresión regular que busque tres dígitos consecutivos en una 
palabra en la tabla de caracteres utilice REGEXP_LIKE. (utilice []{m,})
*/
SELECT * FROM TAB_CARACTERES WHERE REGEXP_LIKE(caracteres, '[0-9]{3}');

/*
25.	Crear una expresión regular que busque tres dígitos consecutivos al inicio
en la tabla de caracteres utilice REGEXP_LIKE.. (utilice []{m,})
*/
SELECT * FROM Tab_caracteres WHERE REGEXP_LIKE(caracteres,'^[0-9]{3}');

/*
26.Llenar en la columna "Salida" un ejemplo del conjunto de literales que 
cumpla con la cadena de metacaracteres de la expresión regular.
1--Ra.a
Salida: "Rata"

2--Ar+
Salida: "Arrr"

3--Bar*
Salida: "BA", "BAR"

4--Fi[r|l|s]
Salida: "Fir", "FIS"

5--C[air]
Salida: "Car", "Cai" 

6--12[5-8]
Salida: "125", "120"

7--9[397]
Salida:  "973", "930"

8--R[^aiu]
Salida:  "Re", "Ro"

9--^EL
Salida:  "ELprimer ejemplo", "ELdocumento"

10--os$
Salida:  "973", "930"

11--[r|s]a$
Salida:  "archivos", "objetos"

12--^[7-9]
Salida:  "7amigos", "99luces"


13--^B[^u|o
Salida:  "Banana", "Billete"

*/
