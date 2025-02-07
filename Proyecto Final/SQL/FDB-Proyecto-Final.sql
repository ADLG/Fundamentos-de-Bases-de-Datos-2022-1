PGDMP                          z            FDB-Proyecto-Final    10.18    10.18 �   q           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            r           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            s           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false            t           1262    116569    FDB-Proyecto-Final    DATABASE     �   CREATE DATABASE "FDB-Proyecto-Final" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Spanish_Spain.1252' LC_CTYPE = 'Spanish_Spain.1252';
 $   DROP DATABASE "FDB-Proyecto-Final";
             postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
             postgres    false            u           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                  postgres    false    3                        3079    12924    plpgsql 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
    DROP EXTENSION plpgsql;
                  false            v           0    0    EXTENSION plpgsql    COMMENT     @   COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';
                       false    1                       1255    117225    cliente_compras(integer)    FUNCTION     v  CREATE FUNCTION public.cliente_compras(id_c integer) RETURNS TABLE(efectivo bigint, tarjeta_de_debito bigint, tarjeta_de_credito bigint)
    LANGUAGE sql
    AS $$
	select T1.efectivo,T2.Tarjeta_de_Debito,T3.Tarjeta_de_Credito from 
	(select sum(total_productos) as efectivo from venta_fisica_r1 A
	join venta_fisica_r2 B on A.Numero_ticket = B.Numero_ticket join cliente_r1 C on A.codigo_cliente = C.codigo_cliente
	where A.codigo_cliente = C.codigo_cliente and A.forma_de_pago = 'Efectivo' and id_c = C.Id_Cliente) T1 ,

	(select sum(total_productos) as Tarjeta_de_Debito from venta_fisica_r1 A
	join venta_fisica_r2 B on A.Numero_ticket = B.Numero_ticket join cliente_r1 C on A.codigo_cliente = C.codigo_cliente
	where A.codigo_cliente = C.codigo_cliente and A.forma_de_pago = 'Tarjeta de Debito' and id_c = C.Id_Cliente) T2 ,

	(select sum(total_productos) as Tarjeta_de_Credito from venta_fisica_r1 A
	join venta_fisica_r2 B on A.Numero_ticket = B.Numero_ticket join cliente_r1 C on A.codigo_cliente = C.codigo_cliente
	where A.codigo_cliente = C.codigo_cliente and A.forma_de_pago = 'Tarjeta de Credito' and id_c = C.Id_Cliente) T3
$$;
 4   DROP FUNCTION public.cliente_compras(id_c integer);
       public       postgres    false    3            w           0    0 &   FUNCTION cliente_compras(id_c integer)    COMMENT     �   COMMENT ON FUNCTION public.cliente_compras(id_c integer) IS 'Funcion que recibe id de un cliente y regresa la informacion de sus tipos de pago.';
            public       postgres    false    258                       1255    117228    cliente_compras_hist(integer)    FUNCTION        CREATE FUNCTION public.cliente_compras_hist(id_c integer) RETURNS TABLE(nombre_cliente record, efectivo bigint, tarjeta_de_debito bigint, tarjeta_de_credito bigint)
    LANGUAGE sql
    AS $$
	SELECT T4,T1.efectivo,T2.Tarjeta_de_Debito,T3.Tarjeta_de_Credito FROM 
	(SELECT sum(total_productos) as efectivo FROM venta_fisica_r1 A
	JOIN venta_fisica_r2 B on A.Numero_ticket = B.Numero_ticket JOIN cliente_r1 C on A.codigo_cliente = C.codigo_cliente
	where A.codigo_cliente = C.codigo_cliente and A.forma_de_pago = 'Efectivo' and id_c = C.Id_Cliente) T1 ,

	(SELECT sum(total_productos) as Tarjeta_de_Debito FROM venta_fisica_r1 A
	JOIN venta_fisica_r2 B on A.Numero_ticket = B.Numero_ticket JOIN cliente_r1 C on A.codigo_cliente = C.codigo_cliente
	where A.codigo_cliente = C.codigo_cliente and A.forma_de_pago = 'Tarjeta de Debito' and id_c = C.Id_Cliente) T2 ,

	(SELECT sum(total_productos) as Tarjeta_de_Credito FROM venta_fisica_r1 A
	JOIN venta_fisica_r2 B on A.Numero_ticket = B.Numero_ticket JOIN cliente_r1 C on A.codigo_cliente = C.codigo_cliente
	where A.codigo_cliente = C.codigo_cliente and A.forma_de_pago = 'Tarjeta de Credito' and id_c = C.Id_Cliente) T3 ,

	(SELECT A.Nombre, A.Apellido_Paterno, A.Apellido_Materno FROM CLIENTE_R1 A where id_Cliente = id_c) T4
$$;
 9   DROP FUNCTION public.cliente_compras_hist(id_c integer);
       public       postgres    false    3            x           0    0 +   FUNCTION cliente_compras_hist(id_c integer)    COMMENT     �   COMMENT ON FUNCTION public.cliente_compras_hist(id_c integer) IS 'Funcion que recibe id de un cliente y regresa la informacion de sus tipos de pago.';
            public       postgres    false    261            �            1255    117221    cliente_edad(character varying)    FUNCTION     �  CREATE FUNCTION public.cliente_edad(rfc_ character varying) RETURNS TABLE(nombre character varying, apellido_paterno character varying, apellido_materno character varying, edad double precision)
    LANGUAGE sql
    AS $$
	select A.nombre,A.Apellido_Paterno,A.Apellido_Materno,date_part('year',age(Fecha_de_nacimiento)) from CLIENTE_R2 B 
	join CLIENTE_R1 A on A.codigo_cliente = B.codigo_cliente where B.rfc = RFC_;
$$;
 ;   DROP FUNCTION public.cliente_edad(rfc_ character varying);
       public       postgres    false    3            y           0    0 -   FUNCTION cliente_edad(rfc_ character varying)    COMMENT     �   COMMENT ON FUNCTION public.cliente_edad(rfc_ character varying) IS 'Funcion que recibe un RFC y regresa la edad de un cliente con su nombre.';
            public       postgres    false    239                       1255    117226 !   cliente_edad_c(character varying)    FUNCTION     !  CREATE FUNCTION public.cliente_edad_c(codigo_c character varying) RETURNS double precision
    LANGUAGE sql
    AS $$
	select date_part('year',age(Fecha_de_nacimiento)) from CLIENTE_R2 A
	join VENTA_FISICA_r1 B on A.codigo_cliente = B.codigo_cliente where A.codigo_cliente = codigo_c;
$$;
 A   DROP FUNCTION public.cliente_edad_c(codigo_c character varying);
       public       postgres    false    3            z           0    0 3   FUNCTION cliente_edad_c(codigo_c character varying)    COMMENT     �   COMMENT ON FUNCTION public.cliente_edad_c(codigo_c character varying) IS 'Funcion que recibe un codigo de cliente y regresa la edad de un cliente.';
            public       postgres    false    259            �            1255    117220     emeplado_edad(character varying)    FUNCTION     n  CREATE FUNCTION public.emeplado_edad(rfc_ character varying) RETURNS TABLE(nombre character varying, apellido_paterno character varying, apellido_materno character varying, edad double precision)
    LANGUAGE sql
    AS $$
	select nombre,Apellido_Paterno,Apellido_Materno,date_part('year',age(Fecha_de_nacimiento)) as edad from EMPLEADO_R1 A where A.rfc = RFC_;
$$;
 <   DROP FUNCTION public.emeplado_edad(rfc_ character varying);
       public       postgres    false    3            {           0    0 .   FUNCTION emeplado_edad(rfc_ character varying)    COMMENT     �   COMMENT ON FUNCTION public.emeplado_edad(rfc_ character varying) IS 'Funcion que recibe un RFC y regresa la edad de un empleado con su nombre.';
            public       postgres    false    238            �            1255    117224 K   empleado_rfc(character varying, character varying, character varying, date)    FUNCTION     ]  CREATE FUNCTION public.empleado_rfc(nombr character varying, apellidop character varying, apellidom character varying, fechab date) RETURNS character varying
    LANGUAGE sql
    AS $$
	select RFC from EMPLEADO_R1 A where A.Nombre = Nombr and A.Apellido_Paterno = ApellidoP and A.Apellido_Materno = ApellidoM and A.Fecha_de_nacimiento = FechaB;
$$;
 �   DROP FUNCTION public.empleado_rfc(nombr character varying, apellidop character varying, apellidom character varying, fechab date);
       public       postgres    false    3            |           0    0 u   FUNCTION empleado_rfc(nombr character varying, apellidop character varying, apellidom character varying, fechab date)    COMMENT     �   COMMENT ON FUNCTION public.empleado_rfc(nombr character varying, apellidop character varying, apellidom character varying, fechab date) IS 'Funcion que recibe el nombre completo de un emplado junto con su fecha de nacimiento y regresa su RFC.';
            public       postgres    false    242            �            1255    117223    informacion_cliente(integer)    FUNCTION     0  CREATE FUNCTION public.informacion_cliente(id_c integer) RETURNS TABLE(id_cliente integer, codigo_cliente character varying, snombre character varying, apellido_paterno character varying, apellido_materno character varying, fecha_de_nacimiento date, direccion character varying, rfc character varying)
    LANGUAGE sql
    AS $$
	select A.Id_Cliente,B.Codigo_cliente,A.Nombre,A.Apellido_Paterno,A.Apellido_Materno,B.Fecha_de_nacimiento,B.Direccion,B.RFC from CLIENTE_R1 A
	join CLIENTE_R2 B on A.codigo_cliente = B.codigo_cliente where id_C = A.Id_Cliente
$$;
 8   DROP FUNCTION public.informacion_cliente(id_c integer);
       public       postgres    false    3            }           0    0 *   FUNCTION informacion_cliente(id_c integer)    COMMENT     �   COMMENT ON FUNCTION public.informacion_cliente(id_c integer) IS 'Funcion que recibe un id de un cliente y regresa todos sus datos.';
            public       postgres    false    241                       1255    117227    numero_vent_e(integer)    FUNCTION     ]  CREATE FUNCTION public.numero_vent_e(id_ev integer) RETURNS bigint
    LANGUAGE sql
    AS $$
	select count(B.Id_Empleado_que_ayudo_a_cliente) from EMPLEADO_R1 A
	join venta_fisica_r1 B on A.Id_Empleado = B.Id_Empleado_que_ayudo_a_cliente
	where B.Id_Empleado_que_ayudo_a_cliente = id_EV
	group by A.nombre,A.Apellido_Paterno,A.Apellido_Materno
$$;
 3   DROP FUNCTION public.numero_vent_e(id_ev integer);
       public       postgres    false    3            ~           0    0 %   FUNCTION numero_vent_e(id_ev integer)    COMMENT     �   COMMENT ON FUNCTION public.numero_vent_e(id_ev integer) IS 'Funcion que recibe un id de un empleado y regresa el numero de ventas que ha realizado.';
            public       postgres    false    260            �            1255    117222    numero_ventas(integer)    FUNCTION       CREATE FUNCTION public.numero_ventas(id_ev integer) RETURNS TABLE(nombre character varying, apellido_paterno character varying, apellido_materno character varying, numero_ventas bigint)
    LANGUAGE sql
    AS $$
	select A.nombre,A.Apellido_Paterno,A.Apellido_Materno,count(B.Id_Empleado_que_ayudo_a_cliente) from EMPLEADO_R1 A
	join venta_fisica_r1 B on A.Id_Empleado = B.Id_Empleado_que_ayudo_a_cliente
	where B.Id_Empleado_que_ayudo_a_cliente = id_EV
	group by A.nombre,A.Apellido_Paterno,A.Apellido_Materno
$$;
 3   DROP FUNCTION public.numero_ventas(id_ev integer);
       public       postgres    false    3                       0    0 %   FUNCTION numero_ventas(id_ev integer)    COMMENT     �   COMMENT ON FUNCTION public.numero_ventas(id_ev integer) IS 'Funcion que recibe un id de un empleado y regresa el numero de ventas que ha realizado.';
            public       postgres    false    240            !           1255    117257    registra_area(integer, integer)    FUNCTION     �   CREATE FUNCTION public.registra_area(id_planta integer, id_tipo_de_planta integer) RETURNS void
    LANGUAGE sql
    AS $$
    INSERT INTO area VALUES(Id_Planta,Id_Tipo_de_Planta)
$$;
 R   DROP FUNCTION public.registra_area(id_planta integer, id_tipo_de_planta integer);
       public       postgres    false    3            �           0    0 D   FUNCTION registra_area(id_planta integer, id_tipo_de_planta integer)    COMMENT     �   COMMENT ON FUNCTION public.registra_area(id_planta integer, id_tipo_de_planta integer) IS '.Procedimiento para insertar datos en la tabla Registra_area.';
            public       postgres    false    289            
           1255    117234 �   registra_cliente(integer, character varying, character varying, character varying, character varying, date, character varying, character varying)    FUNCTION     �  CREATE FUNCTION public.registra_cliente(id_cliente integer, codigo_cliente character varying, nombre character varying, apellido_paterno character varying, apellido_materno character varying, fecha_de_nacimiento date, direccion character varying, rfc character varying) RETURNS void
    LANGUAGE sql
    AS $$
    INSERT INTO CLIENTE_R2 VALUES(Codigo_cliente,Fecha_de_nacimiento,Direccion,RFC);
    INSERT INTO CLIENTE_R1 VALUES(Id_Cliente,Codigo_cliente,Nombre,Apellido_Paterno,Apellido_Materno)
$$;
   DROP FUNCTION public.registra_cliente(id_cliente integer, codigo_cliente character varying, nombre character varying, apellido_paterno character varying, apellido_materno character varying, fecha_de_nacimiento date, direccion character varying, rfc character varying);
       public       postgres    false    3            �           0    0 �   FUNCTION registra_cliente(id_cliente integer, codigo_cliente character varying, nombre character varying, apellido_paterno character varying, apellido_materno character varying, fecha_de_nacimiento date, direccion character varying, rfc character varying)    COMMENT     �  COMMENT ON FUNCTION public.registra_cliente(id_cliente integer, codigo_cliente character varying, nombre character varying, apellido_paterno character varying, apellido_materno character varying, fecha_de_nacimiento date, direccion character varying, rfc character varying) IS 'Procedimiento que se encarga de registrar Clientes con su Id, codigo de cliente, nombre completo, fecha de nacimiento, Direccion y su RFC.';
            public       postgres    false    266                       1255    117254 )   registra_comprar_tipo_e(integer, integer)    FUNCTION     �   CREATE FUNCTION public.registra_comprar_tipo_e(id_ventas_electronicas integer, id_cliente integer) RETURNS void
    LANGUAGE sql
    AS $$
    INSERT INTO COMPRAR_tipo_e VALUES(Id_Ventas_electronicas,Id_Cliente)
$$;
 b   DROP FUNCTION public.registra_comprar_tipo_e(id_ventas_electronicas integer, id_cliente integer);
       public       postgres    false    3            �           0    0 T   FUNCTION registra_comprar_tipo_e(id_ventas_electronicas integer, id_cliente integer)    COMMENT     �   COMMENT ON FUNCTION public.registra_comprar_tipo_e(id_ventas_electronicas integer, id_cliente integer) IS '.Procedimiento para insertar datos en la tabla Registra_COMPRAR_tipo_e.';
            public       postgres    false    286                       1255    117253 )   registra_comprar_tipo_f(integer, integer)    FUNCTION     �   CREATE FUNCTION public.registra_comprar_tipo_f(id_venta_fisica integer, id_cliente integer) RETURNS void
    LANGUAGE sql
    AS $$
    INSERT INTO COMPRAR_tipo_f VALUES(Id_Venta_Fisica,Id_Cliente)
$$;
 [   DROP FUNCTION public.registra_comprar_tipo_f(id_venta_fisica integer, id_cliente integer);
       public       postgres    false    3            �           0    0 M   FUNCTION registra_comprar_tipo_f(id_venta_fisica integer, id_cliente integer)    COMMENT     �   COMMENT ON FUNCTION public.registra_comprar_tipo_f(id_venta_fisica integer, id_cliente integer) IS '.Procedimiento para insertar datos en la tabla Registra_COMPRAR_tipo_f.';
            public       postgres    false    285                       1255    117246 $   registra_controlar(integer, integer)    FUNCTION     �   CREATE FUNCTION public.registra_controlar(id_empleado integer, id_semillas integer) RETURNS void
    LANGUAGE sql
    AS $$
    INSERT INTO Controlar VALUES(Id_Empleado,Id_Semillas)
$$;
 S   DROP FUNCTION public.registra_controlar(id_empleado integer, id_semillas integer);
       public       postgres    false    3            �           0    0 E   FUNCTION registra_controlar(id_empleado integer, id_semillas integer)    COMMENT     �   COMMENT ON FUNCTION public.registra_controlar(id_empleado integer, id_semillas integer) IS '.Procedimiento para insertar datos en la tabla Registra_Controlar.';
            public       postgres    false    278                        1255    117256 8   registra_correo_cli(integer, integer, character varying)    FUNCTION     �   CREATE FUNCTION public.registra_correo_cli(id_cliente integer, id_correo integer, correo character varying) RETURNS void
    LANGUAGE sql
    AS $$
    INSERT INTO CORREO_CLI VALUES(Id_Cliente,Id_Correo,Correo)
$$;
 k   DROP FUNCTION public.registra_correo_cli(id_cliente integer, id_correo integer, correo character varying);
       public       postgres    false    3            �           0    0 ]   FUNCTION registra_correo_cli(id_cliente integer, id_correo integer, correo character varying)    COMMENT     �   COMMENT ON FUNCTION public.registra_correo_cli(id_cliente integer, id_correo integer, correo character varying) IS '.Procedimiento para insertar datos en la tabla Registra_CORREO_CLI.';
            public       postgres    false    288                       1255    117244 8   registra_correo_emp(integer, integer, character varying)    FUNCTION     �   CREATE FUNCTION public.registra_correo_emp(id_empleado integer, id_correo integer, correo character varying) RETURNS void
    LANGUAGE sql
    AS $$
    INSERT INTO CORREO_EMP VALUES(Id_Empleado,Id_Correo,Correo)
$$;
 l   DROP FUNCTION public.registra_correo_emp(id_empleado integer, id_correo integer, correo character varying);
       public       postgres    false    3            �           0    0 ^   FUNCTION registra_correo_emp(id_empleado integer, id_correo integer, correo character varying)    COMMENT     �   COMMENT ON FUNCTION public.registra_correo_emp(id_empleado integer, id_correo integer, correo character varying) IS '.Procedimiento para insertar datos en la tabla Registra_CORREO_EMP.';
            public       postgres    false    276                       1255    117240 ;   registra_direccion_viv(integer, integer, character varying)    FUNCTION     �   CREATE FUNCTION public.registra_direccion_viv(id_vivero integer, id_direccion integer, direccion character varying) RETURNS void
    LANGUAGE sql
    AS $$
    INSERT INTO DIRECCION_VIV VALUES(Id_Vivero,Id_Direccion,Direccion)
$$;
 s   DROP FUNCTION public.registra_direccion_viv(id_vivero integer, id_direccion integer, direccion character varying);
       public       postgres    false    3            �           0    0 e   FUNCTION registra_direccion_viv(id_vivero integer, id_direccion integer, direccion character varying)    COMMENT     �   COMMENT ON FUNCTION public.registra_direccion_viv(id_vivero integer, id_direccion integer, direccion character varying) IS '.Procedimiento para insertar datos en la tabla Registra_DIRECCION_VIV.';
            public       postgres    false    272                       1255    117232 �   registra_empleado(integer, character varying, character varying, character varying, character varying, date, character varying, real, date, character varying)    FUNCTION     )  CREATE FUNCTION public.registra_empleado(id_empleado integer, curp character varying, nombre character varying, apellido_paterno character varying, apellido_materno character varying, fecha_de_nacimiento date, rfc character varying, salario real, fecha_inicio_servicio date, direccion character varying) RETURNS void
    LANGUAGE sql
    AS $$  
    INSERT INTO empleado_r2 VALUES (CURP,Salario,Fecha_Inicio_servicio,Direccion);
    INSERT INTO empleado_r1 VALUES (Id_Empleado,CURP,Nombre,Apellido_Paterno,Apellido_Materno,Fecha_de_nacimiento,RFC);
$$;
 /  DROP FUNCTION public.registra_empleado(id_empleado integer, curp character varying, nombre character varying, apellido_paterno character varying, apellido_materno character varying, fecha_de_nacimiento date, rfc character varying, salario real, fecha_inicio_servicio date, direccion character varying);
       public       postgres    false    3            �           0    0 !  FUNCTION registra_empleado(id_empleado integer, curp character varying, nombre character varying, apellido_paterno character varying, apellido_materno character varying, fecha_de_nacimiento date, rfc character varying, salario real, fecha_inicio_servicio date, direccion character varying)    COMMENT     �  COMMENT ON FUNCTION public.registra_empleado(id_empleado integer, curp character varying, nombre character varying, apellido_paterno character varying, apellido_materno character varying, fecha_de_nacimiento date, rfc character varying, salario real, fecha_inicio_servicio date, direccion character varying) IS 'Procedimiento que se encarga de registrar Empleados con su Id, CURP, Nombre completo, Fecha de nacimiento, RFC, Salario, Fecha en la que inicio su servicio y su Direccion.';
            public       postgres    false    264                       1255    117247 $   registra_germinado(integer, integer)    FUNCTION     �   CREATE FUNCTION public.registra_germinado(id_semillas integer, id_semillas_germinadas integer) RETURNS void
    LANGUAGE sql
    AS $$
    INSERT INTO Germinado VALUES(Id_Semillas,Id_Semillas_Germinadas)
$$;
 ^   DROP FUNCTION public.registra_germinado(id_semillas integer, id_semillas_germinadas integer);
       public       postgres    false    3            �           0    0 P   FUNCTION registra_germinado(id_semillas integer, id_semillas_germinadas integer)    COMMENT     �   COMMENT ON FUNCTION public.registra_germinado(id_semillas integer, id_semillas_germinadas integer) IS '.Procedimiento para insertar datos en la tabla Registra_Germinado.';
            public       postgres    false    279                       1255    117238 +   registra_pago_e(integer, character varying)    FUNCTION     �   CREATE FUNCTION public.registra_pago_e(id_pago_e integer, tipo_de_pago character varying) RETURNS void
    LANGUAGE sql
    AS $$
    INSERT INTO Pago_e VALUES(Id_Pago_e,Tipo_de_pago)
$$;
 Y   DROP FUNCTION public.registra_pago_e(id_pago_e integer, tipo_de_pago character varying);
       public       postgres    false    3            �           0    0 K   FUNCTION registra_pago_e(id_pago_e integer, tipo_de_pago character varying)    COMMENT     �   COMMENT ON FUNCTION public.registra_pago_e(id_pago_e integer, tipo_de_pago character varying) IS 'Procedimiento para insertar datos en la tabla Registra_Pago_e.';
            public       postgres    false    270                       1255    117237 +   registra_pago_f(integer, character varying)    FUNCTION     �   CREATE FUNCTION public.registra_pago_f(id_pago_f integer, tipo_de_pago character varying) RETURNS void
    LANGUAGE sql
    AS $$
    INSERT INTO Pago_f VALUES(Id_Pago_f,Tipo_de_pago)
$$;
 Y   DROP FUNCTION public.registra_pago_f(id_pago_f integer, tipo_de_pago character varying);
       public       postgres    false    3            �           0    0 K   FUNCTION registra_pago_f(id_pago_f integer, tipo_de_pago character varying)    COMMENT     �   COMMENT ON FUNCTION public.registra_pago_f(id_pago_f integer, tipo_de_pago character varying) IS 'Procedimiento para insertar datos en la tabla Registra_Pago_f.';
            public       postgres    false    269                       1255    117252 %   registra_registra_e(integer, integer)    FUNCTION     �   CREATE FUNCTION public.registra_registra_e(id_ventas_electronicas integer, id_pago_e integer) RETURNS void
    LANGUAGE sql
    AS $$
    INSERT INTO REGISTRA_e VALUES(Id_Ventas_electronicas,Id_Pago_e)
$$;
 ]   DROP FUNCTION public.registra_registra_e(id_ventas_electronicas integer, id_pago_e integer);
       public       postgres    false    3            �           0    0 O   FUNCTION registra_registra_e(id_ventas_electronicas integer, id_pago_e integer)    COMMENT     �   COMMENT ON FUNCTION public.registra_registra_e(id_ventas_electronicas integer, id_pago_e integer) IS '.Procedimiento para insertar datos en la tabla Registra_REGISTRA_e.';
            public       postgres    false    284                       1255    117251 %   registra_registra_f(integer, integer)    FUNCTION     �   CREATE FUNCTION public.registra_registra_f(id_venta_fisica integer, id_pago_f integer) RETURNS void
    LANGUAGE sql
    AS $$
    INSERT INTO REGISTRA_f VALUES(Id_Venta_Fisica,Id_Pago_f)
$$;
 V   DROP FUNCTION public.registra_registra_f(id_venta_fisica integer, id_pago_f integer);
       public       postgres    false    3            �           0    0 H   FUNCTION registra_registra_f(id_venta_fisica integer, id_pago_f integer)    COMMENT     �   COMMENT ON FUNCTION public.registra_registra_f(id_venta_fisica integer, id_pago_f integer) IS '.Procedimiento para insertar datos en la tabla Registra_REGISTRA_f.';
            public       postgres    false    283                       1255    117241 $   registra_registrar(integer, integer)    FUNCTION     �   CREATE FUNCTION public.registra_registrar(id_vivero integer, id_registro integer) RETURNS void
    LANGUAGE sql
    AS $$
    INSERT INTO REGISTRAR VALUES(Id_Vivero,Id_Registro)
$$;
 Q   DROP FUNCTION public.registra_registrar(id_vivero integer, id_registro integer);
       public       postgres    false    3            �           0    0 C   FUNCTION registra_registrar(id_vivero integer, id_registro integer)    COMMENT     �   COMMENT ON FUNCTION public.registra_registrar(id_vivero integer, id_registro integer) IS '.Procedimiento para insertar datos en la tabla Registra_REGISTRAR.';
            public       postgres    false    273                       1255    117231 X   registra_registro(integer, character varying, character varying, date, date, date, date)    FUNCTION     �  CREATE FUNCTION public.registra_registro(id_registro integer, nombre character varying, genero character varying, fecha_de_adquisicion date, ultimo_riego date, ultimo_fertilizante date, ultima_fumigacion date) RETURNS void
    LANGUAGE sql
    AS $$
    INSERT INTO REGISTRO_R2 VALUES(Genero,Fecha_de_adquisicion,Ultimo_riego,Ultimo_fertilizante,Ultima_fumigacion);
    INSERT INTO REGISTRO_R1 VALUES(Id_Registro,Genero,Nombre)
$$;
 �   DROP FUNCTION public.registra_registro(id_registro integer, nombre character varying, genero character varying, fecha_de_adquisicion date, ultimo_riego date, ultimo_fertilizante date, ultima_fumigacion date);
       public       postgres    false    3            �           0    0 �   FUNCTION registra_registro(id_registro integer, nombre character varying, genero character varying, fecha_de_adquisicion date, ultimo_riego date, ultimo_fertilizante date, ultima_fumigacion date)    COMMENT     �  COMMENT ON FUNCTION public.registra_registro(id_registro integer, nombre character varying, genero character varying, fecha_de_adquisicion date, ultimo_riego date, ultimo_fertilizante date, ultima_fumigacion date) IS 'Procedimiento que se encarga de registrar los Registros de las plantas productoras con su Id, Nombre, Genero ademas de Fechas de adquisicion, riego, fertilizante y fumigacion.';
            public       postgres    false    263            	           1255    117233 Y   registra_semillas_germinadas(integer, integer, character varying, date, date, date, date)    FUNCTION     �  CREATE FUNCTION public.registra_semillas_germinadas(id_semillas_germinadas integer, semillas_germinadas integer, origen character varying, fecha_de_siembra date, ultimo_riego date, ultimo_fertilizante date, ultima_fumigacion date) RETURNS void
    LANGUAGE sql
    AS $$
    INSERT INTO Semillas_Germinadas_R2 VALUES(Origen,Fecha_de_siembra,Ultimo_riego,Ultimo_fertilizante,Ultima_fumigacion);
    INSERT INTO Semillas_Germinadas_R1 VALUES(Id_Semillas_Germinadas,Origen,Semillas_germinadas)
$$;
 �   DROP FUNCTION public.registra_semillas_germinadas(id_semillas_germinadas integer, semillas_germinadas integer, origen character varying, fecha_de_siembra date, ultimo_riego date, ultimo_fertilizante date, ultima_fumigacion date);
       public       postgres    false    3            �           0    0 �   FUNCTION registra_semillas_germinadas(id_semillas_germinadas integer, semillas_germinadas integer, origen character varying, fecha_de_siembra date, ultimo_riego date, ultimo_fertilizante date, ultima_fumigacion date)    COMMENT     �  COMMENT ON FUNCTION public.registra_semillas_germinadas(id_semillas_germinadas integer, semillas_germinadas integer, origen character varying, fecha_de_siembra date, ultimo_riego date, ultimo_fertilizante date, ultima_fumigacion date) IS 'Procedimiento que se encarga de registrar Viveros con su Id, Cantidad de semillas germinadas, origen, Fechas de riego, siembra, fertilizante y fumigacion.';
            public       postgres    false    265                       1255    117255 :   registra_telefono_cli(integer, integer, character varying)    FUNCTION     �   CREATE FUNCTION public.registra_telefono_cli(id_cliente integer, id_telefono integer, telefono character varying) RETURNS void
    LANGUAGE sql
    AS $$
    INSERT INTO TELEFONO_CLI VALUES(Id_Cliente,Id_Telefono,Telefono)
$$;
 q   DROP FUNCTION public.registra_telefono_cli(id_cliente integer, id_telefono integer, telefono character varying);
       public       postgres    false    3            �           0    0 c   FUNCTION registra_telefono_cli(id_cliente integer, id_telefono integer, telefono character varying)    COMMENT     �   COMMENT ON FUNCTION public.registra_telefono_cli(id_cliente integer, id_telefono integer, telefono character varying) IS '.Procedimiento para insertar datos en la tabla Registra_TELEFONO_CLI.';
            public       postgres    false    287                       1255    117243 :   registra_telefono_emp(integer, integer, character varying)    FUNCTION     �   CREATE FUNCTION public.registra_telefono_emp(id_empleado integer, id_telefono integer, telefono character varying) RETURNS void
    LANGUAGE sql
    AS $$
    INSERT INTO TELEFONO_EMP VALUES(Id_Empleado,Id_Telefono,Telefono)
$$;
 r   DROP FUNCTION public.registra_telefono_emp(id_empleado integer, id_telefono integer, telefono character varying);
       public       postgres    false    3            �           0    0 d   FUNCTION registra_telefono_emp(id_empleado integer, id_telefono integer, telefono character varying)    COMMENT     �   COMMENT ON FUNCTION public.registra_telefono_emp(id_empleado integer, id_telefono integer, telefono character varying) IS '.Procedimiento para insertar datos en la tabla Registra_TELEFONO_EMP.';
            public       postgres    false    275                       1255    117239 :   registra_telefono_viv(integer, integer, character varying)    FUNCTION     �   CREATE FUNCTION public.registra_telefono_viv(id_vivero integer, id_telefono integer, telefono character varying) RETURNS void
    LANGUAGE sql
    AS $$
    INSERT INTO TELEFONO_VIV VALUES(Id_Vivero,Id_Telefono,Telefono)
$$;
 p   DROP FUNCTION public.registra_telefono_viv(id_vivero integer, id_telefono integer, telefono character varying);
       public       postgres    false    3            �           0    0 b   FUNCTION registra_telefono_viv(id_vivero integer, id_telefono integer, telefono character varying)    COMMENT     �   COMMENT ON FUNCTION public.registra_telefono_viv(id_vivero integer, id_telefono integer, telefono character varying) IS '.Procedimiento para insertar datos en la tabla Registra_TELEFONO_VIV.';
            public       postgres    false    271                       1255    117245 $   registra_tiene_emp(integer, integer)    FUNCTION     �   CREATE FUNCTION public.registra_tiene_emp(id_empleado integer, id_rol integer) RETURNS void
    LANGUAGE sql
    AS $$
    INSERT INTO TIENE_EMP VALUES(Id_Empleado,Id_Rol)
$$;
 N   DROP FUNCTION public.registra_tiene_emp(id_empleado integer, id_rol integer);
       public       postgres    false    3            �           0    0 @   FUNCTION registra_tiene_emp(id_empleado integer, id_rol integer)    COMMENT     �   COMMENT ON FUNCTION public.registra_tiene_emp(id_empleado integer, id_rol integer) IS '.Procedimiento para insertar datos en la tabla Registra_TIENE_EMP.';
            public       postgres    false    277                       1255    117248 $   registra_tiene_pla(integer, integer)    FUNCTION     �   CREATE FUNCTION public.registra_tiene_pla(id_vivero integer, id_planta integer) RETURNS void
    LANGUAGE sql
    AS $$
    INSERT INTO TIENE_PLA VALUES(Id_Vivero,Id_Planta)
$$;
 O   DROP FUNCTION public.registra_tiene_pla(id_vivero integer, id_planta integer);
       public       postgres    false    3            �           0    0 A   FUNCTION registra_tiene_pla(id_vivero integer, id_planta integer)    COMMENT     �   COMMENT ON FUNCTION public.registra_tiene_pla(id_vivero integer, id_planta integer) IS '.Procedimiento para insertar datos en la tabla Registra_TIENE_PLA.';
            public       postgres    false    280                       1255    117242 #   registra_trabajar(integer, integer)    FUNCTION     �   CREATE FUNCTION public.registra_trabajar(id_vivero integer, id_empleado integer) RETURNS void
    LANGUAGE sql
    AS $$
    INSERT INTO TRABAJAR VALUES(Id_Vivero,Id_Empleado)
$$;
 P   DROP FUNCTION public.registra_trabajar(id_vivero integer, id_empleado integer);
       public       postgres    false    3            �           0    0 B   FUNCTION registra_trabajar(id_vivero integer, id_empleado integer)    COMMENT     �   COMMENT ON FUNCTION public.registra_trabajar(id_vivero integer, id_empleado integer) IS '.Procedimiento para insertar datos en la tabla Registra_TRABAJAR.';
            public       postgres    false    274                       1255    117250 "   registra_venta_e(integer, integer)    FUNCTION     �   CREATE FUNCTION public.registra_venta_e(id_vivero integer, id_ventas_electronicas integer) RETURNS void
    LANGUAGE sql
    AS $$
    INSERT INTO VENTA_e VALUES(Id_Vivero,Id_Ventas_electronicas)
$$;
 Z   DROP FUNCTION public.registra_venta_e(id_vivero integer, id_ventas_electronicas integer);
       public       postgres    false    3            �           0    0 L   FUNCTION registra_venta_e(id_vivero integer, id_ventas_electronicas integer)    COMMENT     �   COMMENT ON FUNCTION public.registra_venta_e(id_vivero integer, id_ventas_electronicas integer) IS '.Procedimiento para insertar datos en la tabla Registra_VENTA_e.';
            public       postgres    false    282                       1255    117236 �   registra_venta_electronica(integer, integer, integer, date, character varying, character varying, character varying, character varying, integer, character varying, real, character varying, date, character varying, real)    FUNCTION     �  CREATE FUNCTION public.registra_venta_electronica(id_cliente integer, id_ventas_electronicas integer, numero_de_seguimiento integer, fecha_venta_e date, codigo_cliente character varying, nombre character varying, apellido_paterno character varying, apellido_materno character varying, numero_de_productos integer, desglose_de_productos_adquiridos character varying, precio_a_pagar real, direccion_de_envio character varying, fecha_de_pedido date, forma_de_pago character varying, total real) RETURNS void
    LANGUAGE sql
    AS $$  
    INSERT INTO VENTAS_ELECTRONICAS_r2 VALUES (Numero_de_seguimiento,Direccion_de_envio,Fecha_de_pedido,Forma_de_pago,Total);
    INSERT INTO VENTAS_ELECTRONICAS_r1 VALUES (Id_Ventas_electronicas,Numero_de_seguimiento,Fecha_Venta_e,Codigo_cliente,Nombre,Apellido_Paterno,Apellido_Materno,Numero_de_productos,Desglose_de_productos_adquiridos,Precio_a_pagar);
    INSERT INTO COMPRAR_tipo_e VALUES (Id_Ventas_electronicas,Id_Cliente);
$$;
 �  DROP FUNCTION public.registra_venta_electronica(id_cliente integer, id_ventas_electronicas integer, numero_de_seguimiento integer, fecha_venta_e date, codigo_cliente character varying, nombre character varying, apellido_paterno character varying, apellido_materno character varying, numero_de_productos integer, desglose_de_productos_adquiridos character varying, precio_a_pagar real, direccion_de_envio character varying, fecha_de_pedido date, forma_de_pago character varying, total real);
       public       postgres    false    3            �           0    0 �  FUNCTION registra_venta_electronica(id_cliente integer, id_ventas_electronicas integer, numero_de_seguimiento integer, fecha_venta_e date, codigo_cliente character varying, nombre character varying, apellido_paterno character varying, apellido_materno character varying, numero_de_productos integer, desglose_de_productos_adquiridos character varying, precio_a_pagar real, direccion_de_envio character varying, fecha_de_pedido date, forma_de_pago character varying, total real)    COMMENT     r  COMMENT ON FUNCTION public.registra_venta_electronica(id_cliente integer, id_ventas_electronicas integer, numero_de_seguimiento integer, fecha_venta_e date, codigo_cliente character varying, nombre character varying, apellido_paterno character varying, apellido_materno character varying, numero_de_productos integer, desglose_de_productos_adquiridos character varying, precio_a_pagar real, direccion_de_envio character varying, fecha_de_pedido date, forma_de_pago character varying, total real) IS 'Procedimiento que se encarga de registrar los datos de las ventas electronicas cuando un cliente realiza una compra online.';
            public       postgres    false    268                       1255    117249 "   registra_venta_f(integer, integer)    FUNCTION     �   CREATE FUNCTION public.registra_venta_f(id_vivero integer, id_venta_fisica integer) RETURNS void
    LANGUAGE sql
    AS $$
    INSERT INTO VENTA_f VALUES(Id_Vivero,Id_Venta_Fisica)
$$;
 S   DROP FUNCTION public.registra_venta_f(id_vivero integer, id_venta_fisica integer);
       public       postgres    false    3            �           0    0 E   FUNCTION registra_venta_f(id_vivero integer, id_venta_fisica integer)    COMMENT     �   COMMENT ON FUNCTION public.registra_venta_f(id_vivero integer, id_venta_fisica integer) IS '.Procedimiento para insertar datos en la tabla Registra_VENTA_f.';
            public       postgres    false    281                       1255    117235 �   registra_venta_fisica(integer, integer, integer, character varying, character varying, date, integer, integer, integer, character varying, integer, integer)    FUNCTION     ^  CREATE FUNCTION public.registra_venta_fisica(id_cliente integer, id_venta_fisica integer, numero_ticket integer, codigo_cliente character varying, clave_producto character varying, fecha_venta_f date, id_empleado_que_ayudo_a_cliente integer, empleado_que_efectuo_el_cobro integer, vivero_donde_se_adquirio integer, forma_de_pago character varying, numero_de_productos_adquiridos integer, total_productos integer) RETURNS void
    LANGUAGE sql
    AS $$  
    INSERT INTO VENTA_FISICA_r2 VALUES (Numero_ticket,Clave_producto,Numero_de_productos_adquiridos,Total_productos);
    INSERT INTO VENTA_FISICA_r1 VALUES (Id_Venta_Fisica,Numero_ticket,Codigo_cliente,Clave_producto,Fecha_Venta_f,Id_Empleado_que_ayudo_a_cliente,Empleado_que_efectuo_el_cobro,Vivero_donde_se_adquirio,Forma_de_pago);
    INSERT INTO COMPRAR_tipo_f VALUES (Id_Venta_Fisica,Id_Cliente);
$$;
 �  DROP FUNCTION public.registra_venta_fisica(id_cliente integer, id_venta_fisica integer, numero_ticket integer, codigo_cliente character varying, clave_producto character varying, fecha_venta_f date, id_empleado_que_ayudo_a_cliente integer, empleado_que_efectuo_el_cobro integer, vivero_donde_se_adquirio integer, forma_de_pago character varying, numero_de_productos_adquiridos integer, total_productos integer);
       public       postgres    false    3            �           0    0 �  FUNCTION registra_venta_fisica(id_cliente integer, id_venta_fisica integer, numero_ticket integer, codigo_cliente character varying, clave_producto character varying, fecha_venta_f date, id_empleado_que_ayudo_a_cliente integer, empleado_que_efectuo_el_cobro integer, vivero_donde_se_adquirio integer, forma_de_pago character varying, numero_de_productos_adquiridos integer, total_productos integer)    COMMENT     #  COMMENT ON FUNCTION public.registra_venta_fisica(id_cliente integer, id_venta_fisica integer, numero_ticket integer, codigo_cliente character varying, clave_producto character varying, fecha_venta_f date, id_empleado_que_ayudo_a_cliente integer, empleado_que_efectuo_el_cobro integer, vivero_donde_se_adquirio integer, forma_de_pago character varying, numero_de_productos_adquiridos integer, total_productos integer) IS 'Procedimiento que se encarga de registrar los datos de las ventas fisicas cuando un cliente realiza una compra fisicamente.';
            public       postgres    false    267                       1255    117230 1   registra_vivero(integer, character varying, date)    FUNCTION     �   CREATE FUNCTION public.registra_vivero(id_vivero integer, nombre character varying, fecha_de_apertura date) RETURNS void
    LANGUAGE sql
    AS $$
    INSERT INTO vivero VALUES(Id_Vivero,Nombre,Fecha_de_apertura)
$$;
 k   DROP FUNCTION public.registra_vivero(id_vivero integer, nombre character varying, fecha_de_apertura date);
       public       postgres    false    3            �           0    0 ]   FUNCTION registra_vivero(id_vivero integer, nombre character varying, fecha_de_apertura date)    COMMENT     �   COMMENT ON FUNCTION public.registra_vivero(id_vivero integer, nombre character varying, fecha_de_apertura date) IS 'Procedimiento que se encarga de registrar Viveros con su Id, Nombre y su Fecha de apertura.';
            public       postgres    false    262            #           1255    117260    registrav_fecha()    FUNCTION     �   CREATE FUNCTION public.registrav_fecha() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF (TG_OP = 'INSERT' OR TG_OP = 'UPDATE' ) THEN new.Fecha_Venta_f = current_date;
	RETURN new;
	ELSEIF (TG_OP = 'DELETE') THEN RETURN NULL;
	END IF;
END;
$$;
 (   DROP FUNCTION public.registrav_fecha();
       public       postgres    false    3    1            �           0    0    FUNCTION registrav_fecha()    COMMENT     W   COMMENT ON FUNCTION public.registrav_fecha() IS 'Funcion que guarda la fecha actual.';
            public       postgres    false    291            �            1255    117266    valida_cantidad_plantas()    FUNCTION       CREATE FUNCTION public.valida_cantidad_plantas() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF (select sum(numero_de_plantas) from plantas_R2) > 3000
	THEN RAISE EXCEPTION 'No hay espacio para mas de 3000 plantas en el almacén';
	END IF;
	RETURN NULL;
END;
$$;
 0   DROP FUNCTION public.valida_cantidad_plantas();
       public       postgres    false    3    1            �           0    0 "   FUNCTION valida_cantidad_plantas()    COMMENT     {   COMMENT ON FUNCTION public.valida_cantidad_plantas() IS 'Funcion que valida que no haya mas de 3000 plantas en almacén.';
            public       postgres    false    245            "           1255    117258    valida_fecha_cliente()    FUNCTION       CREATE FUNCTION public.valida_fecha_cliente() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF new.Fecha_de_nacimiento > '01/01/2100' THEN RAISE EXCEPTION 'Esta fecha no puede ser insertada, inserte una fecha valida';
	END IF;
	RETURN NULL;
END;
$$;
 -   DROP FUNCTION public.valida_fecha_cliente();
       public       postgres    false    3    1            �           0    0    FUNCTION valida_fecha_cliente()    COMMENT     q   COMMENT ON FUNCTION public.valida_fecha_cliente() IS 'Funcion que valida la fecha de nacimiento de un Cliente.';
            public       postgres    false    290            �            1255    117264    valida_fecha_vivero()    FUNCTION     �   CREATE FUNCTION public.valida_fecha_vivero() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF new.fecha_de_apertura < '01/01/2000' THEN RAISE EXCEPTION 'Esta fecha no puede ser insertada, inserte una fecha valida';
	END IF;
	RETURN NULL;
END;
$$;
 ,   DROP FUNCTION public.valida_fecha_vivero();
       public       postgres    false    3    1            �           0    0    FUNCTION valida_fecha_vivero()    COMMENT     �   COMMENT ON FUNCTION public.valida_fecha_vivero() IS 'Funcion que valida que la fecha de un vivero no sea de años anteriores al año 2000.';
            public       postgres    false    244            �            1255    117262    valida_venta_empleado()    FUNCTION       CREATE FUNCTION public.valida_venta_empleado() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF (select count(Id_Empleado_que_ayudo_a_cliente) from venta_fisica_r1) > 35
	THEN RAISE EXCEPTION 'El empleado ya ha superado las 35 ventas diarias';
	END IF;
	RETURN NULL;
END;
$$;
 .   DROP FUNCTION public.valida_venta_empleado();
       public       postgres    false    1    3            �           0    0     FUNCTION valida_venta_empleado()    COMMENT     �   COMMENT ON FUNCTION public.valida_venta_empleado() IS 'Funcion que valida que un empleado no pueda realizar mas de 35 ventas diarias.';
            public       postgres    false    243            �            1259    116865    area    TABLE     e   CREATE TABLE public.area (
    id_planta integer NOT NULL,
    id_tipo_de_planta integer NOT NULL
);
    DROP TABLE public.area;
       public         postgres    false    3            �           0    0 
   TABLE area    COMMENT     T   COMMENT ON TABLE public.area IS 'Contiene la informacion de areas de las plantas.';
            public       postgres    false    229            �           0    0    COLUMN area.id_planta    COMMENT     J   COMMENT ON COLUMN public.area.id_planta IS 'Identificador de la Planta.';
            public       postgres    false    229            �           0    0    COLUMN area.id_tipo_de_planta    COMMENT     X   COMMENT ON COLUMN public.area.id_tipo_de_planta IS 'Identificador del tipo de planta.';
            public       postgres    false    229            �            1259    116725 
   cliente_r1    TABLE     P  CREATE TABLE public.cliente_r1 (
    id_cliente integer NOT NULL,
    codigo_cliente character varying(5) NOT NULL,
    nombre character varying(20) NOT NULL,
    apellido_paterno character varying(20) NOT NULL,
    apellido_materno character varying(20) NOT NULL,
    CONSTRAINT chc_c CHECK (((codigo_cliente)::text ~~ 'A%'::text))
);
    DROP TABLE public.cliente_r1;
       public         postgres    false    3            �           0    0    TABLE cliente_r1    COMMENT     S   COMMENT ON TABLE public.cliente_r1 IS 'Contiene la información de los clientes.';
            public       postgres    false    218            �           0    0    COLUMN cliente_r1.id_cliente    COMMENT     P   COMMENT ON COLUMN public.cliente_r1.id_cliente IS 'Identificador del cliente.';
            public       postgres    false    218            �           0    0     COLUMN cliente_r1.codigo_cliente    COMMENT     M   COMMENT ON COLUMN public.cliente_r1.codigo_cliente IS 'Codigo del cliente.';
            public       postgres    false    218            �           0    0    COLUMN cliente_r1.nombre    COMMENT     E   COMMENT ON COLUMN public.cliente_r1.nombre IS 'Nombre del cliente.';
            public       postgres    false    218            �           0    0 "   COLUMN cliente_r1.apellido_paterno    COMMENT     Y   COMMENT ON COLUMN public.cliente_r1.apellido_paterno IS 'Apellido Paterno del cliente.';
            public       postgres    false    218            �           0    0 "   COLUMN cliente_r1.apellido_materno    COMMENT     Y   COMMENT ON COLUMN public.cliente_r1.apellido_materno IS 'Apellido Materno del cliente.';
            public       postgres    false    218            �            1259    116720 
   cliente_r2    TABLE     �   CREATE TABLE public.cliente_r2 (
    codigo_cliente character varying(5) NOT NULL,
    fecha_de_nacimiento date NOT NULL,
    direccion character varying(100) NOT NULL,
    rfc character varying(13) NOT NULL
);
    DROP TABLE public.cliente_r2;
       public         postgres    false    3            �           0    0    TABLE cliente_r2    COMMENT     S   COMMENT ON TABLE public.cliente_r2 IS 'Contiene la información de los clientes.';
            public       postgres    false    217            �           0    0     COLUMN cliente_r2.codigo_cliente    COMMENT     M   COMMENT ON COLUMN public.cliente_r2.codigo_cliente IS 'Codigo del cliente.';
            public       postgres    false    217            �           0    0 %   COLUMN cliente_r2.fecha_de_nacimiento    COMMENT     _   COMMENT ON COLUMN public.cliente_r2.fecha_de_nacimiento IS 'Fehca de nacimiento del cliente.';
            public       postgres    false    217            �           0    0    COLUMN cliente_r2.direccion    COMMENT     K   COMMENT ON COLUMN public.cliente_r2.direccion IS 'Direccion del cliente.';
            public       postgres    false    217            �           0    0    COLUMN cliente_r2.rfc    COMMENT     ?   COMMENT ON COLUMN public.cliente_r2.rfc IS 'RFC del Cliente.';
            public       postgres    false    217            �            1259    116955    comprar_tipo_e    TABLE     u   CREATE TABLE public.comprar_tipo_e (
    id_ventas_electronicas integer NOT NULL,
    id_cliente integer NOT NULL
);
 "   DROP TABLE public.comprar_tipo_e;
       public         postgres    false    3            �           0    0    TABLE comprar_tipo_e    COMMENT     k   COMMENT ON TABLE public.comprar_tipo_e IS 'Contiene la informacion de las ventas y compras electronicas.';
            public       postgres    false    235            �           0    0 ,   COLUMN comprar_tipo_e.id_ventas_electronicas    COMMENT     l   COMMENT ON COLUMN public.comprar_tipo_e.id_ventas_electronicas IS 'Identificador de la venta electronica.';
            public       postgres    false    235            �           0    0     COLUMN comprar_tipo_e.id_cliente    COMMENT     U   COMMENT ON COLUMN public.comprar_tipo_e.id_cliente IS 'Identificador del clientes.';
            public       postgres    false    235            �            1259    116940    comprar_tipo_f    TABLE     n   CREATE TABLE public.comprar_tipo_f (
    id_venta_fisica integer NOT NULL,
    id_cliente integer NOT NULL
);
 "   DROP TABLE public.comprar_tipo_f;
       public         postgres    false    3            �           0    0    TABLE comprar_tipo_f    COMMENT     f   COMMENT ON TABLE public.comprar_tipo_f IS 'Contiene la informacion de las ventas y compras fisicas.';
            public       postgres    false    234            �           0    0 %   COLUMN comprar_tipo_f.id_venta_fisica    COMMENT     `   COMMENT ON COLUMN public.comprar_tipo_f.id_venta_fisica IS 'Identificador de la venta Fisica.';
            public       postgres    false    234            �           0    0     COLUMN comprar_tipo_f.id_cliente    COMMENT     U   COMMENT ON COLUMN public.comprar_tipo_f.id_cliente IS 'Identificador del clientes.';
            public       postgres    false    234            �            1259    116820 	   controlar    TABLE     f   CREATE TABLE public.controlar (
    id_empleado integer NOT NULL,
    id_semillas integer NOT NULL
);
    DROP TABLE public.controlar;
       public         postgres    false    3            �           0    0    TABLE controlar    COMMENT     q   COMMENT ON TABLE public.controlar IS 'Contiene la información de los trabajadores que controlan las Semillas.';
            public       postgres    false    226            �           0    0    COLUMN controlar.id_empleado    COMMENT     Q   COMMENT ON COLUMN public.controlar.id_empleado IS 'Identificador del Empleado.';
            public       postgres    false    226            �           0    0    COLUMN controlar.id_semillas    COMMENT     T   COMMENT ON COLUMN public.controlar.id_semillas IS 'Identificador de las Semillas.';
            public       postgres    false    226            �            1259    116980 
   correo_cli    TABLE     �   CREATE TABLE public.correo_cli (
    id_cliente integer NOT NULL,
    id_correo integer NOT NULL,
    correo character varying(40) NOT NULL,
    CONSTRAINT chc_cc CHECK (((correo)::text ~~ '%@%'::text))
);
    DROP TABLE public.correo_cli;
       public         postgres    false    3            �           0    0    TABLE correo_cli    COMMENT     O   COMMENT ON TABLE public.correo_cli IS 'Contiene los Correos de los clientes.';
            public       postgres    false    237            �           0    0    COLUMN correo_cli.id_cliente    COMMENT     P   COMMENT ON COLUMN public.correo_cli.id_cliente IS 'Identificador del cliente.';
            public       postgres    false    237            �           0    0    COLUMN correo_cli.id_correo    COMMENT     Z   COMMENT ON COLUMN public.correo_cli.id_correo IS 'Identificador del Correo del cliente.';
            public       postgres    false    237            �           0    0    COLUMN correo_cli.correo    COMMENT     E   COMMENT ON COLUMN public.correo_cli.correo IS 'Correo del cliente.';
            public       postgres    false    237            �            1259    116795 
   correo_emp    TABLE     �   CREATE TABLE public.correo_emp (
    id_empleado integer NOT NULL,
    id_correo integer NOT NULL,
    correo character varying(40) NOT NULL,
    CONSTRAINT chc_ce CHECK (((correo)::text ~~ '%@%'::text))
);
    DROP TABLE public.correo_emp;
       public         postgres    false    3            �           0    0    TABLE correo_emp    COMMENT     P   COMMENT ON TABLE public.correo_emp IS 'Contiene los Correos de los Empleados.';
            public       postgres    false    224            �           0    0    COLUMN correo_emp.id_empleado    COMMENT     R   COMMENT ON COLUMN public.correo_emp.id_empleado IS 'Identificador del Empleado.';
            public       postgres    false    224            �           0    0    COLUMN correo_emp.id_correo    COMMENT     [   COMMENT ON COLUMN public.correo_emp.id_correo IS 'Identificador del Correo del Empleado.';
            public       postgres    false    224            �           0    0    COLUMN correo_emp.correo    COMMENT     F   COMMENT ON COLUMN public.correo_emp.correo IS 'Correo del Empleado.';
            public       postgres    false    224            �            1259    116745    direccion_viv    TABLE     �   CREATE TABLE public.direccion_viv (
    id_vivero integer NOT NULL,
    id_direccion integer NOT NULL,
    direccion character varying(100) NOT NULL
);
 !   DROP TABLE public.direccion_viv;
       public         postgres    false    3            �           0    0    TABLE direccion_viv    COMMENT     U   COMMENT ON TABLE public.direccion_viv IS 'Contiene las Direcciones de los Viveros.';
            public       postgres    false    220            �           0    0    COLUMN direccion_viv.id_vivero    COMMENT     Q   COMMENT ON COLUMN public.direccion_viv.id_vivero IS 'Identificador del Vivero.';
            public       postgres    false    220            �           0    0 !   COLUMN direccion_viv.id_direccion    COMMENT     d   COMMENT ON COLUMN public.direccion_viv.id_direccion IS 'Identificador de la Direccion del Vivero.';
            public       postgres    false    220            �           0    0    COLUMN direccion_viv.direccion    COMMENT     M   COMMENT ON COLUMN public.direccion_viv.direccion IS 'Direccion del Vivero.';
            public       postgres    false    220            �            1259    116595    empleado_r1    TABLE     S  CREATE TABLE public.empleado_r1 (
    id_empleado integer NOT NULL,
    curp character varying(20) NOT NULL,
    nombre character varying(20) NOT NULL,
    apellido_paterno character varying(20) NOT NULL,
    apellido_materno character varying(20) NOT NULL,
    fecha_de_nacimiento date NOT NULL,
    rfc character varying(13) NOT NULL
);
    DROP TABLE public.empleado_r1;
       public         postgres    false    3            �           0    0    TABLE empleado_r1    COMMENT     U   COMMENT ON TABLE public.empleado_r1 IS 'Contiene la información de los Empleados.';
            public       postgres    false    200            �           0    0    COLUMN empleado_r1.id_empleado    COMMENT     S   COMMENT ON COLUMN public.empleado_r1.id_empleado IS 'Identificador del Empleado.';
            public       postgres    false    200            �           0    0    COLUMN empleado_r1.curp    COMMENT     C   COMMENT ON COLUMN public.empleado_r1.curp IS 'CURP del Empleado.';
            public       postgres    false    200            �           0    0    COLUMN empleado_r1.nombre    COMMENT     G   COMMENT ON COLUMN public.empleado_r1.nombre IS 'Nombre del Empleado.';
            public       postgres    false    200            �           0    0 #   COLUMN empleado_r1.apellido_paterno    COMMENT     [   COMMENT ON COLUMN public.empleado_r1.apellido_paterno IS 'Apellido Paterno del Empleado.';
            public       postgres    false    200            �           0    0 #   COLUMN empleado_r1.apellido_materno    COMMENT     [   COMMENT ON COLUMN public.empleado_r1.apellido_materno IS 'Apellido Materno del Empleado.';
            public       postgres    false    200            �           0    0 &   COLUMN empleado_r1.fecha_de_nacimiento    COMMENT     a   COMMENT ON COLUMN public.empleado_r1.fecha_de_nacimiento IS 'Fecha de nacimiento del Empleado.';
            public       postgres    false    200            �           0    0    COLUMN empleado_r1.rfc    COMMENT     A   COMMENT ON COLUMN public.empleado_r1.rfc IS 'RFC del Empleado.';
            public       postgres    false    200            �            1259    116590    empleado_r2    TABLE     �   CREATE TABLE public.empleado_r2 (
    curp character varying(20) NOT NULL,
    salario real NOT NULL,
    fecha_inicio_servicio date NOT NULL,
    direccion character varying(40) NOT NULL
);
    DROP TABLE public.empleado_r2;
       public         postgres    false    3            �           0    0    TABLE empleado_r2    COMMENT     p   COMMENT ON TABLE public.empleado_r2 IS 'Contiene la Fecha, Direccion y Salario de empleados acorde a su CURP.';
            public       postgres    false    199            �           0    0    COLUMN empleado_r2.curp    COMMENT     C   COMMENT ON COLUMN public.empleado_r2.curp IS 'CURP del Empleado.';
            public       postgres    false    199            �           0    0    COLUMN empleado_r2.salario    COMMENT     I   COMMENT ON COLUMN public.empleado_r2.salario IS 'Salario del Empleado.';
            public       postgres    false    199            �           0    0 (   COLUMN empleado_r2.fecha_inicio_servicio    COMMENT     o   COMMENT ON COLUMN public.empleado_r2.fecha_inicio_servicio IS 'Fecha en la que inicio a trabajar el empleado';
            public       postgres    false    199            �           0    0    COLUMN empleado_r2.direccion    COMMENT     M   COMMENT ON COLUMN public.empleado_r2.direccion IS 'Direccion del Empleado.';
            public       postgres    false    199            �            1259    116835 	   germinado    TABLE     q   CREATE TABLE public.germinado (
    id_semillas integer NOT NULL,
    id_semillas_germinadas integer NOT NULL
);
    DROP TABLE public.germinado;
       public         postgres    false    3            �           0    0    TABLE germinado    COMMENT     ]   COMMENT ON TABLE public.germinado IS 'Contiene la información de las Semillas Germinadas.';
            public       postgres    false    227            �           0    0    COLUMN germinado.id_semillas    COMMENT     T   COMMENT ON COLUMN public.germinado.id_semillas IS 'Identificador de las Semillas.';
            public       postgres    false    227            �           0    0 '   COLUMN germinado.id_semillas_germinadas    COMMENT     j   COMMENT ON COLUMN public.germinado.id_semillas_germinadas IS 'Identificador de las Semillas Germinadas.';
            public       postgres    false    227            �            1259    116715    pago_e    TABLE     p   CREATE TABLE public.pago_e (
    id_pago_e integer NOT NULL,
    tipo_de_pago character varying(20) NOT NULL
);
    DROP TABLE public.pago_e;
       public         postgres    false    3            �           0    0    TABLE pago_e    COMMENT     Y   COMMENT ON TABLE public.pago_e IS 'Contiene la información de los pagos electronicos.';
            public       postgres    false    216            �           0    0    COLUMN pago_e.id_pago_e    COMMENT     H   COMMENT ON COLUMN public.pago_e.id_pago_e IS 'Identificador del pago.';
            public       postgres    false    216            �           0    0    COLUMN pago_e.tipo_de_pago    COMMENT     L   COMMENT ON COLUMN public.pago_e.tipo_de_pago IS 'Nombre del tipo de pago.';
            public       postgres    false    216            �            1259    116710    pago_f    TABLE     p   CREATE TABLE public.pago_f (
    id_pago_f integer NOT NULL,
    tipo_de_pago character varying(20) NOT NULL
);
    DROP TABLE public.pago_f;
       public         postgres    false    3            �           0    0    TABLE pago_f    COMMENT     T   COMMENT ON TABLE public.pago_f IS 'Contiene la información de los pagos fisicos.';
            public       postgres    false    215            �           0    0    COLUMN pago_f.id_pago_f    COMMENT     H   COMMENT ON COLUMN public.pago_f.id_pago_f IS 'Identificador del pago.';
            public       postgres    false    215            �           0    0    COLUMN pago_f.tipo_de_pago    COMMENT     L   COMMENT ON COLUMN public.pago_f.tipo_de_pago IS 'Nombre del tipo de pago.';
            public       postgres    false    215            �            1259    116645 
   plantas_r1    TABLE       CREATE TABLE public.plantas_r1 (
    id_planta integer NOT NULL,
    nombre character varying(20) NOT NULL,
    fechas_de_riego date NOT NULL,
    fecha_de_germinacion date NOT NULL,
    CONSTRAINT chp_nombre CHECK (((nombre)::text = ANY ((ARRAY['Haworthia G'::character varying, 'Gasteria G'::character varying, 'Astrophytum G'::character varying, 'Ariocarpus G'::character varying, 'Haworthia P'::character varying, 'Gasteria P'::character varying, 'Astrophytum P'::character varying, 'Ariocarpus P'::character varying])::text[])))
);
    DROP TABLE public.plantas_r1;
       public         postgres    false    3            �           0    0    TABLE plantas_r1    COMMENT     [   COMMENT ON TABLE public.plantas_r1 IS 'Contiene nombre y fechas de riego de las Plantas.';
            public       postgres    false    207            �           0    0    COLUMN plantas_r1.id_planta    COMMENT     P   COMMENT ON COLUMN public.plantas_r1.id_planta IS 'Identificador de la Planta.';
            public       postgres    false    207            �           0    0    COLUMN plantas_r1.nombre    COMMENT     F   COMMENT ON COLUMN public.plantas_r1.nombre IS 'Nombre de la Planta.';
            public       postgres    false    207            �           0    0 !   COLUMN plantas_r1.fechas_de_riego    COMMENT     X   COMMENT ON COLUMN public.plantas_r1.fechas_de_riego IS 'Fechas de riego de la Planta.';
            public       postgres    false    207            �           0    0 &   COLUMN plantas_r1.fecha_de_germinacion    COMMENT     b   COMMENT ON COLUMN public.plantas_r1.fecha_de_germinacion IS 'Fecha de germinacion de la Planta.';
            public       postgres    false    207            �            1259    116640 
   plantas_r2    TABLE     �   CREATE TABLE public.plantas_r2 (
    nombre character varying(20) NOT NULL,
    precio real NOT NULL,
    numero_de_plantas integer NOT NULL
);
    DROP TABLE public.plantas_r2;
       public         postgres    false    3            �           0    0    TABLE plantas_r2    COMMENT     R   COMMENT ON TABLE public.plantas_r2 IS 'Contiene la información de las Plantas.';
            public       postgres    false    206            �           0    0    COLUMN plantas_r2.nombre    COMMENT     F   COMMENT ON COLUMN public.plantas_r2.nombre IS 'Nombre de la Planta.';
            public       postgres    false    206            �           0    0    COLUMN plantas_r2.precio    COMMENT     F   COMMENT ON COLUMN public.plantas_r2.precio IS 'Precio de la Planta.';
            public       postgres    false    206            �           0    0 #   COLUMN plantas_r2.numero_de_plantas    COMMENT     O   COMMENT ON COLUMN public.plantas_r2.numero_de_plantas IS 'Numero de plantas.';
            public       postgres    false    206            �            1259    116925 
   registra_e    TABLE     p   CREATE TABLE public.registra_e (
    id_ventas_electronicas integer NOT NULL,
    id_pago_e integer NOT NULL
);
    DROP TABLE public.registra_e;
       public         postgres    false    3            �           0    0    TABLE registra_e    COMMENT     t   COMMENT ON TABLE public.registra_e IS 'Contiene la información de los registros de pagos de ventas electronicas.';
            public       postgres    false    233            �           0    0 (   COLUMN registra_e.id_ventas_electronicas    COMMENT     h   COMMENT ON COLUMN public.registra_e.id_ventas_electronicas IS 'Identificador de la venta electronica.';
            public       postgres    false    233            �           0    0    COLUMN registra_e.id_pago_e    COMMENT     L   COMMENT ON COLUMN public.registra_e.id_pago_e IS 'Identificador del pago.';
            public       postgres    false    233            �            1259    116910 
   registra_f    TABLE     i   CREATE TABLE public.registra_f (
    id_venta_fisica integer NOT NULL,
    id_pago_f integer NOT NULL
);
    DROP TABLE public.registra_f;
       public         postgres    false    3            �           0    0    TABLE registra_f    COMMENT     o   COMMENT ON TABLE public.registra_f IS 'Contiene la información de los registros de pagos de ventas fisicas.';
            public       postgres    false    232            �           0    0 !   COLUMN registra_f.id_venta_fisica    COMMENT     \   COMMENT ON COLUMN public.registra_f.id_venta_fisica IS 'Identificador de la venta Fisica.';
            public       postgres    false    232            �           0    0    COLUMN registra_f.id_pago_f    COMMENT     S   COMMENT ON COLUMN public.registra_f.id_pago_f IS 'Identificador del pago fisico.';
            public       postgres    false    232            �            1259    116755 	   registrar    TABLE     d   CREATE TABLE public.registrar (
    id_vivero integer NOT NULL,
    id_registro integer NOT NULL
);
    DROP TABLE public.registrar;
       public         postgres    false    3            �           0    0    TABLE registrar    COMMENT     a   COMMENT ON TABLE public.registrar IS 'Contiene la informacion de los registros de los Viveros.';
            public       postgres    false    221            �           0    0    COLUMN registrar.id_vivero    COMMENT     M   COMMENT ON COLUMN public.registrar.id_vivero IS 'Identificador del Vivero.';
            public       postgres    false    221            �           0    0    COLUMN registrar.id_registro    COMMENT     Q   COMMENT ON COLUMN public.registrar.id_registro IS 'Identificador del Registro.';
            public       postgres    false    221            �            1259    116580    registro_r1    TABLE     n  CREATE TABLE public.registro_r1 (
    id_registro integer NOT NULL,
    genero character varying(30) NOT NULL,
    nombre character varying(20) NOT NULL,
    CONSTRAINT chr_genero_a CHECK ((((genero)::text ~~ '%Haworthia%'::text) OR ((genero)::text ~~ '%Gasteria%'::text) OR ((genero)::text ~~ '%Astrophytum%'::text) OR ((genero)::text ~~ '%Ariocarpus%'::text)))
);
    DROP TABLE public.registro_r1;
       public         postgres    false    3            �           0    0    TABLE registro_r1    COMMENT     o   COMMENT ON TABLE public.registro_r1 IS 'Contiene la información de los Registros de ejemplares productoras.';
            public       postgres    false    198            �           0    0    COLUMN registro_r1.id_registro    COMMENT     S   COMMENT ON COLUMN public.registro_r1.id_registro IS 'Identificador del Registro.';
            public       postgres    false    198            �           0    0    COLUMN registro_r1.genero    COMMENT     R   COMMENT ON COLUMN public.registro_r1.genero IS 'Genero de la planta productora.';
            public       postgres    false    198            �           0    0    COLUMN registro_r1.nombre    COMMENT     G   COMMENT ON COLUMN public.registro_r1.nombre IS 'Nombre del Registro.';
            public       postgres    false    198            �            1259    116575    registro_r2    TABLE     �   CREATE TABLE public.registro_r2 (
    genero character varying(30) NOT NULL,
    fecha_de_adquisicion date NOT NULL,
    ultimo_riego date NOT NULL,
    ultimo_fertilizante date NOT NULL,
    ultima_fumigacion date NOT NULL
);
    DROP TABLE public.registro_r2;
       public         postgres    false    3            �           0    0    TABLE registro_r2    COMMENT     l   COMMENT ON TABLE public.registro_r2 IS 'Contiene la información de las Fechas de ejemplares productoras.';
            public       postgres    false    197            �           0    0    COLUMN registro_r2.genero    COMMENT     R   COMMENT ON COLUMN public.registro_r2.genero IS 'Genero de la planta productora.';
            public       postgres    false    197            �           0    0 '   COLUMN registro_r2.fecha_de_adquisicion    COMMENT     V   COMMENT ON COLUMN public.registro_r2.fecha_de_adquisicion IS 'Fecha de adquisicion.';
            public       postgres    false    197            �           0    0    COLUMN registro_r2.ultimo_riego    COMMENT     P   COMMENT ON COLUMN public.registro_r2.ultimo_riego IS 'Fecha del ultimo riego.';
            public       postgres    false    197            �           0    0 &   COLUMN registro_r2.ultimo_fertilizante    COMMENT     ^   COMMENT ON COLUMN public.registro_r2.ultimo_fertilizante IS 'Fecha del ultimo fertilizante.';
            public       postgres    false    197            �           0    0 $   COLUMN registro_r2.ultima_fumigacion    COMMENT     \   COMMENT ON COLUMN public.registro_r2.ultima_fumigacion IS 'Fecha de la ultima fumigacion.';
            public       postgres    false    197            �            1259    116605    rol    TABLE     i   CREATE TABLE public.rol (
    id_rol integer NOT NULL,
    tipo_de_rol character varying(50) NOT NULL
);
    DROP TABLE public.rol;
       public         postgres    false    3            �           0    0 	   TABLE rol    COMMENT     O   COMMENT ON TABLE public.rol IS 'Contiene el nombre del rol de los Empleados.';
            public       postgres    false    201            �           0    0    COLUMN rol.id_rol    COMMENT     N   COMMENT ON COLUMN public.rol.id_rol IS 'Identificador del Rol del Empleado.';
            public       postgres    false    201            �           0    0    COLUMN rol.tipo_de_rol    COMMENT     L   COMMENT ON COLUMN public.rol.tipo_de_rol IS 'Nombre del rol del Empleado.';
            public       postgres    false    201            �            1259    116630    semillas_germinadas_r1    TABLE     (  CREATE TABLE public.semillas_germinadas_r1 (
    id_semillas_germinadas integer NOT NULL,
    origen character varying(30) NOT NULL,
    semillas_germinadas integer NOT NULL,
    CONSTRAINT chsg_origen_am CHECK ((((origen)::text ~~ '%America%'::text) OR ((origen)::text ~~ '%Africa%'::text)))
);
 *   DROP TABLE public.semillas_germinadas_r1;
       public         postgres    false    3            �           0    0    TABLE semillas_germinadas_r1    COMMENT     j   COMMENT ON TABLE public.semillas_germinadas_r1 IS 'Contiene la información de las semillas germinadas.';
            public       postgres    false    205            �           0    0 4   COLUMN semillas_germinadas_r1.id_semillas_germinadas    COMMENT     w   COMMENT ON COLUMN public.semillas_germinadas_r1.id_semillas_germinadas IS 'Identificador de las Semillas Germinadas.';
            public       postgres    false    205            �           0    0 $   COLUMN semillas_germinadas_r1.origen    COMMENT     `   COMMENT ON COLUMN public.semillas_germinadas_r1.origen IS 'Origen de las Semillas Germinadas.';
            public       postgres    false    205            �           0    0 1   COLUMN semillas_germinadas_r1.semillas_germinadas    COMMENT     i   COMMENT ON COLUMN public.semillas_germinadas_r1.semillas_germinadas IS 'Numero de Semillas Germinadas.';
            public       postgres    false    205            �            1259    116625    semillas_germinadas_r2    TABLE     �   CREATE TABLE public.semillas_germinadas_r2 (
    origen character varying(30) NOT NULL,
    fecha_de_siembra date NOT NULL,
    ultimo_riego date NOT NULL,
    ultimo_fertilizante date NOT NULL,
    ultima_fumigacion date NOT NULL
);
 *   DROP TABLE public.semillas_germinadas_r2;
       public         postgres    false    3            �           0    0    TABLE semillas_germinadas_r2    COMMENT     j   COMMENT ON TABLE public.semillas_germinadas_r2 IS 'Contiene origen y fechas de las semillas germinadas.';
            public       postgres    false    204            �           0    0 $   COLUMN semillas_germinadas_r2.origen    COMMENT     `   COMMENT ON COLUMN public.semillas_germinadas_r2.origen IS 'Origen de las Semillas Germinadas.';
            public       postgres    false    204            �           0    0 .   COLUMN semillas_germinadas_r2.fecha_de_siembra    COMMENT     t   COMMENT ON COLUMN public.semillas_germinadas_r2.fecha_de_siembra IS 'Fehca de siembra de las Semillas Germinadas.';
            public       postgres    false    204                        0    0 *   COLUMN semillas_germinadas_r2.ultimo_riego    COMMENT     [   COMMENT ON COLUMN public.semillas_germinadas_r2.ultimo_riego IS 'Fecha del ultimo riego.';
            public       postgres    false    204                       0    0 1   COLUMN semillas_germinadas_r2.ultimo_fertilizante    COMMENT     i   COMMENT ON COLUMN public.semillas_germinadas_r2.ultimo_fertilizante IS 'Fecha del ultimo fertilizante.';
            public       postgres    false    204                       0    0 /   COLUMN semillas_germinadas_r2.ultima_fumigacion    COMMENT     g   COMMENT ON COLUMN public.semillas_germinadas_r2.ultima_fumigacion IS 'Fecha de la ultima fumigacion.';
            public       postgres    false    204            �            1259    116615    semillas_r1    TABLE     �   CREATE TABLE public.semillas_r1 (
    id_semillas integer NOT NULL,
    planta_de_cruce character varying(20) NOT NULL,
    CONSTRAINT chs_pc CHECK (((planta_de_cruce)::text ~~ 'F%'::text))
);
    DROP TABLE public.semillas_r1;
       public         postgres    false    3                       0    0    TABLE semillas_r1    COMMENT     g   COMMENT ON TABLE public.semillas_r1 IS 'Contiene el id de Semillas y nombre de las plantas de cruce.';
            public       postgres    false    203                       0    0    COLUMN semillas_r1.id_semillas    COMMENT     V   COMMENT ON COLUMN public.semillas_r1.id_semillas IS 'Identificador de las Semillas.';
            public       postgres    false    203                       0    0 "   COLUMN semillas_r1.planta_de_cruce    COMMENT     K   COMMENT ON COLUMN public.semillas_r1.planta_de_cruce IS 'Panta de cruce.';
            public       postgres    false    203            �            1259    116610    semillas_r2    TABLE     �   CREATE TABLE public.semillas_r2 (
    planta_de_cruce character varying(20) NOT NULL,
    fecha_de_polinizacion date NOT NULL,
    cantidad_de_semillas integer NOT NULL
);
    DROP TABLE public.semillas_r2;
       public         postgres    false    3                       0    0    TABLE semillas_r2    COMMENT     �   COMMENT ON TABLE public.semillas_r2 IS 'Contiene las fechas de polinizacion y cantidad de semillas acorde a la planta de cruce.';
            public       postgres    false    202                       0    0 "   COLUMN semillas_r2.planta_de_cruce    COMMENT     K   COMMENT ON COLUMN public.semillas_r2.planta_de_cruce IS 'Panta de cruce.';
            public       postgres    false    202                       0    0 (   COLUMN semillas_r2.fecha_de_polinizacion    COMMENT     h   COMMENT ON COLUMN public.semillas_r2.fecha_de_polinizacion IS 'Fecha de polinizacion de las Semillas.';
            public       postgres    false    202            	           0    0 '   COLUMN semillas_r2.cantidad_de_semillas    COMMENT     V   COMMENT ON COLUMN public.semillas_r2.cantidad_de_semillas IS 'Cantidad de Semillas.';
            public       postgres    false    202            �            1259    116970    telefono_cli    TABLE     �   CREATE TABLE public.telefono_cli (
    id_cliente integer NOT NULL,
    id_telefono integer NOT NULL,
    telefono character varying(12) NOT NULL
);
     DROP TABLE public.telefono_cli;
       public         postgres    false    3            
           0    0    TABLE telefono_cli    COMMENT     S   COMMENT ON TABLE public.telefono_cli IS 'Contiene los Telefonos de los clientes.';
            public       postgres    false    236                       0    0    COLUMN telefono_cli.id_cliente    COMMENT     R   COMMENT ON COLUMN public.telefono_cli.id_cliente IS 'Identificador del cliente.';
            public       postgres    false    236                       0    0    COLUMN telefono_cli.id_telefono    COMMENT     `   COMMENT ON COLUMN public.telefono_cli.id_telefono IS 'Identificador del Telefono del cliente.';
            public       postgres    false    236                       0    0    COLUMN telefono_cli.telefono    COMMENT     c   COMMENT ON COLUMN public.telefono_cli.telefono IS 'Numero de telefono de 12 digitos del cliente.';
            public       postgres    false    236            �            1259    116785    telefono_emp    TABLE     �   CREATE TABLE public.telefono_emp (
    id_empleado integer NOT NULL,
    id_telefono integer NOT NULL,
    telefono character varying(12) NOT NULL
);
     DROP TABLE public.telefono_emp;
       public         postgres    false    3                       0    0    TABLE telefono_emp    COMMENT     T   COMMENT ON TABLE public.telefono_emp IS 'Contiene los Telefonos de los Empleados.';
            public       postgres    false    223                       0    0    COLUMN telefono_emp.id_empleado    COMMENT     T   COMMENT ON COLUMN public.telefono_emp.id_empleado IS 'Identificador del Empleado.';
            public       postgres    false    223                       0    0    COLUMN telefono_emp.id_telefono    COMMENT     a   COMMENT ON COLUMN public.telefono_emp.id_telefono IS 'Identificador del Telefono del Empleado.';
            public       postgres    false    223                       0    0    COLUMN telefono_emp.telefono    COMMENT     d   COMMENT ON COLUMN public.telefono_emp.telefono IS 'Numero de telefono de 12 digitos del Empleado.';
            public       postgres    false    223            �            1259    116735    telefono_viv    TABLE     [  CREATE TABLE public.telefono_viv (
    id_vivero integer NOT NULL,
    id_telefono integer NOT NULL,
    telefono character varying(12) NOT NULL,
    CONSTRAINT chc_t CHECK (((telefono)::text ~~ '5255%'::text)),
    CONSTRAINT che_t CHECK (((telefono)::text ~~ '5255%'::text)),
    CONSTRAINT chvi_t CHECK (((telefono)::text ~~ '5255%'::text))
);
     DROP TABLE public.telefono_viv;
       public         postgres    false    3                       0    0    TABLE telefono_viv    COMMENT     R   COMMENT ON TABLE public.telefono_viv IS 'Contiene los Telefonos de los Viveros.';
            public       postgres    false    219                       0    0    COLUMN telefono_viv.id_vivero    COMMENT     P   COMMENT ON COLUMN public.telefono_viv.id_vivero IS 'Identificador del Vivero.';
            public       postgres    false    219                       0    0    COLUMN telefono_viv.id_telefono    COMMENT     _   COMMENT ON COLUMN public.telefono_viv.id_telefono IS 'Identificador del Telefono del Vivero.';
            public       postgres    false    219                       0    0    COLUMN telefono_viv.telefono    COMMENT     b   COMMENT ON COLUMN public.telefono_viv.telefono IS 'Numero de telefono de 12 digitos del Vivero.';
            public       postgres    false    219            �            1259    116805 	   tiene_emp    TABLE     a   CREATE TABLE public.tiene_emp (
    id_empleado integer NOT NULL,
    id_rol integer NOT NULL
);
    DROP TABLE public.tiene_emp;
       public         postgres    false    3                       0    0    TABLE tiene_emp    COMMENT     _   COMMENT ON TABLE public.tiene_emp IS 'Contiene la información de los tipos de Trabajadores.';
            public       postgres    false    225                       0    0    COLUMN tiene_emp.id_empleado    COMMENT     Q   COMMENT ON COLUMN public.tiene_emp.id_empleado IS 'Identificador del Empleado.';
            public       postgres    false    225                       0    0    COLUMN tiene_emp.id_rol    COMMENT     T   COMMENT ON COLUMN public.tiene_emp.id_rol IS 'Identificador del rol del Empleado.';
            public       postgres    false    225            �            1259    116850 	   tiene_pla    TABLE     b   CREATE TABLE public.tiene_pla (
    id_vivero integer NOT NULL,
    id_planta integer NOT NULL
);
    DROP TABLE public.tiene_pla;
       public         postgres    false    3                       0    0    TABLE tiene_pla    COMMENT     S   COMMENT ON TABLE public.tiene_pla IS 'Contiene las Plantas que hay en un Vivero.';
            public       postgres    false    228                       0    0    COLUMN tiene_pla.id_vivero    COMMENT     M   COMMENT ON COLUMN public.tiene_pla.id_vivero IS 'Identificador del Vivero.';
            public       postgres    false    228                       0    0    COLUMN tiene_pla.id_planta    COMMENT     O   COMMENT ON COLUMN public.tiene_pla.id_planta IS 'Identificador de la Planta.';
            public       postgres    false    228            �            1259    116660    tipo_de_planta_r1    TABLE     j  CREATE TABLE public.tipo_de_planta_r1 (
    id_tipo_de_planta integer NOT NULL,
    nombre_del_tipo_de_planta character varying(20) NOT NULL,
    genero character varying(30) NOT NULL,
    CONSTRAINT cht_genero CHECK (((genero)::text = ANY ((ARRAY['Haworthia'::character varying, 'Gasteria'::character varying, 'Astrophytum'::character varying, 'Ariocarpus'::character varying])::text[]))),
    CONSTRAINT cht_nombre CHECK (((nombre_del_tipo_de_planta)::text = ANY ((ARRAY['Haworthia'::character varying, 'Gasteria'::character varying, 'Astrophytum'::character varying, 'Ariocarpus'::character varying])::text[])))
);
 %   DROP TABLE public.tipo_de_planta_r1;
       public         postgres    false    3                       0    0    TABLE tipo_de_planta_r1    COMMENT     g   COMMENT ON TABLE public.tipo_de_planta_r1 IS 'Contiene nombre tipo y genero de los tipos de plantas.';
            public       postgres    false    209                       0    0 *   COLUMN tipo_de_planta_r1.id_tipo_de_planta    COMMENT     _   COMMENT ON COLUMN public.tipo_de_planta_r1.id_tipo_de_planta IS 'Identificador de la planta.';
            public       postgres    false    209                       0    0 2   COLUMN tipo_de_planta_r1.nombre_del_tipo_de_planta    COMMENT     i   COMMENT ON COLUMN public.tipo_de_planta_r1.nombre_del_tipo_de_planta IS 'Nombre del tipo de la planta.';
            public       postgres    false    209                       0    0    COLUMN tipo_de_planta_r1.genero    COMMENT     M   COMMENT ON COLUMN public.tipo_de_planta_r1.genero IS 'Genero de la planta.';
            public       postgres    false    209            �            1259    116655    tipo_de_planta_r2    TABLE     �   CREATE TABLE public.tipo_de_planta_r2 (
    nombre_del_tipo_de_planta character varying(20) NOT NULL,
    cuidados_basicos character varying(200) NOT NULL,
    tipo_de_sustrato character varying(120) NOT NULL
);
 %   DROP TABLE public.tipo_de_planta_r2;
       public         postgres    false    3                        0    0    TABLE tipo_de_planta_r2    COMMENT     b   COMMENT ON TABLE public.tipo_de_planta_r2 IS 'Contiene la información de los tipos de plantas.';
            public       postgres    false    208            !           0    0 2   COLUMN tipo_de_planta_r2.nombre_del_tipo_de_planta    COMMENT     i   COMMENT ON COLUMN public.tipo_de_planta_r2.nombre_del_tipo_de_planta IS 'Nombre del tipo de la planta.';
            public       postgres    false    208            "           0    0 )   COLUMN tipo_de_planta_r2.cuidados_basicos    COMMENT     a   COMMENT ON COLUMN public.tipo_de_planta_r2.cuidados_basicos IS 'Cuidados basicos de la planta.';
            public       postgres    false    208            #           0    0 )   COLUMN tipo_de_planta_r2.tipo_de_sustrato    COMMENT     a   COMMENT ON COLUMN public.tipo_de_planta_r2.tipo_de_sustrato IS 'Tipo de sustrato de la planta.';
            public       postgres    false    208            �            1259    116770    trabajar    TABLE     c   CREATE TABLE public.trabajar (
    id_vivero integer NOT NULL,
    id_empleado integer NOT NULL
);
    DROP TABLE public.trabajar;
       public         postgres    false    3            $           0    0    TABLE trabajar    COMMENT     d   COMMENT ON TABLE public.trabajar IS 'Contiene la información de los trabajadores de los Viveros.';
            public       postgres    false    222            %           0    0    COLUMN trabajar.id_vivero    COMMENT     L   COMMENT ON COLUMN public.trabajar.id_vivero IS 'Identificador del Vivero.';
            public       postgres    false    222            &           0    0    COLUMN trabajar.id_empleado    COMMENT     P   COMMENT ON COLUMN public.trabajar.id_empleado IS 'Identificador del Empleado.';
            public       postgres    false    222            �            1259    116895    venta_e    TABLE     m   CREATE TABLE public.venta_e (
    id_vivero integer NOT NULL,
    id_ventas_electronicas integer NOT NULL
);
    DROP TABLE public.venta_e;
       public         postgres    false    3            '           0    0    TABLE venta_e    COMMENT     g   COMMENT ON TABLE public.venta_e IS 'Contiene la información de de los tipos de ventas electronicas.';
            public       postgres    false    231            (           0    0    COLUMN venta_e.id_vivero    COMMENT     K   COMMENT ON COLUMN public.venta_e.id_vivero IS 'Identificador del Vivero.';
            public       postgres    false    231            )           0    0 %   COLUMN venta_e.id_ventas_electronicas    COMMENT     e   COMMENT ON COLUMN public.venta_e.id_ventas_electronicas IS 'Identificador de la Venta Electronica.';
            public       postgres    false    231            �            1259    116880    venta_f    TABLE     f   CREATE TABLE public.venta_f (
    id_vivero integer NOT NULL,
    id_venta_fisica integer NOT NULL
);
    DROP TABLE public.venta_f;
       public         postgres    false    3            *           0    0    TABLE venta_f    COMMENT     b   COMMENT ON TABLE public.venta_f IS 'Contiene la información de de los tipos de ventas fisicas.';
            public       postgres    false    230            +           0    0    COLUMN venta_f.id_vivero    COMMENT     K   COMMENT ON COLUMN public.venta_f.id_vivero IS 'Identificador del Vivero.';
            public       postgres    false    230            ,           0    0    COLUMN venta_f.id_venta_fisica    COMMENT     Y   COMMENT ON COLUMN public.venta_f.id_venta_fisica IS 'Identificador de la Venta Fisica.';
            public       postgres    false    230            �            1259    116685    venta_fisica_r1    TABLE     �  CREATE TABLE public.venta_fisica_r1 (
    id_venta_fisica integer NOT NULL,
    numero_ticket integer NOT NULL,
    codigo_cliente character varying(5) NOT NULL,
    clave_producto character varying(5) NOT NULL,
    fecha_venta_f date NOT NULL,
    id_empleado_que_ayudo_a_cliente integer NOT NULL,
    empleado_que_efectuo_el_cobro integer NOT NULL,
    vivero_donde_se_adquirio integer NOT NULL,
    forma_de_pago character varying(20) NOT NULL,
    CONSTRAINT chvf_cp CHECK (((clave_producto)::text = ANY ((ARRAY['PTHAG'::character varying, 'PTHAP'::character varying, 'PTGAG'::character varying, 'PTGAP'::character varying, 'PTASG'::character varying, 'PTASP'::character varying, 'PTARG'::character varying, 'PTARP'::character varying])::text[]))),
    CONSTRAINT chvf_f CHECK (((forma_de_pago)::text = ANY ((ARRAY['Efectivo'::character varying, 'Tarjeta de Debito'::character varying, 'Tarjeta de Credito'::character varying])::text[])))
);
 #   DROP TABLE public.venta_fisica_r1;
       public         postgres    false    3            -           0    0    TABLE venta_fisica_r1    COMMENT     m   COMMENT ON TABLE public.venta_fisica_r1 IS 'Contiene la información de las Ventas Fisicas de los Viveros.';
            public       postgres    false    212            .           0    0 &   COLUMN venta_fisica_r1.id_venta_fisica    COMMENT     a   COMMENT ON COLUMN public.venta_fisica_r1.id_venta_fisica IS 'Identificador de la Venta Fisica.';
            public       postgres    false    212            /           0    0 $   COLUMN venta_fisica_r1.numero_ticket    COMMENT     O   COMMENT ON COLUMN public.venta_fisica_r1.numero_ticket IS 'Numero de ticket.';
            public       postgres    false    212            0           0    0 %   COLUMN venta_fisica_r1.codigo_cliente    COMMENT     Q   COMMENT ON COLUMN public.venta_fisica_r1.codigo_cliente IS 'Codigo de cliente.';
            public       postgres    false    212            1           0    0 %   COLUMN venta_fisica_r1.clave_producto    COMMENT     U   COMMENT ON COLUMN public.venta_fisica_r1.clave_producto IS 'La clave del producto.';
            public       postgres    false    212            2           0    0 $   COLUMN venta_fisica_r1.fecha_venta_f    COMMENT     W   COMMENT ON COLUMN public.venta_fisica_r1.fecha_venta_f IS 'Fecha de la venta fisica.';
            public       postgres    false    212            3           0    0 6   COLUMN venta_fisica_r1.id_empleado_que_ayudo_a_cliente    COMMENT     w   COMMENT ON COLUMN public.venta_fisica_r1.id_empleado_que_ayudo_a_cliente IS 'Id del Empleado que ayudo a un cliente.';
            public       postgres    false    212            4           0    0 4   COLUMN venta_fisica_r1.empleado_que_efectuo_el_cobro    COMMENT     l   COMMENT ON COLUMN public.venta_fisica_r1.empleado_que_efectuo_el_cobro IS 'Empleado que efectuo el cobro.';
            public       postgres    false    212            5           0    0 /   COLUMN venta_fisica_r1.vivero_donde_se_adquirio    COMMENT     n   COMMENT ON COLUMN public.venta_fisica_r1.vivero_donde_se_adquirio IS 'Vivero donde se adquirio el producto.';
            public       postgres    false    212            6           0    0 $   COLUMN venta_fisica_r1.forma_de_pago    COMMENT     L   COMMENT ON COLUMN public.venta_fisica_r1.forma_de_pago IS 'Forma de pago.';
            public       postgres    false    212            �            1259    116675    venta_fisica_r2    TABLE     
  CREATE TABLE public.venta_fisica_r2 (
    numero_ticket integer NOT NULL,
    clave_producto character varying(5) NOT NULL,
    numero_de_productos_adquiridos integer NOT NULL,
    total_productos integer NOT NULL,
    CONSTRAINT chvf_cp CHECK (((clave_producto)::text = ANY ((ARRAY['PTHAG'::character varying, 'PTHAP'::character varying, 'PTGAG'::character varying, 'PTGAP'::character varying, 'PTASG'::character varying, 'PTASP'::character varying, 'PTARG'::character varying, 'PTARP'::character varying])::text[])))
);
 #   DROP TABLE public.venta_fisica_r2;
       public         postgres    false    3            7           0    0    TABLE venta_fisica_r2    COMMENT     m   COMMENT ON TABLE public.venta_fisica_r2 IS 'Contiene la información del ticket y los productos comprados.';
            public       postgres    false    211            8           0    0 $   COLUMN venta_fisica_r2.numero_ticket    COMMENT     O   COMMENT ON COLUMN public.venta_fisica_r2.numero_ticket IS 'Numero de ticket.';
            public       postgres    false    211            9           0    0 %   COLUMN venta_fisica_r2.clave_producto    COMMENT     U   COMMENT ON COLUMN public.venta_fisica_r2.clave_producto IS 'La clave del producto.';
            public       postgres    false    211            :           0    0 5   COLUMN venta_fisica_r2.numero_de_productos_adquiridos    COMMENT     n   COMMENT ON COLUMN public.venta_fisica_r2.numero_de_productos_adquiridos IS 'Numero de Productos adquiridos.';
            public       postgres    false    211            ;           0    0 &   COLUMN venta_fisica_r2.total_productos    COMMENT     Y   COMMENT ON COLUMN public.venta_fisica_r2.total_productos IS 'Costo total de Productos.';
            public       postgres    false    211            �            1259    116670    venta_fisica_r3    TABLE     �   CREATE TABLE public.venta_fisica_r3 (
    clave_producto character varying(5) NOT NULL,
    nombre_producto character varying(70) NOT NULL,
    precio_producto real NOT NULL
);
 #   DROP TABLE public.venta_fisica_r3;
       public         postgres    false    3            <           0    0    TABLE venta_fisica_r3    COMMENT     Y   COMMENT ON TABLE public.venta_fisica_r3 IS 'Contiene la información de los Productos.';
            public       postgres    false    210            =           0    0 %   COLUMN venta_fisica_r3.clave_producto    COMMENT     U   COMMENT ON COLUMN public.venta_fisica_r3.clave_producto IS 'La clave del producto.';
            public       postgres    false    210            >           0    0 &   COLUMN venta_fisica_r3.nombre_producto    COMMENT     T   COMMENT ON COLUMN public.venta_fisica_r3.nombre_producto IS 'Nombre del producto.';
            public       postgres    false    210            ?           0    0 &   COLUMN venta_fisica_r3.precio_producto    COMMENT     T   COMMENT ON COLUMN public.venta_fisica_r3.precio_producto IS 'Precio del producto.';
            public       postgres    false    210            �            1259    116700    ventas_electronicas_r1    TABLE       CREATE TABLE public.ventas_electronicas_r1 (
    id_ventas_electronicas integer NOT NULL,
    numero_de_seguimiento integer NOT NULL,
    fecha_venta_e date NOT NULL,
    codigo_cliente character varying(5) NOT NULL,
    nombre character varying(20) NOT NULL,
    apellido_paterno character varying(20) NOT NULL,
    apellido_materno character varying(20) NOT NULL,
    numero_de_productos integer NOT NULL,
    desglose_de_productos_adquiridos character varying(200) NOT NULL,
    precio_a_pagar real NOT NULL
);
 *   DROP TABLE public.ventas_electronicas_r1;
       public         postgres    false    3            @           0    0    TABLE ventas_electronicas_r1    COMMENT     �   COMMENT ON TABLE public.ventas_electronicas_r1 IS 'Contiene la información de los clientes que realizan compras electronicas.';
            public       postgres    false    214            A           0    0 4   COLUMN ventas_electronicas_r1.id_ventas_electronicas    COMMENT     t   COMMENT ON COLUMN public.ventas_electronicas_r1.id_ventas_electronicas IS 'Identificador de la venta electronica.';
            public       postgres    false    214            B           0    0 3   COLUMN ventas_electronicas_r1.numero_de_seguimiento    COMMENT     {   COMMENT ON COLUMN public.ventas_electronicas_r1.numero_de_seguimiento IS 'Numero de seguimiento de la venta electronica.';
            public       postgres    false    214            C           0    0 +   COLUMN ventas_electronicas_r1.fecha_venta_e    COMMENT     c   COMMENT ON COLUMN public.ventas_electronicas_r1.fecha_venta_e IS 'Fecha de la venta electronica.';
            public       postgres    false    214            D           0    0 ,   COLUMN ventas_electronicas_r1.codigo_cliente    COMMENT     X   COMMENT ON COLUMN public.ventas_electronicas_r1.codigo_cliente IS 'Codigo de cliente.';
            public       postgres    false    214            E           0    0 $   COLUMN ventas_electronicas_r1.nombre    COMMENT     Q   COMMENT ON COLUMN public.ventas_electronicas_r1.nombre IS 'Nombre del cliente.';
            public       postgres    false    214            F           0    0 .   COLUMN ventas_electronicas_r1.apellido_paterno    COMMENT     e   COMMENT ON COLUMN public.ventas_electronicas_r1.apellido_paterno IS 'Apellido Paterno del cliente.';
            public       postgres    false    214            G           0    0 .   COLUMN ventas_electronicas_r1.apellido_materno    COMMENT     e   COMMENT ON COLUMN public.ventas_electronicas_r1.apellido_materno IS 'Apellido Materno del cliente.';
            public       postgres    false    214            H           0    0 1   COLUMN ventas_electronicas_r1.numero_de_productos    COMMENT     j   COMMENT ON COLUMN public.ventas_electronicas_r1.numero_de_productos IS 'Numero de productos adquiridos.';
            public       postgres    false    214            I           0    0 >   COLUMN ventas_electronicas_r1.desglose_de_productos_adquiridos    COMMENT     }   COMMENT ON COLUMN public.ventas_electronicas_r1.desglose_de_productos_adquiridos IS 'Desglose de los productos adquiridos.';
            public       postgres    false    214            J           0    0 ,   COLUMN ventas_electronicas_r1.precio_a_pagar    COMMENT     W   COMMENT ON COLUMN public.ventas_electronicas_r1.precio_a_pagar IS 'Cantidad a pagar.';
            public       postgres    false    214            �            1259    116695    ventas_electronicas_r2    TABLE       CREATE TABLE public.ventas_electronicas_r2 (
    numero_de_seguimiento integer NOT NULL,
    direccion_de_envio character varying(100) NOT NULL,
    fecha_de_pedido date NOT NULL,
    forma_de_pago character varying(20) NOT NULL,
    total real NOT NULL
);
 *   DROP TABLE public.ventas_electronicas_r2;
       public         postgres    false    3            K           0    0    TABLE ventas_electronicas_r2    COMMENT     �   COMMENT ON TABLE public.ventas_electronicas_r2 IS 'Contiene la información de las ventas electronicas acorde al numero de seguimiento.';
            public       postgres    false    213            L           0    0 3   COLUMN ventas_electronicas_r2.numero_de_seguimiento    COMMENT     ~   COMMENT ON COLUMN public.ventas_electronicas_r2.numero_de_seguimiento IS 'El numero de seguimiento de la venta electronica.';
            public       postgres    false    213            M           0    0 0   COLUMN ventas_electronicas_r2.direccion_de_envio    COMMENT     y   COMMENT ON COLUMN public.ventas_electronicas_r2.direccion_de_envio IS 'La Direccion a donde se mandaran los productos.';
            public       postgres    false    213            N           0    0 -   COLUMN ventas_electronicas_r2.fecha_de_pedido    COMMENT     l   COMMENT ON COLUMN public.ventas_electronicas_r2.fecha_de_pedido IS 'Fecha en la que se realizo el pedido.';
            public       postgres    false    213            O           0    0 +   COLUMN ventas_electronicas_r2.forma_de_pago    COMMENT     S   COMMENT ON COLUMN public.ventas_electronicas_r2.forma_de_pago IS 'Forma de pago.';
            public       postgres    false    213            P           0    0 #   COLUMN ventas_electronicas_r2.total    COMMENT     I   COMMENT ON COLUMN public.ventas_electronicas_r2.total IS 'Costo total.';
            public       postgres    false    213            �            1259    116570    vivero    TABLE     �   CREATE TABLE public.vivero (
    id_vivero integer NOT NULL,
    nombre character varying(20) NOT NULL,
    fecha_de_apertura date NOT NULL
);
    DROP TABLE public.vivero;
       public         postgres    false    3            Q           0    0    TABLE vivero    COMMENT     N   COMMENT ON TABLE public.vivero IS 'Contiene la información de los Viveros.';
            public       postgres    false    196            R           0    0    COLUMN vivero.id_vivero    COMMENT     J   COMMENT ON COLUMN public.vivero.id_vivero IS 'Identificador del Vivero.';
            public       postgres    false    196            S           0    0    COLUMN vivero.nombre    COMMENT     @   COMMENT ON COLUMN public.vivero.nombre IS 'Nombre del Vivero.';
            public       postgres    false    196            T           0    0    COLUMN vivero.fecha_de_apertura    COMMENT     V   COMMENT ON COLUMN public.vivero.fecha_de_apertura IS 'Fecha de apertura del Vivero.';
            public       postgres    false    196            f          0    116865    area 
   TABLE DATA               <   COPY public.area (id_planta, id_tipo_de_planta) FROM stdin;
    public       postgres    false    229   ]F      [          0    116725 
   cliente_r1 
   TABLE DATA               l   COPY public.cliente_r1 (id_cliente, codigo_cliente, nombre, apellido_paterno, apellido_materno) FROM stdin;
    public       postgres    false    218   �F      Z          0    116720 
   cliente_r2 
   TABLE DATA               Y   COPY public.cliente_r2 (codigo_cliente, fecha_de_nacimiento, direccion, rfc) FROM stdin;
    public       postgres    false    217   �G      l          0    116955    comprar_tipo_e 
   TABLE DATA               L   COPY public.comprar_tipo_e (id_ventas_electronicas, id_cliente) FROM stdin;
    public       postgres    false    235   aJ      k          0    116940    comprar_tipo_f 
   TABLE DATA               E   COPY public.comprar_tipo_f (id_venta_fisica, id_cliente) FROM stdin;
    public       postgres    false    234   �J      c          0    116820 	   controlar 
   TABLE DATA               =   COPY public.controlar (id_empleado, id_semillas) FROM stdin;
    public       postgres    false    226    K      n          0    116980 
   correo_cli 
   TABLE DATA               C   COPY public.correo_cli (id_cliente, id_correo, correo) FROM stdin;
    public       postgres    false    237   KK      a          0    116795 
   correo_emp 
   TABLE DATA               D   COPY public.correo_emp (id_empleado, id_correo, correo) FROM stdin;
    public       postgres    false    224   1L      ]          0    116745    direccion_viv 
   TABLE DATA               K   COPY public.direccion_viv (id_vivero, id_direccion, direccion) FROM stdin;
    public       postgres    false    220   yM      I          0    116595    empleado_r1 
   TABLE DATA               ~   COPY public.empleado_r1 (id_empleado, curp, nombre, apellido_paterno, apellido_materno, fecha_de_nacimiento, rfc) FROM stdin;
    public       postgres    false    200   �N      H          0    116590    empleado_r2 
   TABLE DATA               V   COPY public.empleado_r2 (curp, salario, fecha_inicio_servicio, direccion) FROM stdin;
    public       postgres    false    199   \R      d          0    116835 	   germinado 
   TABLE DATA               H   COPY public.germinado (id_semillas, id_semillas_germinadas) FROM stdin;
    public       postgres    false    227   iU      Y          0    116715    pago_e 
   TABLE DATA               9   COPY public.pago_e (id_pago_e, tipo_de_pago) FROM stdin;
    public       postgres    false    216   �U      X          0    116710    pago_f 
   TABLE DATA               9   COPY public.pago_f (id_pago_f, tipo_de_pago) FROM stdin;
    public       postgres    false    215   V      P          0    116645 
   plantas_r1 
   TABLE DATA               ^   COPY public.plantas_r1 (id_planta, nombre, fechas_de_riego, fecha_de_germinacion) FROM stdin;
    public       postgres    false    207   �V      O          0    116640 
   plantas_r2 
   TABLE DATA               G   COPY public.plantas_r2 (nombre, precio, numero_de_plantas) FROM stdin;
    public       postgres    false    206   �W      j          0    116925 
   registra_e 
   TABLE DATA               G   COPY public.registra_e (id_ventas_electronicas, id_pago_e) FROM stdin;
    public       postgres    false    233   X      i          0    116910 
   registra_f 
   TABLE DATA               @   COPY public.registra_f (id_venta_fisica, id_pago_f) FROM stdin;
    public       postgres    false    232   `X      ^          0    116755 	   registrar 
   TABLE DATA               ;   COPY public.registrar (id_vivero, id_registro) FROM stdin;
    public       postgres    false    221   �X      G          0    116580    registro_r1 
   TABLE DATA               B   COPY public.registro_r1 (id_registro, genero, nombre) FROM stdin;
    public       postgres    false    198   �X      F          0    116575    registro_r2 
   TABLE DATA               y   COPY public.registro_r2 (genero, fecha_de_adquisicion, ultimo_riego, ultimo_fertilizante, ultima_fumigacion) FROM stdin;
    public       postgres    false    197   �Y      J          0    116605    rol 
   TABLE DATA               2   COPY public.rol (id_rol, tipo_de_rol) FROM stdin;
    public       postgres    false    201   �Z      N          0    116630    semillas_germinadas_r1 
   TABLE DATA               e   COPY public.semillas_germinadas_r1 (id_semillas_germinadas, origen, semillas_germinadas) FROM stdin;
    public       postgres    false    205   �Z      M          0    116625    semillas_germinadas_r2 
   TABLE DATA               �   COPY public.semillas_germinadas_r2 (origen, fecha_de_siembra, ultimo_riego, ultimo_fertilizante, ultima_fumigacion) FROM stdin;
    public       postgres    false    204   k[      L          0    116615    semillas_r1 
   TABLE DATA               C   COPY public.semillas_r1 (id_semillas, planta_de_cruce) FROM stdin;
    public       postgres    false    203   e\      K          0    116610    semillas_r2 
   TABLE DATA               c   COPY public.semillas_r2 (planta_de_cruce, fecha_de_polinizacion, cantidad_de_semillas) FROM stdin;
    public       postgres    false    202   �\      m          0    116970    telefono_cli 
   TABLE DATA               I   COPY public.telefono_cli (id_cliente, id_telefono, telefono) FROM stdin;
    public       postgres    false    236   4]      `          0    116785    telefono_emp 
   TABLE DATA               J   COPY public.telefono_emp (id_empleado, id_telefono, telefono) FROM stdin;
    public       postgres    false    223   �]      \          0    116735    telefono_viv 
   TABLE DATA               H   COPY public.telefono_viv (id_vivero, id_telefono, telefono) FROM stdin;
    public       postgres    false    219   �^      b          0    116805 	   tiene_emp 
   TABLE DATA               8   COPY public.tiene_emp (id_empleado, id_rol) FROM stdin;
    public       postgres    false    225   <_      e          0    116850 	   tiene_pla 
   TABLE DATA               9   COPY public.tiene_pla (id_vivero, id_planta) FROM stdin;
    public       postgres    false    228   �_      R          0    116660    tipo_de_planta_r1 
   TABLE DATA               a   COPY public.tipo_de_planta_r1 (id_tipo_de_planta, nombre_del_tipo_de_planta, genero) FROM stdin;
    public       postgres    false    209   �_      Q          0    116655    tipo_de_planta_r2 
   TABLE DATA               j   COPY public.tipo_de_planta_r2 (nombre_del_tipo_de_planta, cuidados_basicos, tipo_de_sustrato) FROM stdin;
    public       postgres    false    208   <`      _          0    116770    trabajar 
   TABLE DATA               :   COPY public.trabajar (id_vivero, id_empleado) FROM stdin;
    public       postgres    false    222   ab      h          0    116895    venta_e 
   TABLE DATA               D   COPY public.venta_e (id_vivero, id_ventas_electronicas) FROM stdin;
    public       postgres    false    231   �b      g          0    116880    venta_f 
   TABLE DATA               =   COPY public.venta_f (id_vivero, id_venta_fisica) FROM stdin;
    public       postgres    false    230   c      U          0    116685    venta_fisica_r1 
   TABLE DATA               �   COPY public.venta_fisica_r1 (id_venta_fisica, numero_ticket, codigo_cliente, clave_producto, fecha_venta_f, id_empleado_que_ayudo_a_cliente, empleado_que_efectuo_el_cobro, vivero_donde_se_adquirio, forma_de_pago) FROM stdin;
    public       postgres    false    212   ic      T          0    116675    venta_fisica_r2 
   TABLE DATA               y   COPY public.venta_fisica_r2 (numero_ticket, clave_producto, numero_de_productos_adquiridos, total_productos) FROM stdin;
    public       postgres    false    211   �d      S          0    116670    venta_fisica_r3 
   TABLE DATA               [   COPY public.venta_fisica_r3 (clave_producto, nombre_producto, precio_producto) FROM stdin;
    public       postgres    false    210   e      W          0    116700    ventas_electronicas_r1 
   TABLE DATA               �   COPY public.ventas_electronicas_r1 (id_ventas_electronicas, numero_de_seguimiento, fecha_venta_e, codigo_cliente, nombre, apellido_paterno, apellido_materno, numero_de_productos, desglose_de_productos_adquiridos, precio_a_pagar) FROM stdin;
    public       postgres    false    214   �e      V          0    116695    ventas_electronicas_r2 
   TABLE DATA               �   COPY public.ventas_electronicas_r2 (numero_de_seguimiento, direccion_de_envio, fecha_de_pedido, forma_de_pago, total) FROM stdin;
    public       postgres    false    213   g      E          0    116570    vivero 
   TABLE DATA               F   COPY public.vivero (id_vivero, nombre, fecha_de_apertura) FROM stdin;
    public       postgres    false    196   �h      �           2606    116869    area area_pk 
   CONSTRAINT     d   ALTER TABLE ONLY public.area
    ADD CONSTRAINT area_pk PRIMARY KEY (id_planta, id_tipo_de_planta);
 6   ALTER TABLE ONLY public.area DROP CONSTRAINT area_pk;
       public         postgres    false    229    229            v           2606    116729    cliente_r1 cliente_pk 
   CONSTRAINT     [   ALTER TABLE ONLY public.cliente_r1
    ADD CONSTRAINT cliente_pk PRIMARY KEY (id_cliente);
 ?   ALTER TABLE ONLY public.cliente_r1 DROP CONSTRAINT cliente_pk;
       public         postgres    false    218            t           2606    116724    cliente_r2 cliente_r2_pk 
   CONSTRAINT     b   ALTER TABLE ONLY public.cliente_r2
    ADD CONSTRAINT cliente_r2_pk PRIMARY KEY (codigo_cliente);
 B   ALTER TABLE ONLY public.cliente_r2 DROP CONSTRAINT cliente_r2_pk;
       public         postgres    false    217            �           2606    116959    comprar_tipo_e comprar_e_pk 
   CONSTRAINT     y   ALTER TABLE ONLY public.comprar_tipo_e
    ADD CONSTRAINT comprar_e_pk PRIMARY KEY (id_ventas_electronicas, id_cliente);
 E   ALTER TABLE ONLY public.comprar_tipo_e DROP CONSTRAINT comprar_e_pk;
       public         postgres    false    235    235            �           2606    116944     comprar_tipo_f comprar_tipo_f_pk 
   CONSTRAINT     w   ALTER TABLE ONLY public.comprar_tipo_f
    ADD CONSTRAINT comprar_tipo_f_pk PRIMARY KEY (id_venta_fisica, id_cliente);
 J   ALTER TABLE ONLY public.comprar_tipo_f DROP CONSTRAINT comprar_tipo_f_pk;
       public         postgres    false    234    234            �           2606    116824    controlar controlar_pk 
   CONSTRAINT     j   ALTER TABLE ONLY public.controlar
    ADD CONSTRAINT controlar_pk PRIMARY KEY (id_empleado, id_semillas);
 @   ALTER TABLE ONLY public.controlar DROP CONSTRAINT controlar_pk;
       public         postgres    false    226    226            �           2606    116984    correo_cli correo_cli_pk 
   CONSTRAINT     i   ALTER TABLE ONLY public.correo_cli
    ADD CONSTRAINT correo_cli_pk PRIMARY KEY (id_correo, id_cliente);
 B   ALTER TABLE ONLY public.correo_cli DROP CONSTRAINT correo_cli_pk;
       public         postgres    false    237    237            �           2606    116799    correo_emp correo_emp_pk 
   CONSTRAINT     j   ALTER TABLE ONLY public.correo_emp
    ADD CONSTRAINT correo_emp_pk PRIMARY KEY (id_correo, id_empleado);
 B   ALTER TABLE ONLY public.correo_emp DROP CONSTRAINT correo_emp_pk;
       public         postgres    false    224    224            z           2606    116749    direccion_viv direccion_viv_pk 
   CONSTRAINT     q   ALTER TABLE ONLY public.direccion_viv
    ADD CONSTRAINT direccion_viv_pk PRIMARY KEY (id_direccion, id_vivero);
 H   ALTER TABLE ONLY public.direccion_viv DROP CONSTRAINT direccion_viv_pk;
       public         postgres    false    220    220            R           2606    116599    empleado_r1 empleado_r1_pk 
   CONSTRAINT     a   ALTER TABLE ONLY public.empleado_r1
    ADD CONSTRAINT empleado_r1_pk PRIMARY KEY (id_empleado);
 D   ALTER TABLE ONLY public.empleado_r1 DROP CONSTRAINT empleado_r1_pk;
       public         postgres    false    200            P           2606    116594    empleado_r2 empleado_r2_pk 
   CONSTRAINT     Z   ALTER TABLE ONLY public.empleado_r2
    ADD CONSTRAINT empleado_r2_pk PRIMARY KEY (curp);
 D   ALTER TABLE ONLY public.empleado_r2 DROP CONSTRAINT empleado_r2_pk;
       public         postgres    false    199            �           2606    116839    germinado germinado_pk 
   CONSTRAINT     u   ALTER TABLE ONLY public.germinado
    ADD CONSTRAINT germinado_pk PRIMARY KEY (id_semillas, id_semillas_germinadas);
 @   ALTER TABLE ONLY public.germinado DROP CONSTRAINT germinado_pk;
       public         postgres    false    227    227            r           2606    116719    pago_e pago_e_pk 
   CONSTRAINT     U   ALTER TABLE ONLY public.pago_e
    ADD CONSTRAINT pago_e_pk PRIMARY KEY (id_pago_e);
 :   ALTER TABLE ONLY public.pago_e DROP CONSTRAINT pago_e_pk;
       public         postgres    false    216            p           2606    116714    pago_f pago_f_pk 
   CONSTRAINT     U   ALTER TABLE ONLY public.pago_f
    ADD CONSTRAINT pago_f_pk PRIMARY KEY (id_pago_f);
 :   ALTER TABLE ONLY public.pago_f DROP CONSTRAINT pago_f_pk;
       public         postgres    false    215            `           2606    116649    plantas_r1 plantas_r1_pk 
   CONSTRAINT     ]   ALTER TABLE ONLY public.plantas_r1
    ADD CONSTRAINT plantas_r1_pk PRIMARY KEY (id_planta);
 B   ALTER TABLE ONLY public.plantas_r1 DROP CONSTRAINT plantas_r1_pk;
       public         postgres    false    207            ^           2606    116644    plantas_r2 plantas_r2_pk 
   CONSTRAINT     Z   ALTER TABLE ONLY public.plantas_r2
    ADD CONSTRAINT plantas_r2_pk PRIMARY KEY (nombre);
 B   ALTER TABLE ONLY public.plantas_r2 DROP CONSTRAINT plantas_r2_pk;
       public         postgres    false    206            �           2606    116929    registra_e registra_e_pk 
   CONSTRAINT     u   ALTER TABLE ONLY public.registra_e
    ADD CONSTRAINT registra_e_pk PRIMARY KEY (id_ventas_electronicas, id_pago_e);
 B   ALTER TABLE ONLY public.registra_e DROP CONSTRAINT registra_e_pk;
       public         postgres    false    233    233            �           2606    116914    registra_f registra_f_pk 
   CONSTRAINT     n   ALTER TABLE ONLY public.registra_f
    ADD CONSTRAINT registra_f_pk PRIMARY KEY (id_venta_fisica, id_pago_f);
 B   ALTER TABLE ONLY public.registra_f DROP CONSTRAINT registra_f_pk;
       public         postgres    false    232    232            |           2606    116759    registrar registrar_pk 
   CONSTRAINT     h   ALTER TABLE ONLY public.registrar
    ADD CONSTRAINT registrar_pk PRIMARY KEY (id_registro, id_vivero);
 @   ALTER TABLE ONLY public.registrar DROP CONSTRAINT registrar_pk;
       public         postgres    false    221    221            N           2606    116584    registro_r1 registro_r1_pk 
   CONSTRAINT     a   ALTER TABLE ONLY public.registro_r1
    ADD CONSTRAINT registro_r1_pk PRIMARY KEY (id_registro);
 D   ALTER TABLE ONLY public.registro_r1 DROP CONSTRAINT registro_r1_pk;
       public         postgres    false    198            L           2606    116579    registro_r2 registro_r2_pk 
   CONSTRAINT     \   ALTER TABLE ONLY public.registro_r2
    ADD CONSTRAINT registro_r2_pk PRIMARY KEY (genero);
 D   ALTER TABLE ONLY public.registro_r2 DROP CONSTRAINT registro_r2_pk;
       public         postgres    false    197            T           2606    116609 
   rol rol_pk 
   CONSTRAINT     L   ALTER TABLE ONLY public.rol
    ADD CONSTRAINT rol_pk PRIMARY KEY (id_rol);
 4   ALTER TABLE ONLY public.rol DROP CONSTRAINT rol_pk;
       public         postgres    false    201            \           2606    116634 0   semillas_germinadas_r1 semillas_germinadas_r1_pk 
   CONSTRAINT     �   ALTER TABLE ONLY public.semillas_germinadas_r1
    ADD CONSTRAINT semillas_germinadas_r1_pk PRIMARY KEY (id_semillas_germinadas);
 Z   ALTER TABLE ONLY public.semillas_germinadas_r1 DROP CONSTRAINT semillas_germinadas_r1_pk;
       public         postgres    false    205            Z           2606    116629 0   semillas_germinadas_r2 semillas_germinadas_r2_pk 
   CONSTRAINT     r   ALTER TABLE ONLY public.semillas_germinadas_r2
    ADD CONSTRAINT semillas_germinadas_r2_pk PRIMARY KEY (origen);
 Z   ALTER TABLE ONLY public.semillas_germinadas_r2 DROP CONSTRAINT semillas_germinadas_r2_pk;
       public         postgres    false    204            X           2606    116619    semillas_r1 semillas_r1_pk 
   CONSTRAINT     a   ALTER TABLE ONLY public.semillas_r1
    ADD CONSTRAINT semillas_r1_pk PRIMARY KEY (id_semillas);
 D   ALTER TABLE ONLY public.semillas_r1 DROP CONSTRAINT semillas_r1_pk;
       public         postgres    false    203            V           2606    116614    semillas_r2 semillas_r2_pk 
   CONSTRAINT     e   ALTER TABLE ONLY public.semillas_r2
    ADD CONSTRAINT semillas_r2_pk PRIMARY KEY (planta_de_cruce);
 D   ALTER TABLE ONLY public.semillas_r2 DROP CONSTRAINT semillas_r2_pk;
       public         postgres    false    202            �           2606    116974    telefono_cli telefono_cli_pk 
   CONSTRAINT     o   ALTER TABLE ONLY public.telefono_cli
    ADD CONSTRAINT telefono_cli_pk PRIMARY KEY (id_telefono, id_cliente);
 F   ALTER TABLE ONLY public.telefono_cli DROP CONSTRAINT telefono_cli_pk;
       public         postgres    false    236    236            �           2606    116789    telefono_emp telefono_emp_pk 
   CONSTRAINT     p   ALTER TABLE ONLY public.telefono_emp
    ADD CONSTRAINT telefono_emp_pk PRIMARY KEY (id_telefono, id_empleado);
 F   ALTER TABLE ONLY public.telefono_emp DROP CONSTRAINT telefono_emp_pk;
       public         postgres    false    223    223            x           2606    116739    telefono_viv telefono_viv_pk 
   CONSTRAINT     n   ALTER TABLE ONLY public.telefono_viv
    ADD CONSTRAINT telefono_viv_pk PRIMARY KEY (id_telefono, id_vivero);
 F   ALTER TABLE ONLY public.telefono_viv DROP CONSTRAINT telefono_viv_pk;
       public         postgres    false    219    219            �           2606    116809    tiene_emp tiene_emp_pk 
   CONSTRAINT     e   ALTER TABLE ONLY public.tiene_emp
    ADD CONSTRAINT tiene_emp_pk PRIMARY KEY (id_empleado, id_rol);
 @   ALTER TABLE ONLY public.tiene_emp DROP CONSTRAINT tiene_emp_pk;
       public         postgres    false    225    225            �           2606    116854    tiene_pla tiene_pla_pk 
   CONSTRAINT     f   ALTER TABLE ONLY public.tiene_pla
    ADD CONSTRAINT tiene_pla_pk PRIMARY KEY (id_vivero, id_planta);
 @   ALTER TABLE ONLY public.tiene_pla DROP CONSTRAINT tiene_pla_pk;
       public         postgres    false    228    228            d           2606    116664 &   tipo_de_planta_r1 tipo_de_planta_r1_pk 
   CONSTRAINT     s   ALTER TABLE ONLY public.tipo_de_planta_r1
    ADD CONSTRAINT tipo_de_planta_r1_pk PRIMARY KEY (id_tipo_de_planta);
 P   ALTER TABLE ONLY public.tipo_de_planta_r1 DROP CONSTRAINT tipo_de_planta_r1_pk;
       public         postgres    false    209            b           2606    116659 &   tipo_de_planta_r2 tipo_de_planta_r2_pk 
   CONSTRAINT     {   ALTER TABLE ONLY public.tipo_de_planta_r2
    ADD CONSTRAINT tipo_de_planta_r2_pk PRIMARY KEY (nombre_del_tipo_de_planta);
 P   ALTER TABLE ONLY public.tipo_de_planta_r2 DROP CONSTRAINT tipo_de_planta_r2_pk;
       public         postgres    false    208            ~           2606    116774    trabajar trabajar_pk 
   CONSTRAINT     f   ALTER TABLE ONLY public.trabajar
    ADD CONSTRAINT trabajar_pk PRIMARY KEY (id_empleado, id_vivero);
 >   ALTER TABLE ONLY public.trabajar DROP CONSTRAINT trabajar_pk;
       public         postgres    false    222    222            �           2606    116899    venta_e venta_e_pk 
   CONSTRAINT     o   ALTER TABLE ONLY public.venta_e
    ADD CONSTRAINT venta_e_pk PRIMARY KEY (id_vivero, id_ventas_electronicas);
 <   ALTER TABLE ONLY public.venta_e DROP CONSTRAINT venta_e_pk;
       public         postgres    false    231    231            �           2606    116884    venta_f venta_f_pk 
   CONSTRAINT     h   ALTER TABLE ONLY public.venta_f
    ADD CONSTRAINT venta_f_pk PRIMARY KEY (id_vivero, id_venta_fisica);
 <   ALTER TABLE ONLY public.venta_f DROP CONSTRAINT venta_f_pk;
       public         postgres    false    230    230            j           2606    116689 "   venta_fisica_r1 venta_fisica_r1_pk 
   CONSTRAINT     m   ALTER TABLE ONLY public.venta_fisica_r1
    ADD CONSTRAINT venta_fisica_r1_pk PRIMARY KEY (id_venta_fisica);
 L   ALTER TABLE ONLY public.venta_fisica_r1 DROP CONSTRAINT venta_fisica_r1_pk;
       public         postgres    false    212            h           2606    116679 "   venta_fisica_r2 venta_fisica_r2_pk 
   CONSTRAINT     {   ALTER TABLE ONLY public.venta_fisica_r2
    ADD CONSTRAINT venta_fisica_r2_pk PRIMARY KEY (numero_ticket, clave_producto);
 L   ALTER TABLE ONLY public.venta_fisica_r2 DROP CONSTRAINT venta_fisica_r2_pk;
       public         postgres    false    211    211            f           2606    116674 "   venta_fisica_r3 venta_fisica_r3_pk 
   CONSTRAINT     l   ALTER TABLE ONLY public.venta_fisica_r3
    ADD CONSTRAINT venta_fisica_r3_pk PRIMARY KEY (clave_producto);
 L   ALTER TABLE ONLY public.venta_fisica_r3 DROP CONSTRAINT venta_fisica_r3_pk;
       public         postgres    false    210            n           2606    116704 0   ventas_electronicas_r1 ventas_electronicas_r1_pk 
   CONSTRAINT     �   ALTER TABLE ONLY public.ventas_electronicas_r1
    ADD CONSTRAINT ventas_electronicas_r1_pk PRIMARY KEY (id_ventas_electronicas);
 Z   ALTER TABLE ONLY public.ventas_electronicas_r1 DROP CONSTRAINT ventas_electronicas_r1_pk;
       public         postgres    false    214            l           2606    116699 0   ventas_electronicas_r2 ventas_electronicas_r2_pk 
   CONSTRAINT     �   ALTER TABLE ONLY public.ventas_electronicas_r2
    ADD CONSTRAINT ventas_electronicas_r2_pk PRIMARY KEY (numero_de_seguimiento);
 Z   ALTER TABLE ONLY public.ventas_electronicas_r2 DROP CONSTRAINT ventas_electronicas_r2_pk;
       public         postgres    false    213            J           2606    116574    vivero vivero_pk 
   CONSTRAINT     U   ALTER TABLE ONLY public.vivero
    ADD CONSTRAINT vivero_pk PRIMARY KEY (id_vivero);
 :   ALTER TABLE ONLY public.vivero DROP CONSTRAINT vivero_pk;
       public         postgres    false    196            �           2620    117261    venta_fisica_r1 t_guarda_fecha    TRIGGER        CREATE TRIGGER t_guarda_fecha BEFORE INSERT ON public.venta_fisica_r1 FOR EACH ROW EXECUTE PROCEDURE public.registrav_fecha();
 7   DROP TRIGGER t_guarda_fecha ON public.venta_fisica_r1;
       public       postgres    false    212    291            �           2620    117267 $   plantas_r2 t_valida_cantidad_plantas    TRIGGER     �   CREATE TRIGGER t_valida_cantidad_plantas AFTER INSERT ON public.plantas_r2 FOR EACH ROW EXECUTE PROCEDURE public.valida_cantidad_plantas();
 =   DROP TRIGGER t_valida_cantidad_plantas ON public.plantas_r2;
       public       postgres    false    206    245            �           2620    117259    cliente_r2 t_valida_fecha_c    TRIGGER     �   CREATE TRIGGER t_valida_fecha_c AFTER INSERT ON public.cliente_r2 FOR EACH ROW EXECUTE PROCEDURE public.valida_fecha_cliente();
 4   DROP TRIGGER t_valida_fecha_c ON public.cliente_r2;
       public       postgres    false    217    290            �           2620    117265    vivero t_valida_fecha_vivero    TRIGGER     �   CREATE TRIGGER t_valida_fecha_vivero AFTER INSERT ON public.vivero FOR EACH ROW EXECUTE PROCEDURE public.valida_fecha_vivero();
 5   DROP TRIGGER t_valida_fecha_vivero ON public.vivero;
       public       postgres    false    244    196            �           2620    117263 '   venta_fisica_r1 t_valida_venta_empleado    TRIGGER     �   CREATE TRIGGER t_valida_venta_empleado AFTER INSERT ON public.venta_fisica_r1 FOR EACH ROW EXECUTE PROCEDURE public.valida_venta_empleado();
 @   DROP TRIGGER t_valida_venta_empleado ON public.venta_fisica_r1;
       public       postgres    false    212    243            �           2606    117133    area area_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public.area
    ADD CONSTRAINT area_fk1 FOREIGN KEY (id_planta) REFERENCES public.plantas_r1(id_planta) ON DELETE CASCADE;
 7   ALTER TABLE ONLY public.area DROP CONSTRAINT area_fk1;
       public       postgres    false    2912    207    229            �           2606    117138    area area_fk2    FK CONSTRAINT     �   ALTER TABLE ONLY public.area
    ADD CONSTRAINT area_fk2 FOREIGN KEY (id_tipo_de_planta) REFERENCES public.tipo_de_planta_r1(id_tipo_de_planta) ON DELETE CASCADE;
 7   ALTER TABLE ONLY public.area DROP CONSTRAINT area_fk2;
       public       postgres    false    2916    209    229            �           2606    117026    cliente_r1 cliente_r1_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public.cliente_r1
    ADD CONSTRAINT cliente_r1_fk1 FOREIGN KEY (codigo_cliente) REFERENCES public.cliente_r2(codigo_cliente) ON DELETE CASCADE;
 C   ALTER TABLE ONLY public.cliente_r1 DROP CONSTRAINT cliente_r1_fk1;
       public       postgres    false    2932    217    218            �           2606    117193    comprar_tipo_e comprar_e_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public.comprar_tipo_e
    ADD CONSTRAINT comprar_e_fk1 FOREIGN KEY (id_ventas_electronicas) REFERENCES public.ventas_electronicas_r1(id_ventas_electronicas) ON DELETE CASCADE;
 F   ALTER TABLE ONLY public.comprar_tipo_e DROP CONSTRAINT comprar_e_fk1;
       public       postgres    false    2926    235    214            �           2606    117198    comprar_tipo_e comprar_e_fk3    FK CONSTRAINT     �   ALTER TABLE ONLY public.comprar_tipo_e
    ADD CONSTRAINT comprar_e_fk3 FOREIGN KEY (id_cliente) REFERENCES public.cliente_r1(id_cliente) ON DELETE CASCADE;
 F   ALTER TABLE ONLY public.comprar_tipo_e DROP CONSTRAINT comprar_e_fk3;
       public       postgres    false    235    2934    218            �           2606    117183 !   comprar_tipo_f comprar_tipo_f_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public.comprar_tipo_f
    ADD CONSTRAINT comprar_tipo_f_fk1 FOREIGN KEY (id_venta_fisica) REFERENCES public.venta_fisica_r1(id_venta_fisica) ON DELETE CASCADE;
 K   ALTER TABLE ONLY public.comprar_tipo_f DROP CONSTRAINT comprar_tipo_f_fk1;
       public       postgres    false    2922    234    212            �           2606    117188 !   comprar_tipo_f comprar_tipo_f_fk2    FK CONSTRAINT     �   ALTER TABLE ONLY public.comprar_tipo_f
    ADD CONSTRAINT comprar_tipo_f_fk2 FOREIGN KEY (id_cliente) REFERENCES public.cliente_r1(id_cliente) ON DELETE CASCADE;
 K   ALTER TABLE ONLY public.comprar_tipo_f DROP CONSTRAINT comprar_tipo_f_fk2;
       public       postgres    false    234    218    2934            �           2606    117103    controlar controlar_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public.controlar
    ADD CONSTRAINT controlar_fk1 FOREIGN KEY (id_empleado) REFERENCES public.empleado_r1(id_empleado) ON DELETE CASCADE;
 A   ALTER TABLE ONLY public.controlar DROP CONSTRAINT controlar_fk1;
       public       postgres    false    226    200    2898            �           2606    117108    controlar controlar_fk2    FK CONSTRAINT     �   ALTER TABLE ONLY public.controlar
    ADD CONSTRAINT controlar_fk2 FOREIGN KEY (id_semillas) REFERENCES public.semillas_r1(id_semillas) ON DELETE CASCADE;
 A   ALTER TABLE ONLY public.controlar DROP CONSTRAINT controlar_fk2;
       public       postgres    false    2904    203    226            �           2606    117209    correo_cli correo_cli_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public.correo_cli
    ADD CONSTRAINT correo_cli_fk1 FOREIGN KEY (id_cliente) REFERENCES public.cliente_r1(id_cliente) ON DELETE CASCADE;
 C   ALTER TABLE ONLY public.correo_cli DROP CONSTRAINT correo_cli_fk1;
       public       postgres    false    218    2934    237            �           2606    117087    correo_emp correo_emp_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public.correo_emp
    ADD CONSTRAINT correo_emp_fk1 FOREIGN KEY (id_empleado) REFERENCES public.empleado_r1(id_empleado) ON DELETE CASCADE;
 C   ALTER TABLE ONLY public.correo_emp DROP CONSTRAINT correo_emp_fk1;
       public       postgres    false    2898    200    224            �           2606    117056    direccion_viv direccion_viv_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public.direccion_viv
    ADD CONSTRAINT direccion_viv_fk1 FOREIGN KEY (id_vivero) REFERENCES public.vivero(id_vivero) ON DELETE CASCADE;
 I   ALTER TABLE ONLY public.direccion_viv DROP CONSTRAINT direccion_viv_fk1;
       public       postgres    false    196    2890    220            �           2606    117009    empleado_r1 empleado_r1_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public.empleado_r1
    ADD CONSTRAINT empleado_r1_fk1 FOREIGN KEY (curp) REFERENCES public.empleado_r2(curp) ON DELETE CASCADE;
 E   ALTER TABLE ONLY public.empleado_r1 DROP CONSTRAINT empleado_r1_fk1;
       public       postgres    false    199    2896    200            �           2606    117113    germinado germinado_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public.germinado
    ADD CONSTRAINT germinado_fk1 FOREIGN KEY (id_semillas) REFERENCES public.semillas_r1(id_semillas) ON DELETE CASCADE;
 A   ALTER TABLE ONLY public.germinado DROP CONSTRAINT germinado_fk1;
       public       postgres    false    227    203    2904            �           2606    117118    germinado germinado_fk2    FK CONSTRAINT     �   ALTER TABLE ONLY public.germinado
    ADD CONSTRAINT germinado_fk2 FOREIGN KEY (id_semillas_germinadas) REFERENCES public.semillas_germinadas_r1(id_semillas_germinadas) ON DELETE CASCADE;
 A   ALTER TABLE ONLY public.germinado DROP CONSTRAINT germinado_fk2;
       public       postgres    false    205    2908    227            �           2606    116997    plantas_r1 plantas_r1_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public.plantas_r1
    ADD CONSTRAINT plantas_r1_fk1 FOREIGN KEY (nombre) REFERENCES public.plantas_r2(nombre) ON DELETE CASCADE;
 C   ALTER TABLE ONLY public.plantas_r1 DROP CONSTRAINT plantas_r1_fk1;
       public       postgres    false    206    2910    207            �           2606    117173    registra_e registra_e_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public.registra_e
    ADD CONSTRAINT registra_e_fk1 FOREIGN KEY (id_ventas_electronicas) REFERENCES public.ventas_electronicas_r1(id_ventas_electronicas) ON DELETE CASCADE;
 C   ALTER TABLE ONLY public.registra_e DROP CONSTRAINT registra_e_fk1;
       public       postgres    false    214    233    2926            �           2606    117178    registra_e registra_e_fk2    FK CONSTRAINT     �   ALTER TABLE ONLY public.registra_e
    ADD CONSTRAINT registra_e_fk2 FOREIGN KEY (id_pago_e) REFERENCES public.pago_e(id_pago_e) ON DELETE CASCADE;
 C   ALTER TABLE ONLY public.registra_e DROP CONSTRAINT registra_e_fk2;
       public       postgres    false    2930    233    216            �           2606    117163    registra_f registra_f_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public.registra_f
    ADD CONSTRAINT registra_f_fk1 FOREIGN KEY (id_venta_fisica) REFERENCES public.venta_fisica_r1(id_venta_fisica) ON DELETE CASCADE;
 C   ALTER TABLE ONLY public.registra_f DROP CONSTRAINT registra_f_fk1;
       public       postgres    false    232    2922    212            �           2606    117168    registra_f registra_f_fk2    FK CONSTRAINT     �   ALTER TABLE ONLY public.registra_f
    ADD CONSTRAINT registra_f_fk2 FOREIGN KEY (id_pago_f) REFERENCES public.pago_f(id_pago_f) ON DELETE CASCADE;
 C   ALTER TABLE ONLY public.registra_f DROP CONSTRAINT registra_f_fk2;
       public       postgres    false    2928    232    215            �           2606    117061    registrar registrar_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public.registrar
    ADD CONSTRAINT registrar_fk1 FOREIGN KEY (id_vivero) REFERENCES public.vivero(id_vivero) ON DELETE CASCADE;
 A   ALTER TABLE ONLY public.registrar DROP CONSTRAINT registrar_fk1;
       public       postgres    false    2890    196    221            �           2606    117066    registrar registrar_fk2    FK CONSTRAINT     �   ALTER TABLE ONLY public.registrar
    ADD CONSTRAINT registrar_fk2 FOREIGN KEY (id_registro) REFERENCES public.registro_r1(id_registro) ON DELETE CASCADE;
 A   ALTER TABLE ONLY public.registrar DROP CONSTRAINT registrar_fk2;
       public       postgres    false    2894    221    198            �           2606    117215    registro_r1 registro_r1_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public.registro_r1
    ADD CONSTRAINT registro_r1_fk1 FOREIGN KEY (genero) REFERENCES public.registro_r2(genero) ON DELETE CASCADE;
 E   ALTER TABLE ONLY public.registro_r1 DROP CONSTRAINT registro_r1_fk1;
       public       postgres    false    197    2892    198            �           2606    117014 1   semillas_germinadas_r1 semillas_germinadas_r1_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public.semillas_germinadas_r1
    ADD CONSTRAINT semillas_germinadas_r1_fk1 FOREIGN KEY (origen) REFERENCES public.semillas_germinadas_r2(origen) ON DELETE CASCADE;
 [   ALTER TABLE ONLY public.semillas_germinadas_r1 DROP CONSTRAINT semillas_germinadas_r1_fk1;
       public       postgres    false    204    2906    205            �           2606    117020    semillas_r1 semillas_r1_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public.semillas_r1
    ADD CONSTRAINT semillas_r1_fk1 FOREIGN KEY (planta_de_cruce) REFERENCES public.semillas_r2(planta_de_cruce) ON DELETE CASCADE;
 E   ALTER TABLE ONLY public.semillas_r1 DROP CONSTRAINT semillas_r1_fk1;
       public       postgres    false    203    2902    202            �           2606    117203    telefono_cli telefono_cli_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public.telefono_cli
    ADD CONSTRAINT telefono_cli_fk1 FOREIGN KEY (id_cliente) REFERENCES public.cliente_r1(id_cliente) ON DELETE CASCADE;
 G   ALTER TABLE ONLY public.telefono_cli DROP CONSTRAINT telefono_cli_fk1;
       public       postgres    false    218    2934    236            �           2606    117081    telefono_emp telefono_emp_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public.telefono_emp
    ADD CONSTRAINT telefono_emp_fk1 FOREIGN KEY (id_empleado) REFERENCES public.empleado_r1(id_empleado) ON DELETE CASCADE;
 G   ALTER TABLE ONLY public.telefono_emp DROP CONSTRAINT telefono_emp_fk1;
       public       postgres    false    223    2898    200            �           2606    117050    telefono_viv telefono_viv_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public.telefono_viv
    ADD CONSTRAINT telefono_viv_fk1 FOREIGN KEY (id_vivero) REFERENCES public.vivero(id_vivero) ON DELETE CASCADE;
 G   ALTER TABLE ONLY public.telefono_viv DROP CONSTRAINT telefono_viv_fk1;
       public       postgres    false    196    2890    219            �           2606    117093    tiene_emp tiene_emp_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public.tiene_emp
    ADD CONSTRAINT tiene_emp_fk1 FOREIGN KEY (id_empleado) REFERENCES public.empleado_r1(id_empleado) ON DELETE CASCADE;
 A   ALTER TABLE ONLY public.tiene_emp DROP CONSTRAINT tiene_emp_fk1;
       public       postgres    false    200    2898    225            �           2606    117098    tiene_emp tiene_emp_fk2    FK CONSTRAINT     �   ALTER TABLE ONLY public.tiene_emp
    ADD CONSTRAINT tiene_emp_fk2 FOREIGN KEY (id_rol) REFERENCES public.rol(id_rol) ON DELETE CASCADE;
 A   ALTER TABLE ONLY public.tiene_emp DROP CONSTRAINT tiene_emp_fk2;
       public       postgres    false    225    201    2900            �           2606    117123    tiene_pla tiene_pla_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public.tiene_pla
    ADD CONSTRAINT tiene_pla_fk1 FOREIGN KEY (id_vivero) REFERENCES public.vivero(id_vivero) ON DELETE CASCADE;
 A   ALTER TABLE ONLY public.tiene_pla DROP CONSTRAINT tiene_pla_fk1;
       public       postgres    false    196    2890    228            �           2606    117128    tiene_pla tiene_pla_fk2    FK CONSTRAINT     �   ALTER TABLE ONLY public.tiene_pla
    ADD CONSTRAINT tiene_pla_fk2 FOREIGN KEY (id_planta) REFERENCES public.plantas_r1(id_planta) ON DELETE CASCADE;
 A   ALTER TABLE ONLY public.tiene_pla DROP CONSTRAINT tiene_pla_fk2;
       public       postgres    false    207    2912    228            �           2606    116990 '   tipo_de_planta_r1 tipo_de_planta_r1_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public.tipo_de_planta_r1
    ADD CONSTRAINT tipo_de_planta_r1_fk1 FOREIGN KEY (nombre_del_tipo_de_planta) REFERENCES public.tipo_de_planta_r2(nombre_del_tipo_de_planta) ON DELETE CASCADE;
 Q   ALTER TABLE ONLY public.tipo_de_planta_r1 DROP CONSTRAINT tipo_de_planta_r1_fk1;
       public       postgres    false    208    209    2914            �           2606    117071    trabajar trabajar_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public.trabajar
    ADD CONSTRAINT trabajar_fk1 FOREIGN KEY (id_vivero) REFERENCES public.vivero(id_vivero) ON DELETE CASCADE;
 ?   ALTER TABLE ONLY public.trabajar DROP CONSTRAINT trabajar_fk1;
       public       postgres    false    222    196    2890            �           2606    117076    trabajar trabajar_fk2    FK CONSTRAINT     �   ALTER TABLE ONLY public.trabajar
    ADD CONSTRAINT trabajar_fk2 FOREIGN KEY (id_empleado) REFERENCES public.empleado_r1(id_empleado) ON DELETE CASCADE;
 ?   ALTER TABLE ONLY public.trabajar DROP CONSTRAINT trabajar_fk2;
       public       postgres    false    222    2898    200            �           2606    117153    venta_e venta_e_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public.venta_e
    ADD CONSTRAINT venta_e_fk1 FOREIGN KEY (id_vivero) REFERENCES public.vivero(id_vivero) ON DELETE CASCADE;
 =   ALTER TABLE ONLY public.venta_e DROP CONSTRAINT venta_e_fk1;
       public       postgres    false    196    231    2890            �           2606    117158    venta_e venta_e_fk2    FK CONSTRAINT     �   ALTER TABLE ONLY public.venta_e
    ADD CONSTRAINT venta_e_fk2 FOREIGN KEY (id_ventas_electronicas) REFERENCES public.ventas_electronicas_r1(id_ventas_electronicas) ON DELETE CASCADE;
 =   ALTER TABLE ONLY public.venta_e DROP CONSTRAINT venta_e_fk2;
       public       postgres    false    231    2926    214            �           2606    117143    venta_f venta_f_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public.venta_f
    ADD CONSTRAINT venta_f_fk1 FOREIGN KEY (id_vivero) REFERENCES public.vivero(id_vivero) ON DELETE CASCADE;
 =   ALTER TABLE ONLY public.venta_f DROP CONSTRAINT venta_f_fk1;
       public       postgres    false    2890    230    196            �           2606    117148    venta_f venta_f_fk2    FK CONSTRAINT     �   ALTER TABLE ONLY public.venta_f
    ADD CONSTRAINT venta_f_fk2 FOREIGN KEY (id_venta_fisica) REFERENCES public.venta_fisica_r1(id_venta_fisica) ON DELETE CASCADE;
 =   ALTER TABLE ONLY public.venta_f DROP CONSTRAINT venta_f_fk2;
       public       postgres    false    2922    230    212            �           2606    117038 #   venta_fisica_r1 venta_fisica_r1_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public.venta_fisica_r1
    ADD CONSTRAINT venta_fisica_r1_fk1 FOREIGN KEY (clave_producto, numero_ticket) REFERENCES public.venta_fisica_r2(clave_producto, numero_ticket) ON DELETE CASCADE;
 M   ALTER TABLE ONLY public.venta_fisica_r1 DROP CONSTRAINT venta_fisica_r1_fk1;
       public       postgres    false    212    2920    211    211    212            �           2606    117032 #   venta_fisica_r2 venta_fisica_r2_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public.venta_fisica_r2
    ADD CONSTRAINT venta_fisica_r2_fk1 FOREIGN KEY (clave_producto) REFERENCES public.venta_fisica_r3(clave_producto) ON DELETE CASCADE;
 M   ALTER TABLE ONLY public.venta_fisica_r2 DROP CONSTRAINT venta_fisica_r2_fk1;
       public       postgres    false    211    210    2918            �           2606    117045 1   ventas_electronicas_r1 ventas_electronicas_r1_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public.ventas_electronicas_r1
    ADD CONSTRAINT ventas_electronicas_r1_fk1 FOREIGN KEY (numero_de_seguimiento) REFERENCES public.ventas_electronicas_r2(numero_de_seguimiento) ON DELETE CASCADE;
 [   ALTER TABLE ONLY public.ventas_electronicas_r1 DROP CONSTRAINT ventas_electronicas_r1_fk1;
       public       postgres    false    2924    213    214            f   :   x����0D�3[�/$j/�_�����HU�:Z|��؋�'��=w���k~	�      [   3  x�=��N1���<�O`�"?�J 0\y3�NL��!�]��|_�aLzڤ�9=�9x�7�m�!a�Gi���&�(��wsNA"�r-�|9BK����Z���r�K�E`�1�1$�=�"9Kfz����,|5fl� Y1��~�m(8��U��zg\���#%�~��&{�>�Y�f�4��`-z�X�.�Oh
?�Bb8
vZ]�-�Gr0�^RSՁ��Y��q�$&���zℭ��2(��i�L�̩U��s,-�X`r�ƴ�����k���1]h�[oN������5w	nq�ӎ�K+���Y��� <��      Z   g  x���KR�@�ףS�05i��1G�� �*�� O@�b=R��`�|��/����jJ���eaF%�'����]�Wuݜ�¿�����������u��4���^�VeC��:גj�W�G��P�D�)���u��+��}�����ɗ{D����Q�v��Q�W�"P�B=����}�~�޶��]���V��m>�hs���/�\)ʘ9�Id�C�1>�I�Mo!J׍���b��"NEd�i1�fB"8�?���6�{ߎA6=��&T̾��ʀ���(	�p��wOIY�A�}�t���ޟ�e�J�5�<��
����C�vo/��Efv��Fo-֡���DP�=z`�������
C��˂Fք��AQ�0��1�`�Dq[d�3.��%~���PXs�3p�VHA��>ğ}�{m[���N�Ҕ�-�!L7z�'Iyu?`H�o?&w��ƍ��lV,������ ��"��$�3��{C�.�S�h��bH�@
ba�2���M�ƨ��ud�Ã�kܿ}��j��1e]�^d�ӄq�
~�� eԐ6w�ݢp-�TwC[V�>�
�9bylq%�'�(PT7�E��i�2�BҨ=̭
��"�я�(��D}ne      l   ;   x����0İ����)�J/鿎 F*E����,v6'��˛Gh+vl�q⊋�~�E
*      k   D   x�̹� A{'ǣ\��i���tF�bf���ٜ޼�bC��c�V,�q���<��~8�d      c   ;   x����0İ����)�J/鿎 F*E����,v6'��˛Gh+vl�q⊋�~�E
*      n   �   x�]�Mj�@��χ	�%�5M��b��
B�"ؙ0��z�^�CWr�[}=$TL�����e`�/Z7D1b����:A�mO�ֲ�)R옎�xdȰ��޲�ɑ�li�����+�P9�m��~�5J�w���`��Pŝx���F�����N�TL��fb�����a^��y�">x���:�h,=K���#P3�n��cE�/IX~@      a   8  x�m��N�0�ϓ��j��F(T�@�G�,�F�(���\x+��c��Ƒ��n2�;c��N=9�֝�������'+�������)ұ��}��2�j���ޗɑcѱ�v���Qe��z�n�F��Aݹ����*�V��g�kԸ�<w��b�<��u����`T;3�ᔫ��R����Ǔ��@.i�Z�pL�ju=����G��v���d�#D�b"�E�8����4��0�ג�6ǫI/G��]#S�E)3���9��VB�er�'��%[�Ͳ�����+4���;x�sv&���,I�_���      ]     x�u�;n�0D��)���%��`��q�4�F�ТaQB|��|],T�0�Û� ��v�O�'l�hɢux���|	�(����u~�"����+P��5b�܀ۡ�����80��Y�O�������n~�`���7�
����y����+�\��n�.SCǐM���HM�c��a���rJ�����;'rj�K]� 	K���C���=.,���Lw�xJgT������j0O��醫�������7��      I   �  x�mUKr�J7��H�n��	L�$�.?*��-�)%�<R�*k����n		���Aι�#�0��2�d�|�(���|j>����lז���O����0��@���͜�`sD,p!X&y� �y+>aU���s۰YS�U%Y\��%���7��٧�Pp;�{����*p��N-����z)kɢR����!�!SΧB��B ��o���f��ݜ�w����Ͳ�%�-%�A>�۰YUZtrVq>��x΀�-��k�f�,,*BX���޷����( -[�B�pY��� N ���ߩ��祖K��.[�A��w�"o�H�ע��p!��)��*|��(	<�-��y���Y�h�t�P q�� ��� Ar����_��XY�/�0N:�P���g �h!�����́�y�5��R`�~���%�N�"lZJ��� �F��L�j8g	n��.��!�,/M}~���=�d�,"�w�.,BȖ�t��zi�ϱ�ϒ�)w^��勨�z,��Gs�	��d�U���bx���"4u�46$�e$�F�!g��-[�ڣ����7	<�b�#L��ݩ��V�Uw3�")$�i�C�!�����˒�m9�J*�.)���=�\���N����RL@�;�"t��}i`T���P��{љt�Z��.�h�T����+���i��<EEC� � <����G������CB�I����צxSp/|E� F���W�T�"��062�°����~|�0u{X\��I��͇��X����P�:]�su	�p.���jͯ;k�ZO�"�v��q�W�-���Pn��O*}�&V���֯dM�q��j�`�y4B|�y��<��S{{:\�KO�O�ҋ`����c;|#�g���x8gk�)��Y`�.�i��[�쏃�"M�����d2�!�$      H   �  x��U[n�@�Ƨ���{����`CHbCbC�E�3!Br�]V+n��)r�m;��+$��ꮮQ�?��8��>8= z���`�{�b�x����_�����HVyv�<?|�`�h�1TJ�,p�a�h
a�>�=�d�T�^�T�e�ѭ+�����$��M���C�3/)�vے�n�䛝N�y]�{��B9�����[�4���,��6IYLlv����� ����>�D����V�6������[Ʈ�t��&�����-р�~ �l�f%C�hfl�]%ٚ��Zg��>��낃e�`6�}cY��DI6�_hv��:ݾn�c/�~����k�#0��hu&)k&�̻d#�I�s����n���aD���I��U� *TA�i�FI���9gQ��3lW�2�,&�@5��x[ŮY4Q�^�I;��`Z�� ��"��Q��b�NӦ[0��n�a�q��.F��e�����=H���F��Ս��8�\�hwD;]��~h^��)
��-k��R���U(��-�.Q�'�$;��5���.����I���m�-�Ro����n�gL�H��L�L_y�:_z�v>q>�,�)�<9$�E���� ��A��sAR��ﲪ"?r�N�]��.E#�:�#m��0����+�E�Mϴ㎣:��\9��ʡ�����������]8v�V5�u6<����\�aY�^��iX]5��j�-�A^�S��>�p�X�5��U����c8�NsZ�a�}�4�/{���      d   ;   x����0İ����)�J/鿎 F*E����,v6'��˛Gh+vl�q⊋�~�E
*      Y   U   x�3�I,�J-ITHIUp.JM�,��2BtIM�cSh�E�)13l�ͱ	Z`��&hh��"CCl���c��C�&XE��)F��� �bf      X   f   x�3�tMKM.�,��2�I,�J-ITHIUpIM�,��2FH� K;����M��1�"f�0��9�yC$�!��9�ɥ�X�jh����m��8������� �/`�      P   �   x�m�=n�0Fg�� ���5fJ� �QH�� ��+%�i��>��Ӈ���=�4^o���p�-R�ܔ� Y�b��0~���Ž#	�5�aL���;>~�Vy#D��	�9�[�ե�c�K�D�����_4:���	��Y�e��(ͪQ����v�h�Z����WP�����U��8̻���J�|����*��xj�c vQ^A�����VQ���ځ]>�p1�b      O   �   x�]�;�0��>EO�l�x�c�%�*�P9A�o@-�?��!���q
��4�D�
pG؇����)"D��o)k��5/�3��A�%kk�8`C8k��\�wkE����5r>�������ɽA� K9�      j   ;   x����0İ����)�J/鿎 F*E����,v6'��˛Gh+vl�q⊋�~�E
*      i   ;   x����0İ����)�J/鿎 F*E����,v6'��˛Gh+vl�q⊋�~�E
*      ^   ;   x����0İ����)�J/鿎 F*E����,v6'��˛Gh+vl�q⊋�~�E
*      G   �   x�mл
�@��z�S�	�ٛZjI�:�$Zew%��3[p��|�C��n��<�A��לr\N�p)���0���^�o��;�Bq^�!�[��©A�8x�cţ�]�4h	��:K�T�3T��E�tA!Ed�E|�Y&�fA�E�9�/(�<���      F   �   x����
�0F�ۻL�o����!��Es�}��6*υ��?Xg��kZ��B.JN�}��*N�w7k�F$��#�Z�;�=����iPr��m��i��j�c��i!���
z/.$�
%
z-+��iP�P����P�P%�\�{q����07���:+\-�B�B�xsa@�Ņs�
�����4X��r94-\-^
��x���      J   Q   x�3�tO-J�+IU�,K-��2�t.�LIL�/RHIU�I�+I,�2�tN�I�p��%'���s�K��
��b���� ��'      N   k   x�Eλ�0��:��	P����A�H4�_[����k~��^�s\���~��\�cT���01f��XcU��Ͱ1«�5�M��davA�`e�4�6Hܾ�t8      M   �   x���1N�0���)����I3�,������ԩ�JH ux���5�����Ϸ�'zPk�=#6��/SJ��8��e ydD,�/1�N�S��K9(^�yR����sP9�|����>��T��eʓ*N٭�ߩ�/ՠt�ʤ6ob��#�A�jN]~P�5N���JX��,��a�*^[C�˴�جU�֣�����a7�^��b���ٕ��أ����Ķ���R�r���      L   F   x��;�@����9�?�"�q�Uj�VLW:CLe���V6G9\��*/nu7�q1w\��ą�����D      K   i   x�U��� D�3��ff�
��C�+����w�VIP3b�!MP��sQQ�G���d��9��?�e}��ӆp��t�N�D���hN�+��+;��u�o�^0S      m   �   x�=��D1Ϧ������ױy	���b�@i�d�\��`���.��5TQ�m$]YA^d`4i��}��,�
������F��Sg/D��7ً����<]t��C/`;�����y�� �;�6~?"��2`      `   �   x�M�K� C��0K�����(��ꍅ_d�(*E��L�6p�:����2���PP�	��TQ_��DC{#6�t������� 4��q�H��e�(��6��G�
���<�O��׺�9U��]m����1b��?4���J�[2��;��ж�ݤFٺ�̷����gy�P��`��Ԛ�ж�}95��ǣ��7�����ؓ���'���c`x      \   }   x�M��!��b"���{I�u��0��!�����ژ���*���7(]R���7��q�8�����3ihw➬�����Ƴ�	��bi��୍i��~��0��8�
�6��1��F��3���/�      b   O   x����0�jk��E�Ov��s�hp@��m_�m?�k�9��Yd�ۣ"��54A���8�Q�?^�      e   ;   x����0İ����)�J/鿎 F*E����,v6'��˛Gh+vl�q⊋�~�E
*      R   F   x�3��H,�/*��LD���8��KR���0�1�cqIQ~AFeIi.2�˄ӱ(3?9���������� n�!#      Q     x�mS͎�0>7O1n� `�Vp��ԞM]9v��˖��pXq�H^��N%�v�4M�d��|��Y�!�&��i�1y�����X#+I�Y��'Q�vJyK��B:�v��JL�:�{&�q��ؖ$�U+�%�	@��Ǻ%NE:�)G���̺�`�U��f�cW�Q�T��,ي��o��_��z��R�5�f;f% ɑ|PqZ\N'IA@�@��~��;ŉ�^ս#^��m��f��� B%eü���8�Xa�"�1��R	��K�|ȹy�����rU��#�_~����p.u��D@8V��3삔`H/�>7T#��au
mgΞw�dV��	�c���)���9Iz�ĳǞ����˄�&
��WG�a���<z4W<��i�L��Ů�Y�4j�m�]u���9�M�F�r7�i�h�\����-�Eh�#��w�]D��-�|�Z��k�Ve��
2�k���� �8�z�~K~h��	��U`տ6�M����\H3_�\��|�7��		�ؖ��n����d�      _   b   x���A��̪m��\&�8�%� f �H�����ZТ�2d*��J��b��H�'ݮ���������џsBׄ��L�;�߄���H��      h   ;   x����0İ����)�J/鿎 F*E����,v6'��˛Gh+vl�q⊋�~�E
*      g   ;   x����0İ����)�J/鿎 F*E����,v6'��˛Gh+vl�q⊋�~�E
*      U      x�m��j�0E��_�H���C[�e�Yv�6.��@0��^%�I:��Ō|FW�	6�W�@{�u/k�*�x��>��ϱS(LY�r_�����N�Ӽ[�����q��]@�6��]C�T,GDX�R���OӾ`ɫ$~^%#òW�P!|À6x'N���>b��ބ���{A��R��Xv�|��O����k1ê)�7��J?�0:f*�m��Ce���1X	���b��Jl�Eh�l�p<F,�a����?r��&�!�����x���Zu��za�-�]\�� �]��^[©      T   q   x�E�;�0E��o1#��L5)#͔��:�-��+���wb:j�]Q���y�`YP�qZ8���F�.8�Z���%I���Y�yf	�Ų�չ���9����Ǳ�M���0�      S   u   x�Uʱ
�0���)�%VJ�1�9���K(�%r�H߾�
���C[Y��-^�0����0†{FIS\���q7�Tf���Q�4|��I�xn������u�:���i���qd��pwe���3�      W   g  x���Mj�0�ףS� v��giH(]���� ��
�Cin�3�b	��7v����ߛ�fsT9�(X�N]o��]�v�{���3���ά�P# �s�r��hh���f�1}gO��l��Mg���L���Q�CS��{3����f<�]��`�>�!�����8�XjdU����_��L������:xw9~�3��� ��k��:�[�Y	e�ut�f�7�s$}�]�lDVA5�d�X6��[(��P����y�"�u��=,�6Gi�!����P�����<��
�_�$�dI#�����R2J��{�"K*R��.G!
'f�M
�M�"����b�Ic�i�"A<V����w�O��oV�"      V   �  x���Kn�0���)� ���$[K��v�6AW�L$֡AX)EIn��W9�.֡�E�P�����?��L尞��`�kg��<�m�����fp�lZhl��{[�L	!2�g�d���&`|�����e���>�ծǮFg�!��85sg��z��n.3�̤x�dn"�\�EW���x��>��m�`�C���?\�	�I�Z��9��&��5v�3�L�]���
V�?.�<χ�zR�\
^2U��wH�M��w�`:X����n|�t��TʁT�/��
�8߯	P���$@���p�7 �"�ieK�g!x��5��PYb�ޣ"��T�mH�+4\zK4�cbg>��Oޛ���Q%�SB*P����z:ԍ�/�����ю�1��S5Q�����@����LW��ף�Ɏ������c�o����c��X�.���CW09������s�����      E   �   x�E�M
�0��9E/I��eJGc�ISPܺ���7M2#d�𽁑���}|��2;�M.��"���HZeڍj5�E�E�
��ـ����B��S��ʕ*�ذ)R�FP7e�5c¤J�eo �$!�Q��&�J�jR -0�.X�zR�Y��omjJ:�A�f�M:��jRL�)e�d1X�o���Y���-c��cf     