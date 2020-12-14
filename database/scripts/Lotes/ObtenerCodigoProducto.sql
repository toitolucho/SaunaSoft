DELIMITER $$
 
CREATE FUNCTION ObtenerCodigoProducto(
    IdCategoria1 INT
) 
RETURNS CHAR(10)
DETERMINISTIC
BEGIN
    DECLARE CodigoCategoria CHAR(10);
	DECLARE CantidadArticulos INT;
 
    SELECT count(idArticulo) INTO CantidadArticulos
    FROM Articulos
    WHERE IdCategoria = IdCategoria1;
	
	SET CantidadArticulos = CantidadArticulos + 1;
	
	SET CodigoCategoria = RIGHT(CONCAT('0000000' , CAST(CantidadArticulos AS VARCHAR(10))),7);
	
    
    SELECT IF( EXISTS(
             SELECT IdCategoria
             FROM Categorias
             WHERE IdCategoria = IdCategoria1),
              CONCAT(IdCategoria1, '-',CodigoCategoria), 
              CodigoCategoria) into CodigoCategoria;
	
    -- return the customer level
    RETURN ( CodigoCategoria);
END$$
DELIMITER ;