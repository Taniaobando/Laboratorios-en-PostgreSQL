
CREATE OR REPLACE FUNCTION cadenasempleadopagos(inp_id INTEGER)

RETURNS VARCHAR AS $$

DECLARE  
fila RECORD;
curs1 CURSOR IS SELECT empleado.nombre,empleado.apellido,empleado.ciudadres,fechapago,valor FROM empleado INNER JOIN pagonomina ON empleado.id=pagonomina.idempleado NATURAL JOIN detallepago WHERE empleado.id=inp_id;
Vartext VARCHAR :=''; 

BEGIN	
	FOR fila in curs1 LOOP
	Vartext:='Empleado: '|| fila.nombre ||''|| fila.apellido ||', ' || fila.ciudadres || E'\n' || 'Pago: ' || fila.fechapago || '; ' || fila.valor;
	RETURN Vartext;
	END LOOP;
END; $$ LANGUAGE 'plpgsql';

SELECT * FROM cadenasempleadopagos(1);