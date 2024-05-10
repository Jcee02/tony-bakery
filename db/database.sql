CREATE TABLE producto (
  Id_producto INTEGER NOT NULL PRIMARY KEY,
  Nombre_producto TEXT NOT NULL,
  Precio_Producto FLOAT NOT NULL,
  Unidad_medida_producto VARCHAR(50) NOT NULL);

CREATE TABLE detalle_perdida (
  Id_producto INTEGER NOT NULL,
  Id_perdida INTEGER NOT NULL,
  Cantidad_perdida INTEGER NOT NULL,
  Fecha_perdida DATE NOT NULL,
  CONSTRAINT fk_Id_producto FOREIGN KEY (Id_producto) REFERENCES producto(Id_producto));

CREATE TABLE perdida (
  Id_perdida INTEGER NOT NULL,
  Nombre_perdida VARCHAR(50) NOT NULL,
  Descripcion VARCHAR(50) NOT NULL,
  CONSTRAINT pk_Id_perdida PRIMARY KEY (Id_perdida));

CREATE TABLE detalle_materia_prima(
  Id_producto INTEGER NOT NULL,
  Id_materia INTEGER NOT NULL,
  Cantidad INTEGER NOT NULL,
  Fecha_elaboracion DATE NOT NULL);

CREATE TABLE materia_prima(
  Id_materia INTEGER NOT NULL,
  Nombre_mat VARCHAR(35) NOT NULL,
  Unidad_medida_mp VARCHAR(35) NOT NULL,
  Existencia INTEGER NOT NULL,
  CONSTRAINT pk_Id_materia PRIMARY KEY (Id_materia));

CREATE TABLE detalle_proveedor (
  Id_materia INTEGER NOT NULL,
  Id_proveedor INTEGER NOT NULL,
  Cantidad INTEGER NOT NULL,
  Fecha_ingreso DATE NOT NULL,
  Costo FLOAT NOT NULL);

CREATE TABLE proveedor (
  Id_proveedor INTEGER NOT NULL PRIMARY KEY,
  Nombre_comercial VARCHAR(50) NOT NULL,
  RFC_proveedor VARCHAR(13) NOT NULL,
  Direccion_proveedor VARCHAR(50) NOT NULL,
  Telefono INTEGER NOT NULL,
  Email_proveedor VARCHAR(50) NOT NULL);

CREATE TABLE detalle_pedido(
  Id_producto INTEGER NOT NULL,
  Id_pedido INTEGER NOT NULL,
  Cantidad_pedido INTEGER NOT NULL,
  Total_pagar FLOAT NOT NULL);

CREATE TABLE cliente (
  Id_cliente INTEGER NOT NULL,
  Nombre_comercial_cliente VARCHAR(50),
  Nombre_cliente VARCHAR(50) NOT NULL,
  Direccion_cliente VARCHAR(50) NOT NULL,
  Apellido_cliente VARCHAR(50) NOT NULL,
  Apep_cliente VARCHAR(50) NOT NULL,
  Email_cliente VARCHAR(50) NOT NULL,
  Telefono INTEGER NOT NULL,
  PRIMARY KEY (Id_cliente));

CREATE TABLE pedido (
  Id_pedido INTEGER NOT NULL,
  Fecha_pedido DATE NOT NULL,
  Id_cliente INTEGER NOT NULL,
  Id_empleado INTEGER NOT NULL,
  CONSTRAINT pk_Id_pedido PRIMARY KEY (Id_pedido));

CREATE TABLE empleado (
  Id_empleado INTEGER NOT NULL,
  Nombre_empleado VARCHAR(50) NOT NULL,
  Direccion_empleado VARCHAR(50) NOT NULL,
  Telefono_empleado INTEGER NOT NULL,
  Email_empleado VARCHAR(50) NOT NULL,
  NSS_empleado VARCHAR(50) NOT NULL,
  Puesto_empleado VARCHAR(50) NOT NULL,
  PRIMARY KEY (Id_empleado));

CREATE TABLE gasto_empresa(
  Id_gasto INTEGER NOT NULL,
  Id_proveedor INTEGER NOT NULL,
  Descripcion TEXT NOT NULL,
  Cantidad_gasto FLOAT NOT NULL,
  Fecha_gasto DATE NOT NULL,
  IVA FLOAT NOT NULL,
  Subtotal_gasto FLOAT NOT NULL,
  Total_gasto FLOAT NOT NULL,
  CONSTRAINT pk_Id_gasto PRIMARY KEY (Id_gasto));

CREATE TABLE detalle_venta(
  Id_producto INTEGER NOT NULL,
  Id_venta INTEGER NOT NULL,
  Cantidad_venta INTEGER NOT NULL,
  Subtotal_venta FLOAT NOT NULL,
  Total_venta FLOAT NOT NULL);

CREATE TABLE venta(
  Id_venta INTEGER NOT NULL PRIMARY KEY,
  Descripcion_venta VARCHAR(255) NOT NULL,
  Fecha_venta DATE NOT NULL,
  Id_cliente INTEGER NOT NULL);

CREATE TABLE credito (
  Id_credito INTEGER NOT NULL,
  Id_venta INTEGER NOT NULL,
  Monto_credito FLOAT NOT NULL,
  Fecha_pagar DATE NOT NULL,
  PRIMARY KEY (Id_credito));

CREATE TABLE sueldo (
  Id_sueldo INTEGER NOT NULL,
  Total_pago FLOAT,
  Fecha_pago DATE,
  Pago_dia FLOAT,
  Fecha_inicio_trabajo DATE,
  Fecha_fin_trabajo DATE,
  Id_empleado INTEGER NOT NULL,
  CONSTRAINT pk_Id_sueldo PRIMARY KEY (Id_sueldo),
  CONSTRAINT pk_Id_empleado FOREIGN KEY (Id_empleado) REFERENCES empleado(Id_empleado));