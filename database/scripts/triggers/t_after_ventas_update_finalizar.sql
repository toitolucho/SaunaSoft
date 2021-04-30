
DELIMITER $$
 
CREATE TRIGGER t_after_Ventas_finalizado_update2
AFTER UPDATE
ON ventasservicio FOR EACH ROW
BEGIN
	

	
	declare msg varchar(128);
    declare nroTuplas int;
	IF(new.codigoestadoventa='F') THEN    
	
		
		set nroTuplas = (select count(vs.IdVentaServicio) FROM ventasservicio vs join ventasserviciodetallearticulos vsd on vs.IdVentaServicio = vs.IdVentaServicio join articulos a on a.IdArticulo = vsd.IdArticulo WHERE vsd.Cantidad>a.CantidadExistencia and vs.IdVentaServicio = new.IdVentaServicio);
		
    	IF (nroTuplas is null or nroTuplas <1) THEN
        
            UPDATE articulos
            join ventasserviciodetallearticulos vsda
            on articulos.IdArticulo = vsda.IdArticulo
            join ventasservicio vs
            on vs.IdVentaServicio = vsda.IdVentaServicio
            set articulos.CantidadExistencia = articulos.CantidadExistencia - vsda.Cantidad
            where new.codigoestadoventa='F' and vs.IdVentaServicio = new.IdVentaServicio;
       
        ELSE
        

            set msg = concat('ActualizarExistenciaTriggerError: Esta intentando finalizar una venta con una existencia insuficiente en su almacen: ', cast(new.IdVentaServicio as char));
            signal sqlstate '45000' set message_text = msg;
        
        END IF;
    END IF;
    
	
	
	

	
END$$
 
DELIMITER ;