CREATE TABLE Clientes
(
	IdCliente			SERIAL,
	ci					CHAR(10),
	Nombres				VARCHAR(100) NOT NULL,
	Apellidos			varchar(100),
	NroCelular			INT,
	CorreoElectronico	VARCHAR(200),
	FechaNacimiento		DATE,
	FechaRegistro		timestamp ,
	NroVisitas			INT,
	PRIMARY KEY (IdCliente)
)


CREATE TABLE Usuarios
(
	IdUsuario				SERIAL,
	NombreCompleto			VARCHAR(200),
	NombreUsuario			VARCHAR(100),
	Contrasenia				VARCHAR(100),
	FechaRegistro			timestamp ,
	Direccion				VARCHAR(100),
	TipoUsuario				CHAR(1),--'S'->SECRETARIA, --'A'->ADMINISTRADOR, 'V'->VENDEDOR	
	CodigoEstado			CHAR(1),-- 'V'->VIGENTE, 'B'->BAJA, 'S'->SUSPENDIDO
	PRIMARY KEY(IdUsuario)
)

CREATE TABLE Categorias
(
	IdCategoria		SERIAL,
	NombreCategoria	VARCHAR(300) UNIQUE,
	PRIMARY KEY(IdCategoria)
)

CREATE TABLE Articulos
(
	IdArticulo			SERIAL,
	CodigoArticulo		CHAR(10) UNIQUE	NULL ,
	NombreArticulo		VARCHAR(200),
	IdCategoria			INT,
	CantidadExistencia	INT,
	PrecioVigente		DECIMAL(10,2),
	TotalValorado		DECIMAL(10,2), --AUTOCALCULABLE
	TipoInventario		CHAR(1), ----'P'->PEPS, 'U'->UEPS, 'O'->PONDERADO(PROMEDIADO)
	Descripcion			VARCHAR(500),
	FechaVencimiento	DATE,
	PRIMARY KEY(IdArticulo),
	FOREIGN KEY (IdCategoria) REFERENCES Categorias(IdCategoria)
)

CREATE TABLE ComprasArticulos  --COMPRA
(
	IdCompraArticulo	SERIAL,
	IdUsuario			INT,
	FechaHoraRegistro	timestamp ,
	CodigoEstadoIngreso	CHAR(1),-- 'I'->iniciado, 'A'->anulado, 'F'->Finalizado
	Observaciones		VARCHAR(1000),
	PRIMARY KEY (IdCompraArticulo),
	FOREIGN KEY (IdUsuario) REFERENCES Usuarios(IdUsuario)
)

CREATE TABLE ComprasArticulosDetalle
(
	IdCompraArticulo	INT,
	IdArticulo			INT,
	Cantidad			INT	NOT NULL,
	Precio				DECIMAL(10,2) NOT NULL,
	PRIMARY KEY(IdCompraArticulo, IdArticulo),
	FOREIGN KEY (IdCompraArticulo) REFERENCES ComprasArticulos(IdCompraArticulo),
	FOREIGN KEY (IdArticulo) REFERENCES Articulos(IdArticulo),
	CHECK(Cantidad > 0)
)

CREATE TABLE Membresia
(
	IdMembresia		SERIAL,
	IdCliente		INT,
	FechaInicio		DATE,
	FechaFin		DATE,
	CodigoEstado	CHAR(1), --'V'->VIGENTE , 'C'->CONCLUIDO
	CostoGeneral	DECIMAL(10,2),
	PRIMARY KEY (IdMembresia),
	FOREIGN KEY(IdCliente) REFERENCES Clientes(IdCliente)
)

CREATE TABLE Promociones
(
	IdPromocion			SERIAL,
	NombrePromocion		VARCHAR(200),
	FechaInicio			DATE,
	FechaFin			DATE,
	CodigoEstado		CHAR(1), --'V'->VIGENTE , 'C'->CONCLUIDO
	TipoPromocion		CHAR(1), --'D'->DESCUENTO, 'C'->Cumpleaños ,  'N'->N X UNO , 'P' -> DESCUENTO POR PUNTOS DE VISITA
	PorcentajeDescuento	DECIMAL(10,2),
	NroPersonas			INT  DEFAULT 1,
	Descripcion			VARCHAR(500),
	PRIMARY KEY (IdPromocion)
)



CREATE TABLE PromocionDetalleClientes
(
	IdPromocion		 INT,
	IdCliente		 INT,
	PRIMARY KEY(IdPromocion, IdCliente),
	FOREIGN KEY(IdPromocion) REFERENCES Promociones(IdPromocion),
	FOREIGN KEY(IdCliente) REFERENCES Clientes(IdCliente)
)


CREATE TABLE Servicios
(
	IdServicio		SERIAL,
	NombreServicio	VARCHAR(200) UNIQUE,
	Descripcion		VARCHAR(500),
	CostoServicio	DECIMAL(10,2),
	PRIMARY KEY(IdServicio)
)


CREATE TABLE VentasServicio
(
	IdVentaServicio		SERIAL,
	IdUsuario			INT, --el que hace la venta	
	IdCliente			INT,
	FechaHoraVenta		timestamp ,
	CodigoEstadoVenta	CHAR(1),-- 'I'->iniciado, 'A'->anulado, 'F'->Finalizado	
	IdPromocion			INT,
	NroPersonas			INT,
	Observaciones		VARCHAR(1000),	
	PRIMARY KEY(IdVentaServicio),
	FOREIGN KEY(IdUsuario)REFERENCES  Usuarios(IdUsuario),
	FOREIGN KEY (IdCliente) REFERENCES Clientes(IdCliente)
)

CREATE TABLE VentasServicioDetalle
(
	IdVentaServicio			INT,
	IdServicio				INT,	
	Costo					DECIMAL(10,2),
	PRIMARY KEY (IdVentaServicio, IdServicio),
	FOREIGN KEY (IdVentaServicio) REFERENCES VentasServicio(IdVentaServicio),
	FOREIGN KEY (IdServicio) REFERENCES Servicios(IdServicio)
)


CREATE TABLE VentasServicioDetalleClientes
(
	IdVentaServicio			INT,
	IdCliente				INT,			
	PRIMARY KEY (IdVentaServicio, IdCliente),
	FOREIGN KEY (IdVentaServicio) REFERENCES VentasServicio(IdVentaServicio),
	FOREIGN KEY (IdCliente) REFERENCES Clientes(IdCliente)
)

CREATE TABLE VentasServicioDetalleArticulos
(
	IdVentaServicio		INT,
	IdArticulo			INT,
	Cantidad			INT,
	Costo				DECIMAL(10,2),
	PRIMARY KEY (IdVentaServicio, IdArticulo),
	FOREIGN KEY (IdVentaServicio) REFERENCES VentasServicio(IdVentaServicio),
	FOREIGN KEY (IdArticulo) REFERENCES Articulos(IdArticulo)

)

--NOTIFICACIONES

--RESERVAS