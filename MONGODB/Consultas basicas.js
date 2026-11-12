// 1. Devolver los datos de un cliente cuyo DNI tenga la letra Z
db.clientes.findOne({ "DNI": { $regex: /Z/ } })

// 2. Devuelve todos los valores distintos que existen para el campo tipo_piel_cabello.
db.clientes.distinct("tipo_piel_cabello", {"tipo_piel_cabello": {$ne: null}})

// 3. Número de clientes que tienen el cabello fino
db.clientes.find({"tipo_piel_cabello": "cabello fino"}).count()
db.clientes.countDocuments({"tipo_piel_cabello": "cabello fino"})

// 4. Devolver el nombre y apellidos de los clientes que contengan en su apellido la S. Ordenar alfabeticamente por apellido.
db.clientes.find({ "apellidos": {$regex: /S/ }}, {"nombre":true, "apellidos":true, "_id":false}).sort({"apellidos": 1})

// 5. Devolver el nombre de los 3 primeros productos que tengan un precio mayor a 100
db.productos.find({ "precio": { $gt: 100 } },{"nombre":true, "_id":false}).limit(3)

// 6. Devolver alfabeticamete el nombre de los productos que tengan version especial. Mostrar los 5 primeros.
db.productos.find({"versiones_especiales":{$exists:true, $ne: null}}, 
                  {"nombre":true, "versiones_especiales.nombre_especial":true, _id:false}).sort({"nombre":1}).limit(5)
                  
// 7. Numero de productos que pretenecen a un kit.
db.productos.find({"kits": {$exists:true, $ne: null}}).count()
db.productos.countDocuments({"kits": {$exists:true, $ne: null}})

// 8. Devolver los productos cuyo precio sea mayor a 100 o su categoría sea "13".
db.productos.find({$or: [{ "precio": { $gt: 100 } },{ "cod_categoria": "13" }]})

