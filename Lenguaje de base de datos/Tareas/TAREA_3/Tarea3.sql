/*
Grupo#4
Practica 03
1-Steven Cruz Jimenez
2-Jean Carlos Orozco Mendez
3-Cristofer Andres Marin Lazo
4-Herberth Rojas Arce
*/

/*
1.	Crear un select que liste 
los registros cuyos n�meros de tel�fono inicien con (0 -  5 - 2) y
que finalice en 1 o 8 adem�s que la tercera letra del nombre sea una vocal.
*/
SELECT * FROM EMPLOYEES
WHERE
(SUBSTR(PHONE_NUMBER, 1, 1) IN ('0', '5', '2') OR
    SUBSTR(PHONE_NUMBER, 2, 1) IN ('0', '5', '2') OR
    SUBSTR(PHONE_NUMBER, 3, 1) IN ('0', '5', '2'))
AND (SUBSTR(PHONE_NUMBER, -1) IN ('1', '8'))
AND (SUBSTR(FIRST_NAME, 3, 1) IN ('a', 'e','i','o','u'));

/*
2.	Realice una consulta de
muestre el nombre, el apellido y nombre
de departamento de los empleados cuyo n�mero 
telef�nico consta 12 caracteres (c�digo de pa�s (3),
c�digo de �rea (3), n�mero telefono. (4)) el c�digo de pa�s inicia
con 0 y tiene n�meros impares en la posici�n 2y3 , el c�digo
de �rea solo n�meros impares y el  n�mero de tel�fono debe de
terminar con los n�meros del 1  al 5
*/

SELECT e.FIRST_NAME, e.LAST_NAME, d.DEPARTMENT_NAME
FROM EMPLOYEES e
JOIN DEPARTMENTS d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
WHERE
    LENGTH(e.PHONE_NUMBER) = 12
    AND SUBSTR(e.PHONE_NUMBER, 1, 1) = '0'
    AND TO_NUMBER(SUBSTR(e.PHONE_NUMBER, 2, 1), '999') IN (1, 3, 5, 7, 9)
    AND TO_NUMBER(SUBSTR(e.PHONE_NUMBER, 3, 1), '999') IN (1, 3, 5, 7, 9)
    AND TO_NUMBER(SUBSTR(e.PHONE_NUMBER, 4, 1), '999') IN (1, 3, 5)
    AND TO_NUMBER(SUBSTR(e.PHONE_NUMBER, -1), '999') BETWEEN 1 AND 5;

/*
3.	Dada la siguiente hilera cambie los espacios en blanco por comas,
utilice REGEXP_REPLACE 

 Elizabeth   Bishop   36736-36738   976.063  02/08/1911

*/
SELECT REGEXP_REPLACE('Elizabeth  Bishop 36736-36738  976.063  02/08/1911',
' +', ', '  ) AS hielera_modificada FROM dual;

/*
4.Dada la siguiente hilera, proceda a dejar eliminar los espacios repetidos y 
deje solo un espacio entre palabra y palabra, utilice REGEXP_REPLACE.
      500    Oracle     Parkway,    Redwood  Shores,    CA
*/

SELECT REGEXP_REPLACE('500  ORACLE  Parkway,  Redwood  Shores,  CA', ' +', ' ')
AS hilera_modificada FROM dual;

/*
5.	En la tabla employees por medio de una expresi�n regular separe por medio
de un espacio cada una de las letras de la columna Country_name, utilice 
REGEXP_REPLACE
              Australia  ? A u s t r a l i a
*/

SELECT Country_name,
    REGEXP_REPLACE(Country_name, '([[:alpha:]])', '\1 ', 1, 0) AS 
    SEPARATED_COUNTRY_NAME
FROM COUNTRIES;

/*
6. Desarrolle una consulta que liste los pa�ses por regi�n, los datos que debe
mostrar son: el c�digo de la regi�n y nombre de la regi�n con los nombres 
de sus pa�ses.
*/

SELECT r.region_id AS "C�digo de Regi�n",
       r.region_name  AS "Nombre de Regi�n",
       LISTAGG(c.country_name, ', ')WITHIN GROUP (ORDER BY c.country_name) AS
       "Pa�ses en la Regi�n"
FROM regions r
JOIN countries c ON r.region_id = c.region_id
GROUP BY r.region_id, r.region_name;

/*
7.	Realice una consulta que muestre el c�digo, nombre, apellido, inicio y
fin del historial de trabajo de los empleados.
*/

SELECT e.employee_id AS "C�digo de Empleado",
       e.first_name AS "Nombre",
       e.last_name AS "Apellido",
       jh.start_date AS "Inicio de Trabajo",
       jh.end_date AS "Fin de Trabajo"
FROM EMPLOYEES e
JOIN job_history jh ON e.employee_id = jh.employee_id
JOIN jobs j ON jh.job_id = j.job_id;

/*
8.	Realice una consulta que muestres el c�digo de la regi�n, nombre de
la regi�n y el nombre de los pa�ses que se encuentran en �Asia�.
*/
SELECT r.region_id AS "C�digo de Regi�n",r.region_name AS "Nombre de Regi�n",
LISTAGG(c.country_name, ', ') WITHIN GROUP (ORDER BY c.country_name) AS
"Pa�ses en la Regi�n"      
FROM regions r
JOIN countries c ON r.region_id = c.region_id
WHERE r.region_name = 'Asia'
GROUP BY r.region_id, r.region_name;

/*
9.	Crea un select que presente en pantalla el nombre y apellido del empleado,
el departamento donde trabaja, el salario y utilizando la 
sentencia DECODE escriba el mensaje �Con comisi�n� para los empleados que
tienen comisi�n y �Sin comisi�n� para los que no tienen.
*/
SELECT 
    FIRST_NAME || ' ' || LAST_NAME AS "Nombre y Apellido",
    department_name AS "Departamento",
    salary AS "Salario",
    DECODE(commission_pct, NULL, 'Sin comisi�n', 'Con comisi�n') AS "Comisi�n"
FROM 
    EMPLOYEES
JOIN
    DEPARTMENTS ON EMPLOYEES.department_id = departments.department_id;

