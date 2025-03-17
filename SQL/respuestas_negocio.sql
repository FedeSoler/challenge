USE [ECOMMERCE_DB]
GO

--Datos de ejemplo para poblar las tablas
/*

INSERT INTO CATEGORY (NOMBRE, DESCRIPCION, PATH)
VALUES 
    ('Celulares', 'Teléfonos móviles de diversas marcas y modelos', '/categorias/celulares'),
    ('Muebles', 'Mobiliario para el hogar y oficina', '/categorias/muebles'),
    ('Vehículos', 'Automóviles, motocicletas y otros medios de transporte', '/categorias/vehiculos');


INSERT INTO ITEM (NOMBRE, DESCRIPCION, PRECIO, ESTADO, FECHA_BAJA, CATEGORY_ID)
VALUES 
    ('iPhone 11', 'Apple iPhone 11 64GB', 15000, 'Activo', NULL, 1),
    ('Samsung Galaxy S20', 'Samsung Galaxy S20 128GB', 899.99, 'Activo', NULL, 1),
    ('Sofá de 3 plazas', 'Sofá cómodo de tela', 450.00, 'Activo', NULL, 2),
    ('Mesa de comedor', 'Mesa de madera para 6 personas', 700.00, 'Activo', NULL, 2),
    ('Toyota Corolla', 'Toyota Corolla 2020 automático', 15000.00, 'Activo', NULL, 3),
    ('Honda Civic', 'Honda Civic 2020 con motor turbo', 18000.00, 'Activo', NULL, 3),
    ('iPhone SE', 'Apple iPhone SE 2020', 399.99, 'Activo', NULL, 1);

INSERT INTO CUSTOMER (NOMBRE, APELLIDO, EMAIL, SEXO, DIRECCION, FECHA_NACIMIENTO, TELEFONO)
VALUES 
    ('José', 'Pérez', 'juan.perez@email.com', 'Masculino', 'Calle 123', '1985-06-15', '1122334455'),
    ('María', 'Gómez', 'maria.gomez@email.com', 'Femenino', 'Avenida 456', '1990-03-17', '2233445566'),
    ('Carlos', 'Ramírez', 'carlos.ramirez@email.com', 'Masculino', 'Ruta 789', '1982-12-10', '3344556677'),
	('Lucía', 'Fernández', 'lucia.fernandez@email.com', 'Femenino', 'Calle Las Rosas 12', '1995-04-03', '4455667788'),
    ('Martín', 'Gutiérrez', 'martin.gutierrez@email.com', 'Masculino', 'Avenida Los Álamos 34', '1988-11-25', '5566778899'),
    ('Sofía', 'López', 'sofia.lopez@email.com', 'Femenino', 'Boulevard Central 56', '2000-07-18', '6677889900');


INSERT INTO [ORDER] (FECHA_ORDER, BUYER_ID, SELLER_ID, ITEM_ID, CANTIDAD, PRECIO_VENTA, PRECIO_TOTAL)
VALUES 
    ('2020-01-05 10:15:00', 5, 1, 1, 5, 699.99, 3499.95),
    ('2020-01-10 14:30:00', 6, 2, 2, 3, 899.99, 2699.97),
    ('2020-01-15 09:00:00', 5, 2, 1, 4, 699.99, 2799.96),
    ('2020-01-20 16:45:00', 6, 4, 2, 2, 899.99, 1799.98),
    ('2020-02-03 11:00:00', 5, 1, 7, 6, 299.99, 1799.94),
    ('2020-02-15 13:20:00', 6, 2, 7, 5, 399.99, 1999.95),
    ('2020-03-07 09:40:00', 5, 3, 1, 3, 699.99, 2099.97),
    ('2020-03-25 18:00:00', 6, 4, 1, 4, 299.99, 1199.96),
    ('2020-04-01 10:00:00', 5, 1, 2, 2, 799.99, 1599.98),
    ('2020-04-22 15:45:00', 6, 2, 7, 6, 399.99, 2399.94),
    ('2020-05-05 09:30:00', 5, 3, 1, 2, 699.99, 1399.98),
    ('2020-05-28 20:00:00', 6, 4, 3, 5, 699.99, 3499.95),
    ('2020-06-12 11:45:00', 5, 1, 4, 3, 299.99, 899.97),
    ('2020-06-25 16:30:00', 6, 2, 7, 4, 399.99, 1599.96),
    ('2020-07-03 12:15:00', 5, 3, 5, 7, 999.99, 6999.93),
    ('2020-07-21 08:30:00', 6, 4, 6, 6, 799.99, 4799.94),
    ('2020-08-08 14:00:00', 5, 1, 1, 3, 299.99, 899.97),
    ('2020-08-19 19:10:00', 6, 2, 7, 4, 399.99, 1599.96),
    ('2020-09-04 10:45:00', 5, 3, 1, 3, 699.99, 2099.97),
    ('2020-09-28 22:00:00', 6, 4, 2, 2, 899.99, 1799.98),
    ('2020-10-14 11:30:00', 5, 1, 3, 5, 799.99, 3999.95),
    ('2020-10-29 17:50:00', 6, 2, 7, 3, 399.99, 1199.97),
    ('2020-11-07 09:20:00', 5, 3, 4, 4, 299.99, 1199.96),
    ('2020-11-22 15:30:00', 6, 4, 5, 6, 999.99, 5999.94),
    ('2020-12-05 13:10:00', 5, 1, 1, 2, 699.99, 1399.98),
    ('2020-12-18 20:40:00', 6, 2, 2, 3, 899.99, 2699.97),
    ('2021-02-15 14:10:00', 5, 3, 3, 2, 799.99, 1599.98),
    ('2021-07-20 09:30:00', 6, 4, 4, 1, 45000.00, 45000.00);

*/

/*
1. Listar los usuarios que cumplan años el día de hoy
cuya cantidad de ventas realizadas en enero 2020 sea superior a 1500. 
*/

SELECT 
    C.CUSTOMER_ID,
    C.NOMBRE,
    C.APELLIDO,
    COUNT(O.ORDER_ID) AS TOTAL_VENTAS
FROM CUSTOMER C
LEFT JOIN [ORDER] O ON C.CUSTOMER_ID = O.SELLER_ID
WHERE 
    MONTH(C.FECHA_NACIMIENTO) = MONTH(GETDATE()) 
    AND DAY(C.FECHA_NACIMIENTO) = DAY(GETDATE())
    AND MONTH(O.FECHA_ORDER) = 1 
    AND YEAR(O.FECHA_ORDER) = 2020
GROUP BY C.CUSTOMER_ID, C.NOMBRE, C.APELLIDO
HAVING COUNT(O.ORDER_ID) > 1500;


--Ahora yo cambié un poco el enunciado para corroborar la query (Cantidad ventas > 1)
--Como lo corrí el 17/03 el resultado sera para maria gomez que cumple esa fecha

SELECT 
    C.CUSTOMER_ID,
    C.NOMBRE,
    C.APELLIDO,
    COUNT(O.ORDER_ID) AS TOTAL_VENTAS
FROM CUSTOMER C
LEFT JOIN [ORDER] O ON C.CUSTOMER_ID = O.SELLER_ID
WHERE 
    MONTH(C.FECHA_NACIMIENTO) = MONTH(GETDATE()) 
    AND DAY(C.FECHA_NACIMIENTO) = DAY(GETDATE())
    AND MONTH(O.FECHA_ORDER) = 1 
    AND YEAR(O.FECHA_ORDER) = 2020
GROUP BY C.CUSTOMER_ID, C.NOMBRE, C.APELLIDO
HAVING COUNT(O.ORDER_ID) > 1;



/*
2. Por cada mes del 2020, se solicita el top 5 de usuarios que más vendieron($)
en la categoría Celulares. Se requiere el mes y año de análisis, nombre y apellido del vendedor,
cantidad de ventas realizadas, cantidad de productos vendidos y el monto total transaccionado
*/

WITH VentasPorMes AS (
    SELECT 
        MONTH(O.FECHA_ORDER) AS MES,
        YEAR(O.FECHA_ORDER) AS ANIO,
        C.NOMBRE,
        C.APELLIDO,
        SUM(O.PRECIO_TOTAL) AS MONTO_TOTAL,
        COUNT(O.ORDER_ID) AS CANTIDAD_VENTAS,
        SUM(O.CANTIDAD) AS CANTIDAD_PRODUCTOS_VENDIDOS,
        ROW_NUMBER() OVER (PARTITION BY MONTH(O.FECHA_ORDER) ORDER BY SUM(O.PRECIO_TOTAL) DESC) AS RANK
    FROM [ORDER] O
    LEFT JOIN ITEM I ON O.ITEM_ID = I.ITEM_ID
    LEFT JOIN CUSTOMER C ON O.SELLER_ID = C.CUSTOMER_ID
    WHERE I.CATEGORY_ID = 1 --Es la categoria Celulares
    AND YEAR(O.FECHA_ORDER) = 2020
    GROUP BY MONTH(O.FECHA_ORDER), YEAR(O.FECHA_ORDER), C.NOMBRE, C.APELLIDO
)
SELECT 
    VM.MES,
    VM.ANIO,
    VM.NOMBRE,
    VM.APELLIDO,
    VM.CANTIDAD_VENTAS,
    VM.CANTIDAD_PRODUCTOS_VENDIDOS,
    VM.MONTO_TOTAL
FROM VentasPorMes VM
WHERE VM.RANK <= 5

/*
3. Se solicita poblar una nueva tabla con el precio y estado de los Ítems a fin del día.
Tener en cuenta que debe ser reprocesable. Vale resaltar que en la tabla Item,
vamos a tener únicamente el último estado informado por la PK definida. (Se puede resolver a través de StoredProcedure) 
*/
CREATE PROC InsertarHistorialItems
AS
BEGIN
    -- Insertamos el precio y estado de los ítems actuales en ITEM_HISTORY
    INSERT INTO ITEM_HISTORY (ITEM_ID, PRECIO, ESTADO) --Como no especifico la fecha, se va a cargar a la hora que corra el SP
    SELECT ITEM_ID, PRECIO, ESTADO
    FROM ITEM;
END;



