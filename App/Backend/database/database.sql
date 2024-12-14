-- CREAR BASE DE DATOS NEWGOAL

CREATE DATABASE NEWGOAL WITH
    OWNER = postgres                    -- PROPIETARIO DE LA BADE DE DATOS
    ENCODING = 'UTF8'                   -- CODIFICACION DE LOS CARACTERES
    LC_COLLATE = 'Spanish_Spain.1252'   -- LOCALIZACION DE COLLACION
    LC_CTYPE = 'Spanish_Spain.1252'     -- LOCALIZACION DE TIPO DE CARACTERES
    LOCALE_PROVIDER = 'libc'            -- PROVEDOR DE LOCALIZACION
    TABLESPACE = pg_default             -- TABLESPACE PREDETERMINADO
    CONNECTION LIMIT = -1               -- ESTABLECE LIMITE DE CONECCIONES
    IS_TEMPLATE = False;                -- PERMITIR CREACION DE PLANTILLAS

/*          CREACION DE TABLAS        */

CREATE TABLE TBL_ESTUDIANTE (
    ID_ETD SERIAL PRIMARY KEY,          -- Clave primaria autoincremental
    ID_RT INTEGER,                      --FK REPRESENTANTE
    ID_ESTADO INTEGER,                  --FK ESTADO
    ID_DISCD INTEGER,                   --FK DISCAPACIDAD
    ID_GENERO INTEGER,                  --FK GENERO
    ID_NV_EDU INTEGER,                  --FK NIVEL EDUCACION
    ID_NCD INTEGER,                     --FK NACIONALIDAD
    ID_NIVEL_INGLES INTEGER,            --FK NIVEL INGLES
    NOMBRE_ETD VARCHAR(100) NOT NULL,
    APELLIDO_ETD VARCHAR(100) NOT NULL,
    FECHA_NACIMIENTO_ETD DATE,
    CEDULA_ETD VARCHAR(50),
    DIRECCION_ETD VARCHAR(100),
    TELEFONO_ETD VARCHAR(50),
    CORREO_ETD VARCHAR(100),
    CONTACTO_EMERGENCIA_ETD VARCHAR(50),
    QUIEN_RETIRA_ETD VARCHAR(100)
);

CREATE TABLE TBL_PAGO (
    ID_PAGO SERIAL PRIMARY KEY, -- Clave primaria autoincremental
    ID_ETD INTEGER NOT NULL,             --FK ESTUDIANTE
    ID_PERSONA INTEGER NOT NULL,         --FK PERSONA
    ID_METODO_PAGO INTEGER NOT NULL,     --FK METODO PAGO
    FCHA_PAGO DATE NOT NULL,
    MONTO_TOTAL_PAGO NUMERIC(10,2) NOT NULL,
    MONTO_CANCELADO_PAGO NUMERIC(10,2) NOT NULL,
    RENOVACION_PAGO DATE NOT NULL
);

CREATE TABLE TBL_REPRESENTANTE (
    ID_RT SERIAL PRIMARY KEY,                   -- Clave primaria autoincremental
    ID_RELACION INTEGER NOT NULL,                --FK RELACION
    ID_GENERO INTEGER NOT NULL,                  --FK GENERO
    CEDULA_RT VARCHAR(50) NOT NULL,
    NOMBRE_RT VARCHAR(100) NOT NULL,
    APELLIDO_RT VARCHAR(100) NOT NULL,
    DIRECCION_RT VARCHAR(100) NOT NULL,
    CORREO_RT VARCHAR(100) NOT NULL,
    TELEFONO_RT VARCHAR(50) NOT NULL
);

CREATE TABLE TBL_RELACION (
    ID_RELACION SERIAL PRIMARY KEY,
    NOMBRE_RELACION VARCHAR(100) NOT NULL
);

INSERT INTO TBL_RELACION (NOMBRE_RELACION) VALUES
    ('Padre'),
    ('Madre'),
    ('Abuelo'),
    ('Abuela'),
    ('Hermano'),
    ('Hermana'),
    ('Tio'),
    ('Tia'),
    ('Primo'),
    ('Prima'),
    ('Cuidador Principal'),
    ('Guardian Legal'),
    ('Padrastro'),
    ('Madrasta'),
    ('Otro');

CREATE TABLE TBL_DISCAPACIDAD (
    ID_DISCD SERIAL PRIMARY KEY,
    TIPO_DISCD VARCHAR(100) NOT NULL,
    NOMBRE_DISCD VARCHAR(100) NOT NULL
);

INSERT INTO TBL_DISCAPACIDAD (TIPO_DISCD, NOMBRE_DISCD) VALUES
    ('Discapacidad Física', 'Parálisis'),
    ('Discapacidad Física', 'Amputación'),
    ('Discapacidad Física', 'Espina bífida'),
    ('Discapacidad Física', 'Distonías'),
    ('Discapacidad Física', 'Esclerosis múltiple'),
    ('Discapacidad Sensorial', 'Ceguera total'),
    ('Discapacidad Sensorial', 'Baja visión'),
    ('Discapacidad Sensorial', 'Hipoacusia'),
    ('Discapacidad Sensorial', 'Sordera'),
    ('Discapacidad Sensorial', 'Sordoceguera'),
    ('Discapacidad Intelectual', 'Síndrome de Down'),
    ('Discapacidad Intelectual', 'Trastorno del desarrollo intelectual (TDI)'),
    ('Discapacidad Intelectual', 'Fenilcetonuria'),
    ('Discapacidad Psicosocial o Mental', 'Esquizofrenia'),
    ('Discapacidad Psicosocial o Mental', 'Trastorno bipolar'),
    ('Discapacidad Psicosocial o Mental', 'Depresión severa'),
    ('Discapacidad Psicosocial o Mental', 'Trastornos de ansiedad'),
    ('Discapacidad del Desarrollo', 'Autismo (TEA)'),
    ('Discapacidad del Desarrollo', 'Parálisis cerebral'),
    ('Discapacidad del Desarrollo', 'Síndrome de Rett'),
    ('Discapacidad Neurológica', 'Epilepsia'),
    ('Discapacidad Neurológica', 'Parkinson'),
    ('Discapacidad Neurológica', 'Lesión medular');


CREATE TABLE TBL_GENERO (
    ID_GENERO SERIAL PRIMARY KEY,
    NOMBRE_GENERO VARCHAR(100) NOT NULL
);

INSERT INTO TBL_GENERO (NOMBRE_GENERO) VALUES
    ('Hombre'),
    ('Mujer');

CREATE TABLE TBL_NIVEL_EDUCACION (
    ID_NV_EDU SERIAL PRIMARY KEY,
    TIPO_NV_EDU VARCHAR(100) NOT NULL,
    NOMBRE_NV_EDU VARCHAR(100) NOT NULL
);

INSERT INTO TBL_NIVEL_EDUCACION (TIPO_NV_EDU, NOMBRE_NV_EDU)
VALUES
    ('Educación Inicial', 'Maternal'),
    ('Educación Inicial', 'Preescolar'),
    ('Educación Primaria', 'Primer Grado'),
    ('Educación Primaria', 'Segundo Grado'),
    ('Educación Primaria', 'Tercer Grado'),
    ('Educación Primaria', 'Cuarto Grado'),
    ('Educación Primaria', 'Quinto Grado'),
    ('Educación Primaria', 'Sexto Grado'),
    ('Educación Media', 'Primer Año'),
    ('Educación Media', 'Segundo Año'),
    ('Educación Media', 'Tercer Año'),
    ('Educación Media', 'Cuarto Año'),
    ('Educación Media', 'Quinto Año'),
    ('Educación Media', 'Sexto Año'),
    ('Educación Media', 'Bachiller'),
    ('Educación Media', 'Tecnico Medio'),
    ('Educación Universitaria', 'Técnico Superior Universitario'),
    ('Educación Universitaria', 'Licenciatura'),
    ('Educación Universitaria', 'Ingeniería'),
    ('Educación Universitaria', 'Especialización'),
    ('Educación Universitaria', 'Maestría'),
    ('Educación Universitaria', 'Doctorado');


CREATE TABLE TBL_NACIONALIDAD (
    ID_NCD SERIAL PRIMARY KEY,
    NOMBRE_NCD VARCHAR(100) NOT NULL,
    CODIGO_NCD VARCHAR(50) NOT NULL
);

INSERT INTO TBL_NACIONALIDAD (NOMBRE_NCD, CODIGO_NCD)
VALUES
    ('Afganistán', 'AFG'),
    ('Albania', 'ALB'),
    ('Argelia', 'DZA'),
    ('Andorra', 'AND'),
    ('Angola', 'AGO'),
    ('Antigua y Barbuda', 'ATG'),
    ('Argentina', 'ARG'),
    ('Armenia', 'ARM'),
    ('Australia', 'AUS'),
    ('Austria', 'AUT'),
    ('Azerbaiyán', 'AZE'),
    ('Bahamas', 'BHS'),
    ('Baréin', 'BHR'),
    ('Bangladés', 'BGD'),
    ('Barbados', 'BRB'),
    ('Bielorrusia', 'BLR'),
    ('Bélgica', 'BEL'),
    ('Belice', 'BLZ'),
    ('Benín', 'BEN'),
    ('Bután', 'BTN'),
    ('Bolivia', 'BOL'),
    ('Bosnia y Herzegovina', 'BIH'),
    ('Botsuana', 'BWA'),
    ('Brasil', 'BRA'),
    ('Brunéi', 'BRN'),
    ('Bulgaria', 'BGR'),
    ('Burkina Faso', 'BFA'),
    ('Burundi', 'BDI'),
    ('Cabo Verde', 'CPV'),
    ('Camboya', 'KHM'),
    ('Camerún', 'CMR'),
    ('Canadá', 'CAN'),
    ('Chad', 'TCD'),
    ('Chile', 'CHL'),
    ('China', 'CHN'),
    ('Colombia', 'COL'),
    ('Comoras', 'COM'),
    ('Congo', 'COG'),
    ('Costa Rica', 'CRI'),
    ('Croacia', 'HRV'),
    ('Cuba', 'CUB'),
    ('Chipre', 'CYP'),
    ('República Checa', 'CZE'),
    ('Dinamarca', 'DNK'),
    ('Yibuti', 'DJI'),
    ('Dominica', 'DMA'),
    ('República Dominicana', 'DOM'),
    ('Ecuador', 'ECU'),
    ('Egipto', 'EGY'),
    ('El Salvador', 'SLV'),
    ('Guinea Ecuatorial', 'GNQ'),
    ('Eritrea', 'ERI'),
    ('Estonia', 'EST'),
    ('Eswatini', 'SWZ'),
    ('Etiopía', 'ETH'),
    ('Fiyi', 'FJI'),
    ('Finlandia', 'FIN'),
    ('Francia', 'FRA'),
    ('Gabón', 'GAB'),
    ('Gambia', 'GMB'),
    ('Georgia', 'GEO'),
    ('Alemania', 'DEU'),
    ('Ghana', 'GHA'),
    ('Grecia', 'GRC'),
    ('Granada', 'GRD'),
    ('Guatemala', 'GTM'),
    ('Guinea', 'GIN'),
    ('Guinea-Bisáu', 'GNB'),
    ('Guyana', 'GUY'),
    ('Haití', 'HTI'),
    ('Honduras', 'HND'),
    ('Hungría', 'HUN'),
    ('Islandia', 'ISL'),
    ('India', 'IND'),
    ('Indonesia', 'IDN'),
    ('Irán', 'IRN'),
    ('Irak', 'IRQ'),
    ('Irlanda', 'IRL'),
    ('Israel', 'ISR'),
    ('Italia', 'ITA'),
    ('Jamaica', 'JAM'),
    ('Japón', 'JPN'),
    ('Jordania', 'JOR'),
    ('Kazajistán', 'KAZ'),
    ('Kenia', 'KEN'),
    ('Kiribati', 'KIR'),
    ('Corea del Norte', 'PRK'),
    ('Corea del Sur', 'KOR'),
    ('Kosovo', 'UNK'),
    ('Kuwait', 'KWT'),
    ('Kirguistán', 'KGZ'),
    ('Laos', 'LAO'),
    ('Letonia', 'LVA'),
    ('Líbano', 'LBN'),
    ('Lesoto', 'LSO'),
    ('Liberia', 'LBR'),
    ('Libia', 'LBY'),
    ('Liechtenstein', 'LIE'),
    ('Lituania', 'LTU'),
    ('Luxemburgo', 'LUX'),
    ('Madagascar', 'MDG'),
    ('Malaui', 'MWI'),
    ('Malasia', 'MYS'),
    ('Maldivas', 'MDV'),
    ('Malí', 'MLI'),
    ('Malta', 'MLT'),
    ('Islas Marshall', 'MHL'),
    ('Mauritania', 'MRT'),
    ('Mauricio', 'MUS'),
    ('México', 'MEX'),
    ('Micronesia', 'FSM'),
    ('Moldavia', 'MDA'),
    ('Mónaco', 'MCO'),
    ('Mongolia', 'MNG'),
    ('Montenegro', 'MNE'),
    ('Marruecos', 'MAR'),
    ('Mozambique', 'MOZ'),
    ('Birmania', 'MMR'),
    ('Namibia', 'NAM'),
    ('Nauru', 'NRU'),
    ('Nepal', 'NPL'),
    ('Países Bajos', 'NLD'),
    ('Nueva Zelanda', 'NZL'),
    ('Nicaragua', 'NIC'),
    ('Níger', 'NER'),
    ('Nigeria', 'NGA'),
    ('Noruega', 'NOR'),
    ('Omán', 'OMN'),
    ('Pakistán', 'PAK'),
    ('Palaos', 'PLW'),
    ('Palestina', 'PSE'),
    ('Panamá', 'PAN'),
    ('Papúa Nueva Guinea', 'PNG'),
    ('Paraguay', 'PRY'),
    ('Perú', 'PER'),
    ('Filipinas', 'PHL'),
    ('Polonia', 'POL'),
    ('Portugal', 'PRT'),
    ('Catar', 'QAT'),
    ('Rumania', 'ROU'),
    ('Rusia', 'RUS'),
    ('Ruanda', 'RWA'),
    ('San Cristóbal y Nieves', 'KNA'),
    ('Santa Lucía', 'LCA'),
    ('San Vicente y las Granadinas', 'VCT'),
    ('Samoa', 'WSM'),
    ('San Marino', 'SMR'),
    ('Santo Tomé y Príncipe', 'STP'),
    ('Arabia Saudita', 'SAU'),
    ('Senegal', 'SEN'),
    ('Serbia', 'SRB'),
    ('Seychelles', 'SYC'),
    ('Sierra Leona', 'SLE'),
    ('Singapur', 'SGP'),
    ('Eslovaquia', 'SVK'),
    ('Eslovenia', 'SVN'),
    ('Islas Salomón', 'SLB'),
    ('Somalia', 'SOM'),
    ('Sudáfrica', 'ZAF'),
    ('Sudán del Sur', 'SSD'),
    ('España', 'ESP'),
    ('Sri Lanka', 'LKA'),
    ('Sudán', 'SDN'),
    ('Surinam', 'SUR'),
    ('Suecia', 'SWE'),
    ('Suiza', 'CHE'),
    ('Siria', 'SYR'),
    ('Tayikistán', 'TJK'),
    ('Tanzania', 'TZA'),
    ('Tailandia', 'THA'),
    ('Timor-Leste', 'TLS'),
    ('Togo', 'TGO'),
    ('Tonga', 'TON'),
    ('Trinidad y Tobago', 'TTO'),
    ('Túnez', 'TUN'),
    ('Turquía', 'TUR'),
    ('Turkmenistán', 'TKM'),
    ('Tuvalu', 'TUV'),
    ('Uganda', 'UGA'),
    ('Ucrania', 'UKR'),
    ('Emiratos Árabes Unidos', 'ARE'),
    ('Reino Unido', 'GBR'),
    ('Estados Unidos', 'USA'),
    ('Uruguay', 'URY'),
    ('Uzbekistán', 'UZB'),
    ('Vanuatu', 'VUT'),
    ('Vaticano', 'VAT'),
    ('Venezuela', 'VEN'),
    ('Vietnam', 'VNM'),
    ('Yemen', 'YEM'),
    ('Zambia', 'ZMB'),
    ('Zimbabue', 'ZWE');


CREATE TABLE TBL_NIVEL_INGLES (
    ID_NIVEL_INGLES SERIAL PRIMARY KEY,
    NOMBRE_NIVEL_INGLES VARCHAR(100) NOT NULL
);

INSERT INTO TBL_NIVEL_INGLES (NOMBRE_NIVEL_INGLES)
VALUES
    ('A1'),
    ('A2'),
    ('B1'),
    ('B2'),
    ('C1'),
    ('C2');


CREATE TABLE TBL_ALERGIA_ESTUDIANTE (
    ID_ALERGIA_ETD SERIAL PRIMARY KEY,      -- Clave primaria autoincremental
    ID_ETD INTEGER NOT NULL,                --FK ESTUDIANTE
    ID_ALERGIA INTEGER NOT NULL              --FK ALERGIA
);

CREATE TABLE TBL_ALERGIA (
    ID_ALERGIA SERIAL PRIMARY KEY,
    NOMBRE_ALERGIA VARCHAR(100) NOT NULL,
    SEVERIDAD_ALERGIA VARCHAR(100) NOT NULL
);

CREATE TABLE TBL_ESTADO (
    ID_ESTADO SERIAL PRIMARY KEY,
    NOMBRE_ESTADO VARCHAR(100) NOT NULL
);

INSERT INTO TBL_ESTADO (NOMBRE_ESTADO) VALUES
    ('Activo'),
    ('Inactivo');

CREATE TABLE TBL_PERIODO (
    ID_PERIODO SERIAL PRIMARY KEY,          -- Clave primaria autoincremental
    ID_PERSONA INTEGER NOT NULL,                     --FK PERSONA
    ID_ESTADO INTEGER NOT NULL,                      --FK ESTADO
    NOMBRE_PERIODO VARCHAR(100) NOT NULL,
    FECHA_INI_PERIODO DATE NOT NULL,
    FECHA_FIN_PERIODO DATE NOT NULL,
    YEAR_ACADEMICO INTEGER NOT NULL
);

CREATE TABLE TBL_INSCRIPCION (
    ID_INSCRIPCION SERIAL PRIMARY KEY,  -- Clave primaria autoincremental
    ID_ETD INTEGER NOT NULL,                     --FK ESTUDIANTE
    ID_NIVEL INTEGER NOT NULL,                   --FK NIVEL
    ID_PERIODO INTEGER NOT NULL,                 --FK PERIODO
    ID_PERSONA INTEGER NOT NULL,                 --FK PERSONA
    FECHA_INSCRIPCION DATE NOt NULL
);

CREATE TABLE TBL_NIVEL (
    ID_NIVEL SERIAL PRIMARY KEY,        -- Clave primaria autoincremental
    CATEGORIA_NIVEL VARCHAR(50) NOT NULL,
    NOMBRE_NIVEL VARCHAR(100) NOT NULL,
    DESCRIPCION_NIVEL VARCHAR(200),
    DURACION_NIVEL VARCHAR(50) NOT NULL
);

INSERT INTO TBL_NIVEL (CATEGORIA_NIVEL, NOMBRE_NIVEL, DURACION_NIVEL) VALUES 
    ('Adults','A-1','No Definido'),
    ('Adults','A-2','No Definido'),
    ('Adults','A-3','No Definido'),
    ('Adults','A-4','No Definido'),
    ('Adults','A-5','No Definido'),
    ('Adults','A-6','No Definido'),
    ('Little Starters','LS-1','No Definido'),
    ('Little Starters','LS-2','No Definido'),
    ('Little Starters','LS-3','No Definido'),
    ('Little Starters','LS-4','No Definido'),
    ('Little Starters','LS-5','No Definido'),
    ('Little Starters','LS-6','No Definido'),
    ('Pre-Teens & Teens','PT-T 1','No Definido'),
    ('Pre-Teens & Teens','PT-T 2','No Definido'),
    ('Pre-Teens & Teens','PT-T 3','No Definido'),
    ('Pre-Teens & Teens','PT-T 4','No Definido'),
    ('Pre-Teens & Teens','PT-T 5','No Definido'),
    ('Pre-Teens & Teens','PT-T 6','No Definido'),
    ('Kids','K-1','No Definido'),
    ('Kids','K-2','No Definido'),
    ('Kids','K-3','No Definido'),
    ('Kids','K-4','No Definido'),
    ('Kids','K-5','No Definido'),
    ('Kids','K-6','No Definido');


CREATE TABLE TBL_NOTA (
    ID_NOTA SERIAL PRIMARY KEY,     -- Clave primaria autoincremental
    ID_ETD INTEGER NOT NULL,                 --FK ESTUDIANTE
    ID_NIVEL INTEGER NOT NULL,               --FK NIVEL
    ID_PERIODO INTEGER NOT NULL,             --FK PERIODO
    ID_PERSONA INTEGER NOT NULL,             --FK PERSONA
    VALOR_NOTA VARCHAR(50) NOT NULL,
    FECHA_CREACION_NOTA DATE NOT NULL
);

CREATE TABLE TBL_PERSONA (
    ID_PERSONA SERIAL PRIMARY KEY,          -- Clave primaria autoincremental
    NOMBRE_PERSONA VARCHAR(100) NOT NULL,
    APELLIDO_PERSONA VARCHAR(100) NOT NULL,
    CEDULA_PERSONA VARCHAR(50) NOT NULL,
    CARGO_PERSONA VARCHAR(100) NOT NULL
);

CREATE TABLE TBL_METODO_PAGO (
    ID_METODO_PAGO SERIAL PRIMARY KEY,          -- Clave primaria autoincremental
    NOMBRE_METODO_PAGO VARCHAR(100) NOT NULL
);

INSERT INTO TBL_METODO_PAGO (NOMBRE_METODO_PAGO) VALUES
    ('Efectivo'),
    ('Pago Movil'),
    ('Transferencia'),
    ('Zelle'),
    ('Divisas');

CREATE TABLE TBL_GASTO (
    ID_GASTO SERIAL PRIMARY KEY,            -- Clave primaria autoincremental
    ID_PERSONA INTEGER NOT NULL,                    --FK PERSONA
    ID_METODO_PAGO INTEGER NOT NULL,                --FK METODO PAGO
    ID_TIPO_GASTO INTEGER,                          --FK TIPO GASTO
    NOMBRE_GASTO VARCHAR(100) NOT NULL,
    DESCRIPCION_GASTO VARCHAR(200),
    FECHA_GASTO DATE NOT NULL,
    CANTIDAD_GASTO NUMERIC(10,2) NOT NULL
);

CREATE TABLE TBL_TIPO_GASTO (
    ID_TIPO_GASTO SERIAL PRIMARY KEY,           -- Clave primaria autoincremental
    NOMBRE_TIPO_GASTO VARCHAR(100) NOT NULL
);

INSERT INTO TBL_TIPO_GASTO (NOMBRE_TIPO_GASTO) VALUES
    ('Limpeza'),
    ('Papeleria'),
    ('Infraestructura');

CREATE TABLE TBL_REGISTRO_MES (
    ID_REGISTRO_MES SERIAL PRIMARY KEY,             -- Clave primaria autoincremental
    ID_PERSONA INTEGER NOT NULL,                             --FK PERSONA
    TOTAL_REGISTRO_MES NUMERIC(10,2) NOT NULL,
    GANANCIA_REGISTRO_MES NUMERIC(10,2) NOT NULL,
    GASTOS_REGISTRO_MES NUMERIC(10,2) NOT NULL,
    FECHA_INI_REGISTRO_MES DATE NOT NULL,
    FECHA_FIN_REGISTRO_MES DATE NOT NULL
);

CREATE TABLE TBL_USUARIO (
    ID_USUARIO SERIAL PRIMARY KEY,          -- Clave primaria autoincremental
    NOMBRE_USUARIO VARCHAR(50) NOT NULL,
    PASSWORD_USUARIO VARCHAR(50) NOT NULL,
    ROL_USUARIO NUMERIC(2) NOT NULL
);

INSERT INTO TBL_USUARIO (NOMBRE_USUARIO, PASSWORD_USUARIO, ROL_USUARIO) VALUES
    ('admin', 'adminnewgoal', 1);


--          RELACIONES DE TABLA ESTUDIANTES(7)         --

ALTER TABLE TBL_ESTUDIANTE ADD
    FOREIGN KEY (ID_RT) REFERENCES TBL_REPRESENTANTE (ID_RT)
        ON DELETE SET NULL;
    
ALTER TABLE TBL_ESTUDIANTE ADD
    FOREIGN KEY (ID_ESTADO) REFERENCES TBL_ESTADO (ID_ESTADO)
        ON DELETE SET NULL;

ALTER TABLE TBL_ESTUDIANTE ADD
    FOREIGN KEY (ID_DISCD) REFERENCES TBL_DISCAPACIDAD (ID_DISCD)
        ON DELETE SET NULL;

ALTER TABLE TBL_ESTUDIANTE ADD
    FOREIGN KEY (ID_GENERO) REFERENCES TBL_GENERO (ID_GENERO)
        ON DELETE SET NULL;

ALTER TABLE TBL_ESTUDIANTE ADD
    FOREIGN KEY (ID_NV_EDU) REFERENCES TBL_NIVEL_EDUCACION (ID_NV_EDU)
        ON DELETE SET NULL;

ALTER TABLE TBL_ESTUDIANTE ADD
    FOREIGN KEY (ID_NCD) REFERENCES TBL_NACIONALIDAD (ID_NCD)
        ON DELETE SET NULL;

ALTER TABLE TBL_ESTUDIANTE ADD
    FOREIGN KEY (ID_NIVEL_INGLES) REFERENCES TBL_NIVEL_INGLES (ID_NIVEL_INGLES)
        ON DELETE SET NULL;

--          RELACION DE TABLA DE REPRESENTANTES(2)         --

ALTER TABLE TBL_REPRESENTANTE ADD
    FOREIGN KEY (ID_RELACION) REFERENCES TBL_RELACION (ID_RELACION)
        ON DELETE SET NULL;

ALTER TABLE TBL_REPRESENTANTE ADD
    FOREIGN KEY (ID_GENERO) REFERENCES TBL_GENERO (ID_GENERO)
        ON DELETE SET NULL;

--          RELACION DE TABLA PAGO(3)          --

ALTER TABLE TBL_PAGO ADD
    FOREIGN KEY (ID_ETD) REFERENCES TBL_ESTUDIANTE (ID_ETD)
        ON DELETE SET NULL;

ALTER TABLE TBL_PAGO ADD
    FOREIGN KEY (ID_PERSONA) REFERENCES TBL_PERSONA (ID_PERSONA)
        ON DELETE SET NULL;

ALTER TABLE TBL_PAGO ADD
    FOREIGN KEY (ID_METODO_PAGO) REFERENCES TBL_METODO_PAGO (ID_METODO_PAGO)
        ON DELETE SET NULL;

--          RELACION DE TABLA ALERGIAS ESTUDIANTE(2)           --

ALTER TABLE TBL_ALERGIA_ESTUDIANTE ADD
    FOREIGN KEY (ID_ETD) REFERENCES TBL_ESTUDIANTE (ID_ETD)
        ON DELETE SET NULL;

ALTER TABLE TBL_ALERGIA_ESTUDIANTE ADD
    FOREIGN KEY (ID_ALERGIA) REFERENCES TBL_ALERGIA (ID_ALERGIA)
        ON DELETE SET NULL;

--          RELACION DE LA TABLA PERIODO(2)            --

ALTER TABLE TBL_PERIODO ADD
    FOREIGN KEY (ID_PERSONA) REFERENCES TBL_PERSONA (ID_PERSONA)
        ON DELETE SET NULL;

ALTER TABLE TBL_PERIODO ADD
    FOREIGN KEY (ID_ESTADO) REFERENCES TBL_ESTADO (ID_ESTADO)
        ON DELETE SET NULL;

--          RELACIONDE DE LA TABLA INSCRIPCION(4)            --

ALTER TABLE TBL_INSCRIPCION ADD
    FOREIGN KEY (ID_ETD) REFERENCES TBL_ESTUDIANTE (ID_ETD)
        ON DELETE SET NULL;

ALTER TABLE TBL_INSCRIPCION ADD
    FOREIGN KEY (ID_NIVEL) REFERENCES TBL_NIVEL (ID_NIVEL)
        ON DELETE SET NULL;

ALTER TABLE TBL_INSCRIPCION ADD
    FOREIGN KEY (ID_PERIODO) REFERENCES TBL_PERIODO (ID_PERIODO)
        ON DELETE SET NULL;

ALTER TABLE TBL_INSCRIPCION ADD
    FOREIGN KEY (ID_PERSONA) REFERENCES TBL_PERSONA (ID_PERSONA)
        ON DELETE SET NULL;

--          RELACION DE LA TABLA NOTA(4)            --

ALTER TABLE TBL_NOTA ADD
    FOREIGN KEY (ID_ETD) REFERENCES TBL_ESTUDIANTE (ID_ETD)
        ON DELETE SET NULL;

ALTER TABLE TBL_NOTA ADD
    FOREIGN KEY (ID_NIVEL) REFERENCES TBL_NIVEL (ID_NIVEL)
        ON DELETE SET NULL;

ALTER TABLE TBL_NOTA ADD
    FOREIGN KEY (ID_PERIODO) REFERENCES TBL_PERIODO (ID_PERIODO)
        ON DELETE SET NULL;

ALTER TABLE TBL_NOTA ADD
    FOREIGN KEY (ID_PERSONA) REFERENCES TBL_PERSONA (ID_PERSONA)
        ON DELETE SET NULL;

--          RELACION DE LA TABLA REGISTRO MES(1)          --

ALTER TABLE TBL_REGISTRO_MES ADD
    FOREIGN KEY (ID_PERSONA) REFERENCES TBL_PERSONA (ID_PERSONA)
        ON DELETE SET NULL;

--          RELACION DE LA TABALA GASTO(3)         --

ALTER TABLE TBL_GASTO ADD
    FOREIGN KEY (ID_PERSONA) REFERENCES TBL_PERSONA (ID_PERSONA)
        ON DELETE SET NULL;

ALTER TABLE TBL_GASTO ADD
    FOREIGN KEY (ID_METODO_PAGO) REFERENCES TBL_METODO_PAGO (ID_METODO_PAGO)
        ON DELETE SET NULL;

ALTER TABLE TBL_GASTO ADD
    FOREIGN KEY (ID_TIPO_GASTO) REFERENCES TBL_TIPO_GASTO (ID_TIPO_GASTO)
        ON DELETE SET NULL;

--          OTRAS RELACIONES            --
