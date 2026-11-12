use tienda;

-- 1. Mostrar la ciudad y dirección de todas las tiendas registradas.
select ciudad, direccion
from tienda;

-- 2. Mostrar el número de empleado, nombre y apellidos de los empleados que supervisan a otros.
select num_empleado, nombre, apellidos
from empleado 
where supervisa_a is not null;

-- 3. Obtener el nombre y ciudad de los clientes VIP
select nombre, ciudad
from cliente natural join vip;

-- 4. Obtener el código y el nombre de todos los cursos disponibles para maquilladores.
select*from curso;

-- 5. Mostrar el codigo de la categoria y su nombre, ordenadas alfabeticamente por nombre. Mostrar las 5 primeras
select cod_categoria, nombre
from categoria
order by nombre asc
limit 5;


-- 6. Mostrar el nombre, marca y precio de los productos cuyo precio sea mayor a 50.
select nombre, marca, precio
from producto 
where precio > 50;

-- 7. Mostrar los empleados que trabajan en la ciudad de Barcelona.
select*from empleado where ciudad = "Barcelona";

-- 8. Mostrar el número, nombre y precio de los productos que pertenecen a la categoría con código 15.
select num_producto, nombre, precio 
from PRODUCTO 
where cod_categoria = 15;

-- 9. Mostrar el nombre de los cursos cuyo nombre no terminen por "a".
select nombre
from curso 
where nombre not like "%a";

-- 10. Obtener el nombre y descripción de los productos recomendados por el profesional con código 1011.
select nombre, descripcion 
from producto inner join recomienda using (num_producto) 
where codigo = 1011;

-- 11. Obtener el nombre y apellidos de los clientes que han puntuado productos con una calificación mayor a 4, 
-- junto con el nombre del producto y su comentario.
select cliente.nombre, apellidos, producto.nombre as producto, comentario
from cliente inner join puntua on cliente.dni=puntua.dni 
			 inner join producto on puntua.num_producto = producto.num_producto
where nota > 4;

-- 12. Mostrar el nombre, apellidos y el total de productos adquiridos por cada cliente.
select nombre, apellidos, sum(cantidad) as total_productos
from cliente natural join compra
group by dni, nombre, apellidos;


-- 13. Mostrar el número de empleado de los maquilladores que están inscritos en más de un curso.
select num_empleado
from maquillador 
group by num_empleado
having count(codigo) > 1;

-- 14. Mostrar el nombre de los productos incluidos en el kit con código 300
select nombre
from producto natural join contiene
where cod_kit = 25;


-- 15. Obtener los nombres y descripciones de los productos que no han sido vendidos en ninguna tienda.
select nombre, descripcion
from producto 
where not exists (select*from vende where producto.num_producto = vende.num_producto);

-- 16. Obtener los clientes que no son VIP ni PREMIUM. Mostrar su DNI, nombre y apellidos
select dni, nombre, apellidos
from cliente
where dni not in(select dni from vip)
and dni not in (select dni from premium);

-- 17. Obtener los productos recomendados por profesionales ue no han recomendado productos a clientes con estatus VIP.
select*from producto
where num_producto in (select num_producto 
					   from recomienda 
                       where recomienda.dni not in (select dni from vip));

-- 18. Diseña una tabla llamada DEVOLUCION para registrar las devoluciones de productos realizadas por los clientes. 
-- La tabla debe contener las siguientes columnas:
-- num_transaccion (INT): El número de transacción asociado a la devolución.
-- num_producto (INT): El número del producto que está siendo devuelto.
-- DNI_cliente (VARCHAR(20)): El DNI del cliente que realiza la devolución.
-- cantidad (INT): La cantidad de productos devueltos.
-- fecha_devolucion (DATE): La fecha en la que se realiza la devolución.
CREATE TABLE DEVOLUCION (
    num_transaccion INT,
    num_producto INT,
    DNI_cliente VARCHAR(20),
    cantidad INT,
    fecha_devolucion DATE,
    PRIMARY KEY (num_transaccion, num_producto, DNI_cliente),
    FOREIGN KEY (num_producto) REFERENCES PRODUCTO(num_producto),
    FOREIGN KEY (DNI_cliente) REFERENCES CLIENTE(DNI)
);
select*from devolucion;

-- 19. Actualiza los precios de todos los productos de la categoria 15 en un 10% (aumentar el precio un 10%)
update producto
set precio=precio*1.1
where cod_categoria = 16;


