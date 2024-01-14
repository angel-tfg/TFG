-- Definiciones de tablas de dimensión auxiliares, complementan la solución añadiendo contexto. 
-- Por defecto, estos parámetros son almacenandos en el propio GestDoc y no en la base de datos, 
-- se requiere su creación para gestionar de forma más uniforme los datos recogidos por Power BI.
-- Formateadas para una mejor lectura a través de ChatGPT


-- Tabla GDtFormaEntrega
-- Crear la tabla
CREATE TABLE GDtFormaEntrega (
    Id INT PRIMARY KEY,
    Descripcion NVARCHAR(255)
);

-- Insertar los datos
INSERT INTO GDtFormaEntrega (Id, Descripcion) VALUES
    (0, 'No especificada'),
    (1, 'BuroFAX'),
    (2, 'Mensajería'),
    (3, 'FAX'),
    (4, 'Correo Certificado'),
    (5, 'Correo Electrónico'),
    (6, 'Correo Ordinario'),
    (7, 'En Mano'),
    (8, 'ORVE'),
    (9, 'Notificacion Telematica'),
    (10, 'Correo administrativo'),
    (11, 'Gestdoc'),
    (12, 'Web'),
    (13, 'Ventanilla Unica'),
    (14, 'Telegrama'),
    (15, 'Tramite Telematico');

-- Tabla GDtTipoEntrada
-- Crear la tabla
CREATE TABLE GDtTipoEntrada (
    Id INT PRIMARY KEY,
    Descripcion NVARCHAR(255)
);

-- Insertar los datos
INSERT INTO GDtTipoEntrada (Id, Descripcion) VALUES
    (0, 'Entradas'),
    (1, 'Salidas'),
    (2, 'Expedientes');

-- Tabla GDtTipoLogin
-- Crear la tabla
CREATE TABLE GDtTipoLogin (
    Id INT PRIMARY KEY,
    Descripcion NVARCHAR(255)
);

-- Insertar los datos
INSERT INTO GDtTipoLogin (Id, Descripcion) VALUES
    (30, 'Registro con certificado'),
    (2, 'Login'),
    (45, 'Consulta padrón'),
    (47, 'Consulta datos personales'),
    (53, 'Guardando tercero'),
    (5, 'Generar volante padrón'),
    (61, 'Consulta notificación'),
    (70, 'Consulta tablón - anuncio'),
    (71, 'Consulta tablón'),
    (9, 'Notificacion Telematica'),
    (500, 'Acceso GDWeb'),
    (13, 'Consulta entradas'),
    (14, 'Consulta salidas'),
    (15, 'Consulta expediente');
