--Definicion de secuencias
-------
CREATE SEQUENCE Direccion_Seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE Sucursal_Seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE Pedido_Seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE Producto_Seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE Empleado_Seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE Informacion_Contacto_Seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE Credencial_seq START WITH 1 INCREMENT BY 1;
----
--Tablas

CREATE TABLE Direccion (
    Id_Direccion INTEGER PRIMARY KEY,
    Provincia VARCHAR(50),
    Canton VARCHAR(50),
    Distrito VARCHAR(50)
);

CREATE TABLE Sucursal (
    Id_Sucursal INTEGER PRIMARY KEY,
    Id_Direccion INTEGER,
    Nombre_Sucursal VARCHAR(50),
    Telefono INTEGER,
    FOREIGN KEY (Id_Direccion) REFERENCES Direccion(Id_Direccion)
);

CREATE TABLE Pedido (
    Id_Pedido INTEGER PRIMARY KEY,
    Id_Sucursal INTEGER,
    Descripcion_Pedido VARCHAR(255),
    Estado_Pedido VARCHAR(50),
    FOREIGN KEY (Id_Sucursal) REFERENCES Sucursal(Id_Sucursal)
);

CREATE TABLE Producto (
    Id_Producto INTEGER PRIMARY KEY,
    Id_Pedido INTEGER,
    Nombre_Producto VARCHAR(255),
    Descripcion_Producto VARCHAR(255),
    Cantidad_Producto INTEGER,
    Fecha_Vencimiento DATE,
    FOREIGN KEY (Id_Pedido) REFERENCES Pedido(Id_Pedido)
);

CREATE TABLE Credencial (
    Id_Credencial INTEGER PRIMARY KEY,
    Usuario VARCHAR2(50),
    Contraseña VARCHAR2(50),
    Rol_Credencial VARCHAR2(50)
);

CREATE TABLE Empleado (
    Id_Empleado INTEGER PRIMARY KEY,
    Id_Sucursal INTEGER,
    Id_Credencial INTEGER UNIQUE,
    Nombre_Empleado VARCHAR(255),
    Apellido_Empleado VARCHAR(255),
    Estado_Empleado VARCHAR(50),
    FOREIGN KEY (Id_Sucursal) REFERENCES Sucursal(Id_Sucursal),
    FOREIGN KEY (Id_Credencial) REFERENCES Credencial(Id_Credencial)
);

CREATE TABLE Informacion_Contacto (
    Id_Contacto INTEGER PRIMARY KEY,
    Id_Empleado INTEGER,
    Email_Empleado VARCHAR(255),
    Telefono_Empleado VARCHAR(20),
    FOREIGN KEY (Id_Empleado) REFERENCES Empleado(Id_Empleado)
);

--Procedimientos almacenados

--CrearSucursal
CREATE OR REPLACE PROCEDURE CrearSucursal (
    p_Id_Direccion IN INTEGER,
    p_Nombre_Sucursal IN VARCHAR2,
    p_Telefono IN INTEGER
) AS
BEGIN
    INSERT INTO Sucursal (Id_Sucursal, Id_Direccion, Nombre_Sucursal, Telefono)
    VALUES (Sucursal_Seq.NEXTVAL, p_Id_Direccion, p_Nombre_Sucursal, p_Telefono);
    COMMIT;
END CrearSucursal;
/

--LeerSucursal
CREATE OR REPLACE PROCEDURE LeerSucursal (
    p_Id_Sucursal IN INTEGER,
    p_Id_Direccion OUT INTEGER,
    p_Nombre_Sucursal OUT VARCHAR2,
    p_Telefono OUT INTEGER
) AS
BEGIN
    SELECT Id_Direccion, Nombre_Sucursal, Telefono
    INTO p_Id_Direccion, p_Nombre_Sucursal, p_Telefono
    FROM Sucursal
    WHERE Id_Sucursal = p_Id_Sucursal;
END LeerSucursal;
/

--ActualizarSucursal
CREATE OR REPLACE PROCEDURE ActualizarSucursal (
    p_Id_Sucursal IN INTEGER,
    p_Id_Direccion IN INTEGER,
    p_Nombre_Sucursal IN VARCHAR2,
    p_Telefono IN INTEGER
) AS
BEGIN
    UPDATE Sucursal
    SET Id_Direccion = p_Id_Direccion,
        Nombre_Sucursal = p_Nombre_Sucursal,
        Telefono = p_Telefono
    WHERE Id_Sucursal = p_Id_Sucursal;
    COMMIT;
END ActualizarSucursal;
/

--EliminarSucursal
CREATE OR REPLACE PROCEDURE EliminarSucursal (
    p_Id_Sucursal IN INTEGER
) AS
BEGIN
    DELETE FROM Sucursal WHERE Id_Sucursal = p_Id_Sucursal;
    COMMIT;
END EliminarSucursal;
/

--Procedimientos para Direccion

--Creardireccion
CREATE OR REPLACE PROCEDURE CrearDireccion (
    p_Provincia IN VARCHAR2,
    p_Canton IN VARCHAR2,
    p_Distrito IN VARCHAR2
) AS
BEGIN
    INSERT INTO Direccion (Id_Direccion, Provincia, Canton, Distrito)
    VALUES (Direccion_Seq.NEXTVAL, p_Provincia, p_Canton, p_Distrito);
    COMMIT;
END CrearDireccion;
/

Exec CrearDireccion( 'San Jose', 'Alajuelita', 'San Josecito');

--LeerDireccion 

CREATE OR REPLACE PROCEDURE LeerDireccion (
    p_Id_Direccion IN INTEGER,
    p_Provincia OUT VARCHAR2,
    p_Canton OUT VARCHAR2,
    p_Distrito OUT VARCHAR2
) AS
BEGIN
    SELECT Provincia, Canton, Distrito
    INTO p_Provincia, p_Canton, p_Distrito
    FROM Direccion
    WHERE Id_Direccion = p_Id_Direccion;
END LeerDireccion;
/

--ActualixarDireccion
CREATE OR REPLACE PROCEDURE ActualizarDireccion (
    p_Id_Direccion IN INTEGER,
    p_Provincia IN VARCHAR2,
    p_Canton IN VARCHAR2,
    p_Distrito IN VARCHAR2
) AS
BEGIN
    UPDATE Direccion
    SET Provincia = p_Provincia, Canton = p_Canton, Distrito = p_Distrito
    WHERE Id_Direccion = p_Id_Direccion;
    COMMIT;
END ActualizarDireccion;
/
--Eliminar Direccion
CREATE OR REPLACE PROCEDURE EliminarDireccion (
    p_Id_Direccion IN INTEGER
) AS
BEGIN
    DELETE FROM Direccion WHERE Id_Direccion = p_Id_Direccion;
    COMMIT;
END EliminarDireccion;
/

--Procedimientos Pedido 

--CrearPedido 
CREATE OR REPLACE PROCEDURE CrearPedido (
    p_Id_Sucursal IN INTEGER,
    p_Descripcion_Pedido IN VARCHAR2,
    p_Estado_Pedido IN VARCHAR2
) AS
BEGIN
    INSERT INTO Pedido (Id_Pedido, Id_Sucursal, Descripcion_Pedido, Estado_Pedido)
    VALUES (Pedido_Seq.NEXTVAL, p_Id_Sucursal, p_Descripcion_Pedido, p_Estado_Pedido);
    COMMIT;
END CrearPedido;
/

--LeerPedido
CREATE OR REPLACE PROCEDURE LeerPedido (
    p_Id_Pedido IN INTEGER,
    p_Id_Sucursal OUT INTEGER,
    p_Descripcion_Pedido OUT VARCHAR2,
    p_Estado_Pedido OUT VARCHAR2
) AS
BEGIN
    SELECT Id_Sucursal, Descripcion_Pedido, Estado_Pedido
    INTO p_Id_Sucursal, p_Descripcion_Pedido, p_Estado_Pedido
    FROM Pedido
    WHERE Id_Pedido = p_Id_Pedido;
END LeerPedido;
/

--ActualiarPedido

CREATE OR REPLACE PROCEDURE ActualizarPedido (
    p_Id_Pedido IN INTEGER,
    p_Id_Sucursal IN INTEGER,
    p_Descripcion_Pedido IN VARCHAR2,
    p_Estado_Pedido IN VARCHAR2
) AS
BEGIN
    UPDATE Pedido
    SET Id_Sucursal = p_Id_Sucursal, Descripcion_Pedido = p_Descripcion_Pedido, Estado_Pedido = p_Estado_Pedido
    WHERE Id_Pedido = p_Id_Pedido;
    COMMIT;
END ActualizarPedido;
/

--EliminarPedido
CREATE OR REPLACE PROCEDURE EliminarPedido (
    p_Id_Pedido IN INTEGER
) AS
BEGIN
    DELETE FROM Pedido WHERE Id_Pedido = p_Id_Pedido;
    COMMIT;
END EliminarPedido;
/

--Procedimientos Productos

--CrearProducto
CREATE OR REPLACE PROCEDURE CrearProducto (
    p_Id_Pedido IN INTEGER,
    p_Nombre_Producto IN VARCHAR2,
    p_Descripcion_Producto IN VARCHAR2,
    p_Cantidad_Producto IN INTEGER,
    p_Fecha_Vencimiento IN DATE
) AS
BEGIN
    INSERT INTO Producto (Id_Producto, Id_Pedido, Nombre_Producto, Descripcion_Producto, Cantidad_Producto, Fecha_Vencimiento)
    VALUES (Producto_Seq.NEXTVAL, p_Id_Pedido, p_Nombre_Producto, p_Descripcion_Producto, p_Cantidad_Producto, p_Fecha_Vencimiento);
    COMMIT;
END CrearProducto;
/
--LeerProducto
CREATE OR REPLACE PROCEDURE LeerProducto (
    p_Id_Producto IN INTEGER,
    p_Id_Pedido OUT INTEGER,
    p_Nombre_Producto OUT VARCHAR2,
    p_Descripcion_Producto OUT VARCHAR2,
    p_Cantidad_Producto OUT INTEGER,
    p_Fecha_Vencimiento OUT DATE
) AS
BEGIN
    SELECT Id_Pedido, Nombre_Producto, Descripcion_Producto, Cantidad_Producto, Fecha_Vencimiento
    INTO p_Id_Pedido, p_Nombre_Producto, p_Descripcion_Producto, p_Cantidad_Producto, p_Fecha_Vencimiento
    FROM Producto
    WHERE Id_Producto = p_Id_Producto;
END LeerProducto;
/
--AcutalizarProducto
CREATE OR REPLACE PROCEDURE ActualizarProducto (
    p_Id_Producto IN INTEGER,
    p_Id_Pedido IN INTEGER,
    p_Nombre_Producto IN VARCHAR2,
    p_Descripcion_Producto IN VARCHAR2,
    p_Cantidad_Producto IN INTEGER,
    p_Fecha_Vencimiento IN DATE
) AS
BEGIN
    UPDATE Producto
    SET Id_Pedido = p_Id_Pedido, Nombre_Producto = p_Nombre_Producto, Descripcion_Producto = p_Descripcion_Producto,
        Cantidad_Producto = p_Cantidad_Producto, Fecha_Vencimiento = p_Fecha_Vencimiento
    WHERE Id_Producto = p_Id_Producto;
    COMMIT;
END ActualizarProducto;
/
--EliminarProducto
CREATE OR REPLACE PROCEDURE EliminarProducto (
    p_Id_Producto IN INTEGER
) AS
BEGIN
    DELETE FROM Producto WHERE Id_Producto = p_Id_Producto;
    COMMIT;
END EliminarProducto;
/

--Procedimientos almacenados
--CrearInformacionContacto
CREATE OR REPLACE PROCEDURE CrearInformacionContacto (
    p_Id_Empleado IN INTEGER,
    p_Email_Empleado IN VARCHAR2,
    p_Telefono_Empleado IN VARCHAR2
) AS
BEGIN
    INSERT INTO Informacion_Contacto (Id_Contacto, Id_Empleado, Email_Empleado, Telefono_Empleado)
    VALUES (Informacion_Contacto_Seq.NEXTVAL, p_Id_Empleado, p_Email_Empleado, p_Telefono_Empleado);
    COMMIT;
END CrearInformacionContacto;
/
--LeerInformacionContacto
CREATE OR REPLACE PROCEDURE LeerInformacionContacto (
    p_Id_Contacto IN INTEGER,
    p_Id_Empleado OUT INTEGER,
    p_Email_Empleado OUT VARCHAR2,
    p_Telefono_Empleado OUT VARCHAR2
) AS
BEGIN
    SELECT Id_Empleado, Email_Empleado, Telefono_Empleado
    INTO p_Id_Empleado, p_Email_Empleado, p_Telefono_Empleado
    FROM Informacion_Contacto
    WHERE Id_Contacto = p_Id_Contacto;
END LeerInformacionContacto;
/
--ActualizarInformacionContacto
CREATE OR REPLACE PROCEDURE ActualizarInformacionContacto (
    p_Id_Contacto IN INTEGER,
    p_Id_Empleado IN INTEGER,
    p_Email_Empleado IN VARCHAR2,
    p_Telefono_Empleado IN VARCHAR2
) AS
BEGIN
    UPDATE Informacion_Contacto
    SET Id_Empleado = p_Id_Empleado, Email_Empleado = p_Email_Empleado, Telefono_Empleado = p_Telefono_Empleado
    WHERE Id_Contacto = p_Id_Contacto;
    COMMIT;
END ActualizarInformacionContacto;
/
--EliminarInformacionContacto
CREATE OR REPLACE PROCEDURE EliminarInformacionContacto (
    p_Id_Contacto IN INTEGER
) AS
BEGIN
    DELETE FROM Informacion_Contacto WHERE Id_Contacto = p_Id_Contacto;
    COMMIT;
END EliminarInformacionContacto;
/

--Procedimientos Empleado
--CrearEmpleado
CREATE OR REPLACE PROCEDURE CrearEmpleado (
    p_Id_Sucursal IN INTEGER,
    p_Nombre_Empleado IN VARCHAR2,
    p_Apellido_Empleado IN VARCHAR2,
    p_Estado_Empleado IN VARCHAR2
) AS
BEGIN
    INSERT INTO Empleado (Id_Empleado, Id_Sucursal, Nombre_Empleado, Apellido_Empleado, Estado_Empleado)
    VALUES (Empleado_Seq.NEXTVAL, p_Id_Sucursal, p_Nombre_Empleado, p_Apellido_Empleado, p_Estado_Empleado);
    COMMIT;
END CrearEmpleado;
/

--LeerEmpleado
CREATE OR REPLACE PROCEDURE LeerEmpleado (
    p_Id_Empleado IN INTEGER,
    p_Id_Sucursal OUT INTEGER,
    p_Nombre_Empleado OUT VARCHAR2,
    p_Apellido_Empleado OUT VARCHAR2,
    p_Estado_Empleado OUT VARCHAR2
) AS
BEGIN
    SELECT Id_Sucursal, Nombre_Empleado, Apellido_Empleado, Estado_Empleado
    INTO p_Id_Sucursal, p_Nombre_Empleado, p_Apellido_Empleado, p_Estado_Empleado
    FROM Empleado
    WHERE Id_Empleado = p_Id_Empleado;
END LeerEmpleado;
/

--ActualizarEmpleado
CREATE OR REPLACE PROCEDURE ActualizarEmpleado (
    p_Id_Empleado IN INTEGER,
    p_Id_Sucursal IN INTEGER,
    p_Nombre_Empleado IN VARCHAR2,
    p_Apellido_Empleado IN VARCHAR2,
    p_Estado_Empleado IN VARCHAR2
) AS
BEGIN
    UPDATE Empleado
    SET Id_Sucursal = p_Id_Sucursal, Nombre_Empleado = p_Nombre_Empleado, Apellido_Empleado = p_Apellido_Empleado,
        Estado_Empleado = p_Estado_Empleado
    WHERE Id_Empleado = p_Id_Empleado;
    COMMIT;
END ActualizarEmpleado;
/

--EliminarEmpleado
CREATE OR REPLACE PROCEDURE EliminarEmpleado (
    p_Id_Empleado IN INTEGER
) AS
BEGIN
    DELETE FROM Empleado WHERE Id_Empleado = p_Id_Empleado;
    COMMIT;
END EliminarEmpleado;

--Credenciales
-- Procedimientos para la tabla Credencial

-- CrearCredencial
CREATE OR REPLACE PROCEDURE CrearCredencial (
    p_Usuario IN VARCHAR2,
    p_Contraseña IN VARCHAR2,
    p_Rol_Credencial IN VARCHAR2
) AS
BEGIN
    INSERT INTO Credencial (Id_Credencial, Usuario, Contraseña, Rol_Credencial)
    VALUES (Credencial_Seq.NEXTVAL, p_Usuario, p_Contraseña, p_Rol_Credencial);
    COMMIT;
END CrearCredencial;
/

-- LeerCredencial
CREATE OR REPLACE PROCEDURE LeerCredencial (
    p_Id_Credencial IN INTEGER,
    p_Usuario OUT VARCHAR2,
    p_Contraseña OUT VARCHAR2,
    p_Rol_Credencial OUT VARCHAR2
) AS
BEGIN
    SELECT Usuario, Contraseña, Rol_Credencial
    INTO p_Usuario, p_Contraseña, p_Rol_Credencial
    FROM Credencial
    WHERE Id_Credencial = p_Id_Credencial;
END LeerCredencial;

-- ActualizarCredencial
CREATE OR REPLACE PROCEDURE ActualizarCredencial (
    p_Id_Credencial IN INTEGER,
    p_Usuario IN VARCHAR2,
    p_Contraseña IN VARCHAR2,
    p_Rol_Credencial IN VARCHAR2
) AS
BEGIN
    UPDATE Credencial
    SET Usuario = p_Usuario,
        Contraseña = p_Contraseña,
        Rol_Credencial = p_Rol_Credencial
    WHERE Id_Credencial = p_Id_Credencial;
    COMMIT;
END ActualizarCredencial;


-- EliminarCredencial
CREATE OR REPLACE PROCEDURE EliminarCredencial (
    p_Id_Credencial IN INTEGER
) AS
BEGIN
    DELETE FROM Credencial WHERE Id_Credencial = p_Id_Credencial;
    COMMIT;
END EliminarCredencial;


--Vista de detalles del pedido

CREATE VIEW Vista_Detalles_Pedido AS
SELECT P.Id_Pedido, S.Nombre_Sucursal, P.Descripcion_Pedido, P.Estado_Pedido
FROM Pedido P
INNER JOIN Sucursal S ON P.Id_Sucursal = S.Id_Sucursal;

--Vista de empleados activos
CREATE VIEW Vista_Empleados_Activos AS
SELECT E.Id_Empleado, E.Nombre_Empleado, E.Apellido_Empleado
FROM Empleado E
WHERE E.Estado_Empleado = 'Activo';

--Vista de productos vencidos
CREATE VIEW Vista_Productos_Vencidos AS
SELECT P.Id_Producto, P.Nombre_Producto, P.Fecha_Vencimiento
FROM Producto P
WHERE P.Fecha_Vencimiento < SYSDATE;

--Vista de Sucursales y sus direcciones
CREATE VIEW Vista_Sucursales_Direcciones AS
SELECT S.Id_Sucursal, S.Nombre_Sucursal, D.Provincia, D.Canton, D.Distrito
FROM Sucursal S
INNER JOIN Direccion D ON S.Id_Direccion = D.Id_Direccion;

--Vista de pedidos pendientes
CREATE VIEW Vista_Pedidos_Pendientes AS
SELECT P.Id_Pedido, S.Nombre_Sucursal, P.Descripcion_Pedido
FROM Pedido P
INNER JOIN Sucursal S ON P.Id_Sucursal = S.Id_Sucursal
WHERE P.Estado_Pedido = 'Pendiente';


--Vista de empleados por sucursal
CREATE VIEW Vista_Empleados_Por_Sucursal AS
SELECT S.Nombre_Sucursal, E.Nombre_Empleado, E.Apellido_Empleado
FROM Empleado E
INNER JOIN Sucursal S ON E.Id_Sucursal = S.Id_Sucursal;

--Vista de productos en stock por pedido
CREATE VIEW Vista_Productos_En_Stock AS
SELECT P.Id_Pedido, P.Nombre_Producto, SUM(P.Cantidad_Producto) AS Cantidad_En_Stock
FROM Producto P
GROUP BY P.Id_Pedido, P.Nombre_Producto;
--Vista de empleados con información de contacto
CREATE VIEW Vista_Empleados_Contacto AS
SELECT E.Id_Empleado, E.Nombre_Empleado, E.Apellido_Empleado, IC.Email_Empleado, IC.Telefono_Empleado
FROM Empleado E
LEFT JOIN Informacion_Contacto IC ON E.Id_Empleado = IC.Id_Empleado;
--Vista de pedidos por sucursal y estado
CREATE VIEW Vista_Pedidos_Por_Sucursal_Estado AS
SELECT S.Nombre_Sucursal, P.Estado_Pedido, COUNT(*) AS Cantidad_Pedidos
FROM Pedido P
INNER JOIN Sucursal S ON P.Id_Sucursal = S.Id_Sucursal
GROUP BY S.Nombre_Sucursal, P.Estado_Pedido;

--Vista con pedidos y fechas
CREATE VIEW Vista_Pedidos_Sucursal_Fecha AS
SELECT S.Id_Sucursal, S.Nombre_Sucursal, P.Id_Pedido, P.Descripcion_Pedido, P.Estado_Pedido, PR.Fecha_Vencimiento
FROM Sucursal S
INNER JOIN Pedido P ON S.Id_Sucursal = P.Id_Sucursal
INNER JOIN Producto PR ON P.Id_Pedido = PR.Id_Pedido;

---Vista informacion credenciales
CREATE VIEW Vista_Empleado_Credencial AS
SELECT E.Nombre_Empleado, C.Usuario, C.Rol_Credencial, E.Estado_Empleado
FROM Empleado E
INNER JOIN Credencial C ON E.Id_Credencial = C.Id_Credencial;


---Cursores---
/*
Cursor para obtener todos los pedidos de una sucursal con la fecha de cada pedido:
*/
CREATE OR REPLACE PROCEDURE obtener_pedidos_sucursal_fecha AS
BEGIN
    -- Consulta para obtener pedidos de una sucursal con fecha
    -- Usa el cursor c_pedidos_sucursal_fecha
    FOR pedido_sucursal_fecha IN (
        SELECT S.Id_Sucursal, S.Nombre_Sucursal, P.Id_Pedido, P.Descripcion_Pedido, P.Estado_Pedido, PR.Fecha_Vencimiento
        FROM Sucursal S
        INNER JOIN Pedido P ON S.Id_Sucursal = P.Id_Sucursal
        INNER JOIN Producto PR ON P.Id_Pedido = PR.Id_Pedido
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Sucursal: ' || pedido_sucursal_fecha.Nombre_Sucursal || ', Pedido ID: ' || pedido_sucursal_fecha.Id_Pedido || ', Descripción: ' || pedido_sucursal_fecha.Descripcion_Pedido || ', Fecha Vencimiento: ' || pedido_sucursal_fecha.Fecha_Vencimiento);
    END LOOP;
END obtener_pedidos_sucursal_fecha;

--Llamar procedimiento 
BEGIN 
    obtener_pedidos_sucursal_fecha;
    
    END;
SET SERVEROUTPUT ON;


/*
Cursor para obtener los productos vencidos:
*/
CREATE OR REPLACE PROCEDURE obtener_productos_vencidos AS
BEGIN
    FOR producto_vencido IN (
        SELECT P.Id_Producto, P.Nombre_Producto, P.Fecha_Vencimiento
        FROM Producto P
        WHERE P.Fecha_Vencimiento < SYSDATE
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('ID Producto: ' || producto_vencido.Id_Producto || ', Nombre: ' || producto_vencido.Nombre_Producto || ', Fecha Vencimiento: ' || producto_vencido.Fecha_Vencimiento);
    END LOOP;
END obtener_productos_vencidos;

BEGIN
    obtener_productos_vencidos;
END;


/*
Cursor para obtener empleados activos:
*/
CREATE OR REPLACE PROCEDURE obtener_empleados_activos AS
BEGIN
    FOR empleado_activo IN (
        SELECT E.Id_Empleado, E.Nombre_Empleado, E.Apellido_Empleado
        FROM Empleado E
        WHERE E.Estado_Empleado = 'Activo'
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('ID Empleado: ' || empleado_activo.Id_Empleado || ', Nombre: ' || empleado_activo.Nombre_Empleado || ', Apellido: ' || empleado_activo.Apellido_Empleado);
    END LOOP;
END obtener_empleados_activos;

BEGIN
    obtener_empleados_activos;
END;


/*
Cursor para obtener productos en stock por pedido:
*/
CREATE OR REPLACE PROCEDURE obtener_productos_stock_pedido AS
    CURSOR c_productos_stock_pedido IS
        SELECT P.Id_Pedido, P.Nombre_Producto, SUM(P.Cantidad_Producto) AS Cantidad_En_Stock
        FROM Producto P
        GROUP BY P.Id_Pedido, P.Nombre_Producto;
    v_id_pedido Producto.Id_Pedido%TYPE;
    v_nombre_producto Producto.Nombre_Producto%TYPE;
    v_cantidad_en_stock NUMBER;
BEGIN
    OPEN c_productos_stock_pedido;
    LOOP
        FETCH c_productos_stock_pedido INTO v_id_pedido, v_nombre_producto, v_cantidad_en_stock;
        EXIT WHEN c_productos_stock_pedido%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('ID Pedido: ' || v_id_pedido || ', Nombre Producto: ' || v_nombre_producto || ', Cantidad en Stock: ' || v_cantidad_en_stock);
    END LOOP;
    CLOSE c_productos_stock_pedido;
END obtener_productos_stock_pedido;

BEGIN
    obtener_productos_stock_pedido;
END;


/*
Cursor para obtener productos en stock por pedido:
*/
DECLARE
    CURSOR c_productos_stock_pedido IS
        SELECT P.Id_Pedido, P.Nombre_Producto, SUM(P.Cantidad_Producto) AS Cantidad_En_Stock
        FROM Producto P
        GROUP BY P.Id_Pedido, P.Nombre_Producto;
    v_id_pedido Producto.Id_Pedido%TYPE;
    v_nombre_producto Producto.Nombre_Producto%TYPE;
    v_cantidad_en_stock NUMBER;
BEGIN
    OPEN c_productos_stock_pedido;
    LOOP
        FETCH c_productos_stock_pedido INTO v_id_pedido, v_nombre_producto, v_cantidad_en_stock;
        EXIT WHEN c_productos_stock_pedido%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('ID Pedido: ' || v_id_pedido || ', Nombre Producto: ' || v_nombre_producto || ', Cantidad en Stock: ' || v_cantidad_en_stock);
    END LOOP;
    CLOSE c_productos_stock_pedido;
END;

BEGIN
    obtener_productos_stock_pedido;
END;

/*
Cursor para obtener informaciond e contacto de empleados
*/
CREATE OR REPLACE PROCEDURE obtener_info_contacto_empleados AS
BEGIN
    FOR info_empleado IN (
        SELECT E.Id_Empleado, E.Nombre_Empleado, E.Apellido_Empleado, IC.Email_Empleado, IC.Telefono_Empleado
        FROM Empleado E
        LEFT JOIN Informacion_Contacto IC ON E.Id_Empleado = IC.Id_Empleado
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('ID Empleado: ' || info_empleado.Id_Empleado || ', Nombre: ' || info_empleado.Nombre_Empleado || ', Apellido: ' || info_empleado.Apellido_Empleado || ', Email: ' || info_empleado.Email_Empleado || ', Teléfono: ' || info_empleado.Telefono_Empleado);
    END LOOP;
END obtener_info_contacto_empleados;

BEGIN
    obtener_info_contacto_empleados;
END;



/*Cursor para obtener direcciones por provincia*/
CREATE OR REPLACE PROCEDURE obtener_direcciones_por_provincia AS
BEGIN
    FOR direccion IN (
        SELECT D.Provincia, COUNT(*) AS Cantidad_Direcciones
        FROM Direccion D
        GROUP BY D.Provincia
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Provincia: ' || direccion.Provincia || ', Cantidad de Direcciones: ' || direccion.Cantidad_Direcciones);
    END LOOP;
END obtener_direcciones_por_provincia;

BEGIN
    obtener_direcciones_por_provincia;
END;

--Cursor obtener empleados por sucursal
CREATE OR REPLACE PROCEDURE ObtenerEmpleadosPorSucursal (
    p_Id_Sucursal IN INTEGER
) AS
    CURSOR c_empleados_por_sucursal IS
        SELECT Nombre_Empleado, Apellido_Empleado
        FROM Empleado
        WHERE Id_Sucursal = p_Id_Sucursal;

    v_nombre_empleado Empleado.Nombre_Empleado%TYPE;
    v_apellido_empleado Empleado.Apellido_Empleado%TYPE;
BEGIN
    OPEN c_empleados_por_sucursal;
    LOOP
        FETCH c_empleados_por_sucursal INTO v_nombre_empleado, v_apellido_empleado;
        EXIT WHEN c_empleados_por_sucursal%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Nombre: ' || v_nombre_empleado || ', Apellido: ' || v_apellido_empleado);
    END LOOP;
    CLOSE c_empleados_por_sucursal;
END;
--Obtener productos vencidos

CREATE OR REPLACE PROCEDURE ObtenerProductosVencidos AS
    CURSOR c_productos_vencidos IS
        SELECT Nombre_Producto, Fecha_Vencimiento
        FROM Producto
        WHERE Fecha_Vencimiento < SYSDATE;

    v_nombre_producto Producto.Nombre_Producto%TYPE;
    v_fecha_vencimiento Producto.Fecha_Vencimiento%TYPE;
BEGIN
    OPEN c_productos_vencidos;
    LOOP
        FETCH c_productos_vencidos INTO v_nombre_producto, v_fecha_vencimiento;
        EXIT WHEN c_productos_vencidos%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Producto: ' || v_nombre_producto || ', Fecha de Vencimiento: ' || v_fecha_vencimiento);
    END LOOP;
    CLOSE c_productos_vencidos;
END;

--Obtener direcciones por provincia
CREATE OR REPLACE PROCEDURE ObtenerDireccionesPorProvincia AS
    CURSOR c_direcciones_por_provincia IS
        SELECT Provincia, COUNT(*) AS Cantidad_Direcciones
        FROM Direccion
        GROUP BY Provincia;

    v_provincia Direccion.Provincia%TYPE;
    v_cantidad_direcciones NUMBER;
BEGIN
    OPEN c_direcciones_por_provincia;
    LOOP
        FETCH c_direcciones_por_provincia INTO v_provincia, v_cantidad_direcciones;
        EXIT WHEN c_direcciones_por_provincia%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Provincia: ' || v_provincia || ', Cantidad de Direcciones: ' || v_cantidad_direcciones);
    END LOOP;
    CLOSE c_direcciones_por_provincia;
END;

--Obtener detalles de pedidos por sucursal
CREATE OR REPLACE PROCEDURE ObtenerDetallesPedidosPorSucursal (
    p_Id_Sucursal IN INTEGER
) AS
    CURSOR c_detalles_pedidos IS
        SELECT P.Id_Pedido, P.Descripcion_Pedido, P.Estado_Pedido
        FROM Pedido P
        WHERE P.Id_Sucursal = p_Id_Sucursal;

    v_id_pedido Pedido.Id_Pedido%TYPE;
    v_descripcion_pedido Pedido.Descripcion_Pedido%TYPE;
    v_estado_pedido Pedido.Estado_Pedido%TYPE;
BEGIN
    OPEN c_detalles_pedidos;
    LOOP
        FETCH c_detalles_pedidos INTO v_id_pedido, v_descripcion_pedido, v_estado_pedido;
        EXIT WHEN c_detalles_pedidos%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('ID Pedido: ' || v_id_pedido || ', Descripción: ' || v_descripcion_pedido || ', Estado: ' || v_estado_pedido);
    END LOOP;
    CLOSE c_detalles_pedidos;
END;
--Obtener empleados con informacion de contacto
CREATE OR REPLACE PROCEDURE ObtenerEmpleadosConContacto AS
    CURSOR c_empleados_contacto IS
        SELECT E.Nombre_Empleado, E.Apellido_Empleado, IC.Email_Empleado, IC.Telefono_Empleado
        FROM Empleado E
        LEFT JOIN Informacion_Contacto IC ON E.Id_Empleado = IC.Id_Empleado;

    v_nombre_empleado Empleado.Nombre_Empleado%TYPE;
    v_apellido_empleado Empleado.Apellido_Empleado%TYPE;
    v_email_empleado Informacion_Contacto.Email_Empleado%TYPE;
    v_telefono_empleado Informacion_Contacto.Telefono_Empleado%TYPE;
BEGIN
    OPEN c_empleados_contacto;
    LOOP
        FETCH c_empleados_contacto INTO v_nombre_empleado, v_apellido_empleado, v_email_empleado, v_telefono_empleado;
        EXIT WHEN c_empleados_contacto%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Nombre: ' || v_nombre_empleado || ', Apellido: ' || v_apellido_empleado || ', Email: ' || v_email_empleado || ', Teléfono: ' || v_telefono_empleado);
    END LOOP;
    CLOSE c_empleados_contacto;
END;

--Pedidos pendientes por sucursal
CREATE OR REPLACE PROCEDURE ObtenerPedidosPendientesPorSucursal (
    p_Id_Sucursal IN INTEGER
) AS
    CURSOR c_pedidos_pendientes IS
        SELECT P.Id_Pedido, P.Descripcion_Pedido
        FROM Pedido P
        WHERE P.Estado_Pedido = 'Pendiente' AND P.Id_Sucursal = p_Id_Sucursal;

    v_id_pedido Pedido.Id_Pedido%TYPE;
    v_descripcion_pedido Pedido.Descripcion_Pedido%TYPE;
BEGIN
    OPEN c_pedidos_pendientes;
    LOOP
        FETCH c_pedidos_pendientes INTO v_id_pedido, v_descripcion_pedido;
        EXIT WHEN c_pedidos_pendientes%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('ID Pedido: ' || v_id_pedido || ', Descripción: ' || v_descripcion_pedido);
    END LOOP;
    CLOSE c_pedidos_pendientes;
END;

--Direcciones por sucursal
CREATE OR REPLACE PROCEDURE ObtenerDireccionesPorSucursal (
    p_Id_Sucursal IN INTEGER
) AS
    CURSOR c_direcciones_sucursal IS
        SELECT S.Nombre_Sucursal, D.Provincia, D.Canton, D.Distrito
        FROM Sucursal S
        INNER JOIN Direccion D ON S.Id_Direccion = D.Id_Direccion
        WHERE S.Id_Sucursal = p_Id_Sucursal;

    v_nombre_sucursal Sucursal.Nombre_Sucursal%TYPE;
    v_provincia Direccion.Provincia%TYPE;
    v_canton Direccion.Canton%TYPE;
    v_distrito Direccion.Distrito%TYPE;
BEGIN
    OPEN c_direcciones_sucursal;
    LOOP
        FETCH c_direcciones_sucursal INTO v_nombre_sucursal, v_provincia, v_canton, v_distrito;
        EXIT WHEN c_direcciones_sucursal%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Sucursal: ' || v_nombre_sucursal || ', Provincia: ' || v_provincia || ', Cantón: ' || v_canton || ', Distrito: ' || v_distrito);
    END LOOP;
    CLOSE c_direcciones_sucursal;
END;

--Obtener detalles de producto por pedido
CREATE OR REPLACE PROCEDURE ObtenerDetallesProductoPorPedido (
    p_Id_Pedido IN INTEGER
) AS
    CURSOR c_detalles_producto_pedido IS
        SELECT Nombre_Producto, Descripcion_Producto, Cantidad_Producto, Fecha_Vencimiento
        FROM Producto
        WHERE Id_Pedido = p_Id_Pedido;

    v_nombre_producto Producto.Nombre_Producto%TYPE;
    v_descripcion_producto Producto.Descripcion_Producto%TYPE;
    v_cantidad_producto Producto.Cantidad_Producto%TYPE;
    v_fecha_vencimiento Producto.Fecha_Vencimiento%TYPE;
BEGIN
    OPEN c_detalles_producto_pedido;
    LOOP
        FETCH c_detalles_producto_pedido INTO v_nombre_producto, v_descripcion_producto, v_cantidad_producto, v_fecha_vencimiento;
        EXIT WHEN c_detalles_producto_pedido%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Nombre Producto: ' || v_nombre_producto || ', Descripción: ' || v_descripcion_producto || ', Cantidad: ' || v_cantidad_producto || ', Fecha Vencimiento: ' || v_fecha_vencimiento);
    END LOOP;
    CLOSE c_detalles_producto_pedido;
END;

--Obtener empleados por rol
CREATE OR REPLACE PROCEDURE ObtenerEmpleadosPorRol (
    p_Rol IN VARCHAR2
) AS
    CURSOR c_empleados_rol IS
        SELECT E.Nombre_Empleado, E.Apellido_Empleado
        FROM Empleado E
        INNER JOIN Credencial C ON E.Id_Credencial = C.Id_Credencial
        WHERE C.Rol_Credencial = p_Rol;

    v_nombre_empleado Empleado.Nombre_Empleado%TYPE;
    v_apellido_empleado Empleado.Apellido_Empleado%TYPE;
BEGIN
    OPEN c_empleados_rol;
    LOOP
        FETCH c_empleados_rol INTO v_nombre_empleado, v_apellido_empleado;
        EXIT WHEN c_empleados_rol%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Nombre: ' || v_nombre_empleado || ', Apellido: ' || v_apellido_empleado);
    END LOOP;
    CLOSE c_empleados_rol;
END;

--Obtener pedidos por estado y sucursal
CREATE OR REPLACE PROCEDURE ObtenerPedidosPorEstadoYSucursal (
    p_Id_Sucursal IN INTEGER,
    p_Estado_Pedido IN VARCHAR2
) AS
    CURSOR c_pedidos_estado_sucursal IS
        SELECT P.Id_Pedido, P.Descripcion_Pedido
        FROM Pedido P
        WHERE P.Id_Sucursal = p_Id_Sucursal AND P.Estado_Pedido = p_Estado_Pedido;

    v_id_pedido Pedido.Id_Pedido%TYPE;
    v_descripcion_pedido Pedido.Descripcion_Pedido%TYPE;
BEGIN
    OPEN c_pedidos_estado_sucursal;
    LOOP
        FETCH c_pedidos_estado_sucursal INTO v_id_pedido, v_descripcion_pedido;
        EXIT WHEN c_pedidos_estado_sucursal%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('ID Pedido: ' || v_id_pedido || ', Descripción: ' || v_descripcion_pedido);
    END LOOP;
    CLOSE c_pedidos_estado_sucursal;
END;

--Empleados por sucursal y contacto 
CREATE OR REPLACE PROCEDURE ObtenerEmpleadosPorSucursalYContacto (
    p_Id_Sucursal IN INTEGER
) AS
    CURSOR c_empleados_contacto IS
        SELECT E.Nombre_Empleado, E.Apellido_Empleado, IC.Email_Empleado, IC.Telefono_Empleado
        FROM Empleado E
        LEFT JOIN Informacion_Contacto IC ON E.Id_Empleado = IC.Id_Empleado
        WHERE E.Id_Sucursal = p_Id_Sucursal;

    v_nombre_empleado Empleado.Nombre_Empleado%TYPE;
    v_apellido_empleado Empleado.Apellido_Empleado%TYPE;
    v_email_contacto Informacion_Contacto.Email_Empleado%TYPE;
    v_telefono_contacto Informacion_Contacto.Telefono_Empleado%TYPE;
BEGIN
    OPEN c_empleados_contacto;
    LOOP
        FETCH c_empleados_contacto INTO v_nombre_empleado, v_apellido_empleado, v_email_contacto, v_telefono_contacto;
        EXIT WHEN c_empleados_contacto%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Nombre: ' || v_nombre_empleado || ', Apellido: ' || v_apellido_empleado || ', Email: ' || v_email_contacto || ', Teléfono: ' || v_telefono_contacto);
    END LOOP;
    CLOSE c_empleados_contacto;
END;

--Obtener sucursales por provincia

CREATE OR REPLACE PROCEDURE ObtenerSucursalesPorProvincia AS
BEGIN
    FOR sucursal_por_provincia IN (
        SELECT D.Provincia, COUNT(*) AS Cantidad_Sucursales
        FROM Sucursal S
        INNER JOIN Direccion D ON S.Id_Direccion = D.Id_Direccion
        GROUP BY D.Provincia
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Provincia: ' || sucursal_por_provincia.Provincia || ', Cantidad de Sucursales: ' || sucursal_por_provincia.Cantidad_Sucursales);
    END LOOP;
END;



--Funciones

/*Función para obtener la cantidad de productos en un pedido:*/
CREATE OR REPLACE FUNCTION contar_productos_en_pedido(pedido_id INTEGER) RETURN INTEGER IS
    cantidad INTEGER;
BEGIN
    SELECT COUNT(*) INTO cantidad FROM Producto WHERE Id_Pedido = pedido_id;
    RETURN cantidad;
END;

/*Función para obtener el estado de un pedido específico:*/
CREATE OR REPLACE FUNCTION obtener_estado_pedido(pedido_id INTEGER) RETURN VARCHAR2 IS
    estado_pedido VARCHAR2(50);
BEGIN
    SELECT Estado_Pedido INTO estado_pedido FROM Pedido WHERE Id_Pedido = pedido_id;
    RETURN estado_pedido;
END;

/*Función para calcular la cantidad total de productos en stock por sucursal:*/
CREATE OR REPLACE FUNCTION total_productos_en_stock_sucursal(sucursal_id INTEGER) RETURN INTEGER IS
    total_stock INTEGER;
BEGIN
    SELECT SUM(Cantidad_Producto) INTO total_stock
    FROM Producto P
    JOIN Pedido PE ON P.Id_Pedido = PE.Id_Pedido
    JOIN Sucursal S ON PE.Id_Sucursal = S.Id_Sucursal
    WHERE S.Id_Sucursal = sucursal_id;
    RETURN total_stock;
END;

/*Función para obtener el nombre completo de un empleado a partir de su ID*/
CREATE OR REPLACE FUNCTION obtener_nombre_completo_empleado(empleado_id INTEGER) RETURN VARCHAR2 IS
    nombre_completo VARCHAR2(255);
BEGIN
    SELECT Nombre_Empleado || ' ' || Apellido_Empleado INTO nombre_completo
    FROM Empleado
    WHERE Id_Empleado = empleado_id;
    RETURN nombre_completo;
END;
/*Función para validar si un empleado está activo o no*/
CREATE OR REPLACE FUNCTION empleado_activo(empleado_id INTEGER) RETURN BOOLEAN IS
    empleado_estado VARCHAR2(50);
BEGIN
    SELECT Estado_Empleado INTO empleado_estado FROM Empleado WHERE Id_Empleado = empleado_id;
    IF empleado_estado = 'Activo' THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;

/* Función para obtener la provincia de una dirección a partir del ID de dirección*/
CREATE OR REPLACE FUNCTION obtener_provincia_direccion(direccion_id INTEGER) RETURN VARCHAR2 IS
    provincia_direccion VARCHAR2(50);
BEGIN
    SELECT Provincia INTO provincia_direccion FROM Direccion WHERE Id_Direccion = direccion_id;
    RETURN provincia_direccion;
END;
/* Función para obtener la cantidad de direcciones por provincia:*/
CREATE OR REPLACE FUNCTION contar_direcciones_por_provincia(provincia VARCHAR2) RETURN INTEGER IS
    cantidad_direcciones INTEGER;
BEGIN
    SELECT COUNT(*) INTO cantidad_direcciones FROM Direccion WHERE Provincia = provincia;
    RETURN cantidad_direcciones;
END;

/* Función para obtener el número de teléfono de un empleado a partir de su ID*/
CREATE OR REPLACE FUNCTION obtener_telefono_empleado(empleado_id INTEGER) RETURN VARCHAR2 IS
    telefono_empleado VARCHAR2(20);
BEGIN
    SELECT Telefono_Empleado INTO telefono_empleado FROM Informacion_Contacto WHERE Id_Empleado = empleado_id;
    RETURN telefono_empleado;
END;

/*Función para verificar las credenciales de un usuario*/
CREATE OR REPLACE FUNCTION verificar_credenciales(usuario VARCHAR2, contraseña VARCHAR2) RETURN BOOLEAN IS
    credenciales_validas NUMBER;
BEGIN
    SELECT COUNT(*) INTO credenciales_validas
    FROM credencial
    WHERE usuario = usuario AND contraseña = contraseña;
    IF credenciales_validas = 1 THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;
/*Función para obtener el rol de un usuario a partir de su usuario*/
CREATE OR REPLACE FUNCTION obtener_rol_usuario(usuario VARCHAR2) RETURN VARCHAR2 IS
    rol_usuario VARCHAR2(50);
BEGIN
    SELECT rol_credencial INTO rol_usuario FROM credencial WHERE usuario = usuario;
    RETURN rol_usuario;
END;

/*Función para obtener la descripción del pedido más reciente*/
CREATE OR REPLACE FUNCTION obtener_descripcion_pedido_reciente RETURN VARCHAR2 IS
    descripcion_pedido VARCHAR2(255);
BEGIN
    SELECT Descripcion_Pedido INTO descripcion_pedido
    FROM Pedido
    WHERE Id_Pedido = (SELECT MAX(Id_Pedido) FROM Pedido);
    RETURN descripcion_pedido;
END;

/*Función para obtener el nombre de la sucursal a partir de su ID*/
CREATE OR REPLACE FUNCTION obtener_nombre_sucursal(sucursal_id INTEGER) RETURN VARCHAR2 IS
    nombre_sucursal VARCHAR2(50);
BEGIN
    SELECT Nombre_Sucursal INTO nombre_sucursal FROM Sucursal WHERE Id_Sucursal = sucursal_id;
    RETURN nombre_sucursal;
END;

/*Función para obtener la cantidad total de productos en stock*/
CREATE OR REPLACE FUNCTION total_productos_en_stock RETURN INTEGER IS
    total_stock INTEGER;
BEGIN
    SELECT SUM(Cantidad_Producto) INTO total_stock FROM Producto;
    RETURN total_stock;
END;

/*Función para obtener la cantidad de pedidos en un estado especifico*/
CREATE OR REPLACE FUNCTION contar_pedidos_por_estado(estado_pedido VARCHAR2) RETURN INTEGER IS
    cantidad_pedidos INTEGER;
BEGIN
    SELECT COUNT(*) INTO cantidad_pedidos
    FROM Pedido
    WHERE Estado_Pedido = estado_pedido;
    RETURN cantidad_pedidos;
END;

/* Función para obtener el nombre completo de un empleado y su ID concatenados */
CREATE OR REPLACE FUNCTION obtener_id_nombre_empleado(empleado_id INTEGER) RETURN VARCHAR2 IS
    nombre_completo_id VARCHAR2(255);
BEGIN
    SELECT Id_Empleado || ' - ' || Nombre_Empleado || ' ' || Apellido_Empleado INTO nombre_completo_id
    FROM Empleado
    WHERE Id_Empleado = empleado_id;
    RETURN nombre_completo_id;
END;

/* Función para obtener la cantidad de productos vencidos */
CREATE OR REPLACE FUNCTION contar_productos_vencidos RETURN INTEGER IS
    cantidad_productos_vencidos INTEGER;
BEGIN
    SELECT COUNT(*) INTO cantidad_productos_vencidos
    FROM Producto
    WHERE Fecha_Vencimiento < SYSDATE;
    RETURN cantidad_productos_vencidos;
END;

--Triggers
--Para crear un id credencial automatico
CREATE OR REPLACE TRIGGER tr_insert_empleado_credencial
BEFORE INSERT ON Empleado
FOR EACH ROW
BEGIN
    SELECT credencial_seq.NEXTVAL INTO :new.Id_Credencial FROM dual;
    INSERT INTO Credencial (Id_Credencial, Usuario, Contraseña, Rol_Credencial)
    VALUES (:new.Id_Credencial, 'usuario_default', 'contraseña_default', 'rol_default');
END;

--Triggers 
--Alerta menos de 10 unidades 

CREATE OR REPLACE TRIGGER trg_inventario_bajo
BEFORE INSERT OR UPDATE ON Producto
FOR EACH ROW
BEGIN
    IF :NEW.Cantidad_Producto < 10 THEN
        DBMS_OUTPUT.PUT_LINE('¡Alerta! La cantidad del producto con ID ' || :NEW.Id_Producto || ' está por debajo de 10 unidades.');
    END IF;
END;

--Cantidad de producto en pedidos
CREATE OR REPLACE TRIGGER trg_alerta_cantidad_producto
BEFORE UPDATE ON Producto
FOR EACH ROW
BEGIN
    IF :NEW.Cantidad_Producto < 10 THEN
        DBMS_OUTPUT.PUT_LINE('¡Alerta! La cantidad del producto con ID ' || :NEW.Id_Producto || ' está por debajo de 10 unidades en el pedido.');
    END IF;
END;
--Restriccion de insercion de empleados inactivos
CREATE OR REPLACE TRIGGER trg_restriccion_empleado_inactivo
BEFORE INSERT ON Empleado
FOR EACH ROW
BEGIN
    IF :NEW.Estado_Empleado = 'Inactivo' THEN
        RAISE_APPLICATION_ERROR(-20001, 'No se puede insertar un empleado inactivo.');
    END IF;
END;

--Nuevo Producto
CREATE OR REPLACE TRIGGER trg_producto_agregado
AFTER INSERT ON Producto
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('¡Se ha agregado un nuevo producto! ID del Producto: ' || :NEW.Id_Producto);
END;

--Editar producto
CREATE OR REPLACE TRIGGER trg_producto_editado
AFTER UPDATE OF Nombre_Producto, Descripcion_Producto, Cantidad_Producto, Fecha_Vencimiento
ON Producto
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('¡El producto con ID ' || :NEW.Id_Producto || ' ha sido editado!');
END;


--Cambio de credencial
CREATE OR REPLACE TRIGGER trg_cambio_rol_usuario
BEFORE UPDATE OF Rol_Credencial ON Credencial
FOR EACH ROW
BEGIN
    IF :OLD.Rol_Credencial != :NEW.Rol_Credencial THEN
        DBMS_OUTPUT.PUT_LINE('El usuario con ID de credencial ' || :NEW.Id_Credencial || ' ha cambiado de rol.');
    END IF;
END;

--Paquete triggers
CREATE OR REPLACE PACKAGE paquete_triggers AS
  PROCEDURE insert_empleado_credencial;
  PROCEDURE alerta_inventario_bajo;
  PROCEDURE alerta_cantidad_producto;
END paquete_triggers;
/

CREATE OR REPLACE PACKAGE BODY paquete_triggers AS
  PROCEDURE insert_empleado_credencial IS
  BEGIN
    FOR empleado IN (SELECT * FROM Empleado WHERE Id_Credencial IS NULL) LOOP
      SELECT credencial_seq.NEXTVAL INTO empleado.Id_Credencial FROM dual;
      INSERT INTO Credencial (Id_Credencial, Usuario, Contraseña, Rol_Credencial)
      VALUES (empleado.Id_Credencial, 'usuario_default', 'contraseña_default', 'rol_default');
    END LOOP;
  END insert_empleado_credencial;

  PROCEDURE alerta_inventario_bajo IS
  BEGIN
    FOR producto IN (SELECT * FROM Producto) LOOP
      IF producto.Cantidad_Producto < 10 THEN
        DBMS_OUTPUT.PUT_LINE('¡Alerta! La cantidad del producto con ID ' || producto.Id_Producto || ' está por debajo de 10 unidades.');
      END IF;
    END LOOP;
  END alerta_inventario_bajo;

  PROCEDURE alerta_cantidad_producto IS
  BEGIN
    FOR producto IN (SELECT * FROM Producto) LOOP
      IF producto.Cantidad_Producto < 10 THEN
        DBMS_OUTPUT.PUT_LINE('¡Alerta! La cantidad del producto con ID ' || producto.Id_Producto || ' está por debajo de 10 unidades en el pedido.');
      END IF;
    END LOOP;
  END alerta_cantidad_producto;
END paquete_triggers;




--Paquete Procedimientos_Empleado

--Paquete Procedimientos_Producto

--Paquete Procedimientos_Sucursal
CREATE OR REPLACE PACKAGE paquete_sucursal AS
  PROCEDURE CrearSucursal (
    p_Id_Direccion IN INTEGER,
    p_Nombre_Sucursal IN VARCHAR2,
    p_Telefono IN INTEGER
  );

  PROCEDURE LeerSucursal (
    p_Id_Sucursal IN INTEGER,
    p_Id_Direccion OUT INTEGER,
    p_Nombre_Sucursal OUT VARCHAR2,
    p_Telefono OUT INTEGER
  );

  PROCEDURE ActualizarSucursal (
    p_Id_Sucursal IN INTEGER,
    p_Id_Direccion IN INTEGER,
    p_Nombre_Sucursal IN VARCHAR2,
    p_Telefono IN INTEGER
  );

  PROCEDURE EliminarSucursal (
    p_Id_Sucursal IN INTEGER
  );
END paquete_sucursal;
/

CREATE OR REPLACE PACKAGE BODY paquete_sucursal AS
  PROCEDURE CrearSucursal (
    p_Id_Direccion IN INTEGER,
    p_Nombre_Sucursal IN VARCHAR2,
    p_Telefono IN INTEGER
  ) AS
  BEGIN
    INSERT INTO Sucursal (Id_Sucursal, Id_Direccion, Nombre_Sucursal, Telefono)
    VALUES (Sucursal_Seq.NEXTVAL, p_Id_Direccion, p_Nombre_Sucursal, p_Telefono);
    COMMIT;
  END CrearSucursal;

  PROCEDURE LeerSucursal (
    p_Id_Sucursal IN INTEGER,
    p_Id_Direccion OUT INTEGER,
    p_Nombre_Sucursal OUT VARCHAR2,
    p_Telefono OUT INTEGER
  ) AS
BEGIN
    SELECT Id_Direccion, Nombre_Sucursal, Telefono
    INTO p_Id_Direccion, p_Nombre_Sucursal, p_Telefono
    FROM Sucursal
    WHERE Id_Sucursal = p_Id_Sucursal;
END LeerSucursal;

PROCEDURE ActualizarSucursal (
    p_Id_Sucursal IN INTEGER,
    p_Id_Direccion IN INTEGER,
    p_Nombre_Sucursal IN VARCHAR2,
    p_Telefono IN INTEGER
) AS
BEGIN
    UPDATE Sucursal
    SET Id_Direccion = p_Id_Direccion,
        Nombre_Sucursal = p_Nombre_Sucursal,
        Telefono = p_Telefono
    WHERE Id_Sucursal = p_Id_Sucursal;
    COMMIT;
END ActualizarSucursal;

 PROCEDURE EliminarSucursal (
    p_Id_Sucursal IN INTEGER
) AS
BEGIN
    DELETE FROM Sucursal WHERE Id_Sucursal = p_Id_Sucursal;
    COMMIT;
END EliminarSucursal;
    END Paquete_Sucursal;

--Paquete Procedimientos_Direccion
-- Creación del paquete
CREATE OR REPLACE PACKAGE paquete_direccion AS
    -- Procedimiento para crear una dirección
    PROCEDURE CrearDireccion (
        p_Provincia IN VARCHAR2,
        p_Canton IN VARCHAR2,
        p_Distrito IN VARCHAR2
    );
    
    -- Procedimiento para leer una dirección
    PROCEDURE LeerDireccion (
        p_Id_Direccion IN INTEGER,
        p_Provincia OUT VARCHAR2,
        p_Canton OUT VARCHAR2,
        p_Distrito OUT VARCHAR2
    );
    
    -- Procedimiento para actualizar una dirección
    PROCEDURE ActualizarDireccion (
        p_Id_Direccion IN INTEGER,
        p_Provincia IN VARCHAR2,
        p_Canton IN VARCHAR2,
        p_Distrito IN VARCHAR2
    );
    
    -- Procedimiento para eliminar una dirección
    PROCEDURE EliminarDireccion (
        p_Id_Direccion IN INTEGER
    );
END paquete_direccion;
/

-- Cuerpo del paquete
CREATE OR REPLACE PACKAGE BODY paquete_direccion AS
    -- Procedimiento para crear una dirección
    PROCEDURE CrearDireccion (
        p_Provincia IN VARCHAR2,
        p_Canton IN VARCHAR2,
        p_Distrito IN VARCHAR2
    ) AS
    BEGIN
        INSERT INTO Direccion (Id_Direccion, Provincia, Canton, Distrito)
        VALUES (Direccion_Seq.NEXTVAL, p_Provincia, p_Canton, p_Distrito);
        COMMIT;
    END CrearDireccion;

    -- Procedimiento para leer una dirección
    PROCEDURE LeerDireccion (
        p_Id_Direccion IN INTEGER,
        p_Provincia OUT VARCHAR2,
        p_Canton OUT VARCHAR2,
        p_Distrito OUT VARCHAR2
    ) AS
    BEGIN
        SELECT Provincia, Canton, Distrito
        INTO p_Provincia, p_Canton, p_Distrito
        FROM Direccion
        WHERE Id_Direccion = p_Id_Direccion;
    END LeerDireccion;

    -- Procedimiento para actualizar una dirección
    PROCEDURE ActualizarDireccion (
        p_Id_Direccion IN INTEGER,
        p_Provincia IN VARCHAR2,
        p_Canton IN VARCHAR2,
        p_Distrito IN VARCHAR2
    ) AS
    BEGIN
        UPDATE Direccion
        SET Provincia = p_Provincia, Canton = p_Canton, Distrito = p_Distrito
        WHERE Id_Direccion = p_Id_Direccion;
        COMMIT;
    END ActualizarDireccion;

    -- Procedimiento para eliminar una dirección
    PROCEDURE EliminarDireccion (
        p_Id_Direccion IN INTEGER
    ) AS
    BEGIN
        DELETE FROM Direccion WHERE Id_Direccion = p_Id_Direccion;
        COMMIT;
    END EliminarDireccion;
END paquete_direccion;


--Paquete Procedimientos_Pedido
-- Creación del paquete
CREATE OR REPLACE PACKAGE paquete_pedido AS
    -- Procedimiento para leer un pedido
    PROCEDURE LeerPedido (
        p_Id_Pedido IN INTEGER,
        p_Id_Sucursal OUT INTEGER,
        p_Descripcion_Pedido OUT VARCHAR2,
        p_Estado_Pedido OUT VARCHAR2
    );
    
    -- Procedimiento para actualizar un pedido
    PROCEDURE ActualizarPedido (
        p_Id_Pedido IN INTEGER,
        p_Id_Sucursal IN INTEGER,
        p_Descripcion_Pedido IN VARCHAR2,
        p_Estado_Pedido IN VARCHAR2
    );
    
    -- Procedimiento para eliminar un pedido
    PROCEDURE EliminarPedido (
        p_Id_Pedido IN INTEGER
    );
END paquete_pedido;
/

-- Cuerpo del paquete
CREATE OR REPLACE PACKAGE BODY paquete_pedido AS
    -- Procedimiento para leer un pedido
    PROCEDURE LeerPedido (
        p_Id_Pedido IN INTEGER,
        p_Id_Sucursal OUT INTEGER,
        p_Descripcion_Pedido OUT VARCHAR2,
        p_Estado_Pedido OUT VARCHAR2
    ) AS
    BEGIN
        SELECT Id_Sucursal, Descripcion_Pedido, Estado_Pedido
        INTO p_Id_Sucursal, p_Descripcion_Pedido, p_Estado_Pedido
        FROM Pedido
        WHERE Id_Pedido = p_Id_Pedido;
    END LeerPedido;

    -- Procedimiento para actualizar un pedido
    PROCEDURE ActualizarPedido (
        p_Id_Pedido IN INTEGER,
        p_Id_Sucursal IN INTEGER,
        p_Descripcion_Pedido IN VARCHAR2,
        p_Estado_Pedido IN VARCHAR2
    ) AS
    BEGIN
        UPDATE Pedido
        SET Id_Sucursal = p_Id_Sucursal, Descripcion_Pedido = p_Descripcion_Pedido, Estado_Pedido = p_Estado_Pedido
        WHERE Id_Pedido = p_Id_Pedido;
        COMMIT;
    END ActualizarPedido;

    -- Procedimiento para eliminar un pedido
    PROCEDURE EliminarPedido (
        p_Id_Pedido IN INTEGER
    ) AS
    BEGIN
        DELETE FROM Pedido WHERE Id_Pedido = p_Id_Pedido;
        COMMIT;
    END EliminarPedido;
END paquete_pedido;


--Paquete productos
-- Creación del paquete
CREATE OR REPLACE PACKAGE paquete_producto AS
    -- Procedimiento para crear un producto
    PROCEDURE CrearProducto (
        p_Id_Pedido IN INTEGER,
        p_Nombre_Producto IN VARCHAR2,
        p_Descripcion_Producto IN VARCHAR2,
        p_Cantidad_Producto IN INTEGER,
        p_Fecha_Vencimiento IN DATE
    );
    
    -- Procedimiento para leer un producto
    PROCEDURE LeerProducto (
        p_Id_Producto IN INTEGER,
        p_Id_Pedido OUT INTEGER,
        p_Nombre_Producto OUT VARCHAR2,
        p_Descripcion_Producto OUT VARCHAR2,
        p_Cantidad_Producto OUT INTEGER,
        p_Fecha_Vencimiento OUT DATE
    );
    
    -- Procedimiento para actualizar un producto
    PROCEDURE ActualizarProducto (
        p_Id_Producto IN INTEGER,
        p_Id_Pedido IN INTEGER,
        p_Nombre_Producto IN VARCHAR2,
        p_Descripcion_Producto IN VARCHAR2,
        p_Cantidad_Producto IN INTEGER,
        p_Fecha_Vencimiento IN DATE
    );
    
    -- Procedimiento para eliminar un producto
    PROCEDURE EliminarProducto (
        p_Id_Producto IN INTEGER
    );
END paquete_producto;
/

-- Cuerpo del paquete
CREATE OR REPLACE PACKAGE BODY paquete_producto AS
    -- Procedimiento para crear un producto
    PROCEDURE CrearProducto (
        p_Id_Pedido IN INTEGER,
        p_Nombre_Producto IN VARCHAR2,
        p_Descripcion_Producto IN VARCHAR2,
        p_Cantidad_Producto IN INTEGER,
        p_Fecha_Vencimiento IN DATE
    ) AS
    BEGIN
        INSERT INTO Producto (Id_Producto, Id_Pedido, Nombre_Producto, Descripcion_Producto, Cantidad_Producto, Fecha_Vencimiento)
        VALUES (Producto_Seq.NEXTVAL, p_Id_Pedido, p_Nombre_Producto, p_Descripcion_Producto, p_Cantidad_Producto, p_Fecha_Vencimiento);
        COMMIT;
    END CrearProducto;
    
    -- Procedimiento para leer un producto
    PROCEDURE LeerProducto (
        p_Id_Producto IN INTEGER,
        p_Id_Pedido OUT INTEGER,
        p_Nombre_Producto OUT VARCHAR2,
        p_Descripcion_Producto OUT VARCHAR2,
        p_Cantidad_Producto OUT INTEGER,
        p_Fecha_Vencimiento OUT DATE
    ) AS
    BEGIN
        SELECT Id_Pedido, Nombre_Producto, Descripcion_Producto, Cantidad_Producto, Fecha_Vencimiento
        INTO p_Id_Pedido, p_Nombre_Producto, p_Descripcion_Producto, p_Cantidad_Producto, p_Fecha_Vencimiento
        FROM Producto
        WHERE Id_Producto = p_Id_Producto;
    END LeerProducto;
    
    -- Procedimiento para actualizar un producto
    PROCEDURE ActualizarProducto (
        p_Id_Producto IN INTEGER,
        p_Id_Pedido IN INTEGER,
        p_Nombre_Producto IN VARCHAR2,
        p_Descripcion_Producto IN VARCHAR2,
        p_Cantidad_Producto IN INTEGER,
        p_Fecha_Vencimiento IN DATE
    ) AS
    BEGIN
        UPDATE Producto
        SET Id_Pedido = p_Id_Pedido, Nombre_Producto = p_Nombre_Producto, Descripcion_Producto = p_Descripcion_Producto,
            Cantidad_Producto = p_Cantidad_Producto, Fecha_Vencimiento = p_Fecha_Vencimiento
        WHERE Id_Producto = p_Id_Producto;
        COMMIT;
    END ActualizarProducto;
    
    -- Procedimiento para eliminar un producto
    PROCEDURE EliminarProducto (
        p_Id_Producto IN INTEGER
    ) AS
    BEGIN
        DELETE FROM Producto WHERE Id_Producto = p_Id_Producto;
        COMMIT;
    END EliminarProducto;
END paquete_producto;

--Procedimientos Empleado
CREATE OR REPLACE PACKAGE paquete_empleado AS
    -- Procedimiento para crear un empleado
    PROCEDURE CrearEmpleado (
        p_Id_Sucursal IN INTEGER,
        p_Nombre_Empleado IN VARCHAR2,
        p_Apellido_Empleado IN VARCHAR2,
        p_Estado_Empleado IN VARCHAR2
    );
    
    -- Procedimiento para leer un empleado
    PROCEDURE LeerEmpleado (
        p_Id_Empleado IN INTEGER,
        p_Id_Sucursal OUT INTEGER,
        p_Nombre_Empleado OUT VARCHAR2,
        p_Apellido_Empleado OUT VARCHAR2,
        p_Estado_Empleado OUT VARCHAR2
    );
    
    -- Procedimiento para actualizar un empleado
    PROCEDURE ActualizarEmpleado (
        p_Id_Empleado IN INTEGER,
        p_Id_Sucursal IN INTEGER,
        p_Nombre_Empleado IN VARCHAR2,
        p_Apellido_Empleado IN VARCHAR2,
        p_Estado_Empleado IN VARCHAR2
    );
    
    -- Procedimiento para eliminar un empleado
    PROCEDURE EliminarEmpleado (
        p_Id_Empleado IN INTEGER
    );
END paquete_empleado;
/

CREATE OR REPLACE PACKAGE BODY paquete_empleado AS
    -- Procedimiento para crear un empleado
    PROCEDURE CrearEmpleado (
        p_Id_Sucursal IN INTEGER,
        p_Nombre_Empleado IN VARCHAR2,
        p_Apellido_Empleado IN VARCHAR2,
        p_Estado_Empleado IN VARCHAR2
    ) AS
    BEGIN
        INSERT INTO Empleado (Id_Empleado, Id_Sucursal, Nombre_Empleado, Apellido_Empleado, Estado_Empleado)
        VALUES (Empleado_Seq.NEXTVAL, p_Id_Sucursal, p_Nombre_Empleado, p_Apellido_Empleado, p_Estado_Empleado);
        COMMIT;
    END CrearEmpleado;
    
    -- Procedimiento para leer un empleado
    PROCEDURE LeerEmpleado (
        p_Id_Empleado IN INTEGER,
        p_Id_Sucursal OUT INTEGER,
        p_Nombre_Empleado OUT VARCHAR2,
        p_Apellido_Empleado OUT VARCHAR2,
        p_Estado_Empleado OUT VARCHAR2
    ) AS
    BEGIN
        SELECT Id_Sucursal, Nombre_Empleado, Apellido_Empleado, Estado_Empleado
        INTO p_Id_Sucursal, p_Nombre_Empleado, p_Apellido_Empleado, p_Estado_Empleado
        FROM Empleado
        WHERE Id_Empleado = p_Id_Empleado;
    END LeerEmpleado;
    
    -- Procedimiento para actualizar un empleado
    PROCEDURE ActualizarEmpleado (
        p_Id_Empleado IN INTEGER,
        p_Id_Sucursal IN INTEGER,
        p_Nombre_Empleado IN VARCHAR2,
        p_Apellido_Empleado IN VARCHAR2,
        p_Estado_Empleado IN VARCHAR2
    ) AS
    BEGIN
        UPDATE Empleado
        SET Id_Sucursal = p_Id_Sucursal, Nombre_Empleado = p_Nombre_Empleado, Apellido_Empleado = p_Apellido_Empleado,
            Estado_Empleado = p_Estado_Empleado
        WHERE Id_Empleado = p_Id_Empleado;
        COMMIT;
    END ActualizarEmpleado;
    
    -- Procedimiento para eliminar un empleado
    PROCEDURE EliminarEmpleado (
        p_Id_Empleado IN INTEGER
    ) AS
    BEGIN
        DELETE FROM Empleado WHERE Id_Empleado = p_Id_Empleado;
        COMMIT;
    END EliminarEmpleado;
END paquete_empleado;
/

--Procedimienros Credencial 
CREATE OR REPLACE PACKAGE paquete_credencial AS
    -- Procedimiento para leer una credencial
    PROCEDURE LeerCredencial (
        p_Id_Credencial IN INTEGER,
        p_Usuario OUT VARCHAR2,
        p_Contraseña OUT VARCHAR2,
        p_Rol_Credencial OUT VARCHAR2
    );
    
    -- Procedimiento para actualizar una credencial
    PROCEDURE ActualizarCredencial (
        p_Id_Credencial IN INTEGER,
        p_Usuario IN VARCHAR2,
        p_Contraseña IN VARCHAR2,
        p_Rol_Credencial IN VARCHAR2
    );
    
    -- Procedimiento para eliminar una credencial
    PROCEDURE EliminarCredencial (
        p_Id_Credencial IN INTEGER
    );
END paquete_credencial;
/

CREATE OR REPLACE PACKAGE BODY paquete_credencial AS
    -- Procedimiento para leer una credencial
    PROCEDURE LeerCredencial (
        p_Id_Credencial IN INTEGER,
        p_Usuario OUT VARCHAR2,
        p_Contraseña OUT VARCHAR2,
        p_Rol_Credencial OUT VARCHAR2
    ) AS
    BEGIN
        SELECT Usuario, Contraseña, Rol_Credencial
        INTO p_Usuario, p_Contraseña, p_Rol_Credencial
        FROM Credencial
        WHERE Id_Credencial = p_Id_Credencial;
    END LeerCredencial;
    
    -- Procedimiento para actualizar una credencial
    PROCEDURE ActualizarCredencial (
        p_Id_Credencial IN INTEGER,
        p_Usuario IN VARCHAR2,
        p_Contraseña IN VARCHAR2,
        p_Rol_Credencial IN VARCHAR2
    ) AS
    BEGIN
        UPDATE Credencial
        SET Usuario = p_Usuario,
            Contraseña = p_Contraseña,
            Rol_Credencial = p_Rol_Credencial
        WHERE Id_Credencial = p_Id_Credencial;
        COMMIT;
    END ActualizarCredencial;
    
    -- Procedimiento para eliminar una credencial
    PROCEDURE EliminarCredencial (
        p_Id_Credencial IN INTEGER
    ) AS
    BEGIN
        DELETE FROM Credencial WHERE Id_Credencial = p_Id_Credencial;
        COMMIT;
    END EliminarCredencial;
END paquete_credencial;
/

--Procedimientos Informacion_Contacto

--Funciones 
CREATE OR REPLACE PACKAGE Funciones_Utilitarias AS

    /*Función para obtener la cantidad de productos en un pedido:*/
    FUNCTION contar_productos_en_pedido(pedido_id INTEGER) RETURN INTEGER;

    /*Función para obtener el estado de un pedido específico:*/
    FUNCTION obtener_estado_pedido(pedido_id INTEGER) RETURN VARCHAR2;

    /*Función para calcular la cantidad total de productos en stock por sucursal:*/
    FUNCTION total_productos_en_stock_sucursal(sucursal_id INTEGER) RETURN INTEGER;

    /* Agrega aquí otras funciones si es necesario */

END Funciones_Utilitarias;
/

CREATE OR REPLACE PACKAGE BODY Funciones_Utilitarias AS

    /*Función para obtener la cantidad de productos en un pedido:*/
    FUNCTION contar_productos_en_pedido(pedido_id INTEGER) RETURN INTEGER IS
        cantidad INTEGER;
    BEGIN
        SELECT COUNT(*) INTO cantidad FROM Producto WHERE Id_Pedido = pedido_id;
        RETURN cantidad;
    END;

    /*Función para obtener el estado de un pedido específico:*/
    FUNCTION obtener_estado_pedido(pedido_id INTEGER) RETURN VARCHAR2 IS
        estado_pedido VARCHAR2(50);
    BEGIN
        SELECT Estado_Pedido INTO estado_pedido FROM Pedido WHERE Id_Pedido = pedido_id;
        RETURN estado_pedido;
    END;

    /*Función para calcular la cantidad total de productos en stock por sucursal:*/
    FUNCTION total_productos_en_stock_sucursal(sucursal_id INTEGER) RETURN INTEGER IS
        total_stock INTEGER;
    BEGIN
        SELECT SUM(Cantidad_Producto) INTO total_stock
        FROM Producto P
        JOIN Pedido PE ON P.Id_Pedido = PE.Id_Pedido
        JOIN Sucursal S ON PE.Id_Sucursal = S.Id_Sucursal
        WHERE S.Id_Sucursal = sucursal_id;
        RETURN total_stock;
    END;

    /* Agrega aquí el cuerpo de otras funciones si es necesario */

END Funciones_Utilitarias;

--Vistas
CREATE OR REPLACE PACKAGE Paquete_Vistas AS

    /* Procedimiento para obtener los detalles de un pedido */
    PROCEDURE Obtener_Detalles_Pedido(result_cursor OUT SYS_REFCURSOR);

    /* Procedimiento para obtener empleados activos */
    PROCEDURE Obtener_Empleados_Activos(result_cursor OUT SYS_REFCURSOR);

    /* Procedimiento para obtener productos vencidos */
    PROCEDURE Obtener_Productos_Vencidos(result_cursor OUT SYS_REFCURSOR);

    /* Procedimiento para obtener sucursales y direcciones */
    PROCEDURE Obtener_Sucursales_Direcciones(result_cursor OUT SYS_REFCURSOR);

    /* Procedimiento para obtener pedidos pendientes */
    PROCEDURE Obtener_Pedidos_Pendientes(result_cursor OUT SYS_REFCURSOR);

END Paquete_Vistas;


CREATE OR REPLACE PACKAGE BODY Paquete_Vistas AS

    /* Procedimiento para obtener los detalles de un pedido */
    PROCEDURE Obtener_Detalles_Pedido(result_cursor OUT SYS_REFCURSOR) IS
    BEGIN
        OPEN result_cursor FOR
        SELECT P.Id_Pedido, S.Nombre_Sucursal, P.Descripcion_Pedido, P.Estado_Pedido
        FROM Pedido P
        INNER JOIN Sucursal S ON P.Id_Sucursal = S.Id_Sucursal;
    END Obtener_Detalles_Pedido;

    /* Procedimiento para obtener empleados activos */
    PROCEDURE Obtener_Empleados_Activos(result_cursor OUT SYS_REFCURSOR) IS
    BEGIN
        OPEN result_cursor FOR
        SELECT E.Id_Empleado, E.Nombre_Empleado, E.Apellido_Empleado
        FROM Empleado E
        WHERE E.Estado_Empleado = 'Activo';
    END Obtener_Empleados_Activos;

    /* Procedimiento para obtener productos vencidos */
    PROCEDURE Obtener_Productos_Vencidos(result_cursor OUT SYS_REFCURSOR) IS
    BEGIN
        OPEN result_cursor FOR
        SELECT P.Id_Producto, P.Nombre_Producto, P.Fecha_Vencimiento
        FROM Producto P
        WHERE P.Fecha_Vencimiento < SYSDATE;
    END Obtener_Productos_Vencidos;

    /* Procedimiento para obtener sucursales y direcciones */
    PROCEDURE Obtener_Sucursales_Direcciones(result_cursor OUT SYS_REFCURSOR) IS
    BEGIN
        OPEN result_cursor FOR
        SELECT S.Id_Sucursal, S.Nombre_Sucursal, D.Provincia, D.Canton, D.Distrito
        FROM Sucursal S
        INNER JOIN Direccion D ON S.Id_Direccion = D.Id_Direccion;
    END Obtener_Sucursales_Direcciones;

    /* Procedimiento para obtener pedidos pendientes */
    PROCEDURE Obtener_Pedidos_Pendientes(result_cursor OUT SYS_REFCURSOR) IS
    BEGIN
        OPEN result_cursor FOR
        SELECT P.Id_Pedido, S.Nombre_Sucursal, P.Descripcion_Pedido
        FROM Pedido P
        INNER JOIN Sucursal S ON P.Id_Sucursal = S.Id_Sucursal
        WHERE P.Estado_Pedido = 'Pendiente';
    END Obtener_Pedidos_Pendientes;

END Paquete_Vistas;
/


--Cursores
CREATE OR REPLACE PACKAGE paquete_operaciones AS
    -- Procedimiento para obtener direcciones por provincia
    PROCEDURE obtener_direcciones_por_provincia;

    -- Procedimiento para obtener empleados por sucursal
    PROCEDURE ObtenerEmpleadosPorSucursal (
        p_Id_Sucursal IN INTEGER
    );

    -- Procedimiento para obtener productos vencidos
    PROCEDURE ObtenerProductosVencidos;
END paquete_operaciones;
/

CREATE OR REPLACE PACKAGE BODY paquete_operaciones AS
    -- Procedimiento para obtener direcciones por provincia
    PROCEDURE obtener_direcciones_por_provincia AS
    BEGIN
        FOR direccion IN (
            SELECT D.Provincia, COUNT(*) AS Cantidad_Direcciones
            FROM Direccion D
            GROUP BY D.Provincia
        ) LOOP
            DBMS_OUTPUT.PUT_LINE('Provincia: ' || direccion.Provincia || ', Cantidad de Direcciones: ' || direccion.Cantidad_Direcciones);
        END LOOP;
    END obtener_direcciones_por_provincia;

    -- Procedimiento para obtener empleados por sucursal
    PROCEDURE ObtenerEmpleadosPorSucursal (
        p_Id_Sucursal IN INTEGER
    ) AS
        CURSOR c_empleados_por_sucursal IS
            SELECT Nombre_Empleado, Apellido_Empleado
            FROM Empleado
            WHERE Id_Sucursal = p_Id_Sucursal;

        v_nombre_empleado Empleado.Nombre_Empleado%TYPE;
        v_apellido_empleado Empleado.Apellido_Empleado%TYPE;
    BEGIN
        OPEN c_empleados_por_sucursal;
        LOOP
            FETCH c_empleados_por_sucursal INTO v_nombre_empleado, v_apellido_empleado;
            EXIT WHEN c_empleados_por_sucursal%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('Nombre: ' || v_nombre_empleado || ', Apellido: ' || v_apellido_empleado);
        END LOOP;
        CLOSE c_empleados_por_sucursal;
    END;

    -- Procedimiento para obtener productos vencidos
    PROCEDURE ObtenerProductosVencidos AS
        CURSOR c_productos_vencidos IS
            SELECT Nombre_Producto, Fecha_Vencimiento
            FROM Producto
            WHERE Fecha_Vencimiento < SYSDATE;

        v_nombre_producto Producto.Nombre_Producto%TYPE;
        v_fecha_vencimiento Producto.Fecha_Vencimiento%TYPE;
    BEGIN
        OPEN c_productos_vencidos;
        LOOP
            FETCH c_productos_vencidos INTO v_nombre_producto, v_fecha_vencimiento;
            EXIT WHEN c_productos_vencidos%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('Producto: ' || v_nombre_producto || ', Fecha de Vencimiento: ' || v_fecha_vencimiento);
        END LOOP;
        CLOSE c_productos_vencidos;
    END;
END paquete_operaciones;
/
