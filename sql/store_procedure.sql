-- Function: importaciones_db.sp_proceso_carga()

-- DROP FUNCTION importaciones_db.sp_proceso_carga();

CREATE OR REPLACE FUNCTION importaciones_db.sp_proceso_carga()
  RETURNS void AS
$BODY$
declare
	v_rs_record record;
	v_id_pais_origen integer;
	v_id_aduana_ingreso integer;
	v_id_pais_id_aduana integer;
	v_id_marca integer;
	v_id_modelo_lanzamiento integer;
	v_id_linea integer;
	v_id_linea_modelo integer;
	v_id_tipo_vehiculo integer;
	v_id_tipo_combustible integer;
	v_id_tipo_importador integer;
begin

   /*
      select * from importaciones_db.sp_proceso_carga();
   */
	
	update importaciones_db.tablatemporal set
		pais_de_proveniencia = upper(trim(pais_de_proveniencia)),
		aduana_de_ingreso = upper(trim(aduana_de_ingreso)),
		fecha_de_la_poliza = upper(trim(fecha_de_la_poliza)),
		modelo_del_vehiculo = upper(trim(modelo_del_vehiculo)),
		marca = upper(trim(marca)),
		linea = upper(trim(linea)),
		centimetros_cubicos = upper(trim(centimetros_cubicos)),
		tipo_de_vehiculo = upper(trim(tipo_de_vehiculo)),
		tipo_de_importador = upper(trim(tipo_de_importador)),
		tipo_combustible = upper(trim(tipo_combustible)),
		asientos = upper(trim(asientos)),
		puertas = upper(trim(puertas)),
		tonelaje = upper(trim(tonelaje)),
		valor_cif = upper(trim(valor_cif)),
		impuesto = upper(trim(impuesto))
	;

	update importaciones_db.tablatemporal set marca = 'GREAT DANE'
	where marca = 'GRATE DANE';

	update importaciones_db.tablatemporal set linea = (
		case
			when linea in ('SINLINEA', 'SILINEA', '--') then 'SIN LINEA'
			when linea =  'SOUL !' then 'SOUL'
			else linea 
		end
	);

	delete from importaciones_db.importacion;
	delete from importaciones_db.pais_aduana;
	delete from importaciones_db.aduana_ingreso;
	delete from importaciones_db.pais_aduana;
	delete from importaciones_db.tipo_vehiculo;
	delete from importaciones_db.tipo_importador;
	delete from importaciones_db.tipo_combustible;
	delete from importaciones_db.linea_modelo;
	delete from importaciones_db.modelo_lanzamiento;
	delete from importaciones_db.marca;
	delete from importaciones_db.linea;
	
	-- INSERT INTO TABLE importaciones_db.pais_origen;
	
	insert into importaciones_db.pais_origen(nombre_pais_origen)
	select pais_de_proveniencia
	from importaciones_db.tablatemporal
	where pais_de_proveniencia not in (
		select nombre_pais_origen
		from importaciones_db.pais_origen
	)
	group by pais_de_proveniencia
	order by pais_de_proveniencia;

	-- INSERT INTO TABLE importaciones_db.aduana_ingreso

	insert into importaciones_db.aduana_ingreso(nombre_aduana_ingreso)
	select aduana_de_ingreso
	from importaciones_db.tablatemporal
	where aduana_de_ingreso not in (
		select nombre_aduana_ingreso
		from importaciones_db.aduana_ingreso
	)
	group by aduana_de_ingreso
	order by aduana_de_ingreso;

	-- INSERT INTO TABLE importaciones_db.pais_aduana

	insert into importaciones_db.pais_aduana (id_pais_origen, id_aduana_ingreso)
	select tb.id_pais_origen, tc.id_aduana_ingreso
	from (
		select ta.pais_de_proveniencia, ta.aduana_de_ingreso
		from importaciones_db.tablatemporal ta
		group by ta.pais_de_proveniencia, ta.aduana_de_ingreso
	) tx
		left join importaciones_db.pais_origen tb on tx.pais_de_proveniencia = tb.nombre_pais_origen
		left join importaciones_db.aduana_ingreso tc on tx.aduana_de_ingreso = tc.nombre_aduana_ingreso
	where (id_pais_origen, id_aduana_ingreso) not in (
		select id_pais_origen, id_aduana_ingreso
		from importaciones_db.pais_aduana
	);
	
	-- INSERT INTO TABLE importaciones_db.tipo_vehiculo
	
	insert into importaciones_db.tipo_vehiculo(nombre_tipo_vehiculo)
	select tipo_de_vehiculo
	from importaciones_db.tablatemporal
	where tipo_de_vehiculo not in (
		select nombre_tipo_vehiculo
		from importaciones_db.tipo_vehiculo
	)
	group by tipo_de_vehiculo
	order by tipo_de_vehiculo;
	
	-- INSERT INTO TABLE importaciones_db.tipo_vehiculo

	insert into importaciones_db.tipo_importador(nombre_tipo_importador)
	select tipo_de_importador
	from importaciones_db.tablatemporal
	where tipo_de_importador not in (
		select nombre_tipo_importador
		from importaciones_db.tipo_importador
	)
	group by tipo_de_importador
	order by tipo_de_importador;

	-- INSERT INTO TABLE importaciones_db.tipo_combustible

	insert into importaciones_db.tipo_combustible(nombre_tipo_combustible)
	select tipo_combustible
	from importaciones_db.tablatemporal
	where tipo_combustible not in (
		select nombre_tipo_combustible
		from importaciones_db.tipo_combustible
	)
	group by tipo_combustible
	order by tipo_combustible;

	-- INSERT INTO TABLE importaciones_db.modelo_lanzamiento

	insert into importaciones_db.modelo_lanzamiento(anio)
	select modelo_del_vehiculo
	from importaciones_db.tablatemporal
	where modelo_del_vehiculo not in (
		select anio
		from importaciones_db.modelo_lanzamiento
	)
	group by modelo_del_vehiculo
	order by modelo_del_vehiculo;

	-- INSERT INTO TABLE importaciones_db.marca

	insert into importaciones_db.marca(nombre_marca)
	select marca
	from importaciones_db.tablatemporal
	where marca not in (
		select nombre_marca
		from importaciones_db.marca
	)
	group by marca
	order by marca;
	
	-- INSERT INTO TABLE importaciones_db.linea
	
	insert into importaciones_db.linea(nombre_linea)
	select linea
	from importaciones_db.tablatemporal
	where linea not in (
		select nombre_linea
		from importaciones_db.linea
	)
	group by linea
	order by linea;

	-- INSERT INTO TABLE importaciones_db.linea_modelo

	insert into importaciones_db.linea_modelo(id_linea, id_modelo_lanzamiento, id_marca)
	select ta.id_linea, tb.id_modelo_lanzamiento, tc.id_marca
	from (
		select modelo_del_vehiculo, marca, linea
		from importaciones_db.tablatemporal
		group by modelo_del_vehiculo, marca, linea
	) tx, importaciones_db.linea ta, importaciones_db.modelo_lanzamiento tb, importaciones_db.marca tc
	where tx.linea = ta.nombre_linea
	and tx.modelo_del_vehiculo = tb.anio
	and tx.marca = tc.nombre_marca
	and (id_linea, id_modelo_lanzamiento, id_marca) not in (
		select id_linea, id_modelo_lanzamiento, id_marca
		from importaciones_db.linea_modelo
	);
	
	
	for v_rs_record in
		select *
		from importaciones_db.tablatemporal
	loop
		
		v_id_pais_origen := null;
		v_id_pais_origen := (
			select id_pais_origen
			from importaciones_db.pais_origen
			where nombre_pais_origen = v_rs_record.pais_de_proveniencia
		);
		
		v_id_aduana_ingreso := null;
		v_id_aduana_ingreso := (
			select id_aduana_ingreso
			from importaciones_db.aduana_ingreso
			where nombre_aduana_ingreso = v_rs_record.aduana_de_ingreso
		);

		
		v_id_pais_id_aduana := null;
		v_id_pais_id_aduana := (
			select id_pais_id_aduana
			from importaciones_db.pais_aduana
			where id_pais_origen = v_id_pais_origen
			and id_aduana_ingreso = v_id_aduana_ingreso
		);
		
		v_id_marca := null;
		v_id_marca := (
			select id_marca
			from importaciones_db.marca
			where nombre_marca = v_rs_record.marca
		);

		v_id_modelo_lanzamiento := null;
		v_id_modelo_lanzamiento := (
			select id_modelo_lanzamiento
			from importaciones_db.modelo_lanzamiento
			where anio= v_rs_record.modelo_del_vehiculo 
		);

		v_id_linea := null;
		v_id_linea := (
			select id_linea
			from importaciones_db.linea
			where nombre_linea = v_rs_record.linea
		);

		v_id_linea_modelo := null;
		v_id_linea_modelo := (
			select id_linea_modelo
			from importaciones_db.linea_modelo
			where id_marca = v_id_marca
			and id_modelo_lanzamiento = v_id_modelo_lanzamiento
			and id_linea = v_id_linea
			
		);

		v_id_tipo_vehiculo := null;
		v_id_tipo_vehiculo := (
			select id_tipo_vehiculo
			from importaciones_db.tipo_vehiculo
			where nombre_tipo_vehiculo = v_rs_record.tipo_de_vehiculo
		);

		v_id_tipo_combustible := null;
		v_id_tipo_combustible := (
			select id_tipo_combustible
			from importaciones_db.tipo_combustible
			where nombre_tipo_combustible = v_rs_record.tipo_combustible
		);

		v_id_tipo_importador := null;
		v_id_tipo_importador := (
			select id_tipo_importador
			from importaciones_db.tipo_importador
			where nombre_tipo_importador = v_rs_record.tipo_de_importador
		);
		
		insert into importaciones_db.importacion (
			id_pais_id_aduana,
			id_linea_modelo,
			id_tipo_vehiculo,
			id_tipo_combustible,
			id_tipo_importador,
			fecha_importacion,
			valor_cif,
			impuesto,
			puertas,
			tonelaje,
			asientos
		)
		select
			v_id_pais_id_aduana,
			v_id_linea_modelo,
			v_id_tipo_vehiculo,
			v_id_tipo_combustible,
			v_id_tipo_importador,
			v_rs_record.fecha_de_la_poliza::date,
			v_rs_record.valor_cif::numeric(10,3),
			v_rs_record.impuesto::numeric(10,3),
			v_rs_record.puertas::integer,
			v_rs_record.tonelaje::numeric::integer,
			v_rs_record.asientos::integer
		;
		
	end loop;
	
   
end;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;