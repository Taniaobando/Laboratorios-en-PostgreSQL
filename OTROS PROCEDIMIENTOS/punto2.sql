ALTER TABLE sucursal ADD COLUMN totalsalarios INTEGER;

SELECT codsucursal,SUM(salario) as totsalarios FROM empleado INNER JOIN empsucursal ON empleado.id=empsucursal.idempleado GROUP BY codsucursal ORDER BY codsucursal;


UPDATE sucursal SET totalsalarios=647086317 WHERE codsucursal=100;
UPDATE sucursal SET totalsalarios=811777183 WHERE codsucursal=200;
UPDATE sucursal SET totalsalarios=642650185 WHERE codsucursal=300;
UPDATE sucursal SET totalsalarios=718617873 WHERE codsucursal=400;
UPDATE sucursal SET totalsalarios=667474630 WHERE codsucursal=500;
UPDATE sucursal SET totalsalarios=684580823 WHERE codsucursal=600;
UPDATE sucursal SET totalsalarios=777466955 WHERE codsucursal=700;
UPDATE sucursal SET totalsalarios=606365290 WHERE codsucursal=800;

CREATE OR REPLACE FUNCTION updateTotalSal()

RETURNS TRIGGER AS $$

DECLARE 

tmptotsal INTEGER;

BEGIN


SELECT SUM(salario) INTO tmptotsal FROM empleado INNER JOIN empsucursal ON empleado.id=empsucursal.idempleado WHERE codsucursal= NEW.codsucursal;

UPDATE sucursal SET totalsalarios=tmptotsal WHERE codsucursal=NEW.codsucursal;

RETURN NULL;
END; $$ LANGUAGE 'plpgsql';

CREATE TRIGGER updateTotalSal AFTER INSERT OR UPDATE ON empsucursal FOR EACH ROW EXECUTE PROCEDURE updateTotalSal();

UPDATE empsucursal SET salario=1000000 WHERE idempleado=1;

SELECT id,codsucursal FROM empleado INNER JOIN empsucursal ON empleado.id=empsucursal.idempleado WHERE id=1;

SELECT * from sucursal;

UPDATE empsucursal SET salario=2000000 WHERE idempleado=1;

SELECT * from sucursal;

INSERT INTO empsucursal (codsucursal,idempleado,codcargo,salario) VALUES (600,1500,1,1000000);

SELECT * from sucursal;
