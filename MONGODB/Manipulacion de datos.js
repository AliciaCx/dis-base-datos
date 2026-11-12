// 1. Actualiza el número de teléfono de la persona con el DNI "01234567T" a "900123456".
db.clientes.updateOne(
  { "DNI": "01234567T" },
  { $set: { "telefono": 900123456 } }
)
// 2. Inserta un nuevo documento con los mismos campos que el original, pero con el DNI "98765432A" y el nombre "Carlos".
db.clientes.insertOne({
  "DNI": "98765432A",
  "nombre": "Carlos",
  "apellidos": "Pérez Gómez",
  "telefono": 801234568,
  "ciudad": "Barcelona",
  "tipo_piel_cabello": "piel grasa",
  "tipo": {
    "vip": null,
    "premium": null
  }
})

// 3. Actualiza todos los documentos de la ciudad "Girona" para que el valor del campo tipo_piel_cabello sea "piel sensible".
db.clientes.updateMany({ "ciudad": "Girona" },{ $set: { "tipo_piel_cabello": "piel sensible" } })

// 4. Elimina todos los productos que no tengan ninguna versión especial (versiones_especiales).
db.productos.deleteMany({ "versiones_especiales": { $exists: false } })

// 5. Actualiza el nombre del producto con num_producto "42632" a "Sérum Revitalizante Ultra" y su precio a 120.
db.collection.updateOne(
  { "num_producto": "42632" },
  { $set: { "nombre": "Sérum Revitalizante Ultra", "precio": 120 } }
)
