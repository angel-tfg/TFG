-- Instrucciones para la creación de de un usuario con el mínimo privilegio (solo lectura)
-- Creará un usuario para el logado y lo añadirá al rol de db_reader.
-- Con esto conseguimos que únicamente tenga acceso a la base de datos objetivo y en modo lectura.

-- Instrucciones para servidor que aloja la base de datos de origen
USE <Base de datos origen>;
CREATE LOGIN <usuario_readOnly> WITH PASSWORD = '<Password>';
CREATE USER <usuario_readOnly> FOR LOGIN <usuario_readOnly>;
ALTER ROLE [db_datareader] ADD MEMBER [<usuario_readOnly>];

-- Instrucciones para servidor que aloja las vistas
EXEC sp_addlinkedsrvlogin
    @rmtsrvname = '<Servidor que aloja la base de datos origen>',
    @useself = 'FALSE',
    @rmtuser = '<usuario_readOnly>',
    @rmtpassword = '<Password>';