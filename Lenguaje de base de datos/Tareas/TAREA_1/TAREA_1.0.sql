/*Grupo#4
1-Steven Cruz Jimenez
2-Jean Carlos Orozco Mendez
3-Cristofer Andres Marin Lazo
4-Herberth Rojas Arce




1.	Crear un tabla  TEST de dos columnas 
( Nombre varchar2(80), puesto varchar2(10))
*/

--EJERCICIO 1:
CREATE TABLE TAB_TEST(
    NOMBRE VARCHAR2(80),
    PUESTO VARCHAR2(10)
    );
COMMIT;

/*
2.	Hacer la inserción de 2 registros a la tabla creada
*/
--EJERCICIO 2:
INSERT INTO TAB_TEST (Nombre,Puesto) VALUES ('Test1','Puesto1');
INSERT INTO TAB_TEST (Nombre, Puesto) VALUES ('Test2','Puesto2');
COMMIT
/*
3.	Hacer la inserción de los todos los  
registros concatenados de la tabla employees en la tabla test.
*/
--EJERCICIO 3:
INSERT INTO tab_test(NOMBRE, PUESTO)
SELECT first_name || ' ' || last_name, 'PUESTO'
FROM EMPLOYEES;
SELECT * FROM TAB_TEST;
COMMIT
/*
4.	Modificar la tabla creada 
añadiendo una columna(nombre de departamento varchar 2(20))
*/
--EJERCICIO 4:
ALTER TABLE tab_test ADD NOMBRE_DEPARTAMENTO VARCHAR2(20);
COMMIT
/*
5.	Crear una tabla test1 basado 
en un select de la tabla de empleados, escoja las columnas que guste.
*/
--EJERCICIO 5:
CREATE TABLE Tab_TEST1 AS (SELECT FIRST_NAME, LAST_NAME, EMAIL,PHONE_NUMBER
FROM EMPLOYEES);
SELECT * FROM TAB_TEST1;
COMMIT
/*
6.	Crear una selección del nombre utilizando
la cláusula de distinct en la tabla de employees esquema HR.
*/
--EJERCICIO 6:
SELECT DISTINCT first_name, last_name FROM EMPLOYEES;
COMMIT
SELECT * FROM EMPLOYEES;
/*
7.	Hacer un update a un registro 
subiendo el salario en un 10% a los empleados que no tienen comisión
*/
--EJERCICIO 7:
UPDATE EMPLOYEES
SET SALARY = SALARY * 1.10
WHERE commission_pct IS NULL;
COMMIT;
/*
8.	Hacer un update en employees al   
salario en un  10%  de aumento  cuando el salario  
sea  menor a 5000 y el departamento no sea 30.
*/
--EJERCICIO 8:
UPDATE HR.EMPLOYEES
SET SALARY = SALARY * 1.10
WHERE SALARY < 5000 AND department_id <> 30;
COMMIT;

/*
9.Hacer un borrado de un registro de la
tabla creada donde el empleado se llame Peter
*/
--EJERCICIO 9:
DELETE FROM EMPLOYEES
WHERE FIRST_NAME = 'Peter';
COMMIT;

/*
10.	Eliminar la tabla test1 creada utilizando el comando DROP
*/
--EJERCICIO 10:
DROP TABLE TAB_TEST1;
COMMIT;

/*
11.	Crear una concatenación de la columna de nombre y apellido
con el alias NOMBRE
*/
--EJERCICIO 11:
SELECT FIRST_NAME || ' ' || LAST_NAME AS NOMBRE  
FROM EMPLOYEES;
COMMIT;
/*
12.	Ejecute un select donde se impriman
en pantalla los tres tipos de alias que podemos usar.
*/
--EJERCICIO 12:

--No encuentro un ejemplo claro


/*
13.	Ejecutar un select de los puestos de la tabla employees
donde sea presentado en pantalla un único registro por puesto.
*/
--EJERCICIO 13:
SELECT job_id, MAX(salary) AS max_salary
FROM EMPLOYEES
GROUP BY job_id;
COMMIT;
/*
14.	Crear una tabla de TEST con los siguientes campos
( ID_EMP, NOMBRE, ID_PUESTO,FECHA, ID_DEPARTAMENTO).
*/
--EJERCICIO 14:
CREATE TABLE TAB_TEST(
    ID_EMP NUMBER(8),
    NOMBRE VARCHAR2(50),
    ID_PUESTO NUMBER(3),
    FECHA DATE,
    ID_DEPARTAMENTO NUMBER(3)
    );
COMMIT
/*
15.	Crear una llave primaria en el campo ID_EMP.
*/
--EJERCICIO 15:
ALTER TABLE TAB_TEST ADD CONSTRAINT PK_ID_EMP
PRIMARY KEY(ID_EMP);
COMMIT
/*
16.	Crear una llave UNICA en el campo ID_PUESTO.
*/
--EJERCICIO 16:
ALTER TABLE TAB_TEST ADD CONSTRAINT UK_ID_PUESTO
UNIQUE (ID_PUESTO);
COMMIT;
/*
17.	Crear un constraint de fecha tipo default para el campo FECHA.
*/
--EJERCICIO 17:
ALTER TABLE TAB_TEST
MODIFY FECHA DEFAULT SYSDATE;
/*
18.	Crear una tabla llamada departamentos que contenga 
(id_departamento,descripción), poblarla mediante un select con los datos 
de la tabla DEPARTMENTS.
*/
--EJERCICIO 18:
CREATE TABLE TAB_DEPARTAMENTOS(
    ID_DEPARTAMENTO NUMBER(3),
    DESCRIPCION VARCHAR2(50)
    );
    
INSERT INTO TAB_DEPARTAMENTOS (ID_DEPARTAMENTO, DESCRIPCION)
SELECT department_id, department_name FROM DEPARTMENTS;

SELECT * FROM TAB_DEPARTAMENTOS;
/*
19.	Crear una llave foránea entre la tabla de DEPARTAMENTOS y la tabla de TEST
*/
--EJERCICIO 19:

/*
20.	Por medio de INSERT poblar la tabla test con los campos requeridos
al menos 5 registros
*/
--EJERCICIO 20:

/*
21.	Anadir una columna a la tabla test llamada nueva_columna (varchar2 (12)).
*/
--EJERCICIO 21:

/*
22.	Modificar a number el tipo de nueva_columna.
*/
--EJERCICIO 22:

/*11.	Crear una concatenación de la columna de nombre
y apellido  con el alias NOMBRE
*/
--EJERCICIO 11:
SELECT FIRST_NAME || ' ' || LAST_NAME AS NOMBRE
FROM EMPLOYEES;

/*
12.	Ejecute un select donde se impriman en pantalla los
tres tipos de alias que podemos usar.
*/
--EJERCICIO 12:
--**PENDIENTE** 

/*
13.	Ejecutar un select de los puestos de la tabla employees 
donde sea presentado en pantalla un único registro por puesto.
*/
--EJERCICIO 13:
SELECT DISTINCT j.job_title
FROM employees e
JOIN jobs j ON e.job_id = j.job_id;

/*
14.	Crear una tabla de TEST con los siguientes campos 
( ID_EMP, NOMBRE, ID_PUESTO,FECHA, ID_DEPARTAMENTO).
*/
--EJERCICIO 14:
CREATE TABLE HR.TAB_TEST1 (
    ID_EMP NUMBER,
    NOMBRE VARCHAR2(50),
    ID_PUESTO NUMBER,
    FECHA DATE,
    ID_DEPARTAMENTO NUMBER
);

/*
15.	Crear una llave primaria en el campo ID_EMP.
*/
--EJERCICIO 15:
ALTER TABLE HR.TAB_TEST1
ADD CONSTRAINT PK_TAB_TEST_ID_EMP PRIMARY KEY (ID_EMP);

/*
16.	Crear una llave UNICA en el campo ID_PUESTO.
*/
--EJERCICIO 16:
ALTER TABLE HR.TAB_TEST1
ADD CONSTRAINT UK_ID_PUESTO UNIQUE (ID_PUESTO);

/*
17.	Crear un CONSTRAINT de fecha tipo default para el campo FECHA.
*/
--EJERCICIO 17:
ALTER TABLE HR.TAB_TEST1
MODIFY FECHA DEFAULT CURRENT_TIMESTAMP;

/*
18.	Crear una tabla llamada departamentos que contenga (id_departamento, 
descripcion) y poblarla mediante
un select con los datos de la tabla deparments:.
*/
--EJERCICIO 18:
CREATE TABLE DEPARTAMENTOS (
ID_DEPARTAMENTO NUMBER PRIMARY KEY,
DESCRIPCION VARCHAR2(255)
);
INSERT INTO DEPARTAMENTOS (ID_DEPARTAMENTO, DESCRIPCION)
SELECT DEPARTMENT_ID, DEPARTMENT_NAME FROM DEPARTMENTS;
SELECT * FROM DEPARTAMENTOS;
/*
19.	Crear una llave foranea entre la tabla DEPARTAMENTOS y la tabla TEST1.
*/
--EJERCICIO 19:

ALTER TABLE HR.TAB_TEST1
ADD CONSTRAINT FK_TAB_TEST_DEPARTAMENTO FOREIGN KEY (ID_DEPARTAMENTO) 
REFERENCES DEPARTAMENTOS(ID_DEPARTAMENTO);

/*
20.	Poblar la tabla Test con al menos 5 registros.
*/
--EJERCICIO 20:

INSERT INTO TAB_TEST1 (ID_EMP, NOMBRE, ID_PUESTO, FECHA, ID_DEPARTAMENTO)
VALUES (3, 'Empleado3', 103, TO_DATE('2023-10-03', 'YYYY-MM-DD'), 30);

INSERT INTO TAB_TEST1 (ID_EMP, NOMBRE, ID_PUESTO, FECHA, ID_DEPARTAMENTO)
VALUES (4, 'Empleado4', 104, TO_DATE('2023-10-03', 'YYYY-MM-DD'), 40);

INSERT INTO TAB_TEST1 (ID_EMP, NOMBRE, ID_PUESTO, FECHA, ID_DEPARTAMENTO)
VALUES (5, 'Empleado5', 105, TO_DATE('2023-10-03', 'YYYY-MM-DD'), 50);

INSERT INTO TAB_TEST1 (ID_EMP, NOMBRE, ID_PUESTO, FECHA, ID_DEPARTAMENTO)
VALUES (6, 'Empleado6', 106, TO_DATE('2023-10-03', 'YYYY-MM-DD'), 60);

INSERT INTO TAB_TEST1 (ID_EMP, NOMBRE, ID_PUESTO, FECHA, ID_DEPARTAMENTO)
VALUES (7, 'Empleado7', 107, TO_DATE('2023-10-03', 'YYYY-MM-DD'), 70);

/*
21.	Anadir una columna a la tabla TEST llamada nueva_columna(NUMBER)
*/
--EJERCICIO 21:

ALTER TABLE HR.TAB_TEST1
ADD nueva_columna NUMBER(12);


/*
22.	Modificar el tipo de nueva_columna a number.
*/
--EJERCICIO 22:

ALTER TABLE HR.TAB_TEST1 
MODIFY nueva_columna NUMBER;

/*
23.	Crear una tabla de PRACTICA con los siguientes campos ( ID_EMPLEADO, NOMBRE_EMPLEADO, ID_PUESTO
, ID_DEPARTAMENTO)
*/
--EJERCICIO 23:

CREATE TABLE PRACTICA (
ID_EMPLEADO NUMBER,
NOMBRE_EMPLEADO VARCHAR2(255),
ID_PUESTO NUMBER,
ID_DEPARTAMENTO NUMBER);

/*
24.	Crear una llave primaria compuesta con los campos (ID_EMP, Nombre)
en la tabla practica.
*/
--EJERCICIO 24:
ALTER TABLE PRACTICA
ADD CONSTRAINT PK_PRACTICA PRIMARY KEY (ID_EMPLEADO, NOMBRE_EMPLEADO);

/*
25.	Crear una llave de chequeo para que trabajadores del departamento 50 no 
puedan ser insertados en la tabla.
*/
--EJERCICIO 25:

ALTER TABLE PRACTICA
ADD CONSTRAINT CHK_departamento
CHECK (ID_DEPARTAMENTO != 50);


/*
26.	Anadir una columna llamada CN en la tabla PRACTICA.
*/
--EJERCICIO 26:

ALTER TABLE PRACTICA
ADD CN VARCHAR2(50);

/*
27.	Por medio de INSERTS llenar la tabla con los datos solicitados e ingresándolos por el department_id.
*/
--EJERCICIO 27:
INSERT INTO PRACTICA (ID_EMPLEADO, NOMBRE_EMPLEADO, ID_PUESTO, ID_DEPARTAMENTO, CN)
VALUES (1015, 'Alison Taylor', 36, 12, 'CN55')

/*
28.	Agregar un valor al SALARIO por defecto para  esa columna.
*/
--EJERCICIO 28:
ALTER TABLE PRACTICA
ADD SALARIO NUMBER(8);

ALTER TABLE PRACTICA
MODIFY (SALARIO NUMBER(8,0) DEFAULT 300000);

/*
29.	Hacer una inserción de  nuevos datos en la tabla nueva 
*/
--EJERCICIO 29:

INSERT INTO PRACTICA (ID_EMPLEADO, NOMBRE_EMPLEADO, ID_PUESTO, ID_DEPARTAMENTO, CN, SALARIO)
VALUES (1016, 'Carlos Salgado', 12, 54, 'CN56', 625000);

INSERT INTO PRACTICA (ID_EMPLEADO, NOMBRE_EMPLEADO, ID_PUESTO, ID_DEPARTAMENTO, CN, SALARIO)
VALUES (1017, 'Maria Tapia', 22, 25, 'CN57', 450000);

INSERT INTO PRACTICA (ID_EMPLEADO, NOMBRE_EMPLEADO, ID_PUESTO, ID_DEPARTAMENTO, CN, SALARIO)
VALUES (1018, 'Marco Salazar', 31, 33, 'CN58',375000);

INSERT INTO PRACTICA (ID_EMPLEADO, NOMBRE_EMPLEADO, ID_PUESTO, ID_DEPARTAMENTO, CN, SALARIO)
VALUES (1019, 'Fernando Pérez', 7, 11, 'CN59', 654000);

INSERT INTO PRACTICA (ID_EMPLEADO, NOMBRE_EMPLEADO, ID_PUESTO, ID_DEPARTAMENTO, CN, SALARIO)
VALUES (1020, 'Teresa Sánchez', 24, 89, 'CN60', 560000);

INSERT INTO PRACTICA (ID_EMPLEADO, NOMBRE_EMPLEADO, ID_PUESTO, ID_DEPARTAMENTO, CN, SALARIO)
VALUES (1021, 'Marta Solis', 9, 44, 'CN61', 710500);

INSERT INTO PRACTICA (ID_EMPLEADO, NOMBRE_EMPLEADO, ID_PUESTO, ID_DEPARTAMENTO, CN, SALARIO)
VALUES (1022, 'Juliana Solano', 28, 26, 'CN62', 545000);

/*
30.	Crear una selección de los empleado cuyo puesto sea ST_CLERK
*/
--EJERCICIO 30:

SELECT * FROM EMPLOYEES WHERE job_id = 'ST_CLERK';

/*
31.	Hacer una modificación de datos en la Tabla PRACTICA 
utilizando el comando UPDATE
*/
--EJERCICIO 31:
UPDATE PRACTICA
SET ID_PUESTO = 40
WHERE ID_EMPLEADO = 1015;

/*
32.	Borrar datos de la tabla PRACTICA con el comando DELETE.
*/
--EJERCICIO 32:
DELETE FROM PRACTICA WHERE SALARIO > 700000;

/*
33.	Crear un select de la tabla EMPLOYEES en el cual 
incluya las tres variaciones de alias.
*/
--EJERCICIO 33:
--Mayúscula - Minúscula
UPDATE EMPLOYEES
SET FIRST_NAME = INITCAP(FIRST_NAME);

--Minúsculas
UPDATE EMPLOYEES
SET LAST_NAME = LOWER(LAST_NAME);

--Dos Letras
UPDATE EMPLOYEES
SET Email = CONCAT(UPPER(SUBSTR(Email, 1, 2)), LOWER(SUBSTR(Email, 3)));

/*
34.	Crea un select donde concatene de las columnas 
(LAST_NAME, FIRST_NAME) bajo el alias de nombre. 
		Ej.: John Smith
*/
--EJERCICIO 34:
SELECT CONCAT(CONCAT(FIRST_NAME,' '), LAST_NAME) AS NOMBRE
FROM EMPLOYEES;

/*
35.	Crear un select donde concatene dos columnas
y haga uso de literales, haga uso de un alias.
*/
--EJERCICIO 35:

SELECT CONCAT(CONCAT(FIRST_NAME,' '), LAST_NAME) AS NOMBRE,
       PHONE_NUMBER,
       HIRE_DATE,
       JOB_ID,
       SALARY
FROM EMPLOYEES;

/*
36.	Crear un select de la tabla
EMPLOYEES tengan una vocal en la tercera letra del nombre.
*/
--EJERCICIO 36:
SELECT *
FROM EMPLOYEES
WHERE SUBSTR(FIRST_NAME, 3, 1) 
IN ('A', 'E', 'I', 'O', 'U', 'a', 'e', 'i', 'o', 'u');

/*
37.	Proceda a implementar un select donde incluya los salarios
que estén por abajo de 20000 y que sean mayores a 5000.
*/
--EJERCICIO 37:
SELECT SALARY --> o *
FROM EMPLOYEES
WHERE SALARY > 5000 AND SALARY < 20000;

/*
38.	Crear un select que muestre la cantidad de caracteres, el nombre y
apellido de los empleados que tienen la letra “b” después del tercer carácter.
*/
--EJERCICIO 38:
SELECT LENGTH(FIRST_NAME || LAST_NAME) AS cantidad_de_caracteres, FIRST_NAME, 
LAST_NAME FROM EMPLOYEES
WHERE SUBSTR(FIRST_NAME || LAST_NAME, 4,1) = 'b';


/*
39.	Se desea conocer los empleados que tengan como puestos las siguientes 
categorías (st_clerk,sa_rep, it_prog) de la tabla de empleados.
*/
--EJERCICIO 39:
SELECT * FROM EMPLOYEES
WHERE JOB_ID IN ('ST_CLERK', 'SA_REP', 'IT_PROG');
/*
40.	Se desea conocer los empleados que tengan un salario mayor a 5000 y menor a
15000 de la tabla de empleados y que la letra inicial de su apellido de P
*/
--EJERCICIO 40:
SELECT * FROM
EMPLOYEES WHERE SALARY > 5000 AND SALARY < 15000 AND 
UPPER(SUBSTR(LAST_NAME, 1, 1)) = 'P';

/*
41.	Busque los empleados que tengan 
como letra inicial la letra N de la tabla de empleados.
*/
--EJERCICIO 41:
SELECT * FROM EMPLOYEES WHERE UPPER(SUBSTR(FIRST_NAME, 1, 1)) = 'N';

/*
42.	Liste por medio de un select los empleados que tengan la comisión en NULL
*/
--EJERCICIO 42:
SELECT * FROM EMPLOYEES WHERE COMMISSION_PCT IS NULL;
/*
43.	Crear un listado de los empleados que no gane 
comisión y que su salario sea menor a 20000
*/
--EJERCICIO 43:
SELECT * FROM EMPLOYEES WHERE COMMISSION_PCT IS NULL AND SALARY < 20000;


/*
44.	Crear un Select de la tabla de EMPLOYEES  donde el puesto sea 
ST_CLERK o que el salario sea mayor a 40000
*/
--EJERCICIO 44:
SELECT * FROM EMPLOYEES WHERE JOB_ID = 'ST_CLERK' OR SALARY = 40000;
/*
45.	Busque los empleados que tengan 
la letra “e” en la segunda posición del nombre y que 
la penúltima letra del apellido sea  una vocal.
*/
--EJERCICIO 45:
SELECT * FROM EMPLOYEES WHERE SUBSTR(FIRST_NAME, 2, 1) = 'e' AND 
SUBSTR(LAST_NAME, LENGTH(LAST_NAME) - 1, 1)
IN('A''E','I','O','U','a','e','i','o','u');

/*
46.	Crear un select de los empleados que no trabajen en los departamentos (80,70,90)
*/
--EJERCICIO 46:
SELECT *
FROM employees
WHERE DEPARTMENT_ID NOT IN (80, 70, 90);

/*
47.	Crear un select que de un reporte de los salarios ordenados de mayos a menor en orden descendente.
*/
--EJERCICIO 47:
SELECT salary
FROM employees
ORDER BY salary DESC;

/*
48.	Crear un select que de un reporte de los empleados ordenados por nombre  de en forma alfabética  en orden ascendente y por  departamento en orden descendente
*/
--EJERCICIO 48:
SELECT employee_id, FIRST_NAME, LAST_NAME, DEPARTMENT_ID
FROM employees
ORDER BY FIRST_NAME ASC, DEPARTMENT_ID DESC;
/*
49.	Haga una consulta de la tabla de empleados donde presente los datos del nombre, apellido, puesto de trabajo utilizando la función LOWER.
*/
--EJERCICIO 49:
SELECT LOWER(first_name) AS nombre_min,
       LOWER(last_name) AS apellido_min,
       LOWER(job_id) AS puesto_trabajo_min
FROM employees;

/*
50.	Haga una consulta de la tabla de empleados donde presente los datos del nombre, apellido, puesto de trabajo utilizando la función UPPER
*/
--EJERCICIO 50:
SELECT UPPER(first_name) AS nombre_mayus,
       UPPER(last_name) AS apellido_mayus,
       UPPER(job_id) AS puesto_trabajo_mayus
FROM employees;
/*
51.	Haga una consulta de la tabla de empleados donde presente los datos concatenados del nombre, apellido, en otra columna el puesto de trabajo utilizando la función INITCAP.
*/
--EJERCICIO 51:
SELECT INITCAP(first_name || ' ' || last_name) AS nombre_completo,
       INITCAP(job_id) AS puesto_trabajo
FROM employees;

/*
52.	Crear un código de empleado que contenga los siguiente:
-	Letras del nombre 2,3,4 
-	Letras del apellido las tres ultimas 
-	Job_id
*/
--EJERCICIO 52:
SELECT
    job_id AS puesto_trabajo,
    SUBSTR(first_name, 2, 3) || SUBSTR(last_name, -3) || job_id AS codigo_empleado
FROM employees;























