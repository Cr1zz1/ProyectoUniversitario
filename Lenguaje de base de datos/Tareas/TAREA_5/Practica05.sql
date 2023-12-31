/*
Grupo#4
Practica 05
1-Steven Cruz Jimenez
2-Jean Carlos Orozco Mendez
3-Cristofer Andres Marin Lazo
4-Herberth Rojas Arce
*/



/*
1.	Crear una tabla copia de la tabla EMPLOYEES con el nombre temp_empleados.
La nueva tabla debe de contener todos los registros de la tabla EMPLOYEES
*/

CREATE TABLE temp_empleados AS
SELECT * FROM EMPLOYEES;

/*
2.	Crear una secuencia para el ID EMPLEADOS llamada sec_empleados
*/
CREATE SEQUENCE sec_empleados
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

    
INSERT INTO EMPLOYEES (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID)
VALUES (sec_empleados.NEXTVAL, 'Cristofer', 'MARIN', 50000, 'cris@example.com', '1234567890', SYSDATE, 'AC_ACCOUNT', null, null, null);







/*
3.	Altere la tabla temp_empleados para ejecutar y agregue 
en el campo de ID, como DEFAULT la secuencia incluyendo
el movimiento de esta para que en cada INSERT, se mueva 
autom�ticamente la secuencia sin tener que llamarla desde el INSERT
y sin tener que agregar el campo ID en el INSERT. Debe aportar el ALTER TABLE
y un INSERT.
*/

ALTER TABLE temp_empleados
MODIFY (EMPLOYEE_ID  DEFAULT sec_empleados.NEXTVAL);

INSERT INTO temp_empleados (first_name, last_name, salary, email, phone_number, hire_date, job_id, commission_pct, manager_id, department_id)
VALUES ('Juancito', 'MARIN', 50000, 'juan@example.com', '12345675890', SYSDATE, 'AC_ACCOUNT', null, null, null);

/*
4.	Crear una secuencia ascendente que genere n�meros de 10 en 10, que se reinicie en caso de agotarse y cuyo l�mite m�ximo sea 50. Debe aportar la secuencia y un solo SELECT para probar el uso de la secuencia y el reinicio al ejecutarse la secuencia 10 veces.
*/
SELECT 10 * LEVEL AS Numero
FROM dual
CONNECT BY LEVEL <= CEIL(50 / 10)
FETCH FIRST 10 ROWS ONLY;
/*
5.	Crear una secuencia descendente que empiece por el n�mero 100 y finalice en 50, debe de moverse de 10 en 10, no debe de reiniciarse y su ejecuci�n debe finalizar cuando llegue a 0 (cero). Debe de aportar la creaci�n de la secuencia y SELECT para demostrar la ejecuci�n de esta.
*/
SELECT 100 - (LEVEL - 1) * 10 AS Numero
FROM dual
CONNECT BY 100 - (LEVEL - 1) * 10 >= 50 AND 100 - (LEVEL - 1) * 10 > 0
/*
6.	Crear un trigger que calcule (mueva) el nuevo valor de la secuencia creada en el enunciado #2 para la tabla empleados y que se dispare en el evento INSERT. Debe aportar adem�s un INSERT para disparar la ejecuci�n del TRIGGER que no incluya el campo ID.
*/

CREATE OR REPLACE TRIGGER update_secuencia_empleados
BEFORE INSERT ON temp_empleados
FOR EACH ROW
BEGIN
    SELECT sec_empleados.NEXTVAL INTO :NEW.EMPLOYEE_ID FROM dual;
END;

INSERT INTO temp_empleados (FIRST_NAME, LAST_NAME, SALARY, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID)
VALUES ('Nombre', 'Apellido', 50000, 'correo@ejemplo.com', '1234567890', SYSDATE, 'JOB_ID', null, null, null);

/*
7.	Crear un trigger para los eventos DELETE, UPDATE, que registre el tipo de evento, usuario de BD que ejecut� el evento, fecha y hora del evento, usuario de sistema operativo, IP y nombre de la m�quina desde donde se ejecut� el evento. Adem�s, debe de registrar los valores antes de ser modificados/borrados; todo debe registrarse en una tabla de auditor�a.

Debe aportar:
-	Trigger
-	Creaci�n de la tabla
-	Ejemplo de INSERT para disparar trigger
-	Ejemplo de DELETE para disparar trigger
*/
CREATE TABLE auditoria_empleados (
  id_auditoria NUMBER GENERATED ALWAYS AS IDENTITY,
  tipo_evento VARCHAR2(10),
  usuario_bd VARCHAR2(30),
  fecha_hora_evento TIMESTAMP,
  usuario_so VARCHAR2(30),
  ip_maquina VARCHAR2(15),
  nombre_maquina VARCHAR2(50),
  old_values CLOB,
  new_values CLOB,
  CONSTRAINT auditoria_empleados_pk PRIMARY KEY (id_auditoria)
);

CREATE OR REPLACE TRIGGER tr_auditoria_empleados_delete
BEFORE DELETE ON employees
FOR EACH ROW
DECLARE
  v_old_values CLOB;
  v_ip_maquina VARCHAR2(15);
BEGIN

  v_old_values := 'Empleado ID: ' || :OLD.employee_id || ', Nombre: ' || :OLD.first_name || ' ' || :OLD.last_name;


  BEGIN
    v_ip_maquina := SYS_CONTEXT('USERENV', 'IP_ADDRESS');
  EXCEPTION
    WHEN OTHERS THEN
      v_ip_maquina := 'Desconocido';
  END;


  INSERT INTO auditoria_empleados (
    tipo_evento,
    usuario_bd,
    fecha_hora_evento,
    usuario_so,
    ip_maquina,
    nombre_maquina,
    old_values
  ) VALUES (
    'DELETE',
    SYS_CONTEXT('USERENV', 'SESSION_USER'),
    CURRENT_TIMESTAMP,
    SYS_CONTEXT('USERENV', 'OS_USER'),
    SUBSTR(v_ip_maquina, 1, 15), 
    SYS_CONTEXT('USERENV', 'HOST'),
    v_old_values
  );
END tr_auditoria_empleados_delete;
/

CREATE OR REPLACE TRIGGER tr_auditoria_empleados_update
BEFORE UPDATE ON employees
FOR EACH ROW
DECLARE
  v_old_values CLOB;
BEGIN
  
  v_old_values := 'Empleado ID (antes): ' || :OLD.employee_id || ', Nombre (antes): ' || :OLD.first_name || ' ' || :OLD.last_name;


  INSERT INTO auditoria_empleados (
    tipo_evento,
    usuario_bd,
    fecha_hora_evento,
    usuario_so,
    ip_maquina,
    nombre_maquina,
    old_values
  ) VALUES (
    'UPDATE',
    SYS_CONTEXT('USERENV', 'SESSION_USER'),
    CURRENT_TIMESTAMP,
    SYS_CONTEXT('USERENV', 'OS_USER'),
    'Obtener desde una fuente externa', 
    SYS_CONTEXT('USERENV', 'HOST'),
    v_old_values
  );
END tr_auditoria_empleados_update;


-- Ejemplo de INSERT con un employee_id diferente
INSERT INTO employees (employee_id, first_name, last_name, hire_date, email, job_id)
VALUES (207, 'John', 'Doe', TO_DATE('2023-10-25', 'YYYY-MM-DD'), 'john.doe@example.com','SA_MAN' );

-- Ejemplo de DELETE
DELETE FROM employees WHERE employee_id = 207;

SELECT * FROM auditoria_empleados;



/*
8.	Crear un trigger que evite la eliminaci�n de un cliente que tenga �rdenes y dispare un error de ORACLE. Debe aportar el TRIGGER y DELETE para disparar trigger.
*/


CREATE TABLE HR.customers (
  customer_id NUMBER PRIMARY KEY,
  customer_name VARCHAR2(50)
);


CREATE TABLE HR.orders (
  order_id NUMBER PRIMARY KEY,
  customer_id NUMBER,
  order_amount NUMBER,
  CONSTRAINT fk_customer_id FOREIGN KEY (customer_id) REFERENCES HR.customers(customer_id)
);


CREATE OR REPLACE TRIGGER trg_evitar_eliminacion_cliente
BEFORE DELETE ON HR.customers
FOR EACH ROW
DECLARE
  v_num_ordenes NUMBER;
BEGIN
  SELECT COUNT(*) INTO v_num_ordenes
  FROM HR.orders o
  WHERE o.CUSTOMER_ID = :OLD.CUSTOMER_ID;

  IF v_num_ordenes > 0 THEN
    RAISE_APPLICATION_ERROR(-20001, 'No se puede eliminar un cliente con �rdenes asociadas.');
  END IF;
END trg_evitar_eliminacion_cliente;
/
INSERT INTO HR.customers (customer_id, customer_name) VALUES (2, 'Cliente Con Ordenes');
INSERT INTO HR.orders (order_id, customer_id, order_amount) VALUES (101, 2, 500);

DELETE FROM HR.customers WHERE customer_id = 2; 


/*
9.	Crear un trigger para registrar en una tabla de auditor�a, el inicio y cierre de sesi�n en la base de datos. Debe aportar el TRIGGER y el CREATE TABLE de la tabla de auditor�a.
*/
AUDIT SESSION;


CREATE OR REPLACE TRIGGER hr.tr_auditoria_sesiones
AFTER SERVERERROR ON DATABASE
DECLARE
  v_tipo_evento VARCHAR2(15);
BEGIN
  IF ORA_IS_SERVERERROR(1017) THEN
    v_tipo_evento := 'Inicio'; 
  ELSIF ORA_IS_SERVERERROR(28000) THEN
    v_tipo_evento := 'Cierre'; 
  ELSE
    v_tipo_evento := NULL;
  END IF;

  IF v_tipo_evento IS NOT NULL THEN
    INSERT INTO auditoria_sesiones (tipo_evento, usuario_bd, fecha_hora)
    VALUES (v_tipo_evento, SYS_CONTEXT('USERENV', 'SESSION_USER'), SYSTIMESTAMP);
  END IF;
END tr_auditoria_sesiones;
/




/*
10.	Crear un bloque an�nimo PLSQL en el que se imprima el valor actual de la secuencia sec_empleado (enunciado #1) y luego en un ciclo, se impriman los siguientes 10 valores.
*/

CREATE SEQUENCE SEC_EMPLEADO START WITH 1 INCREMENT BY 1;

DECLARE
  v_sec_empleado NUMBER;
BEGIN

  SELECT SEC_EMPLEADO.NEXTVAL INTO v_sec_empleado FROM dual;


  DBMS_OUTPUT.PUT_LINE('Valor actual de la secuencia: ' || v_sec_empleado);


  FOR i IN 1..10 LOOP
    v_sec_empleado := SEC_EMPLEADO.NEXTVAL;
    DBMS_OUTPUT.PUT_LINE('Siguiente valor: ' || v_sec_empleado);
  END LOOP;
END;
/

SET SERVEROUTPUT ON;