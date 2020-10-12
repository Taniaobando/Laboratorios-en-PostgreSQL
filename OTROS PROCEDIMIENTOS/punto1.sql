CREATE OR REPLACE FUNCTION Verificacionxpagos()

RETURNS TRIGGER AS $$

DECLARE 

TMPsalario INTEGER;
TMPbonificacion INTEGER;

BEGIN

IF NEW.codconcepto = 1

THEN
		 IF NEW.valor =	 (SELECT salario INTO TMPsalario FROM empsucursal NATURAL JOIN pagonomina WHERE pagonomina.nrocomprobante = NEW.nrocomprobante)	

		 THEN

		 RETURN NEW;

		 ELSE 

		 NEW.valor=TMPsalario;
		 RETURN NEW;
		 END IF;
END IF;

IF NEW.codconcepto = 2

THEN 
		IF NEW.valor = (SELECT (salario*bonificacion) INTO TMPbonificacion FROM empsucursal  NATURAL JOIN pagonomina WHERE pagonomina.nrocomprobante=NEW.nrocomprobante)

		THEN

		RETURN NEW;

		ELSE

		NEW.valor=TMPbonificacion;
		RETURN NEW;
		END IF;

END IF;

END; $$ LANGUAGE 'plpgsql';

CREATE TRIGGER Verificacionxpagos BEFORE INSERT OR UPDATE ON detallepago FOR EACH ROW EXECUTE PROCEDURE Verificacionxpagos();

INSERT INTO pagonomina
INSERT INTO detallepago (nrocomprobante,codconcepto,valor) VALUES (6603919,1,)