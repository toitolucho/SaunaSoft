CREATE TABLE TiposClientes
(
	IdTipoCliente		INT NOT NULL AUTO_INCREMENT,
	Descripcion			VARCHAR(100),
	PRIMARY KEY (IdTipoCliente)
);



CREATE TABLE Clientes
(
	IdCliente			INT NOT NULL AUTO_INCREMENT,
	ci					CHAR(10),
	Nombres				VARCHAR(100) NOT NULL,
	Apellidos			varchar(100),
	NroCelular			INT,
	CorreoElectronico	VARCHAR(200),
	FechaNacimiento		DATE,
	FechaRegistro		timestamp ,
	NroVisitas			INT,
	Sexo				CHAR(1), -- 'F'->FEMENINO, 'M'->MASCULINO
	IdTipoCliente		INT,
	PRIMARY KEY (IdCliente),
	FOREIGN KEY (IdTipoCliente) REFERENCES TiposClientes(IdTipoCliente)
);


CREATE TABLE Usuarios
(
	IdUsuario				INT NOT NULL AUTO_INCREMENT,
	NombreCompleto			VARCHAR(200),
	NombreUsuario			VARCHAR(100),
	Contrasenia				VARCHAR(100),
	FechaRegistro			timestamp ,
	Direccion				VARCHAR(100),
	TipoUsuario				CHAR(1), -- 'S'->SECRETARIA, 'A'->ADMINISTRADOR, 'V'->VENDEDOR	
	CodigoEstado			CHAR(1), -- 'V'->VIGENTE, 'B'->BAJA, 'S'->SUSPENDIDO
	PRIMARY KEY(IdUsuario)
);

CREATE TABLE Categorias
(
	IdCategoria		INT NOT NULL AUTO_INCREMENT,
	NombreCategoria	VARCHAR(300) UNIQUE,
	PRIMARY KEY(IdCategoria)
);

CREATE TABLE Articulos
(
	IdArticulo			INT NOT NULL AUTO_INCREMENT,
	CodigoArticulo		CHAR(10) NULL ,
	NombreArticulo		VARCHAR(200),
	IdCategoria			INT,
	CantidadExistencia	INT,
	PrecioVigente		DECIMAL(10,2),
	TotalValorado		DECIMAL(10,2), -- AUTOCALCULABLE
	TipoInventario		CHAR(1), -- --'P'->PEPS, 'U'->UEPS, 'O'->PONDERADO(PROMEDIADO)
	Descripcion			VARCHAR(500),
	FechaVencimiento	DATE,
	PRIMARY KEY(IdArticulo),
	FOREIGN KEY (IdCategoria) REFERENCES Categorias(IdCategoria)
);

CREATE TABLE Proveedores (
  IdProveedor int(11) NOT NULL AUTO_INCREMENT,
  NombreRazonSocial varchar(200) DEFAULT NULL,
  NombreRepresentante varchar(200) DEFAULT NULL,
  Direccion varchar(150) DEFAULT NULL,
  NroCelular char(10) DEFAULT NULL,
  PRIMARY KEY (IdProveedor)
);

CREATE TABLE ComprasArticulos  -- COMPRA
(
	IdCompraArticulo	INT NOT NULL AUTO_INCREMENT,
	IdUsuario			INT,
	FechaHoraRegistro	timestamp ,
	CodigoEstadoIngreso	CHAR(1),-- 'I'->iniciado, 'A'->anulado, 'F'->Finalizado
	IdProveedor			INT,
	Observaciones		VARCHAR(1000),
	PRIMARY KEY (IdCompraArticulo),
	FOREIGN KEY (IdUsuario) REFERENCES Usuarios(IdUsuario),
	FOREIGN KEY (IdProveedor) REFERENCES proveedores(IdProveedor)
);

CREATE TABLE ComprasArticulosDetalle
(
	IdCompraArticulo	INT,
	IdArticulo			INT,
	Cantidad			INT,
	Precio				DECIMAL(10,2) NOT NULL, 	
    -- CHECK(Cantidad > 0),
	PRIMARY KEY(IdCompraArticulo, IdArticulo),
	FOREIGN KEY (IdCompraArticulo) REFERENCES ComprasArticulos(IdCompraArticulo),
	FOREIGN KEY (IdArticulo) REFERENCES Articulos(IdArticulo)
	
);

CREATE TABLE Membresia
(
	IdMembresia		INT NOT NULL AUTO_INCREMENT,
	IdCliente		INT,
	FechaRegistro	DATE,
	FechaInicio		DATE,
	FechaFin		DATE,
	CodigoEstado	CHAR(1), -- 'V'->VIGENTE , 'C'->CONCLUIDO
	CostoGeneral	DECIMAL(10,2),
	PRIMARY KEY (IdMembresia),
	FOREIGN KEY(IdCliente) REFERENCES Clientes(IdCliente)
);

CREATE TABLE Servicios
(
	IdServicio		INT NOT NULL AUTO_INCREMENT,
	NombreServicio	VARCHAR(200) UNIQUE,
	CodigoEstado	CHAR(1), -- 'A'->ACTIVO , 'I'->INACTIVO
	Descripcion		VARCHAR(500),
	CostoServicio	DECIMAL(10,2),
	PRIMARY KEY(IdServicio)
);

-- Tipos de Promociones
-- edad ->ninos adolescentes  		-> se necesita rango de edad

-- fecha dia festivo.				->Rango de Fechas
-- por periodo de tiempo ->			->Rango de Fechas

-- tipo cliente(membresia)		    -> universitario, del hotel, general, membresia  -> Se necesita numero id tipo cliente
-- por sexo ->						-> numero se neceista sexo entero 1 o 0
-- por regularidad de asistencia 	-> numero de asistencias entero 
-- 2 x uno							-> numero de personas

CREATE TABLE Promociones
(
	IdPromocion			INT NOT NULL AUTO_INCREMENT,
	NombrePromocion		VARCHAR(200),
	FechaRegistro		DATE,
	FechaInicio			DATE,
	FechaFin			DATE,
	CodigoEstado		CHAR(1), -- 'V'->VIGENTE , 'C'->CONCLUIDO
	TipoPromocion		CHAR(1), -- 'E'->POR EDAD, 'P'->PERIODO DE TIEMPO, 'F'->DIA FESTIVO, 'T'->TIPO CLIENTE, 'A'->ASISTENCIA, 'C'->Por Cantidad de Personas
	PorcentajeDescuento	DECIMAL(10,2),
	NroPersonas			INT  DEFAULT 1,
	Descripcion			VARCHAR(500),
	IdServicio			INT,
	PRIMARY KEY (IdPromocion),
	FOREIGN KEY (IdServicio) REFERENCES Servicios(IdServicio)
);



-- CREATE TABLE PromocionDetalleClientes
-- (
	-- IdPromocion		 INT,
	-- IdCliente		 INT,
	-- PRIMARY KEY(IdPromocion, IdCliente),
	-- FOREIGN KEY(IdPromocion) REFERENCES Promociones(IdPromocion),
	-- FOREIGN KEY(IdCliente) REFERENCES Clientes(IdCliente)
-- );




CREATE TABLE VentasServicio
(
	IdVentaServicio		INT NOT NULL AUTO_INCREMENT,
	IdUsuario			INT, -- el que hace la venta	
	IdCliente			INT,
	FechaHoraVenta		timestamp ,
	CodigoEstadoVenta	CHAR(1),-- 'I'->iniciado, 'A'->anulado, 'F'->Finalizado		
	NroCasillero		INT,
	NroPersonas			INT,	
	MontoTotalPago		DECIMAL(10,2),
	Observaciones		VARCHAR(1000),	
	PRIMARY KEY(IdVentaServicio),
	FOREIGN KEY(IdUsuario)REFERENCES  Usuarios(IdUsuario),
	FOREIGN KEY (IdCliente) REFERENCES Clientes(IdCliente)
	-- FOREIGN KEY (IdPromocion) REFERENCES Promociones(IdPromocion)
);

CREATE TABLE VentasServicioDetalle
(
	IdVentaServicio			INT,
	IdServicio				INT,	
	Costo					DECIMAL(10,2),
	NroPersonas				INT,
	IdPromocion				INT,
	PorcentajeDescuento		DECIMAL(10,2),
	CostoReal				DECIMAL(10,2),
	PRIMARY KEY (IdVentaServicio, IdServicio),
	FOREIGN KEY (IdVentaServicio) REFERENCES VentasServicio(IdVentaServicio),
	FOREIGN KEY (IdServicio) REFERENCES Servicios(IdServicio),
	FOREIGN KEY (IdPromocion) REFERENCES Promociones(IdPromocion)
);


CREATE TABLE VentasServicioDetalleClientes
(
	IdVentaServicio			INT,
	IdCliente				INT,			
	PRIMARY KEY (IdVentaServicio, IdCliente),
	FOREIGN KEY (IdVentaServicio) REFERENCES VentasServicio(IdVentaServicio),
	FOREIGN KEY (IdCliente) REFERENCES Clientes(IdCliente)
);

CREATE TABLE VentasServicioDetalleArticulos
(
	IdVentaServicio		INT,
	IdArticulo			INT,
	Cantidad			INT,
	Costo				DECIMAL(10,2),
	PRIMARY KEY (IdVentaServicio, IdArticulo),
	FOREIGN KEY (IdVentaServicio) REFERENCES VentasServicio(IdVentaServicio),
	FOREIGN KEY (IdArticulo) REFERENCES Articulos(IdArticulo)

);



