PGDMP         
                 z            Practica 12    10.18    10.18 o   M           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            N           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            O           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false            P           1262    86365    Practica 12    DATABASE     �   CREATE DATABASE "Practica 12" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Spanish_Spain.1252' LC_CTYPE = 'Spanish_Spain.1252';
    DROP DATABASE "Practica 12";
             postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
             postgres    false            Q           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                  postgres    false    3                        3079    12924    plpgsql 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
    DROP EXTENSION plpgsql;
                  false            R           0    0    EXTENSION plpgsql    COMMENT     @   COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';
                       false    1                        1255    87023    cliente_compras(integer)    FUNCTION     l  CREATE FUNCTION public.cliente_compras(id_c integer) RETURNS TABLE(efectivo bigint, tarjeta_de_debito bigint, tarjeta_de_credito bigint)
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
       public       postgres    false    3            �            1255    87021 +   cliente_dias_cumpleaños(character varying)    FUNCTION       CREATE FUNCTION public."cliente_dias_cumpleaños"(rfc_ character varying) RETURNS double precision
    LANGUAGE sql
    AS $$
	select abs(extract(day from current_date::timestamp - Fecha_de_nacimiento::timestamp))
	from cliente_r2 A where A.rfc = RFC_;
$$;
 I   DROP FUNCTION public."cliente_dias_cumpleaños"(rfc_ character varying);
       public       postgres    false    3            �            1255    87018    cliente_edad(character varying)    FUNCTION     �   CREATE FUNCTION public.cliente_edad(rfc_ character varying) RETURNS double precision
    LANGUAGE sql
    AS $$
	select date_part('year',age(Fecha_de_nacimiento)) from CLIENTE_R2 A where A.rfc = RFC_;
$$;
 ;   DROP FUNCTION public.cliente_edad(rfc_ character varying);
       public       postgres    false    3                       1255    87025    elimina_empleado(integer)    FUNCTION     �  CREATE FUNCTION public.elimina_empleado(id_emp integer) RETURNS void
    LANGUAGE sql
    AS $$  
    DELETE FROM controlar where id_Emp = id_empleado;
    DELETE FROM tiene_emp where id_Emp = id_empleado;
    DELETE FROM correo_emp where id_Emp = id_empleado;
    DELETE FROM telefono_emp where id_Emp = id_empleado;
    DELETE FROM trabajar where id_Emp = id_empleado;
    ALTER TABLE EMPLEADO_R1 DROP CONSTRAINT EMPLEADO_R1_FK1;
    ALTER TABLE EMPLEADO_R1 ADD CONSTRAINT EMPLEADO_R1_FK1
    FOREIGN KEY (CURP) REFERENCES EMPLEADO_R2(CURP) ON DELETE CASCADE;
    DELETE FROM empleado_r2 WHERE curp = (select A.curp from empleado_r2 A join empleado_r1 B on a.curp = b.curp where b.id_empleado = id_Emp);
    DELETE FROM empleado_r1 WHERE id_Emp = id_empleado;
    UPDATE VENTA_FISICA_R1 SET Id_Empleado_que_ayudo_a_cliente = NULL,Empleado_que_efectuo_el_cobro = NULL where Id_Empleado_que_ayudo_a_cliente = id_Emp;
$$;
 7   DROP FUNCTION public.elimina_empleado(id_emp integer);
       public       postgres    false    3            �            1255    87017     emeplado_edad(character varying)    FUNCTION     �   CREATE FUNCTION public.emeplado_edad(rfc_ character varying) RETURNS double precision
    LANGUAGE sql
    AS $$
	select date_part('year',age(Fecha_de_nacimiento)) from EMPLEADO_R1 A where A.rfc = RFC_;
$$;
 <   DROP FUNCTION public.emeplado_edad(rfc_ character varying);
       public       postgres    false    3            �            1255    87020 ,   empleado_dias_cumpleaños(character varying)    FUNCTION       CREATE FUNCTION public."empleado_dias_cumpleaños"(rfc_ character varying) RETURNS double precision
    LANGUAGE sql
    AS $$
	select abs(extract(day from current_date::timestamp - Fecha_de_nacimiento::timestamp))
	from EMPLEADO_R1 A where A.rfc = RFC_;
$$;
 J   DROP FUNCTION public."empleado_dias_cumpleaños"(rfc_ character varying);
       public       postgres    false    3            �            1255    87022 K   empleado_rfc(character varying, character varying, character varying, date)    FUNCTION     ]  CREATE FUNCTION public.empleado_rfc(nombr character varying, apellidop character varying, apellidom character varying, fechab date) RETURNS character varying
    LANGUAGE sql
    AS $$
	select RFC from EMPLEADO_R1 A where A.Nombre = Nombr and A.Apellido_Paterno = ApellidoP and A.Apellido_Materno = ApellidoM and A.Fecha_de_nacimiento = FechaB;
$$;
 �   DROP FUNCTION public.empleado_rfc(nombr character varying, apellidop character varying, apellidom character varying, fechab date);
       public       postgres    false    3            �            1255    87019    numero_ventas(integer)    FUNCTION     $  CREATE FUNCTION public.numero_ventas(id_ev integer) RETURNS bigint
    LANGUAGE sql
    AS $$
	select count(B.Id_Empleado_que_ayudo_a_cliente) from EMPLEADO_R1 A
	join venta_fisica_r1 B on A.Id_Empleado = B.Id_Empleado_que_ayudo_a_cliente
	where B.Id_Empleado_que_ayudo_a_cliente = id_EV
$$;
 3   DROP FUNCTION public.numero_ventas(id_ev integer);
       public       postgres    false    3                       1255    87024 �   registra_empleado(integer, character varying, character varying, character varying, character varying, date, character varying, real, date, character varying)    FUNCTION     )  CREATE FUNCTION public.registra_empleado(id_empleado integer, curp character varying, nombre character varying, apellido_paterno character varying, apellido_materno character varying, fecha_de_nacimiento date, rfc character varying, salario real, fecha_inicio_servicio date, direccion character varying) RETURNS void
    LANGUAGE sql
    AS $$  
    INSERT INTO empleado_r2 VALUES (CURP,Salario,Fecha_Inicio_servicio,Direccion);
    INSERT INTO empleado_r1 VALUES (Id_Empleado,CURP,Nombre,Apellido_Paterno,Apellido_Materno,Fecha_de_nacimiento,RFC);
$$;
 /  DROP FUNCTION public.registra_empleado(id_empleado integer, curp character varying, nombre character varying, apellido_paterno character varying, apellido_materno character varying, fecha_de_nacimiento date, rfc character varying, salario real, fecha_inicio_servicio date, direccion character varying);
       public       postgres    false    3                       1255    87027 �   registra_venta_electronica(integer, integer, integer, date, character varying, character varying, character varying, character varying, integer, character varying, real, character varying, date, character varying, real)    FUNCTION     �  CREATE FUNCTION public.registra_venta_electronica(id_cliente integer, id_ventas_electronicas integer, numero_de_seguimiento integer, fecha_venta_e date, codigo_cliente character varying, nombre character varying, apellido_paterno character varying, apellido_materno character varying, numero_de_productos integer, desglose_de_productos_adquiridos character varying, precio_a_pagar real, direccion_de_envio character varying, fecha_de_pedido date, forma_de_pago character varying, total real) RETURNS void
    LANGUAGE sql
    AS $$  
    INSERT INTO VENTAS_ELECTRONICAS_r2 VALUES (Numero_de_seguimiento,Direccion_de_envio,Fecha_de_pedido,Forma_de_pago,Total);
    INSERT INTO VENTAS_ELECTRONICAS_r1 VALUES (Id_Ventas_electronicas,Numero_de_seguimiento,Fecha_Venta_e,Codigo_cliente,Nombre,Apellido_Paterno,Apellido_Materno,Numero_de_productos,Desglose_de_productos_adquiridos,Precio_a_pagar);
    INSERT INTO COMPRAR_tipo_e VALUES (Id_Ventas_electronicas,Id_Cliente);
$$;
 �  DROP FUNCTION public.registra_venta_electronica(id_cliente integer, id_ventas_electronicas integer, numero_de_seguimiento integer, fecha_venta_e date, codigo_cliente character varying, nombre character varying, apellido_paterno character varying, apellido_materno character varying, numero_de_productos integer, desglose_de_productos_adquiridos character varying, precio_a_pagar real, direccion_de_envio character varying, fecha_de_pedido date, forma_de_pago character varying, total real);
       public       postgres    false    3                       1255    87026 �   registra_venta_fisica(integer, integer, integer, character varying, character varying, date, integer, integer, integer, character varying, integer, integer)    FUNCTION     ^  CREATE FUNCTION public.registra_venta_fisica(id_cliente integer, id_venta_fisica integer, numero_ticket integer, codigo_cliente character varying, clave_producto character varying, fecha_venta_f date, id_empleado_que_ayudo_a_cliente integer, empleado_que_efectuo_el_cobro integer, vivero_donde_se_adquirio integer, forma_de_pago character varying, numero_de_productos_adquiridos integer, total_productos integer) RETURNS void
    LANGUAGE sql
    AS $$  
    INSERT INTO VENTA_FISICA_r2 VALUES (Numero_ticket,Clave_producto,Numero_de_productos_adquiridos,Total_productos);
    INSERT INTO VENTA_FISICA_r1 VALUES (Id_Venta_Fisica,Numero_ticket,Codigo_cliente,Clave_producto,Fecha_Venta_f,Id_Empleado_que_ayudo_a_cliente,Empleado_que_efectuo_el_cobro,Vivero_donde_se_adquirio,Forma_de_pago);
    INSERT INTO COMPRAR_tipo_f VALUES (Id_Venta_Fisica,Id_Cliente);
$$;
 �  DROP FUNCTION public.registra_venta_fisica(id_cliente integer, id_venta_fisica integer, numero_ticket integer, codigo_cliente character varying, clave_producto character varying, fecha_venta_f date, id_empleado_que_ayudo_a_cliente integer, empleado_que_efectuo_el_cobro integer, vivero_donde_se_adquirio integer, forma_de_pago character varying, numero_de_productos_adquiridos integer, total_productos integer);
       public       postgres    false    3            �            1259    86661    area    TABLE     e   CREATE TABLE public.area (
    id_planta integer NOT NULL,
    id_tipo_de_planta integer NOT NULL
);
    DROP TABLE public.area;
       public         postgres    false    3            S           0    0 
   TABLE area    COMMENT     T   COMMENT ON TABLE public.area IS 'Contiene la informacion de areas de las plantas.';
            public       postgres    false    229            T           0    0    COLUMN area.id_planta    COMMENT     J   COMMENT ON COLUMN public.area.id_planta IS 'Identificador de la Planta.';
            public       postgres    false    229            U           0    0    COLUMN area.id_tipo_de_planta    COMMENT     X   COMMENT ON COLUMN public.area.id_tipo_de_planta IS 'Identificador del tipo de planta.';
            public       postgres    false    229            �            1259    86521 
   cliente_r1    TABLE     P  CREATE TABLE public.cliente_r1 (
    id_cliente integer NOT NULL,
    codigo_cliente character varying(5) NOT NULL,
    nombre character varying(20) NOT NULL,
    apellido_paterno character varying(20) NOT NULL,
    apellido_materno character varying(20) NOT NULL,
    CONSTRAINT chc_c CHECK (((codigo_cliente)::text ~~ 'A%'::text))
);
    DROP TABLE public.cliente_r1;
       public         postgres    false    3            V           0    0    TABLE cliente_r1    COMMENT     S   COMMENT ON TABLE public.cliente_r1 IS 'Contiene la información de los clientes.';
            public       postgres    false    218            W           0    0    COLUMN cliente_r1.id_cliente    COMMENT     P   COMMENT ON COLUMN public.cliente_r1.id_cliente IS 'Identificador del cliente.';
            public       postgres    false    218            X           0    0     COLUMN cliente_r1.codigo_cliente    COMMENT     M   COMMENT ON COLUMN public.cliente_r1.codigo_cliente IS 'Codigo del cliente.';
            public       postgres    false    218            Y           0    0    COLUMN cliente_r1.nombre    COMMENT     E   COMMENT ON COLUMN public.cliente_r1.nombre IS 'Nombre del cliente.';
            public       postgres    false    218            Z           0    0 "   COLUMN cliente_r1.apellido_paterno    COMMENT     Y   COMMENT ON COLUMN public.cliente_r1.apellido_paterno IS 'Apellido Paterno del cliente.';
            public       postgres    false    218            [           0    0 "   COLUMN cliente_r1.apellido_materno    COMMENT     Y   COMMENT ON COLUMN public.cliente_r1.apellido_materno IS 'Apellido Materno del cliente.';
            public       postgres    false    218            �            1259    86516 
   cliente_r2    TABLE     �   CREATE TABLE public.cliente_r2 (
    codigo_cliente character varying(5) NOT NULL,
    fecha_de_nacimiento date NOT NULL,
    direccion character varying(100),
    rfc character varying(13) NOT NULL
);
    DROP TABLE public.cliente_r2;
       public         postgres    false    3            \           0    0    TABLE cliente_r2    COMMENT     S   COMMENT ON TABLE public.cliente_r2 IS 'Contiene la información de los clientes.';
            public       postgres    false    217            ]           0    0     COLUMN cliente_r2.codigo_cliente    COMMENT     M   COMMENT ON COLUMN public.cliente_r2.codigo_cliente IS 'Codigo del cliente.';
            public       postgres    false    217            ^           0    0 %   COLUMN cliente_r2.fecha_de_nacimiento    COMMENT     _   COMMENT ON COLUMN public.cliente_r2.fecha_de_nacimiento IS 'Fehca de nacimiento del cliente.';
            public       postgres    false    217            _           0    0    COLUMN cliente_r2.direccion    COMMENT     K   COMMENT ON COLUMN public.cliente_r2.direccion IS 'Direccion del cliente.';
            public       postgres    false    217            `           0    0    COLUMN cliente_r2.rfc    COMMENT     ?   COMMENT ON COLUMN public.cliente_r2.rfc IS 'RFC del Cliente.';
            public       postgres    false    217            �            1259    86751    comprar_tipo_e    TABLE     u   CREATE TABLE public.comprar_tipo_e (
    id_ventas_electronicas integer NOT NULL,
    id_cliente integer NOT NULL
);
 "   DROP TABLE public.comprar_tipo_e;
       public         postgres    false    3            a           0    0    TABLE comprar_tipo_e    COMMENT     k   COMMENT ON TABLE public.comprar_tipo_e IS 'Contiene la informacion de las ventas y compras electronicas.';
            public       postgres    false    235            b           0    0 ,   COLUMN comprar_tipo_e.id_ventas_electronicas    COMMENT     l   COMMENT ON COLUMN public.comprar_tipo_e.id_ventas_electronicas IS 'Identificador de la venta electronica.';
            public       postgres    false    235            c           0    0     COLUMN comprar_tipo_e.id_cliente    COMMENT     U   COMMENT ON COLUMN public.comprar_tipo_e.id_cliente IS 'Identificador del clientes.';
            public       postgres    false    235            �            1259    86736    comprar_tipo_f    TABLE     n   CREATE TABLE public.comprar_tipo_f (
    id_venta_fisica integer NOT NULL,
    id_cliente integer NOT NULL
);
 "   DROP TABLE public.comprar_tipo_f;
       public         postgres    false    3            d           0    0    TABLE comprar_tipo_f    COMMENT     f   COMMENT ON TABLE public.comprar_tipo_f IS 'Contiene la informacion de las ventas y compras fisicas.';
            public       postgres    false    234            e           0    0 %   COLUMN comprar_tipo_f.id_venta_fisica    COMMENT     `   COMMENT ON COLUMN public.comprar_tipo_f.id_venta_fisica IS 'Identificador de la venta Fisica.';
            public       postgres    false    234            f           0    0     COLUMN comprar_tipo_f.id_cliente    COMMENT     U   COMMENT ON COLUMN public.comprar_tipo_f.id_cliente IS 'Identificador del clientes.';
            public       postgres    false    234            �            1259    86616 	   controlar    TABLE     f   CREATE TABLE public.controlar (
    id_empleado integer NOT NULL,
    id_semillas integer NOT NULL
);
    DROP TABLE public.controlar;
       public         postgres    false    3            g           0    0    TABLE controlar    COMMENT     q   COMMENT ON TABLE public.controlar IS 'Contiene la información de los trabajadores que controlan las Semillas.';
            public       postgres    false    226            h           0    0    COLUMN controlar.id_empleado    COMMENT     Q   COMMENT ON COLUMN public.controlar.id_empleado IS 'Identificador del Empleado.';
            public       postgres    false    226            i           0    0    COLUMN controlar.id_semillas    COMMENT     T   COMMENT ON COLUMN public.controlar.id_semillas IS 'Identificador de las Semillas.';
            public       postgres    false    226            �            1259    86776 
   correo_cli    TABLE     �   CREATE TABLE public.correo_cli (
    id_cliente integer NOT NULL,
    id_correo integer NOT NULL,
    correo character varying(40),
    CONSTRAINT chc_cc CHECK (((correo)::text ~~ '%@%'::text))
);
    DROP TABLE public.correo_cli;
       public         postgres    false    3            j           0    0    TABLE correo_cli    COMMENT     O   COMMENT ON TABLE public.correo_cli IS 'Contiene los Correos de los clientes.';
            public       postgres    false    237            k           0    0    COLUMN correo_cli.id_cliente    COMMENT     P   COMMENT ON COLUMN public.correo_cli.id_cliente IS 'Identificador del cliente.';
            public       postgres    false    237            l           0    0    COLUMN correo_cli.id_correo    COMMENT     Z   COMMENT ON COLUMN public.correo_cli.id_correo IS 'Identificador del Correo del cliente.';
            public       postgres    false    237            m           0    0    COLUMN correo_cli.correo    COMMENT     E   COMMENT ON COLUMN public.correo_cli.correo IS 'Correo del cliente.';
            public       postgres    false    237            �            1259    86591 
   correo_emp    TABLE     �   CREATE TABLE public.correo_emp (
    id_empleado integer NOT NULL,
    id_correo integer NOT NULL,
    correo character varying(40),
    CONSTRAINT chc_ce CHECK (((correo)::text ~~ '%@%'::text))
);
    DROP TABLE public.correo_emp;
       public         postgres    false    3            n           0    0    TABLE correo_emp    COMMENT     P   COMMENT ON TABLE public.correo_emp IS 'Contiene los Correos de los Empleados.';
            public       postgres    false    224            o           0    0    COLUMN correo_emp.id_empleado    COMMENT     R   COMMENT ON COLUMN public.correo_emp.id_empleado IS 'Identificador del Empleado.';
            public       postgres    false    224            p           0    0    COLUMN correo_emp.id_correo    COMMENT     [   COMMENT ON COLUMN public.correo_emp.id_correo IS 'Identificador del Correo del Empleado.';
            public       postgres    false    224            q           0    0    COLUMN correo_emp.correo    COMMENT     F   COMMENT ON COLUMN public.correo_emp.correo IS 'Correo del Empleado.';
            public       postgres    false    224            �            1259    86541    direccion_viv    TABLE     �   CREATE TABLE public.direccion_viv (
    id_vivero integer NOT NULL,
    id_direccion integer NOT NULL,
    direccion character varying(100) NOT NULL
);
 !   DROP TABLE public.direccion_viv;
       public         postgres    false    3            r           0    0    TABLE direccion_viv    COMMENT     U   COMMENT ON TABLE public.direccion_viv IS 'Contiene las Direcciones de los Viveros.';
            public       postgres    false    220            s           0    0    COLUMN direccion_viv.id_vivero    COMMENT     Q   COMMENT ON COLUMN public.direccion_viv.id_vivero IS 'Identificador del Vivero.';
            public       postgres    false    220            t           0    0 !   COLUMN direccion_viv.id_direccion    COMMENT     d   COMMENT ON COLUMN public.direccion_viv.id_direccion IS 'Identificador de la Direccion del Vivero.';
            public       postgres    false    220            u           0    0    COLUMN direccion_viv.direccion    COMMENT     M   COMMENT ON COLUMN public.direccion_viv.direccion IS 'Direccion del Vivero.';
            public       postgres    false    220            �            1259    86391    empleado_r1    TABLE     S  CREATE TABLE public.empleado_r1 (
    id_empleado integer NOT NULL,
    curp character varying(20) NOT NULL,
    nombre character varying(20) NOT NULL,
    apellido_paterno character varying(20) NOT NULL,
    apellido_materno character varying(20) NOT NULL,
    fecha_de_nacimiento date NOT NULL,
    rfc character varying(13) NOT NULL
);
    DROP TABLE public.empleado_r1;
       public         postgres    false    3            v           0    0    TABLE empleado_r1    COMMENT     U   COMMENT ON TABLE public.empleado_r1 IS 'Contiene la información de los Empleados.';
            public       postgres    false    200            w           0    0    COLUMN empleado_r1.id_empleado    COMMENT     S   COMMENT ON COLUMN public.empleado_r1.id_empleado IS 'Identificador del Empleado.';
            public       postgres    false    200            x           0    0    COLUMN empleado_r1.curp    COMMENT     C   COMMENT ON COLUMN public.empleado_r1.curp IS 'CURP del Empleado.';
            public       postgres    false    200            y           0    0    COLUMN empleado_r1.nombre    COMMENT     G   COMMENT ON COLUMN public.empleado_r1.nombre IS 'Nombre del Empleado.';
            public       postgres    false    200            z           0    0 #   COLUMN empleado_r1.apellido_paterno    COMMENT     [   COMMENT ON COLUMN public.empleado_r1.apellido_paterno IS 'Apellido Paterno del Empleado.';
            public       postgres    false    200            {           0    0 #   COLUMN empleado_r1.apellido_materno    COMMENT     [   COMMENT ON COLUMN public.empleado_r1.apellido_materno IS 'Apellido Materno del Empleado.';
            public       postgres    false    200            |           0    0 &   COLUMN empleado_r1.fecha_de_nacimiento    COMMENT     a   COMMENT ON COLUMN public.empleado_r1.fecha_de_nacimiento IS 'Fecha de nacimiento del Empleado.';
            public       postgres    false    200            }           0    0    COLUMN empleado_r1.rfc    COMMENT     A   COMMENT ON COLUMN public.empleado_r1.rfc IS 'RFC del Empleado.';
            public       postgres    false    200            �            1259    86386    empleado_r2    TABLE     �   CREATE TABLE public.empleado_r2 (
    curp character varying(20) NOT NULL,
    salario real,
    fecha_inicio_servicio date NOT NULL,
    direccion character varying(40)
);
    DROP TABLE public.empleado_r2;
       public         postgres    false    3            ~           0    0    TABLE empleado_r2    COMMENT     p   COMMENT ON TABLE public.empleado_r2 IS 'Contiene la Fecha, Direccion y Salario de empleados acorde a su CURP.';
            public       postgres    false    199                       0    0    COLUMN empleado_r2.curp    COMMENT     C   COMMENT ON COLUMN public.empleado_r2.curp IS 'CURP del Empleado.';
            public       postgres    false    199            �           0    0    COLUMN empleado_r2.salario    COMMENT     I   COMMENT ON COLUMN public.empleado_r2.salario IS 'Salario del Empleado.';
            public       postgres    false    199            �           0    0 (   COLUMN empleado_r2.fecha_inicio_servicio    COMMENT     o   COMMENT ON COLUMN public.empleado_r2.fecha_inicio_servicio IS 'Fecha en la que inicio a trabajar el empleado';
            public       postgres    false    199            �           0    0    COLUMN empleado_r2.direccion    COMMENT     M   COMMENT ON COLUMN public.empleado_r2.direccion IS 'Direccion del Empleado.';
            public       postgres    false    199            �            1259    86631 	   germinado    TABLE     q   CREATE TABLE public.germinado (
    id_semillas integer NOT NULL,
    id_semillas_germinadas integer NOT NULL
);
    DROP TABLE public.germinado;
       public         postgres    false    3            �           0    0    TABLE germinado    COMMENT     ]   COMMENT ON TABLE public.germinado IS 'Contiene la información de las Semillas Germinadas.';
            public       postgres    false    227            �           0    0    COLUMN germinado.id_semillas    COMMENT     T   COMMENT ON COLUMN public.germinado.id_semillas IS 'Identificador de las Semillas.';
            public       postgres    false    227            �           0    0 '   COLUMN germinado.id_semillas_germinadas    COMMENT     j   COMMENT ON COLUMN public.germinado.id_semillas_germinadas IS 'Identificador de las Semillas Germinadas.';
            public       postgres    false    227            �            1259    86511    pago_e    TABLE     p   CREATE TABLE public.pago_e (
    id_pago_e integer NOT NULL,
    tipo_de_pago character varying(20) NOT NULL
);
    DROP TABLE public.pago_e;
       public         postgres    false    3            �           0    0    TABLE pago_e    COMMENT     Y   COMMENT ON TABLE public.pago_e IS 'Contiene la información de los pagos electronicos.';
            public       postgres    false    216            �           0    0    COLUMN pago_e.id_pago_e    COMMENT     H   COMMENT ON COLUMN public.pago_e.id_pago_e IS 'Identificador del pago.';
            public       postgres    false    216            �           0    0    COLUMN pago_e.tipo_de_pago    COMMENT     L   COMMENT ON COLUMN public.pago_e.tipo_de_pago IS 'Nombre del tipo de pago.';
            public       postgres    false    216            �            1259    86506    pago_f    TABLE     p   CREATE TABLE public.pago_f (
    id_pago_f integer NOT NULL,
    tipo_de_pago character varying(20) NOT NULL
);
    DROP TABLE public.pago_f;
       public         postgres    false    3            �           0    0    TABLE pago_f    COMMENT     T   COMMENT ON TABLE public.pago_f IS 'Contiene la información de los pagos fisicos.';
            public       postgres    false    215            �           0    0    COLUMN pago_f.id_pago_f    COMMENT     H   COMMENT ON COLUMN public.pago_f.id_pago_f IS 'Identificador del pago.';
            public       postgres    false    215            �           0    0    COLUMN pago_f.tipo_de_pago    COMMENT     L   COMMENT ON COLUMN public.pago_f.tipo_de_pago IS 'Nombre del tipo de pago.';
            public       postgres    false    215            �            1259    86441 
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
            public       postgres    false    207            �            1259    86436 
   plantas_r2    TABLE     ~   CREATE TABLE public.plantas_r2 (
    nombre character varying(20) NOT NULL,
    precio real,
    numero_de_plantas integer
);
    DROP TABLE public.plantas_r2;
       public         postgres    false    3            �           0    0    TABLE plantas_r2    COMMENT     R   COMMENT ON TABLE public.plantas_r2 IS 'Contiene la información de las Plantas.';
            public       postgres    false    206            �           0    0    COLUMN plantas_r2.nombre    COMMENT     F   COMMENT ON COLUMN public.plantas_r2.nombre IS 'Nombre de la Planta.';
            public       postgres    false    206            �           0    0    COLUMN plantas_r2.precio    COMMENT     F   COMMENT ON COLUMN public.plantas_r2.precio IS 'Precio de la Planta.';
            public       postgres    false    206            �           0    0 #   COLUMN plantas_r2.numero_de_plantas    COMMENT     O   COMMENT ON COLUMN public.plantas_r2.numero_de_plantas IS 'Numero de plantas.';
            public       postgres    false    206            �            1259    86721 
   registra_e    TABLE     p   CREATE TABLE public.registra_e (
    id_ventas_electronicas integer NOT NULL,
    id_pago_e integer NOT NULL
);
    DROP TABLE public.registra_e;
       public         postgres    false    3            �           0    0    TABLE registra_e    COMMENT     t   COMMENT ON TABLE public.registra_e IS 'Contiene la información de los registros de pagos de ventas electronicas.';
            public       postgres    false    233            �           0    0 (   COLUMN registra_e.id_ventas_electronicas    COMMENT     h   COMMENT ON COLUMN public.registra_e.id_ventas_electronicas IS 'Identificador de la venta electronica.';
            public       postgres    false    233            �           0    0    COLUMN registra_e.id_pago_e    COMMENT     L   COMMENT ON COLUMN public.registra_e.id_pago_e IS 'Identificador del pago.';
            public       postgres    false    233            �            1259    86706 
   registra_f    TABLE     i   CREATE TABLE public.registra_f (
    id_venta_fisica integer NOT NULL,
    id_pago_f integer NOT NULL
);
    DROP TABLE public.registra_f;
       public         postgres    false    3            �           0    0    TABLE registra_f    COMMENT     o   COMMENT ON TABLE public.registra_f IS 'Contiene la información de los registros de pagos de ventas fisicas.';
            public       postgres    false    232            �           0    0 !   COLUMN registra_f.id_venta_fisica    COMMENT     \   COMMENT ON COLUMN public.registra_f.id_venta_fisica IS 'Identificador de la venta Fisica.';
            public       postgres    false    232            �           0    0    COLUMN registra_f.id_pago_f    COMMENT     S   COMMENT ON COLUMN public.registra_f.id_pago_f IS 'Identificador del pago fisico.';
            public       postgres    false    232            �            1259    86551 	   registrar    TABLE     d   CREATE TABLE public.registrar (
    id_vivero integer NOT NULL,
    id_registro integer NOT NULL
);
    DROP TABLE public.registrar;
       public         postgres    false    3            �           0    0    TABLE registrar    COMMENT     a   COMMENT ON TABLE public.registrar IS 'Contiene la informacion de los registros de los Viveros.';
            public       postgres    false    221            �           0    0    COLUMN registrar.id_vivero    COMMENT     M   COMMENT ON COLUMN public.registrar.id_vivero IS 'Identificador del Vivero.';
            public       postgres    false    221            �           0    0    COLUMN registrar.id_registro    COMMENT     Q   COMMENT ON COLUMN public.registrar.id_registro IS 'Identificador del Registro.';
            public       postgres    false    221            �            1259    86376    registro_r1    TABLE     j  CREATE TABLE public.registro_r1 (
    id_registro integer NOT NULL,
    genero character varying(30) NOT NULL,
    nombre character varying(20) NOT NULL,
    CONSTRAINT chr_genero CHECK (((genero)::text = ANY ((ARRAY['Haworthia'::character varying, 'Gasteria'::character varying, 'Astrophytum'::character varying, 'Ariocarpus'::character varying])::text[])))
);
    DROP TABLE public.registro_r1;
       public         postgres    false    3            �           0    0    TABLE registro_r1    COMMENT     o   COMMENT ON TABLE public.registro_r1 IS 'Contiene la información de los Registros de ejemplares productoras.';
            public       postgres    false    198            �           0    0    COLUMN registro_r1.id_registro    COMMENT     S   COMMENT ON COLUMN public.registro_r1.id_registro IS 'Identificador del Registro.';
            public       postgres    false    198            �           0    0    COLUMN registro_r1.genero    COMMENT     R   COMMENT ON COLUMN public.registro_r1.genero IS 'Genero de la planta productora.';
            public       postgres    false    198            �           0    0    COLUMN registro_r1.nombre    COMMENT     G   COMMENT ON COLUMN public.registro_r1.nombre IS 'Nombre del Registro.';
            public       postgres    false    198            �            1259    86371    registro_r2    TABLE     �   CREATE TABLE public.registro_r2 (
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
            public       postgres    false    197            �            1259    86401    rol    TABLE     i   CREATE TABLE public.rol (
    id_rol integer NOT NULL,
    tipo_de_rol character varying(50) NOT NULL
);
    DROP TABLE public.rol;
       public         postgres    false    3            �           0    0 	   TABLE rol    COMMENT     O   COMMENT ON TABLE public.rol IS 'Contiene el nombre del rol de los Empleados.';
            public       postgres    false    201            �           0    0    COLUMN rol.id_rol    COMMENT     N   COMMENT ON COLUMN public.rol.id_rol IS 'Identificador del Rol del Empleado.';
            public       postgres    false    201            �           0    0    COLUMN rol.tipo_de_rol    COMMENT     L   COMMENT ON COLUMN public.rol.tipo_de_rol IS 'Nombre del rol del Empleado.';
            public       postgres    false    201            �            1259    86426    semillas_germinadas_r1    TABLE     0  CREATE TABLE public.semillas_germinadas_r1 (
    id_semillas_germinadas integer NOT NULL,
    origen character varying(30) NOT NULL,
    semillas_germinadas integer,
    CONSTRAINT chsg_origen CHECK (((origen)::text = ANY ((ARRAY['America'::character varying, 'Africa'::character varying])::text[])))
);
 *   DROP TABLE public.semillas_germinadas_r1;
       public         postgres    false    3            �           0    0    TABLE semillas_germinadas_r1    COMMENT     j   COMMENT ON TABLE public.semillas_germinadas_r1 IS 'Contiene la información de las semillas germinadas.';
            public       postgres    false    205            �           0    0 4   COLUMN semillas_germinadas_r1.id_semillas_germinadas    COMMENT     w   COMMENT ON COLUMN public.semillas_germinadas_r1.id_semillas_germinadas IS 'Identificador de las Semillas Germinadas.';
            public       postgres    false    205            �           0    0 $   COLUMN semillas_germinadas_r1.origen    COMMENT     `   COMMENT ON COLUMN public.semillas_germinadas_r1.origen IS 'Origen de las Semillas Germinadas.';
            public       postgres    false    205            �           0    0 1   COLUMN semillas_germinadas_r1.semillas_germinadas    COMMENT     i   COMMENT ON COLUMN public.semillas_germinadas_r1.semillas_germinadas IS 'Numero de Semillas Germinadas.';
            public       postgres    false    205            �            1259    86421    semillas_germinadas_r2    TABLE     �   CREATE TABLE public.semillas_germinadas_r2 (
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
            public       postgres    false    204            �           0    0 *   COLUMN semillas_germinadas_r2.ultimo_riego    COMMENT     [   COMMENT ON COLUMN public.semillas_germinadas_r2.ultimo_riego IS 'Fecha del ultimo riego.';
            public       postgres    false    204            �           0    0 1   COLUMN semillas_germinadas_r2.ultimo_fertilizante    COMMENT     i   COMMENT ON COLUMN public.semillas_germinadas_r2.ultimo_fertilizante IS 'Fecha del ultimo fertilizante.';
            public       postgres    false    204            �           0    0 /   COLUMN semillas_germinadas_r2.ultima_fumigacion    COMMENT     g   COMMENT ON COLUMN public.semillas_germinadas_r2.ultima_fumigacion IS 'Fecha de la ultima fumigacion.';
            public       postgres    false    204            �            1259    86411    semillas_r1    TABLE     �   CREATE TABLE public.semillas_r1 (
    id_semillas integer NOT NULL,
    planta_de_cruce character varying(20),
    CONSTRAINT chs_pc CHECK (((planta_de_cruce)::text ~~ 'F%'::text))
);
    DROP TABLE public.semillas_r1;
       public         postgres    false    3            �           0    0    TABLE semillas_r1    COMMENT     g   COMMENT ON TABLE public.semillas_r1 IS 'Contiene el id de Semillas y nombre de las plantas de cruce.';
            public       postgres    false    203            �           0    0    COLUMN semillas_r1.id_semillas    COMMENT     V   COMMENT ON COLUMN public.semillas_r1.id_semillas IS 'Identificador de las Semillas.';
            public       postgres    false    203            �           0    0 "   COLUMN semillas_r1.planta_de_cruce    COMMENT     K   COMMENT ON COLUMN public.semillas_r1.planta_de_cruce IS 'Panta de cruce.';
            public       postgres    false    203            �            1259    86406    semillas_r2    TABLE     �   CREATE TABLE public.semillas_r2 (
    planta_de_cruce character varying(20) NOT NULL,
    fecha_de_polinizacion date NOT NULL,
    cantidad_de_semillas integer NOT NULL
);
    DROP TABLE public.semillas_r2;
       public         postgres    false    3            �           0    0    TABLE semillas_r2    COMMENT     �   COMMENT ON TABLE public.semillas_r2 IS 'Contiene las fechas de polinizacion y cantidad de semillas acorde a la planta de cruce.';
            public       postgres    false    202            �           0    0 "   COLUMN semillas_r2.planta_de_cruce    COMMENT     K   COMMENT ON COLUMN public.semillas_r2.planta_de_cruce IS 'Panta de cruce.';
            public       postgres    false    202            �           0    0 (   COLUMN semillas_r2.fecha_de_polinizacion    COMMENT     h   COMMENT ON COLUMN public.semillas_r2.fecha_de_polinizacion IS 'Fecha de polinizacion de las Semillas.';
            public       postgres    false    202            �           0    0 '   COLUMN semillas_r2.cantidad_de_semillas    COMMENT     V   COMMENT ON COLUMN public.semillas_r2.cantidad_de_semillas IS 'Cantidad de Semillas.';
            public       postgres    false    202            �            1259    86766    telefono_cli    TABLE     �   CREATE TABLE public.telefono_cli (
    id_cliente integer NOT NULL,
    id_telefono integer NOT NULL,
    telefono character varying(12)
);
     DROP TABLE public.telefono_cli;
       public         postgres    false    3            �           0    0    TABLE telefono_cli    COMMENT     S   COMMENT ON TABLE public.telefono_cli IS 'Contiene los Telefonos de los clientes.';
            public       postgres    false    236            �           0    0    COLUMN telefono_cli.id_cliente    COMMENT     R   COMMENT ON COLUMN public.telefono_cli.id_cliente IS 'Identificador del cliente.';
            public       postgres    false    236            �           0    0    COLUMN telefono_cli.id_telefono    COMMENT     `   COMMENT ON COLUMN public.telefono_cli.id_telefono IS 'Identificador del Telefono del cliente.';
            public       postgres    false    236            �           0    0    COLUMN telefono_cli.telefono    COMMENT     c   COMMENT ON COLUMN public.telefono_cli.telefono IS 'Numero de telefono de 12 digitos del cliente.';
            public       postgres    false    236            �            1259    86581    telefono_emp    TABLE     �   CREATE TABLE public.telefono_emp (
    id_empleado integer NOT NULL,
    id_telefono integer NOT NULL,
    telefono character varying(12)
);
     DROP TABLE public.telefono_emp;
       public         postgres    false    3            �           0    0    TABLE telefono_emp    COMMENT     T   COMMENT ON TABLE public.telefono_emp IS 'Contiene los Telefonos de los Empleados.';
            public       postgres    false    223            �           0    0    COLUMN telefono_emp.id_empleado    COMMENT     T   COMMENT ON COLUMN public.telefono_emp.id_empleado IS 'Identificador del Empleado.';
            public       postgres    false    223            �           0    0    COLUMN telefono_emp.id_telefono    COMMENT     a   COMMENT ON COLUMN public.telefono_emp.id_telefono IS 'Identificador del Telefono del Empleado.';
            public       postgres    false    223            �           0    0    COLUMN telefono_emp.telefono    COMMENT     d   COMMENT ON COLUMN public.telefono_emp.telefono IS 'Numero de telefono de 12 digitos del Empleado.';
            public       postgres    false    223            �            1259    86531    telefono_viv    TABLE     [  CREATE TABLE public.telefono_viv (
    id_vivero integer NOT NULL,
    id_telefono integer NOT NULL,
    telefono character varying(12) NOT NULL,
    CONSTRAINT chc_t CHECK (((telefono)::text ~~ '5255%'::text)),
    CONSTRAINT che_t CHECK (((telefono)::text ~~ '5255%'::text)),
    CONSTRAINT chvi_t CHECK (((telefono)::text ~~ '5255%'::text))
);
     DROP TABLE public.telefono_viv;
       public         postgres    false    3            �           0    0    TABLE telefono_viv    COMMENT     R   COMMENT ON TABLE public.telefono_viv IS 'Contiene los Telefonos de los Viveros.';
            public       postgres    false    219            �           0    0    COLUMN telefono_viv.id_vivero    COMMENT     P   COMMENT ON COLUMN public.telefono_viv.id_vivero IS 'Identificador del Vivero.';
            public       postgres    false    219            �           0    0    COLUMN telefono_viv.id_telefono    COMMENT     _   COMMENT ON COLUMN public.telefono_viv.id_telefono IS 'Identificador del Telefono del Vivero.';
            public       postgres    false    219            �           0    0    COLUMN telefono_viv.telefono    COMMENT     b   COMMENT ON COLUMN public.telefono_viv.telefono IS 'Numero de telefono de 12 digitos del Vivero.';
            public       postgres    false    219            �            1259    86601 	   tiene_emp    TABLE     a   CREATE TABLE public.tiene_emp (
    id_empleado integer NOT NULL,
    id_rol integer NOT NULL
);
    DROP TABLE public.tiene_emp;
       public         postgres    false    3            �           0    0    TABLE tiene_emp    COMMENT     _   COMMENT ON TABLE public.tiene_emp IS 'Contiene la información de los tipos de Trabajadores.';
            public       postgres    false    225            �           0    0    COLUMN tiene_emp.id_empleado    COMMENT     Q   COMMENT ON COLUMN public.tiene_emp.id_empleado IS 'Identificador del Empleado.';
            public       postgres    false    225            �           0    0    COLUMN tiene_emp.id_rol    COMMENT     T   COMMENT ON COLUMN public.tiene_emp.id_rol IS 'Identificador del rol del Empleado.';
            public       postgres    false    225            �            1259    86646 	   tiene_pla    TABLE     b   CREATE TABLE public.tiene_pla (
    id_vivero integer NOT NULL,
    id_planta integer NOT NULL
);
    DROP TABLE public.tiene_pla;
       public         postgres    false    3            �           0    0    TABLE tiene_pla    COMMENT     S   COMMENT ON TABLE public.tiene_pla IS 'Contiene las Plantas que hay en un Vivero.';
            public       postgres    false    228            �           0    0    COLUMN tiene_pla.id_vivero    COMMENT     M   COMMENT ON COLUMN public.tiene_pla.id_vivero IS 'Identificador del Vivero.';
            public       postgres    false    228            �           0    0    COLUMN tiene_pla.id_planta    COMMENT     O   COMMENT ON COLUMN public.tiene_pla.id_planta IS 'Identificador de la Planta.';
            public       postgres    false    228            �            1259    86456    tipo_de_planta_r1    TABLE     j  CREATE TABLE public.tipo_de_planta_r1 (
    id_tipo_de_planta integer NOT NULL,
    nombre_del_tipo_de_planta character varying(20) NOT NULL,
    genero character varying(30) NOT NULL,
    CONSTRAINT cht_genero CHECK (((genero)::text = ANY ((ARRAY['Haworthia'::character varying, 'Gasteria'::character varying, 'Astrophytum'::character varying, 'Ariocarpus'::character varying])::text[]))),
    CONSTRAINT cht_nombre CHECK (((nombre_del_tipo_de_planta)::text = ANY ((ARRAY['Haworthia'::character varying, 'Gasteria'::character varying, 'Astrophytum'::character varying, 'Ariocarpus'::character varying])::text[])))
);
 %   DROP TABLE public.tipo_de_planta_r1;
       public         postgres    false    3            �           0    0    TABLE tipo_de_planta_r1    COMMENT     g   COMMENT ON TABLE public.tipo_de_planta_r1 IS 'Contiene nombre tipo y genero de los tipos de plantas.';
            public       postgres    false    209            �           0    0 *   COLUMN tipo_de_planta_r1.id_tipo_de_planta    COMMENT     _   COMMENT ON COLUMN public.tipo_de_planta_r1.id_tipo_de_planta IS 'Identificador de la planta.';
            public       postgres    false    209            �           0    0 2   COLUMN tipo_de_planta_r1.nombre_del_tipo_de_planta    COMMENT     i   COMMENT ON COLUMN public.tipo_de_planta_r1.nombre_del_tipo_de_planta IS 'Nombre del tipo de la planta.';
            public       postgres    false    209            �           0    0    COLUMN tipo_de_planta_r1.genero    COMMENT     M   COMMENT ON COLUMN public.tipo_de_planta_r1.genero IS 'Genero de la planta.';
            public       postgres    false    209            �            1259    86451    tipo_de_planta_r2    TABLE     �   CREATE TABLE public.tipo_de_planta_r2 (
    nombre_del_tipo_de_planta character varying(20) NOT NULL,
    cuidados_basicos character varying(200),
    tipo_de_sustrato character varying(120) NOT NULL
);
 %   DROP TABLE public.tipo_de_planta_r2;
       public         postgres    false    3            �           0    0    TABLE tipo_de_planta_r2    COMMENT     b   COMMENT ON TABLE public.tipo_de_planta_r2 IS 'Contiene la información de los tipos de plantas.';
            public       postgres    false    208            �           0    0 2   COLUMN tipo_de_planta_r2.nombre_del_tipo_de_planta    COMMENT     i   COMMENT ON COLUMN public.tipo_de_planta_r2.nombre_del_tipo_de_planta IS 'Nombre del tipo de la planta.';
            public       postgres    false    208            �           0    0 )   COLUMN tipo_de_planta_r2.cuidados_basicos    COMMENT     a   COMMENT ON COLUMN public.tipo_de_planta_r2.cuidados_basicos IS 'Cuidados basicos de la planta.';
            public       postgres    false    208            �           0    0 )   COLUMN tipo_de_planta_r2.tipo_de_sustrato    COMMENT     a   COMMENT ON COLUMN public.tipo_de_planta_r2.tipo_de_sustrato IS 'Tipo de sustrato de la planta.';
            public       postgres    false    208            �            1259    86566    trabajar    TABLE     c   CREATE TABLE public.trabajar (
    id_vivero integer NOT NULL,
    id_empleado integer NOT NULL
);
    DROP TABLE public.trabajar;
       public         postgres    false    3            �           0    0    TABLE trabajar    COMMENT     d   COMMENT ON TABLE public.trabajar IS 'Contiene la información de los trabajadores de los Viveros.';
            public       postgres    false    222            �           0    0    COLUMN trabajar.id_vivero    COMMENT     L   COMMENT ON COLUMN public.trabajar.id_vivero IS 'Identificador del Vivero.';
            public       postgres    false    222            �           0    0    COLUMN trabajar.id_empleado    COMMENT     P   COMMENT ON COLUMN public.trabajar.id_empleado IS 'Identificador del Empleado.';
            public       postgres    false    222            �            1259    86691    venta_e    TABLE     m   CREATE TABLE public.venta_e (
    id_vivero integer NOT NULL,
    id_ventas_electronicas integer NOT NULL
);
    DROP TABLE public.venta_e;
       public         postgres    false    3            �           0    0    TABLE venta_e    COMMENT     g   COMMENT ON TABLE public.venta_e IS 'Contiene la información de de los tipos de ventas electronicas.';
            public       postgres    false    231            �           0    0    COLUMN venta_e.id_vivero    COMMENT     K   COMMENT ON COLUMN public.venta_e.id_vivero IS 'Identificador del Vivero.';
            public       postgres    false    231            �           0    0 %   COLUMN venta_e.id_ventas_electronicas    COMMENT     e   COMMENT ON COLUMN public.venta_e.id_ventas_electronicas IS 'Identificador de la Venta Electronica.';
            public       postgres    false    231            �            1259    86676    venta_f    TABLE     f   CREATE TABLE public.venta_f (
    id_vivero integer NOT NULL,
    id_venta_fisica integer NOT NULL
);
    DROP TABLE public.venta_f;
       public         postgres    false    3            �           0    0    TABLE venta_f    COMMENT     b   COMMENT ON TABLE public.venta_f IS 'Contiene la información de de los tipos de ventas fisicas.';
            public       postgres    false    230            �           0    0    COLUMN venta_f.id_vivero    COMMENT     K   COMMENT ON COLUMN public.venta_f.id_vivero IS 'Identificador del Vivero.';
            public       postgres    false    230            �           0    0    COLUMN venta_f.id_venta_fisica    COMMENT     Y   COMMENT ON COLUMN public.venta_f.id_venta_fisica IS 'Identificador de la Venta Fisica.';
            public       postgres    false    230            �            1259    86481    venta_fisica_r1    TABLE     �  CREATE TABLE public.venta_fisica_r1 (
    id_venta_fisica integer NOT NULL,
    numero_ticket integer NOT NULL,
    codigo_cliente character varying(5) NOT NULL,
    clave_producto character varying(5) NOT NULL,
    fecha_venta_f date NOT NULL,
    id_empleado_que_ayudo_a_cliente integer,
    empleado_que_efectuo_el_cobro integer,
    vivero_donde_se_adquirio integer NOT NULL,
    forma_de_pago character varying(20) NOT NULL,
    CONSTRAINT chvf_cp CHECK (((clave_producto)::text = ANY ((ARRAY['PTHAG'::character varying, 'PTHAP'::character varying, 'PTGAG'::character varying, 'PTGAP'::character varying, 'PTASG'::character varying, 'PTASP'::character varying, 'PTARG'::character varying, 'PTARP'::character varying])::text[]))),
    CONSTRAINT chvf_f CHECK (((forma_de_pago)::text = ANY ((ARRAY['Efectivo'::character varying, 'Tarjeta de Debito'::character varying, 'Tarjeta de Credito'::character varying])::text[])))
);
 #   DROP TABLE public.venta_fisica_r1;
       public         postgres    false    3            �           0    0    TABLE venta_fisica_r1    COMMENT     m   COMMENT ON TABLE public.venta_fisica_r1 IS 'Contiene la información de las Ventas Fisicas de los Viveros.';
            public       postgres    false    212            �           0    0 &   COLUMN venta_fisica_r1.id_venta_fisica    COMMENT     a   COMMENT ON COLUMN public.venta_fisica_r1.id_venta_fisica IS 'Identificador de la Venta Fisica.';
            public       postgres    false    212            �           0    0 $   COLUMN venta_fisica_r1.numero_ticket    COMMENT     O   COMMENT ON COLUMN public.venta_fisica_r1.numero_ticket IS 'Numero de ticket.';
            public       postgres    false    212            �           0    0 %   COLUMN venta_fisica_r1.codigo_cliente    COMMENT     Q   COMMENT ON COLUMN public.venta_fisica_r1.codigo_cliente IS 'Codigo de cliente.';
            public       postgres    false    212            �           0    0 %   COLUMN venta_fisica_r1.clave_producto    COMMENT     U   COMMENT ON COLUMN public.venta_fisica_r1.clave_producto IS 'La clave del producto.';
            public       postgres    false    212            �           0    0 $   COLUMN venta_fisica_r1.fecha_venta_f    COMMENT     W   COMMENT ON COLUMN public.venta_fisica_r1.fecha_venta_f IS 'Fecha de la venta fisica.';
            public       postgres    false    212            �           0    0 6   COLUMN venta_fisica_r1.id_empleado_que_ayudo_a_cliente    COMMENT     w   COMMENT ON COLUMN public.venta_fisica_r1.id_empleado_que_ayudo_a_cliente IS 'Id del Empleado que ayudo a un cliente.';
            public       postgres    false    212            �           0    0 4   COLUMN venta_fisica_r1.empleado_que_efectuo_el_cobro    COMMENT     l   COMMENT ON COLUMN public.venta_fisica_r1.empleado_que_efectuo_el_cobro IS 'Empleado que efectuo el cobro.';
            public       postgres    false    212            �           0    0 /   COLUMN venta_fisica_r1.vivero_donde_se_adquirio    COMMENT     n   COMMENT ON COLUMN public.venta_fisica_r1.vivero_donde_se_adquirio IS 'Vivero donde se adquirio el producto.';
            public       postgres    false    212            �           0    0 $   COLUMN venta_fisica_r1.forma_de_pago    COMMENT     L   COMMENT ON COLUMN public.venta_fisica_r1.forma_de_pago IS 'Forma de pago.';
            public       postgres    false    212            �            1259    86471    venta_fisica_r2    TABLE     �  CREATE TABLE public.venta_fisica_r2 (
    numero_ticket integer NOT NULL,
    clave_producto character varying(5) NOT NULL,
    numero_de_productos_adquiridos integer,
    total_productos integer,
    CONSTRAINT chvf_cp CHECK (((clave_producto)::text = ANY ((ARRAY['PTHAG'::character varying, 'PTHAP'::character varying, 'PTGAG'::character varying, 'PTGAP'::character varying, 'PTASG'::character varying, 'PTASP'::character varying, 'PTARG'::character varying, 'PTARP'::character varying])::text[])))
);
 #   DROP TABLE public.venta_fisica_r2;
       public         postgres    false    3            �           0    0    TABLE venta_fisica_r2    COMMENT     m   COMMENT ON TABLE public.venta_fisica_r2 IS 'Contiene la información del ticket y los productos comprados.';
            public       postgres    false    211            �           0    0 $   COLUMN venta_fisica_r2.numero_ticket    COMMENT     O   COMMENT ON COLUMN public.venta_fisica_r2.numero_ticket IS 'Numero de ticket.';
            public       postgres    false    211            �           0    0 %   COLUMN venta_fisica_r2.clave_producto    COMMENT     U   COMMENT ON COLUMN public.venta_fisica_r2.clave_producto IS 'La clave del producto.';
            public       postgres    false    211            �           0    0 5   COLUMN venta_fisica_r2.numero_de_productos_adquiridos    COMMENT     n   COMMENT ON COLUMN public.venta_fisica_r2.numero_de_productos_adquiridos IS 'Numero de Productos adquiridos.';
            public       postgres    false    211            �           0    0 &   COLUMN venta_fisica_r2.total_productos    COMMENT     Y   COMMENT ON COLUMN public.venta_fisica_r2.total_productos IS 'Costo total de Productos.';
            public       postgres    false    211            �            1259    86466    venta_fisica_r3    TABLE     �   CREATE TABLE public.venta_fisica_r3 (
    clave_producto character varying(5) NOT NULL,
    nombre_producto character varying(70),
    precio_producto real
);
 #   DROP TABLE public.venta_fisica_r3;
       public         postgres    false    3            �           0    0    TABLE venta_fisica_r3    COMMENT     Y   COMMENT ON TABLE public.venta_fisica_r3 IS 'Contiene la información de los Productos.';
            public       postgres    false    210            �           0    0 %   COLUMN venta_fisica_r3.clave_producto    COMMENT     U   COMMENT ON COLUMN public.venta_fisica_r3.clave_producto IS 'La clave del producto.';
            public       postgres    false    210            �           0    0 &   COLUMN venta_fisica_r3.nombre_producto    COMMENT     T   COMMENT ON COLUMN public.venta_fisica_r3.nombre_producto IS 'Nombre del producto.';
            public       postgres    false    210            �           0    0 &   COLUMN venta_fisica_r3.precio_producto    COMMENT     T   COMMENT ON COLUMN public.venta_fisica_r3.precio_producto IS 'Precio del producto.';
            public       postgres    false    210            �            1259    86496    ventas_electronicas_r1    TABLE       CREATE TABLE public.ventas_electronicas_r1 (
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
       public         postgres    false    3            �           0    0    TABLE ventas_electronicas_r1    COMMENT     �   COMMENT ON TABLE public.ventas_electronicas_r1 IS 'Contiene la información de los clientes que realizan compras electronicas.';
            public       postgres    false    214            �           0    0 4   COLUMN ventas_electronicas_r1.id_ventas_electronicas    COMMENT     t   COMMENT ON COLUMN public.ventas_electronicas_r1.id_ventas_electronicas IS 'Identificador de la venta electronica.';
            public       postgres    false    214            �           0    0 3   COLUMN ventas_electronicas_r1.numero_de_seguimiento    COMMENT     {   COMMENT ON COLUMN public.ventas_electronicas_r1.numero_de_seguimiento IS 'Numero de seguimiento de la venta electronica.';
            public       postgres    false    214            �           0    0 +   COLUMN ventas_electronicas_r1.fecha_venta_e    COMMENT     c   COMMENT ON COLUMN public.ventas_electronicas_r1.fecha_venta_e IS 'Fecha de la venta electronica.';
            public       postgres    false    214            �           0    0 ,   COLUMN ventas_electronicas_r1.codigo_cliente    COMMENT     X   COMMENT ON COLUMN public.ventas_electronicas_r1.codigo_cliente IS 'Codigo de cliente.';
            public       postgres    false    214            �           0    0 $   COLUMN ventas_electronicas_r1.nombre    COMMENT     Q   COMMENT ON COLUMN public.ventas_electronicas_r1.nombre IS 'Nombre del cliente.';
            public       postgres    false    214            �           0    0 .   COLUMN ventas_electronicas_r1.apellido_paterno    COMMENT     e   COMMENT ON COLUMN public.ventas_electronicas_r1.apellido_paterno IS 'Apellido Paterno del cliente.';
            public       postgres    false    214            �           0    0 .   COLUMN ventas_electronicas_r1.apellido_materno    COMMENT     e   COMMENT ON COLUMN public.ventas_electronicas_r1.apellido_materno IS 'Apellido Materno del cliente.';
            public       postgres    false    214            �           0    0 1   COLUMN ventas_electronicas_r1.numero_de_productos    COMMENT     j   COMMENT ON COLUMN public.ventas_electronicas_r1.numero_de_productos IS 'Numero de productos adquiridos.';
            public       postgres    false    214            �           0    0 >   COLUMN ventas_electronicas_r1.desglose_de_productos_adquiridos    COMMENT     }   COMMENT ON COLUMN public.ventas_electronicas_r1.desglose_de_productos_adquiridos IS 'Desglose de los productos adquiridos.';
            public       postgres    false    214            �           0    0 ,   COLUMN ventas_electronicas_r1.precio_a_pagar    COMMENT     W   COMMENT ON COLUMN public.ventas_electronicas_r1.precio_a_pagar IS 'Cantidad a pagar.';
            public       postgres    false    214            �            1259    86491    ventas_electronicas_r2    TABLE     �   CREATE TABLE public.ventas_electronicas_r2 (
    numero_de_seguimiento integer NOT NULL,
    direccion_de_envio character varying(100) NOT NULL,
    fecha_de_pedido date NOT NULL,
    forma_de_pago character varying(20) NOT NULL,
    total real
);
 *   DROP TABLE public.ventas_electronicas_r2;
       public         postgres    false    3            �           0    0    TABLE ventas_electronicas_r2    COMMENT     �   COMMENT ON TABLE public.ventas_electronicas_r2 IS 'Contiene la información de las ventas electronicas acorde al numero de seguimiento.';
            public       postgres    false    213            �           0    0 3   COLUMN ventas_electronicas_r2.numero_de_seguimiento    COMMENT     ~   COMMENT ON COLUMN public.ventas_electronicas_r2.numero_de_seguimiento IS 'El numero de seguimiento de la venta electronica.';
            public       postgres    false    213            �           0    0 0   COLUMN ventas_electronicas_r2.direccion_de_envio    COMMENT     y   COMMENT ON COLUMN public.ventas_electronicas_r2.direccion_de_envio IS 'La Direccion a donde se mandaran los productos.';
            public       postgres    false    213                        0    0 -   COLUMN ventas_electronicas_r2.fecha_de_pedido    COMMENT     l   COMMENT ON COLUMN public.ventas_electronicas_r2.fecha_de_pedido IS 'Fecha en la que se realizo el pedido.';
            public       postgres    false    213                       0    0 +   COLUMN ventas_electronicas_r2.forma_de_pago    COMMENT     S   COMMENT ON COLUMN public.ventas_electronicas_r2.forma_de_pago IS 'Forma de pago.';
            public       postgres    false    213                       0    0 #   COLUMN ventas_electronicas_r2.total    COMMENT     I   COMMENT ON COLUMN public.ventas_electronicas_r2.total IS 'Costo total.';
            public       postgres    false    213            �            1259    86366    vivero    TABLE     �   CREATE TABLE public.vivero (
    id_vivero integer NOT NULL,
    nombre character varying(20) NOT NULL,
    fecha_de_apertura date NOT NULL
);
    DROP TABLE public.vivero;
       public         postgres    false    3                       0    0    TABLE vivero    COMMENT     N   COMMENT ON TABLE public.vivero IS 'Contiene la información de los Viveros.';
            public       postgres    false    196                       0    0    COLUMN vivero.id_vivero    COMMENT     J   COMMENT ON COLUMN public.vivero.id_vivero IS 'Identificador del Vivero.';
            public       postgres    false    196                       0    0    COLUMN vivero.nombre    COMMENT     @   COMMENT ON COLUMN public.vivero.nombre IS 'Nombre del Vivero.';
            public       postgres    false    196                       0    0    COLUMN vivero.fecha_de_apertura    COMMENT     V   COMMENT ON COLUMN public.vivero.fecha_de_apertura IS 'Fecha de apertura del Vivero.';
            public       postgres    false    196            B          0    86661    area 
   TABLE DATA               <   COPY public.area (id_planta, id_tipo_de_planta) FROM stdin;
    public       postgres    false    229   ��      7          0    86521 
   cliente_r1 
   TABLE DATA               l   COPY public.cliente_r1 (id_cliente, codigo_cliente, nombre, apellido_paterno, apellido_materno) FROM stdin;
    public       postgres    false    218   Ӵ      6          0    86516 
   cliente_r2 
   TABLE DATA               Y   COPY public.cliente_r2 (codigo_cliente, fecha_de_nacimiento, direccion, rfc) FROM stdin;
    public       postgres    false    217   z�      H          0    86751    comprar_tipo_e 
   TABLE DATA               L   COPY public.comprar_tipo_e (id_ventas_electronicas, id_cliente) FROM stdin;
    public       postgres    false    235   ��      G          0    86736    comprar_tipo_f 
   TABLE DATA               E   COPY public.comprar_tipo_f (id_venta_fisica, id_cliente) FROM stdin;
    public       postgres    false    234   �      ?          0    86616 	   controlar 
   TABLE DATA               =   COPY public.controlar (id_empleado, id_semillas) FROM stdin;
    public       postgres    false    226   �      J          0    86776 
   correo_cli 
   TABLE DATA               C   COPY public.correo_cli (id_cliente, id_correo, correo) FROM stdin;
    public       postgres    false    237   <�      =          0    86591 
   correo_emp 
   TABLE DATA               D   COPY public.correo_emp (id_empleado, id_correo, correo) FROM stdin;
    public       postgres    false    224   ��      9          0    86541    direccion_viv 
   TABLE DATA               K   COPY public.direccion_viv (id_vivero, id_direccion, direccion) FROM stdin;
    public       postgres    false    220   �      %          0    86391    empleado_r1 
   TABLE DATA               ~   COPY public.empleado_r1 (id_empleado, curp, nombre, apellido_paterno, apellido_materno, fecha_de_nacimiento, rfc) FROM stdin;
    public       postgres    false    200   ��      $          0    86386    empleado_r2 
   TABLE DATA               V   COPY public.empleado_r2 (curp, salario, fecha_inicio_servicio, direccion) FROM stdin;
    public       postgres    false    199   [�      @          0    86631 	   germinado 
   TABLE DATA               H   COPY public.germinado (id_semillas, id_semillas_germinadas) FROM stdin;
    public       postgres    false    227   �      5          0    86511    pago_e 
   TABLE DATA               9   COPY public.pago_e (id_pago_e, tipo_de_pago) FROM stdin;
    public       postgres    false    216   @�      4          0    86506    pago_f 
   TABLE DATA               9   COPY public.pago_f (id_pago_f, tipo_de_pago) FROM stdin;
    public       postgres    false    215   w�      ,          0    86441 
   plantas_r1 
   TABLE DATA               ^   COPY public.plantas_r1 (id_planta, nombre, fechas_de_riego, fecha_de_germinacion) FROM stdin;
    public       postgres    false    207   ��      +          0    86436 
   plantas_r2 
   TABLE DATA               G   COPY public.plantas_r2 (nombre, precio, numero_de_plantas) FROM stdin;
    public       postgres    false    206   R�      F          0    86721 
   registra_e 
   TABLE DATA               G   COPY public.registra_e (id_ventas_electronicas, id_pago_e) FROM stdin;
    public       postgres    false    233   �      E          0    86706 
   registra_f 
   TABLE DATA               @   COPY public.registra_f (id_venta_fisica, id_pago_f) FROM stdin;
    public       postgres    false    232   �      :          0    86551 	   registrar 
   TABLE DATA               ;   COPY public.registrar (id_vivero, id_registro) FROM stdin;
    public       postgres    false    221   7�      #          0    86376    registro_r1 
   TABLE DATA               B   COPY public.registro_r1 (id_registro, genero, nombre) FROM stdin;
    public       postgres    false    198   b�      "          0    86371    registro_r2 
   TABLE DATA               y   COPY public.registro_r2 (genero, fecha_de_adquisicion, ultimo_riego, ultimo_fertilizante, ultima_fumigacion) FROM stdin;
    public       postgres    false    197   ��      &          0    86401    rol 
   TABLE DATA               2   COPY public.rol (id_rol, tipo_de_rol) FROM stdin;
    public       postgres    false    201   4�      *          0    86426    semillas_germinadas_r1 
   TABLE DATA               e   COPY public.semillas_germinadas_r1 (id_semillas_germinadas, origen, semillas_germinadas) FROM stdin;
    public       postgres    false    205   ��      )          0    86421    semillas_germinadas_r2 
   TABLE DATA               �   COPY public.semillas_germinadas_r2 (origen, fecha_de_siembra, ultimo_riego, ultimo_fertilizante, ultima_fumigacion) FROM stdin;
    public       postgres    false    204   ɽ      (          0    86411    semillas_r1 
   TABLE DATA               C   COPY public.semillas_r1 (id_semillas, planta_de_cruce) FROM stdin;
    public       postgres    false    203   �      '          0    86406    semillas_r2 
   TABLE DATA               c   COPY public.semillas_r2 (planta_de_cruce, fecha_de_polinizacion, cantidad_de_semillas) FROM stdin;
    public       postgres    false    202   P�      I          0    86766    telefono_cli 
   TABLE DATA               I   COPY public.telefono_cli (id_cliente, id_telefono, telefono) FROM stdin;
    public       postgres    false    236   ��      <          0    86581    telefono_emp 
   TABLE DATA               J   COPY public.telefono_emp (id_empleado, id_telefono, telefono) FROM stdin;
    public       postgres    false    223   ��      8          0    86531    telefono_viv 
   TABLE DATA               H   COPY public.telefono_viv (id_vivero, id_telefono, telefono) FROM stdin;
    public       postgres    false    219   9�      >          0    86601 	   tiene_emp 
   TABLE DATA               8   COPY public.tiene_emp (id_empleado, id_rol) FROM stdin;
    public       postgres    false    225   ��      A          0    86646 	   tiene_pla 
   TABLE DATA               9   COPY public.tiene_pla (id_vivero, id_planta) FROM stdin;
    public       postgres    false    228   ��      .          0    86456    tipo_de_planta_r1 
   TABLE DATA               a   COPY public.tipo_de_planta_r1 (id_tipo_de_planta, nombre_del_tipo_de_planta, genero) FROM stdin;
    public       postgres    false    209   Կ      -          0    86451    tipo_de_planta_r2 
   TABLE DATA               j   COPY public.tipo_de_planta_r2 (nombre_del_tipo_de_planta, cuidados_basicos, tipo_de_sustrato) FROM stdin;
    public       postgres    false    208   *�      ;          0    86566    trabajar 
   TABLE DATA               :   COPY public.trabajar (id_vivero, id_empleado) FROM stdin;
    public       postgres    false    222   O�      D          0    86691    venta_e 
   TABLE DATA               D   COPY public.venta_e (id_vivero, id_ventas_electronicas) FROM stdin;
    public       postgres    false    231   x�      C          0    86676    venta_f 
   TABLE DATA               =   COPY public.venta_f (id_vivero, id_venta_fisica) FROM stdin;
    public       postgres    false    230   ��      1          0    86481    venta_fisica_r1 
   TABLE DATA               �   COPY public.venta_fisica_r1 (id_venta_fisica, numero_ticket, codigo_cliente, clave_producto, fecha_venta_f, id_empleado_que_ayudo_a_cliente, empleado_que_efectuo_el_cobro, vivero_donde_se_adquirio, forma_de_pago) FROM stdin;
    public       postgres    false    212   ��      0          0    86471    venta_fisica_r2 
   TABLE DATA               y   COPY public.venta_fisica_r2 (numero_ticket, clave_producto, numero_de_productos_adquiridos, total_productos) FROM stdin;
    public       postgres    false    211   2�      /          0    86466    venta_fisica_r3 
   TABLE DATA               [   COPY public.venta_fisica_r3 (clave_producto, nombre_producto, precio_producto) FROM stdin;
    public       postgres    false    210   t�      3          0    86496    ventas_electronicas_r1 
   TABLE DATA               �   COPY public.ventas_electronicas_r1 (id_ventas_electronicas, numero_de_seguimiento, fecha_venta_e, codigo_cliente, nombre, apellido_paterno, apellido_materno, numero_de_productos, desglose_de_productos_adquiridos, precio_a_pagar) FROM stdin;
    public       postgres    false    214   ��      2          0    86491    ventas_electronicas_r2 
   TABLE DATA               �   COPY public.ventas_electronicas_r2 (numero_de_seguimiento, direccion_de_envio, fecha_de_pedido, forma_de_pago, total) FROM stdin;
    public       postgres    false    213   ��      !          0    86366    vivero 
   TABLE DATA               F   COPY public.vivero (id_vivero, nombre, fecha_de_apertura) FROM stdin;
    public       postgres    false    196   l�      m           2606    86665    area area_pk 
   CONSTRAINT     d   ALTER TABLE ONLY public.area
    ADD CONSTRAINT area_pk PRIMARY KEY (id_planta, id_tipo_de_planta);
 6   ALTER TABLE ONLY public.area DROP CONSTRAINT area_pk;
       public         postgres    false    229    229            W           2606    86525    cliente_r1 cliente_pk 
   CONSTRAINT     [   ALTER TABLE ONLY public.cliente_r1
    ADD CONSTRAINT cliente_pk PRIMARY KEY (id_cliente);
 ?   ALTER TABLE ONLY public.cliente_r1 DROP CONSTRAINT cliente_pk;
       public         postgres    false    218            U           2606    86520    cliente_r2 cliente_r2_pk 
   CONSTRAINT     b   ALTER TABLE ONLY public.cliente_r2
    ADD CONSTRAINT cliente_r2_pk PRIMARY KEY (codigo_cliente);
 B   ALTER TABLE ONLY public.cliente_r2 DROP CONSTRAINT cliente_r2_pk;
       public         postgres    false    217            y           2606    86755    comprar_tipo_e comprar_e_pk 
   CONSTRAINT     y   ALTER TABLE ONLY public.comprar_tipo_e
    ADD CONSTRAINT comprar_e_pk PRIMARY KEY (id_ventas_electronicas, id_cliente);
 E   ALTER TABLE ONLY public.comprar_tipo_e DROP CONSTRAINT comprar_e_pk;
       public         postgres    false    235    235            w           2606    86740     comprar_tipo_f comprar_tipo_f_pk 
   CONSTRAINT     w   ALTER TABLE ONLY public.comprar_tipo_f
    ADD CONSTRAINT comprar_tipo_f_pk PRIMARY KEY (id_venta_fisica, id_cliente);
 J   ALTER TABLE ONLY public.comprar_tipo_f DROP CONSTRAINT comprar_tipo_f_pk;
       public         postgres    false    234    234            g           2606    86620    controlar controlar_pk 
   CONSTRAINT     j   ALTER TABLE ONLY public.controlar
    ADD CONSTRAINT controlar_pk PRIMARY KEY (id_empleado, id_semillas);
 @   ALTER TABLE ONLY public.controlar DROP CONSTRAINT controlar_pk;
       public         postgres    false    226    226            }           2606    86780    correo_cli correo_cli_pk 
   CONSTRAINT     i   ALTER TABLE ONLY public.correo_cli
    ADD CONSTRAINT correo_cli_pk PRIMARY KEY (id_correo, id_cliente);
 B   ALTER TABLE ONLY public.correo_cli DROP CONSTRAINT correo_cli_pk;
       public         postgres    false    237    237            c           2606    86595    correo_emp correo_emp_pk 
   CONSTRAINT     j   ALTER TABLE ONLY public.correo_emp
    ADD CONSTRAINT correo_emp_pk PRIMARY KEY (id_correo, id_empleado);
 B   ALTER TABLE ONLY public.correo_emp DROP CONSTRAINT correo_emp_pk;
       public         postgres    false    224    224            [           2606    86545    direccion_viv direccion_viv_pk 
   CONSTRAINT     q   ALTER TABLE ONLY public.direccion_viv
    ADD CONSTRAINT direccion_viv_pk PRIMARY KEY (id_direccion, id_vivero);
 H   ALTER TABLE ONLY public.direccion_viv DROP CONSTRAINT direccion_viv_pk;
       public         postgres    false    220    220            3           2606    86395    empleado_r1 empleado_r1_pk 
   CONSTRAINT     a   ALTER TABLE ONLY public.empleado_r1
    ADD CONSTRAINT empleado_r1_pk PRIMARY KEY (id_empleado);
 D   ALTER TABLE ONLY public.empleado_r1 DROP CONSTRAINT empleado_r1_pk;
       public         postgres    false    200            1           2606    86390    empleado_r2 empleado_r2_pk 
   CONSTRAINT     Z   ALTER TABLE ONLY public.empleado_r2
    ADD CONSTRAINT empleado_r2_pk PRIMARY KEY (curp);
 D   ALTER TABLE ONLY public.empleado_r2 DROP CONSTRAINT empleado_r2_pk;
       public         postgres    false    199            i           2606    86635    germinado germinado_pk 
   CONSTRAINT     u   ALTER TABLE ONLY public.germinado
    ADD CONSTRAINT germinado_pk PRIMARY KEY (id_semillas, id_semillas_germinadas);
 @   ALTER TABLE ONLY public.germinado DROP CONSTRAINT germinado_pk;
       public         postgres    false    227    227            S           2606    86515    pago_e pago_e_pk 
   CONSTRAINT     U   ALTER TABLE ONLY public.pago_e
    ADD CONSTRAINT pago_e_pk PRIMARY KEY (id_pago_e);
 :   ALTER TABLE ONLY public.pago_e DROP CONSTRAINT pago_e_pk;
       public         postgres    false    216            Q           2606    86510    pago_f pago_f_pk 
   CONSTRAINT     U   ALTER TABLE ONLY public.pago_f
    ADD CONSTRAINT pago_f_pk PRIMARY KEY (id_pago_f);
 :   ALTER TABLE ONLY public.pago_f DROP CONSTRAINT pago_f_pk;
       public         postgres    false    215            A           2606    86445    plantas_r1 plantas_r1_pk 
   CONSTRAINT     ]   ALTER TABLE ONLY public.plantas_r1
    ADD CONSTRAINT plantas_r1_pk PRIMARY KEY (id_planta);
 B   ALTER TABLE ONLY public.plantas_r1 DROP CONSTRAINT plantas_r1_pk;
       public         postgres    false    207            ?           2606    86440    plantas_r2 plantas_r2_pk 
   CONSTRAINT     Z   ALTER TABLE ONLY public.plantas_r2
    ADD CONSTRAINT plantas_r2_pk PRIMARY KEY (nombre);
 B   ALTER TABLE ONLY public.plantas_r2 DROP CONSTRAINT plantas_r2_pk;
       public         postgres    false    206            u           2606    86725    registra_e registra_e_pk 
   CONSTRAINT     u   ALTER TABLE ONLY public.registra_e
    ADD CONSTRAINT registra_e_pk PRIMARY KEY (id_ventas_electronicas, id_pago_e);
 B   ALTER TABLE ONLY public.registra_e DROP CONSTRAINT registra_e_pk;
       public         postgres    false    233    233            s           2606    86710    registra_f registra_f_pk 
   CONSTRAINT     n   ALTER TABLE ONLY public.registra_f
    ADD CONSTRAINT registra_f_pk PRIMARY KEY (id_venta_fisica, id_pago_f);
 B   ALTER TABLE ONLY public.registra_f DROP CONSTRAINT registra_f_pk;
       public         postgres    false    232    232            ]           2606    86555    registrar registrar_pk 
   CONSTRAINT     h   ALTER TABLE ONLY public.registrar
    ADD CONSTRAINT registrar_pk PRIMARY KEY (id_registro, id_vivero);
 @   ALTER TABLE ONLY public.registrar DROP CONSTRAINT registrar_pk;
       public         postgres    false    221    221            /           2606    86380    registro_r1 registro_r1_pk 
   CONSTRAINT     a   ALTER TABLE ONLY public.registro_r1
    ADD CONSTRAINT registro_r1_pk PRIMARY KEY (id_registro);
 D   ALTER TABLE ONLY public.registro_r1 DROP CONSTRAINT registro_r1_pk;
       public         postgres    false    198            -           2606    86375    registro_r2 registro_r2_pk 
   CONSTRAINT     \   ALTER TABLE ONLY public.registro_r2
    ADD CONSTRAINT registro_r2_pk PRIMARY KEY (genero);
 D   ALTER TABLE ONLY public.registro_r2 DROP CONSTRAINT registro_r2_pk;
       public         postgres    false    197            5           2606    86405 
   rol rol_pk 
   CONSTRAINT     L   ALTER TABLE ONLY public.rol
    ADD CONSTRAINT rol_pk PRIMARY KEY (id_rol);
 4   ALTER TABLE ONLY public.rol DROP CONSTRAINT rol_pk;
       public         postgres    false    201            =           2606    86430 0   semillas_germinadas_r1 semillas_germinadas_r1_pk 
   CONSTRAINT     �   ALTER TABLE ONLY public.semillas_germinadas_r1
    ADD CONSTRAINT semillas_germinadas_r1_pk PRIMARY KEY (id_semillas_germinadas);
 Z   ALTER TABLE ONLY public.semillas_germinadas_r1 DROP CONSTRAINT semillas_germinadas_r1_pk;
       public         postgres    false    205            ;           2606    86425 0   semillas_germinadas_r2 semillas_germinadas_r2_pk 
   CONSTRAINT     r   ALTER TABLE ONLY public.semillas_germinadas_r2
    ADD CONSTRAINT semillas_germinadas_r2_pk PRIMARY KEY (origen);
 Z   ALTER TABLE ONLY public.semillas_germinadas_r2 DROP CONSTRAINT semillas_germinadas_r2_pk;
       public         postgres    false    204            9           2606    86415    semillas_r1 semillas_r1_pk 
   CONSTRAINT     a   ALTER TABLE ONLY public.semillas_r1
    ADD CONSTRAINT semillas_r1_pk PRIMARY KEY (id_semillas);
 D   ALTER TABLE ONLY public.semillas_r1 DROP CONSTRAINT semillas_r1_pk;
       public         postgres    false    203            7           2606    86410    semillas_r2 semillas_r2_pk 
   CONSTRAINT     e   ALTER TABLE ONLY public.semillas_r2
    ADD CONSTRAINT semillas_r2_pk PRIMARY KEY (planta_de_cruce);
 D   ALTER TABLE ONLY public.semillas_r2 DROP CONSTRAINT semillas_r2_pk;
       public         postgres    false    202            {           2606    86770    telefono_cli telefono_cli_pk 
   CONSTRAINT     o   ALTER TABLE ONLY public.telefono_cli
    ADD CONSTRAINT telefono_cli_pk PRIMARY KEY (id_telefono, id_cliente);
 F   ALTER TABLE ONLY public.telefono_cli DROP CONSTRAINT telefono_cli_pk;
       public         postgres    false    236    236            a           2606    86585    telefono_emp telefono_emp_pk 
   CONSTRAINT     p   ALTER TABLE ONLY public.telefono_emp
    ADD CONSTRAINT telefono_emp_pk PRIMARY KEY (id_telefono, id_empleado);
 F   ALTER TABLE ONLY public.telefono_emp DROP CONSTRAINT telefono_emp_pk;
       public         postgres    false    223    223            Y           2606    86535    telefono_viv telefono_viv_pk 
   CONSTRAINT     n   ALTER TABLE ONLY public.telefono_viv
    ADD CONSTRAINT telefono_viv_pk PRIMARY KEY (id_telefono, id_vivero);
 F   ALTER TABLE ONLY public.telefono_viv DROP CONSTRAINT telefono_viv_pk;
       public         postgres    false    219    219            e           2606    86605    tiene_emp tiene_emp_pk 
   CONSTRAINT     e   ALTER TABLE ONLY public.tiene_emp
    ADD CONSTRAINT tiene_emp_pk PRIMARY KEY (id_empleado, id_rol);
 @   ALTER TABLE ONLY public.tiene_emp DROP CONSTRAINT tiene_emp_pk;
       public         postgres    false    225    225            k           2606    86650    tiene_pla tiene_pla_pk 
   CONSTRAINT     f   ALTER TABLE ONLY public.tiene_pla
    ADD CONSTRAINT tiene_pla_pk PRIMARY KEY (id_vivero, id_planta);
 @   ALTER TABLE ONLY public.tiene_pla DROP CONSTRAINT tiene_pla_pk;
       public         postgres    false    228    228            E           2606    86460 &   tipo_de_planta_r1 tipo_de_planta_r1_pk 
   CONSTRAINT     s   ALTER TABLE ONLY public.tipo_de_planta_r1
    ADD CONSTRAINT tipo_de_planta_r1_pk PRIMARY KEY (id_tipo_de_planta);
 P   ALTER TABLE ONLY public.tipo_de_planta_r1 DROP CONSTRAINT tipo_de_planta_r1_pk;
       public         postgres    false    209            C           2606    86455 &   tipo_de_planta_r2 tipo_de_planta_r2_pk 
   CONSTRAINT     {   ALTER TABLE ONLY public.tipo_de_planta_r2
    ADD CONSTRAINT tipo_de_planta_r2_pk PRIMARY KEY (nombre_del_tipo_de_planta);
 P   ALTER TABLE ONLY public.tipo_de_planta_r2 DROP CONSTRAINT tipo_de_planta_r2_pk;
       public         postgres    false    208            _           2606    86570    trabajar trabajar_pk 
   CONSTRAINT     f   ALTER TABLE ONLY public.trabajar
    ADD CONSTRAINT trabajar_pk PRIMARY KEY (id_empleado, id_vivero);
 >   ALTER TABLE ONLY public.trabajar DROP CONSTRAINT trabajar_pk;
       public         postgres    false    222    222            q           2606    86695    venta_e venta_e_pk 
   CONSTRAINT     o   ALTER TABLE ONLY public.venta_e
    ADD CONSTRAINT venta_e_pk PRIMARY KEY (id_vivero, id_ventas_electronicas);
 <   ALTER TABLE ONLY public.venta_e DROP CONSTRAINT venta_e_pk;
       public         postgres    false    231    231            o           2606    86680    venta_f venta_f_pk 
   CONSTRAINT     h   ALTER TABLE ONLY public.venta_f
    ADD CONSTRAINT venta_f_pk PRIMARY KEY (id_vivero, id_venta_fisica);
 <   ALTER TABLE ONLY public.venta_f DROP CONSTRAINT venta_f_pk;
       public         postgres    false    230    230            K           2606    86485 "   venta_fisica_r1 venta_fisica_r1_pk 
   CONSTRAINT     m   ALTER TABLE ONLY public.venta_fisica_r1
    ADD CONSTRAINT venta_fisica_r1_pk PRIMARY KEY (id_venta_fisica);
 L   ALTER TABLE ONLY public.venta_fisica_r1 DROP CONSTRAINT venta_fisica_r1_pk;
       public         postgres    false    212            I           2606    86475 "   venta_fisica_r2 venta_fisica_r2_pk 
   CONSTRAINT     {   ALTER TABLE ONLY public.venta_fisica_r2
    ADD CONSTRAINT venta_fisica_r2_pk PRIMARY KEY (numero_ticket, clave_producto);
 L   ALTER TABLE ONLY public.venta_fisica_r2 DROP CONSTRAINT venta_fisica_r2_pk;
       public         postgres    false    211    211            G           2606    86470 "   venta_fisica_r3 venta_fisica_r3_pk 
   CONSTRAINT     l   ALTER TABLE ONLY public.venta_fisica_r3
    ADD CONSTRAINT venta_fisica_r3_pk PRIMARY KEY (clave_producto);
 L   ALTER TABLE ONLY public.venta_fisica_r3 DROP CONSTRAINT venta_fisica_r3_pk;
       public         postgres    false    210            O           2606    86500 0   ventas_electronicas_r1 ventas_electronicas_r1_pk 
   CONSTRAINT     �   ALTER TABLE ONLY public.ventas_electronicas_r1
    ADD CONSTRAINT ventas_electronicas_r1_pk PRIMARY KEY (id_ventas_electronicas);
 Z   ALTER TABLE ONLY public.ventas_electronicas_r1 DROP CONSTRAINT ventas_electronicas_r1_pk;
       public         postgres    false    214            M           2606    86495 0   ventas_electronicas_r2 ventas_electronicas_r2_pk 
   CONSTRAINT     �   ALTER TABLE ONLY public.ventas_electronicas_r2
    ADD CONSTRAINT ventas_electronicas_r2_pk PRIMARY KEY (numero_de_seguimiento);
 Z   ALTER TABLE ONLY public.ventas_electronicas_r2 DROP CONSTRAINT ventas_electronicas_r2_pk;
       public         postgres    false    213            +           2606    86370    vivero vivero_pk 
   CONSTRAINT     U   ALTER TABLE ONLY public.vivero
    ADD CONSTRAINT vivero_pk PRIMARY KEY (id_vivero);
 :   ALTER TABLE ONLY public.vivero DROP CONSTRAINT vivero_pk;
       public         postgres    false    196            �           2606    86930    area area_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public.area
    ADD CONSTRAINT area_fk1 FOREIGN KEY (id_planta) REFERENCES public.plantas_r1(id_planta) ON DELETE CASCADE;
 7   ALTER TABLE ONLY public.area DROP CONSTRAINT area_fk1;
       public       postgres    false    2881    207    229            �           2606    86935    area area_fk2    FK CONSTRAINT     �   ALTER TABLE ONLY public.area
    ADD CONSTRAINT area_fk2 FOREIGN KEY (id_tipo_de_planta) REFERENCES public.tipo_de_planta_r1(id_tipo_de_planta) ON DELETE CASCADE;
 7   ALTER TABLE ONLY public.area DROP CONSTRAINT area_fk2;
       public       postgres    false    2885    209    229            �           2606    86823    cliente_r1 cliente_r1_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public.cliente_r1
    ADD CONSTRAINT cliente_r1_fk1 FOREIGN KEY (codigo_cliente) REFERENCES public.cliente_r2(codigo_cliente) ON DELETE CASCADE;
 C   ALTER TABLE ONLY public.cliente_r1 DROP CONSTRAINT cliente_r1_fk1;
       public       postgres    false    218    2901    217            �           2606    86990    comprar_tipo_e comprar_e_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public.comprar_tipo_e
    ADD CONSTRAINT comprar_e_fk1 FOREIGN KEY (id_ventas_electronicas) REFERENCES public.ventas_electronicas_r1(id_ventas_electronicas) ON DELETE CASCADE;
 F   ALTER TABLE ONLY public.comprar_tipo_e DROP CONSTRAINT comprar_e_fk1;
       public       postgres    false    214    2895    235            �           2606    86995    comprar_tipo_e comprar_e_fk3    FK CONSTRAINT     �   ALTER TABLE ONLY public.comprar_tipo_e
    ADD CONSTRAINT comprar_e_fk3 FOREIGN KEY (id_cliente) REFERENCES public.cliente_r1(id_cliente) ON DELETE CASCADE;
 F   ALTER TABLE ONLY public.comprar_tipo_e DROP CONSTRAINT comprar_e_fk3;
       public       postgres    false    235    218    2903            �           2606    86980 !   comprar_tipo_f comprar_tipo_f_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public.comprar_tipo_f
    ADD CONSTRAINT comprar_tipo_f_fk1 FOREIGN KEY (id_venta_fisica) REFERENCES public.venta_fisica_r1(id_venta_fisica) ON DELETE CASCADE;
 K   ALTER TABLE ONLY public.comprar_tipo_f DROP CONSTRAINT comprar_tipo_f_fk1;
       public       postgres    false    234    2891    212            �           2606    86985 !   comprar_tipo_f comprar_tipo_f_fk2    FK CONSTRAINT     �   ALTER TABLE ONLY public.comprar_tipo_f
    ADD CONSTRAINT comprar_tipo_f_fk2 FOREIGN KEY (id_cliente) REFERENCES public.cliente_r1(id_cliente) ON DELETE CASCADE;
 K   ALTER TABLE ONLY public.comprar_tipo_f DROP CONSTRAINT comprar_tipo_f_fk2;
       public       postgres    false    234    2903    218            �           2606    86900    controlar controlar_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public.controlar
    ADD CONSTRAINT controlar_fk1 FOREIGN KEY (id_empleado) REFERENCES public.empleado_r1(id_empleado) ON DELETE CASCADE;
 A   ALTER TABLE ONLY public.controlar DROP CONSTRAINT controlar_fk1;
       public       postgres    false    2867    200    226            �           2606    86905    controlar controlar_fk2    FK CONSTRAINT     �   ALTER TABLE ONLY public.controlar
    ADD CONSTRAINT controlar_fk2 FOREIGN KEY (id_semillas) REFERENCES public.semillas_r1(id_semillas) ON DELETE CASCADE;
 A   ALTER TABLE ONLY public.controlar DROP CONSTRAINT controlar_fk2;
       public       postgres    false    2873    203    226            �           2606    87006    correo_cli correo_cli_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public.correo_cli
    ADD CONSTRAINT correo_cli_fk1 FOREIGN KEY (id_cliente) REFERENCES public.cliente_r1(id_cliente) ON DELETE CASCADE;
 C   ALTER TABLE ONLY public.correo_cli DROP CONSTRAINT correo_cli_fk1;
       public       postgres    false    2903    237    218            �           2606    86884    correo_emp correo_emp_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public.correo_emp
    ADD CONSTRAINT correo_emp_fk1 FOREIGN KEY (id_empleado) REFERENCES public.empleado_r1(id_empleado) ON DELETE CASCADE;
 C   ALTER TABLE ONLY public.correo_emp DROP CONSTRAINT correo_emp_fk1;
       public       postgres    false    224    2867    200            �           2606    86853    direccion_viv direccion_viv_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public.direccion_viv
    ADD CONSTRAINT direccion_viv_fk1 FOREIGN KEY (id_vivero) REFERENCES public.vivero(id_vivero) ON DELETE CASCADE;
 I   ALTER TABLE ONLY public.direccion_viv DROP CONSTRAINT direccion_viv_fk1;
       public       postgres    false    2859    196    220                       2606    86806    empleado_r1 empleado_r1_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public.empleado_r1
    ADD CONSTRAINT empleado_r1_fk1 FOREIGN KEY (curp) REFERENCES public.empleado_r2(curp) ON DELETE CASCADE;
 E   ALTER TABLE ONLY public.empleado_r1 DROP CONSTRAINT empleado_r1_fk1;
       public       postgres    false    199    200    2865            �           2606    86910    germinado germinado_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public.germinado
    ADD CONSTRAINT germinado_fk1 FOREIGN KEY (id_semillas) REFERENCES public.semillas_r1(id_semillas) ON DELETE CASCADE;
 A   ALTER TABLE ONLY public.germinado DROP CONSTRAINT germinado_fk1;
       public       postgres    false    227    2873    203            �           2606    86915    germinado germinado_fk2    FK CONSTRAINT     �   ALTER TABLE ONLY public.germinado
    ADD CONSTRAINT germinado_fk2 FOREIGN KEY (id_semillas_germinadas) REFERENCES public.semillas_germinadas_r1(id_semillas_germinadas) ON DELETE CASCADE;
 A   ALTER TABLE ONLY public.germinado DROP CONSTRAINT germinado_fk2;
       public       postgres    false    2877    205    227            �           2606    86794    plantas_r1 plantas_r1_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public.plantas_r1
    ADD CONSTRAINT plantas_r1_fk1 FOREIGN KEY (nombre) REFERENCES public.plantas_r2(nombre) ON DELETE CASCADE;
 C   ALTER TABLE ONLY public.plantas_r1 DROP CONSTRAINT plantas_r1_fk1;
       public       postgres    false    207    206    2879            �           2606    86970    registra_e registra_e_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public.registra_e
    ADD CONSTRAINT registra_e_fk1 FOREIGN KEY (id_ventas_electronicas) REFERENCES public.ventas_electronicas_r1(id_ventas_electronicas) ON DELETE CASCADE;
 C   ALTER TABLE ONLY public.registra_e DROP CONSTRAINT registra_e_fk1;
       public       postgres    false    214    2895    233            �           2606    86975    registra_e registra_e_fk2    FK CONSTRAINT     �   ALTER TABLE ONLY public.registra_e
    ADD CONSTRAINT registra_e_fk2 FOREIGN KEY (id_pago_e) REFERENCES public.pago_e(id_pago_e) ON DELETE CASCADE;
 C   ALTER TABLE ONLY public.registra_e DROP CONSTRAINT registra_e_fk2;
       public       postgres    false    2899    216    233            �           2606    86960    registra_f registra_f_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public.registra_f
    ADD CONSTRAINT registra_f_fk1 FOREIGN KEY (id_venta_fisica) REFERENCES public.venta_fisica_r1(id_venta_fisica) ON DELETE CASCADE;
 C   ALTER TABLE ONLY public.registra_f DROP CONSTRAINT registra_f_fk1;
       public       postgres    false    232    212    2891            �           2606    86965    registra_f registra_f_fk2    FK CONSTRAINT     �   ALTER TABLE ONLY public.registra_f
    ADD CONSTRAINT registra_f_fk2 FOREIGN KEY (id_pago_f) REFERENCES public.pago_f(id_pago_f) ON DELETE CASCADE;
 C   ALTER TABLE ONLY public.registra_f DROP CONSTRAINT registra_f_fk2;
       public       postgres    false    232    2897    215            �           2606    86858    registrar registrar_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public.registrar
    ADD CONSTRAINT registrar_fk1 FOREIGN KEY (id_vivero) REFERENCES public.vivero(id_vivero) ON DELETE CASCADE;
 A   ALTER TABLE ONLY public.registrar DROP CONSTRAINT registrar_fk1;
       public       postgres    false    2859    196    221            �           2606    86863    registrar registrar_fk2    FK CONSTRAINT     �   ALTER TABLE ONLY public.registrar
    ADD CONSTRAINT registrar_fk2 FOREIGN KEY (id_registro) REFERENCES public.registro_r1(id_registro) ON DELETE CASCADE;
 A   ALTER TABLE ONLY public.registrar DROP CONSTRAINT registrar_fk2;
       public       postgres    false    198    221    2863            ~           2606    87012    registro_r1 registro_r1_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public.registro_r1
    ADD CONSTRAINT registro_r1_fk1 FOREIGN KEY (genero) REFERENCES public.registro_r2(genero) ON DELETE CASCADE;
 E   ALTER TABLE ONLY public.registro_r1 DROP CONSTRAINT registro_r1_fk1;
       public       postgres    false    198    197    2861            �           2606    86811 1   semillas_germinadas_r1 semillas_germinadas_r1_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public.semillas_germinadas_r1
    ADD CONSTRAINT semillas_germinadas_r1_fk1 FOREIGN KEY (origen) REFERENCES public.semillas_germinadas_r2(origen) ON DELETE CASCADE;
 [   ALTER TABLE ONLY public.semillas_germinadas_r1 DROP CONSTRAINT semillas_germinadas_r1_fk1;
       public       postgres    false    204    2875    205            �           2606    86817    semillas_r1 semillas_r1_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public.semillas_r1
    ADD CONSTRAINT semillas_r1_fk1 FOREIGN KEY (planta_de_cruce) REFERENCES public.semillas_r2(planta_de_cruce) ON DELETE CASCADE;
 E   ALTER TABLE ONLY public.semillas_r1 DROP CONSTRAINT semillas_r1_fk1;
       public       postgres    false    202    203    2871            �           2606    87000    telefono_cli telefono_cli_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public.telefono_cli
    ADD CONSTRAINT telefono_cli_fk1 FOREIGN KEY (id_cliente) REFERENCES public.cliente_r1(id_cliente) ON DELETE CASCADE;
 G   ALTER TABLE ONLY public.telefono_cli DROP CONSTRAINT telefono_cli_fk1;
       public       postgres    false    236    218    2903            �           2606    86878    telefono_emp telefono_emp_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public.telefono_emp
    ADD CONSTRAINT telefono_emp_fk1 FOREIGN KEY (id_empleado) REFERENCES public.empleado_r1(id_empleado) ON DELETE CASCADE;
 G   ALTER TABLE ONLY public.telefono_emp DROP CONSTRAINT telefono_emp_fk1;
       public       postgres    false    2867    223    200            �           2606    86847    telefono_viv telefono_viv_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public.telefono_viv
    ADD CONSTRAINT telefono_viv_fk1 FOREIGN KEY (id_vivero) REFERENCES public.vivero(id_vivero) ON DELETE CASCADE;
 G   ALTER TABLE ONLY public.telefono_viv DROP CONSTRAINT telefono_viv_fk1;
       public       postgres    false    219    196    2859            �           2606    86890    tiene_emp tiene_emp_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public.tiene_emp
    ADD CONSTRAINT tiene_emp_fk1 FOREIGN KEY (id_empleado) REFERENCES public.empleado_r1(id_empleado) ON DELETE CASCADE;
 A   ALTER TABLE ONLY public.tiene_emp DROP CONSTRAINT tiene_emp_fk1;
       public       postgres    false    2867    200    225            �           2606    86895    tiene_emp tiene_emp_fk2    FK CONSTRAINT     �   ALTER TABLE ONLY public.tiene_emp
    ADD CONSTRAINT tiene_emp_fk2 FOREIGN KEY (id_rol) REFERENCES public.rol(id_rol) ON DELETE CASCADE;
 A   ALTER TABLE ONLY public.tiene_emp DROP CONSTRAINT tiene_emp_fk2;
       public       postgres    false    2869    201    225            �           2606    86920    tiene_pla tiene_pla_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public.tiene_pla
    ADD CONSTRAINT tiene_pla_fk1 FOREIGN KEY (id_vivero) REFERENCES public.vivero(id_vivero) ON DELETE CASCADE;
 A   ALTER TABLE ONLY public.tiene_pla DROP CONSTRAINT tiene_pla_fk1;
       public       postgres    false    228    2859    196            �           2606    86925    tiene_pla tiene_pla_fk2    FK CONSTRAINT     �   ALTER TABLE ONLY public.tiene_pla
    ADD CONSTRAINT tiene_pla_fk2 FOREIGN KEY (id_planta) REFERENCES public.plantas_r1(id_planta) ON DELETE CASCADE;
 A   ALTER TABLE ONLY public.tiene_pla DROP CONSTRAINT tiene_pla_fk2;
       public       postgres    false    2881    207    228            �           2606    86787 '   tipo_de_planta_r1 tipo_de_planta_r1_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public.tipo_de_planta_r1
    ADD CONSTRAINT tipo_de_planta_r1_fk1 FOREIGN KEY (nombre_del_tipo_de_planta) REFERENCES public.tipo_de_planta_r2(nombre_del_tipo_de_planta) ON DELETE CASCADE;
 Q   ALTER TABLE ONLY public.tipo_de_planta_r1 DROP CONSTRAINT tipo_de_planta_r1_fk1;
       public       postgres    false    2883    208    209            �           2606    86868    trabajar trabajar_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public.trabajar
    ADD CONSTRAINT trabajar_fk1 FOREIGN KEY (id_vivero) REFERENCES public.vivero(id_vivero) ON DELETE CASCADE;
 ?   ALTER TABLE ONLY public.trabajar DROP CONSTRAINT trabajar_fk1;
       public       postgres    false    196    2859    222            �           2606    86873    trabajar trabajar_fk2    FK CONSTRAINT     �   ALTER TABLE ONLY public.trabajar
    ADD CONSTRAINT trabajar_fk2 FOREIGN KEY (id_empleado) REFERENCES public.empleado_r1(id_empleado) ON DELETE CASCADE;
 ?   ALTER TABLE ONLY public.trabajar DROP CONSTRAINT trabajar_fk2;
       public       postgres    false    200    222    2867            �           2606    86950    venta_e venta_e_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public.venta_e
    ADD CONSTRAINT venta_e_fk1 FOREIGN KEY (id_vivero) REFERENCES public.vivero(id_vivero) ON DELETE CASCADE;
 =   ALTER TABLE ONLY public.venta_e DROP CONSTRAINT venta_e_fk1;
       public       postgres    false    231    196    2859            �           2606    86955    venta_e venta_e_fk2    FK CONSTRAINT     �   ALTER TABLE ONLY public.venta_e
    ADD CONSTRAINT venta_e_fk2 FOREIGN KEY (id_ventas_electronicas) REFERENCES public.ventas_electronicas_r1(id_ventas_electronicas) ON DELETE CASCADE;
 =   ALTER TABLE ONLY public.venta_e DROP CONSTRAINT venta_e_fk2;
       public       postgres    false    231    214    2895            �           2606    86940    venta_f venta_f_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public.venta_f
    ADD CONSTRAINT venta_f_fk1 FOREIGN KEY (id_vivero) REFERENCES public.vivero(id_vivero) ON DELETE CASCADE;
 =   ALTER TABLE ONLY public.venta_f DROP CONSTRAINT venta_f_fk1;
       public       postgres    false    2859    196    230            �           2606    86945    venta_f venta_f_fk2    FK CONSTRAINT     �   ALTER TABLE ONLY public.venta_f
    ADD CONSTRAINT venta_f_fk2 FOREIGN KEY (id_venta_fisica) REFERENCES public.venta_fisica_r1(id_venta_fisica) ON DELETE CASCADE;
 =   ALTER TABLE ONLY public.venta_f DROP CONSTRAINT venta_f_fk2;
       public       postgres    false    2891    212    230            �           2606    86835 #   venta_fisica_r1 venta_fisica_r1_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public.venta_fisica_r1
    ADD CONSTRAINT venta_fisica_r1_fk1 FOREIGN KEY (clave_producto, numero_ticket) REFERENCES public.venta_fisica_r2(clave_producto, numero_ticket) ON DELETE CASCADE;
 M   ALTER TABLE ONLY public.venta_fisica_r1 DROP CONSTRAINT venta_fisica_r1_fk1;
       public       postgres    false    212    211    211    212    2889            �           2606    86829 #   venta_fisica_r2 venta_fisica_r2_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public.venta_fisica_r2
    ADD CONSTRAINT venta_fisica_r2_fk1 FOREIGN KEY (clave_producto) REFERENCES public.venta_fisica_r3(clave_producto) ON DELETE CASCADE;
 M   ALTER TABLE ONLY public.venta_fisica_r2 DROP CONSTRAINT venta_fisica_r2_fk1;
       public       postgres    false    2887    210    211            �           2606    86842 1   ventas_electronicas_r1 ventas_electronicas_r1_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public.ventas_electronicas_r1
    ADD CONSTRAINT ventas_electronicas_r1_fk1 FOREIGN KEY (numero_de_seguimiento) REFERENCES public.ventas_electronicas_r2(numero_de_seguimiento) ON DELETE CASCADE;
 [   ALTER TABLE ONLY public.ventas_electronicas_r1 DROP CONSTRAINT ventas_electronicas_r1_fk1;
       public       postgres    false    214    2893    213            B   '   x�3�4�2b#N#.3 6�4�2bN. ����� Uuy      7   �   x�-�A
�@�=��Bb�}I "����6da�+cr�_�?fD��>Up�\�뚏8��f)�Jt�AmJ���k��f��{>�n%���.�̠m�
�BCK�G��8��e�GS��D�&���3KW��mL8.��m���~�H�nE�p�9e      6   7  x���1N�0��>�;@]=��I<Z�����`�X��@$+)M�Zn���r1�NE,]��O��ɤ֩@)� �Ba}_{�N`�>��`}9���O`���j�r��C]�,�saIS��P�%p&0f�`^ە�׮�]���w;W��v�|��1ǯ3�XeH��[�M$D�J�b�������������M ���V@8U�K�,׈R��n7��2#!S&�(n`5����ʖf�%��1q�N���D�f��8��poC��2�V'�P�F��O+�p��d���۝Ҫ�`㎮S��������6�BkTDO��)���ő�      H      x�3�4�2�4�2�4����� �      G      x�3�4�2�4�2�4����� A      ?      x�3�4�2�4�2�4����� A      J   d   x�3�4������/H�rH�M���K���2�4�tw��/*�D6�4�tt�wO,J�LD7�4����0ŔӔ3�%>(?7�(I܌ӌ��9ޫ4�E}� ��,�      =   B   x�3�4�ts�-�LJuH�M���K���2�4���w�����ID�0�4��v���J,F����� u��      9   x   x�3�4�42PpN��SJM��Q��O�����I��QpN�SHIU�=��"39�ˈӈ���B! 19�49(��XP�S�Z����ؘӘ��H�,��WZ\�������(1�
�� �)1z\\\ k.4!      %   �   x�-�A��0 ���)�@'��0�e������M�.j�&'qn5g�bb��#�_&O%R���`
�;������o�0���4�r�@���a�e1��Z+�����m�
���zpg;�� Y�0X���׾�����w�����t	��m�R�$(�M���HP�K����?h��^�A	Ną��5 �H��d?��'.7�      $   �   x�mν
�0�9y�<@#��?cl�+���KZ�K0T�Oour9p��qdQVBX���XBNr  �1G$Qʤ�	�4�,k7��%`E���JJ)"HAԪ��_9�3��lo�s�F����6"�UV��!!����"d���T����y�W{���G9-(�/p7Q      @      x�3�4�2bcN#. ����� u�      5   '   x�3�I,�J-ITHIUpIM�,��2�"f�E,F��� ��      4      x�3�tMKM.�,��2B0��=... ��      ,   �   x�e�A�0��u�^`�L)-]��%p�X��RB���b���d��},.n�!�;u��m�d�O�T!Y��ss��ob�%J��� +�D;����G�$�U�RȌ�%�0���2���m�މ���)@&�?Q_�R���A�"�������ߢ� ^s�E�      +   �   x�U�;
�0�Y:EO�����)}�.���8����LZ��c��$e^�e�{fv4�sy�V��1��r��Ο��Z��dI�(떕�����t. WS�^x.)P�x��R n��-��HO�;D���8      F      x�3�4�2�4�2�4����� A      E      x�3�4�2�4�2�4����� A      :      x�3�4�2�4�2�4b�=... ��      #   N   x�3��H,�/*��L�JM�,.)�W0�2�tO,.I-B5�2�t�
2*KJs�\&��E��ɉE��q�=... m� 	      "   d   x��H,�/*��L�4200�50�54D0�LK$&�{bqIj�&#���i�uM��\��%E��%����A,3�"#s$&�cQf~rbQAi1I�b���� �a/c      &   Q   x�3�tO-J�+IU�,K-��2�t.�LIL�/RHIU�I�+I,�2�tN�I�p��%'���s�K��
��b���� ��'      *   $   x�3�t�M-�LN�460�2�tLsLL�b���� �h      )   F   x�s�M-�LN�4����5 "s�R��H���D5�rL�i��54�54�4200�50�L$&W� ���      (   !   x�3�t3�2�t3�2�t3�2�t3����� 1I�      '   >   x�s3�4����50�50�445�r3�X�X��@D��"F�FƜ�@���XM� �J      I   H   x�5���0��RL>�q/鿎 #_�f
���.;�V�\>����b
�,ZΒȻ4��="���u      <   3   x�%ȱ  ��=)	��/�<�0m��H�����P�yc��<�	p      8   7   x�%�� 1�7�� ��K����k�F�K��j.��e�la�F���0	�      >      x�3�4�2�4�2�4����� A      A      x�3�4�2�4�2�4b�=... ��      .   F   x�3��H,�/*��LD���8��KR���0�1�cqIQ~AFeIi.2�˄ӱ(3?9���������� n�!#      -     x�mS͎�0>7O1n� `�Vp��ԞM]9v��˖��pXq�H^��N%�v�4M�d��|��Y�!�&��i�1y�����X#+I�Y��'Q�vJyK��B:�v��JL�:�{&�q��ؖ$�U+�%�	@��Ǻ%NE:�)G���̺�`�U��f�cW�Q�T��,ي��o��_��z��R�5�f;f% ɑ|PqZ\N'IA@�@��~��;ŉ�^ս#^��m��f��� B%eü���8�Xa�"�1��R	��K�|ȹy�����rU��#�_~����p.u��D@8V��3삔`H/�>7T#��au
mgΞw�dV��	�c���)���9Iz�ĳǞ����˄�&
��WG�a���<z4W<��i�L��Ů�Y�4j�m�]u���9�M�F�r7�i�h�\����-�Eh�#��w�]D��-�|�Z��k�Ve��
2�k���� �8�z�~K~h��	��U`տ6�M����\H3_�\��|�7��		�ؖ��n����d�      ;      x�3�4�2�4�2�4����� A      D      x�3�4�2�4�2�4����� A      C      x�3�4�2�4�2�4����� A      1   X   x�=�;
�0���]V�#h��h��N�l��ӎB��-�`"��,�j��㽿�����ڄ�gUXњ��[��)��:������~��      0   2   x�3��p�4�445�2�܁<#N3.c �18�Ӑ��Ȁ+F��� ��T      /   h   x�Uʱ@0 ���c��`�T���IR�V��ku���h줂N���Y5�)}����R���_�W�(rP �g����MR�k�h.�vּr���X�2D��Q0o      3   �   x���1
1D��)<��$�d��AA��m>��F��x+��Ō �(��o����Z���V#:,H�&�6���5��<Vt�p�#a�0>�`��}3}��G�a�-iJ<�|d�X&��E<_$�՟�Δ'W�V5h>O�E��$C��JR�ōwe���T}+���N��J�'r�Q�      2   �   x���;�0Dk�{ ���rR�P�,����p$j����PQ�@�fgv�'�����A����5j���k�M%���D0��'B�#�/&���نhJ��B)ũ ���1���C��v�qf$�y�4#������[w��i<T�z�~յ��9:�3t�O�X_�SJ)� |�V`      !   P   x�3��,K-�Wp�Q���4200�50�54�2�I�8*���9*�$u,t͹����C�\}|A�F�ƺ�\1z\\\  %-     