-- Definición de vistas. Capa intermedia de abstracción entre Power BI y GestDoc.
-- Formateadas para una mejor lectura a través de ChatGPT

CREATE VIEW [dbo].[GDvEntradasSalidas]
AS
SELECT 
    Id, 
    Numero, 
    TipoReg, 
    Principal, 
    Fecha, 
    TipoDocumento, 
    FechaDocumento, 
    Referencia, 
    DirigidoA, 
    Interesado, 
    Representado, 
    Relacionado, 
    Usuario, 
    Cerrado, 
    Departamento, 
    TipoExpediente, 
    Materia, 
    DirEntrada, 
    DirNotificacion, 
    ClaseRegistro, 
    FCambioEstado, 
    OcultoWeb, 
    FormaEntrega, 
    Referencia2, 
    ClaseRegistroWeb, 
    FCambioFACe, 
    FCambioEstadoAnterior, 
    CASE 
        WHEN [IdOriginal] IS NULL THEN 'No' 
        ELSE 'Si' 
    END AS EsEnlace, 
    IdOriginal
FROM 
    [SRV-SQL].GestDocSQL.dbo.EntradasSalidas AS EntradasSalidas_1
WHERE 
    (OcultoGD = 0) AND (Principal > 2017)
GO

CREATE VIEW [dbo].[GDvClaseRegistro]
AS
SELECT 
    Id, 
    Nombre, 
    IdTipoReg
FROM 
    [SRV-SQL].GestDocSQL.dbo.ClaseRegistro AS ClaseRegistro_1
GO

CREATE VIEW [dbo].[GDvDepartamentos]
AS
SELECT 
    Id, 
    Nombre
FROM 
    [SRV-SQL].GestDocSQL.dbo.Departamentos AS Departamentos_1
GO

CREATE VIEW [dbo].[GDvDirigidoA]
AS
SELECT 
    Id, 
    Nombre, 
    TipoReg
FROM 
    [SRV-SQL].GestDocSQL.dbo.DirigidoA AS DirigidoA_1
GO

CREATE VIEW [dbo].[GDvLogAcceso]
AS
SELECT 
    LA.Id, 
    LA.Fecha, 
    LA.Tipo, 
    LA.Mensaje
FROM 
    [SRV-SQL].GestDocSQL.dbo.LogAcceso AS LA 
    INNER JOIN dbo.GDtTipoLogin AS TL ON TL.Id = LA.Tipo
GO

CREATE VIEW [dbo].[GDvMateriaExpedientes]
AS
SELECT 
    Id, 
    Nombre, 
    TipoRegistro, 
    RelMateria
FROM 
    [SRV-SQL].GestDocSQL.dbo.MateriaExpedientes AS MateriaExpedientes_1
GO

CREATE VIEW [dbo].[GDvNotifTel]
AS
SELECT 
    Id, 
    IdNotifSolicitud, 
    IdDocumento, 
    FechaAlta, 
    FechaRecepcion, 
    FechaRechazo, 
    Referencia
FROM 
    [SRV-SQL].GestDocSQL.dbo.NotifTel AS NotifTel_1
WHERE 
    (Referencia NOT LIKE 'MENSAJE DESARROLLO')
GO

CREATE VIEW [dbo].[GDvTipoDocumentos]
AS
SELECT 
    Id, 
    Nombre
FROM 
    [SRV-SQL].GestDocSQL.dbo.TipoDocumentos AS TipoDocumentos_1
GO

CREATE VIEW [dbo].[GDvTipoExpedientes]
AS
SELECT 
    Id, 
    Nombre, 
    Departamento, 
    Usuario, 
    Materia, 
    Registro, 
    Activo, 
    VisibleWeb
FROM 
    [SRV-SQL].GestDocSQL.dbo.TipoExpedientes AS TipoExpedientes_1
GO

CREATE VIEW [dbo].[GDvTipoReg]
AS
SELECT 
    TR.Id, 
    TR.Nombre, 
    TR.TipoEntr, 
    TE.Descripcion AS DescripcionEntrada, 
    TR.Contador, 
    TR.WebPublico, 
    TR.EsDeOficio, 
    TR.SalidasDemoradas, 
    TR.IdDocumentoDef, 
    TR.EsDeUnLibro
FROM 
    [SRV-SQL].GestDocSQL.dbo.TipoReg AS TR 
    LEFT OUTER JOIN dbo.GDtTipoEntrada AS
