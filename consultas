#Entradas, salidas, expedientes por mes

SELECT 
    'ENTRADAS' as Tipo,
    YEAR(Fecha) AS Expr1,
    COUNT(GDvEntradasSalidas.Id) AS CuentaDeId,
    GDvTipoReg.TipoEntr AS TipoEntrada
FROM 
    GDvEntradasSalidas
JOIN 
    GDvTipoReg ON GDvEntradasSalidas.TipoReg = GDvTipoReg.Id
WHERE 
    MONTH(Fecha) = 1 AND GDvTipoReg.TipoEntr = 0
GROUP BY 
    YEAR(Fecha), GDvTipoReg.TipoEntr

UNION

SELECT 
    'SALIDAS' as Tipo,
    YEAR(Fecha) AS Expr1,
    COUNT(GDvEntradasSalidas.Id) AS CuentaDeId,
    GDvTipoReg.TipoEntr AS TipoEntrada
FROM 
    GDvEntradasSalidas
JOIN 
    GDvTipoReg ON GDvEntradasSalidas.TipoReg = GDvTipoReg.Id
WHERE 
    MONTH(Fecha) = 1 AND GDvTipoReg.TipoEntr = 1
GROUP BY 
    YEAR(Fecha), GDvTipoReg.TipoEntr

UNION

SELECT 'EXPEDIENTES' as Tipo,
    YEAR(Fecha) AS Expr1,
    COUNT(GDvEntradasSalidas.Id) AS CuentaDeId,
    GDvTipoReg.TipoEntr AS TipoEntrada
FROM 
    GDvEntradasSalidas
JOIN 
    GDvTipoReg ON GDvEntradasSalidas.TipoReg = GDvTipoReg.Id
WHERE 
    MONTH(Fecha) = 1 AND GDvTipoReg.TipoEntr = 2
GROUP BY 
    YEAR(Fecha), GDvTipoReg.TipoEntr

ORDER BY 1, 2

