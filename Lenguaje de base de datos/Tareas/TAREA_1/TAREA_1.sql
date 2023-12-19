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
INSERT INTO tab_test(NOMBRE, PUESTO)  VALUES ('Cristofer','Jefe');
INSERT INTO tab_test(NOMBRE, PUESTO)  VALUES ('Ana','Secretaria');
COMMIT
/*
3.	Hacer la inserción de los todos los  
registros concatenados de la tabla employees en la tabla test.
*/
--EJERCICIO 3:
INSERT INTO tab_test(NOMBRE, PUESTO)
SELECT first_name || ' ' || last_name, 'PUESTO'
FROM EMPLOYEES;
COMMIT
/*
4.	Modificar la tabla creada 
añadiendo una columna(nombre de departamento varchar 2(20))
*/
--EJERCICIO 4:
ALTER TABLE tab_test ADD NOMBRE_DEPARTAMENTO VARCHAR2(20);
SELECT * FROM tab_test;
COMMIT
/*
5.	Crear una tabla test1 basado 
en un select de la tabla de empleados, escoja las columnas que guste.
*/
--EJERCICIO 5:
CREATE TABLE Tab_TEST1 AS (SELECT FIRST_NAME, LAST_NAME, EMAIL,PHONE_NUMBER
FROM EMPLOYEES);
COMMIT
/*
6.	Crear una selección del nombre utilizando
la cláusula de distinct en la tabla de employees esquema HR.
*/
--EJERCICIO 6:
SELECT DISTINCT first_name, last_name FROM EMPLOYEES;
COMMIT
SELECT * FROM HR.EMPLOYEES;
/*
7.	Hacer un update a un registro 
subiendo el salario en un 10% a los empleados que no tienen comisión
*/
--EJERCICIO 7:
UPDATE HR.EMPLOYEES
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
DROP TABLE HR.Tab_TEST1;
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
























