class Tennis {
  final int id;
  final String nombre;
  final double precio;
  final String descripcion;
  final String imagen;

  Tennis(
    this.id,
    this.nombre,
    this.precio,
    this.descripcion,
    this.imagen,
  );

  Tennis.fromJson(Map<String, dynamic> json)
      : id = json["idProducto"],
        nombre = json["nombre"],
        precio = json["precio"].toDouble(),
        descripcion = json["descripccion"],
        imagen = json["image_name"];


  Map<String, dynamic> toJson() => {
        "idProducto": id,
        "nombre": nombre,
        "precio": precio,
        "descripccion": descripcion,
        "image_name": imagen,
      };
}
