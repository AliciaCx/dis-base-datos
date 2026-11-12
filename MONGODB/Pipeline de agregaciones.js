// 1. Obtener los tipos de piel/cabello más comunes entre los clientes, mostrando solo aquellos con más de un cliente, 
// y ordenarlos de mayor a menor según su frecuencia.
db.clientes.aggregate([
    {$match: {"tipo_piel_cabello": {$ne:null}}}, 
    {$group: { _id: "$tipo_piel_cabello", total:{$sum:1}}}, 
    {$match: {total: {$gt:1}}},
    {$sort:{total:-1}])
    
// 2. Mostrar el numero de clientes por ciudad. 
db.clientes.aggregate([
    {$group: { _id: "$ciudad", num_clientes: { $sum: 1 }}},
    {$sort:{_id: 1}}}])

// 3. Calcular el precio promedio de los productos por categoría y mostrar las 3 categorías con el precio promedio más alto.   
db.productos.aggregate([
  {$match: { "precio": { $exists: true, $ne: null } } },
  {$group: { _id: "$cod_categoria", promedio: { $avg: "$precio" } } },
  {$sort: {promedio: -1 }},
  {$limit:3}])
  
// 4. Obtener el producto con el precio más bajo para cada categoría, mostrando el nombre del producto y el precio más bajo.

db.productos.aggregate([
  { $group: { _id: "$cod_categoria", producto_bajo_precio: { $min: "$precio" },nombre_producto: { $first: "$nombre" }}},
  { $sort: { "_id": 1 } }])

// 5. Calcular el número de productos que contiene los kits y el precio total esperado.
db.productos.aggregate([
  { $unwind: "$kits" },
  { $group: {_id: "$kits.nombre_kit",  num_productos: { $sum: 1 },  precio_total: { $sum: "$precio" }}},
  { $sort: { num_productos: -1 } }])


