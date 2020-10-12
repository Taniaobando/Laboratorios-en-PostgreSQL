CREATE OR REPLACE FUNCTION rifamedicamentos ( INT inCodservicio)

RETURNS VOID AS $$

DECLARE

ran1 INTEGER;
ran2 INTEGER;
ran3 INTEGER;
contador INTEGER;
count INTEGER;
fila RECORD;
aux1 INTEGER;

curs1 CURSOR IS SELECT idpaciente,codRegistroSer FROM Paciente NATURAL JOIN registroGeneral NATURAL JOIN registroServicio  WHERE codServicio=inCodservicio and EXTRACT(MONTH FROM CURRENT_DATE)-EXTRACT(MONTH FROM fechaIniSer)<=1 ORDER BY idpaciente;


BEGIN

SELECT count(idpaciente) INTO contador FROM Paciente NATURAL JOIN registroGeneral NATURAL JOIN registroServicio WHERE codServicio=inCodservicio and EXTRACT(MONTH FROM CURRENT_DATE)-EXTRACT(MONTH FROM fechaIniSer)<=1;

	WHILE count < 3 LOOP

	SELECT trunc(random() * contador + 1) INTO ram1 FROM generate_series(1,1);

	SELECT trunc(random() * contador + 1) INTO ram2 FROM generate_series(1,1);

	SELECT trunc(random() * contador + 1) INTO ram3 FROM generate_series(1,1);

	IF ran1 != ran2 THEN
	   count:=count+1;
	
	END IF;

	IF ran2 != ran3 THEN
	count:=count+1;

	END IF;

	IF ran1 != ran3 THEN
	count:=count+1;
	END IF;

	IF count<3 THEN

	count:=0;

	END IF; 

	END  LOOP;

aux1 :=1;

FOR fila in curs1 LOOP

	IF aux1=ran1 and THEN
	UPDATE registroServicio SET preciopago=0 WHERE fila.codRegistroSer=registroservicio.codRegistroSer;
	END IF;
	IF aux1=ran2 THEN
	UPDATE registroServicio SET preciopago=0 WHERE fila.codRegistroSer=registroservicio.codRegistroSer;
	END IF;
	IF aux1=ran3 THEN 
	UPDATE registroServicio SET preciopago=0 WHERE fila.codRegistroSer=registroservcio.codRegistroSer;
	END IF;

	aux1:=aux1+1:

END LOOP;

END; $$ LANGUAGE 'plpgsql';

SELECT * FROM rifamedicamentos(1);

#SE ASUME QUE A LA PERSONA SE LE SUMINISTRO SOLO UNA VEZ EL MEDICAMENTO EN EL ULTIMO MES DE LO CONTRARIO EL MISMO PACIENTE PUEDE GANAR DESDE UNO O HASTA TRES SUMINISTROS DEL MEDICAMENTO QUE CONSUMIO EN EL ULTIMO MES.