// Script Power Query para crear la tabla de dimensión de fecha personalizada (dimFecha)
// Usa dos parámetros definidos en Power Query que permiten acotar el rango de fechas para el análisis.
// Adaptado de: https://radacad.com/all-in-one-script-to-create-date-dimension-in-power-bi-using-power-query
let
    // Configuraciones iniciales
    Hoy=Date.From(DateTime.LocalNow()), // fecha de hoy
    FechaInicio = RangoFechaInicial, // Utiliza el parámetro para la fecha de inicio
    FechaFin = RangoFechaFinal, // Utiliza el parámetro para la fecha de fin
    InicioAñoFiscal=7, // Mes de inicio del año fiscal
    PrimerDiaSemana=Day.Monday, // Primer día de la semana
    // Fin configuraciones
    RangoFechas=List.Dates(
        FechaInicio,
        Duration.Days(FechaFin-FechaInicio)+1,
        #duration(1,0,0,0)
    ),
    #"Convertida a Tabla" = Table.FromList(RangoFechas, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
    #"Columnas Renombradas" = Table.RenameColumns(#"Convertida a Tabla",{{"Column1", "Fecha"}}),
    #"Tipo Cambiado" = Table.TransformColumnTypes(#"Columnas Renombradas",{{"Fecha", type date}}),
    #"Año Insertado" = Table.AddColumn(#"Tipo Cambiado", "Año", each Date.Year([Fecha]), Int64.Type),
    #"Inicio de Año" = Table.AddColumn(#"Año Insertado", "Inicio de Año", each Date.StartOfYear([Fecha]), type date),
    #"Fin de Año" = Table.AddColumn(#"Inicio de Año", "Fin de Año", each Date.EndOfYear([Fecha]), type date),
    #"Mes Insertado" = Table.AddColumn(#"Fin de Año", "Mes", each Date.Month([Fecha]), Int64.Type),
    #"Inicio de Mes" = Table.AddColumn(#"Mes Insertado", "Inicio de Mes", each Date.StartOfMonth([Fecha]), type date),
    #"Fin de Mes" = Table.AddColumn(#"Inicio de Mes", "Fin de Mes", each Date.EndOfMonth([Fecha]), type date),
    #"Días en el Mes" = Table.AddColumn(#"Fin de Mes", "Días en el Mes", each Date.DaysInMonth([Fecha]), Int64.Type),
    #"Día Insertado" = Table.AddColumn(#"Días en el Mes", "Día", each Date.Day([Fecha]), Int64.Type),
    #"Nombre del Día" = Table.AddColumn(#"Día Insertado", "Nombre del Día", each Date.DayOfWeekName([Fecha]), type text),
    #"Día de la Semana" = Table.AddColumn(#"Nombre del Día", "Día de la Semana", each Date.DayOfWeek([Fecha], PrimerDiaSemana), Int64.Type),
    #"Día del Año" = Table.AddColumn(#"Día de la Semana", "Día del Año", each Date.DayOfYear([Fecha]), Int64.Type),
    #"Nombre del Mes" = Table.AddColumn(#"Día del Año", "Nombre del Mes", each Date.MonthName([Fecha]), type text),
    #"Trimestre Insertado" = Table.AddColumn(#"Nombre del Mes", "Trimestre", each Date.QuarterOfYear([Fecha]), Int64.Type),
    #"Inicio de Trimestre" = Table.AddColumn(#"Trimestre Insertado", "Inicio de Trimestre", each Date.StartOfQuarter([Fecha]), type date),
    #"Fin de Trimestre" = Table.AddColumn(#"Inicio de Trimestre", "Fin de Trimestre", each Date.EndOfQuarter([Fecha]), type date),
    #"Semana del Año" = Table.AddColumn(#"Fin de Trimestre", "Semana del Año", each Date.WeekOfYear([Fecha], PrimerDiaSemana), Int64.Type),
    #"Semana del Mes" = Table.AddColumn(#"Semana del Año", "Semana del Mes", each Date.WeekOfMonth([Fecha], PrimerDiaSemana), Int64.Type),
    #"Inicio de Semana" = Table.AddColumn(#"Semana del Mes", "Inicio de Semana", each Date.StartOfWeek([Fecha], PrimerDiaSemana), type date),
    #"Fin de Semana" = Table.AddColumn(#"Inicio de Semana", "Fin de Semana", each Date.EndOfWeek([Fecha], PrimerDiaSemana), type date),
    BaseMesFiscal=13-InicioAñoFiscal,
    AjusteBaseMesFiscal=if(BaseMesFiscal>=12 or BaseMesFiscal<0) then 0 else BaseMesFiscal,
    #"Personalizada Añadida" = Table.AddColumn(#"Fin de Semana", "FechaBaseFiscal", each Date.AddMonths([Fecha],AjusteBaseMesFiscal)),
    #"Tipo Cambiado1" = Table.TransformColumnTypes(#"Personalizada Añadida",{{"FechaBaseFiscal", type date}}),
    #"Año Fiscal Insertado" = Table.AddColumn(#"Tipo Cambiado1", "Año Fiscal", each Date.Year([FechaBaseFiscal]), Int64.Type),
    #"Trimestre Fiscal Insertado" = Table.AddColumn(#"Año Fiscal Insertado", "Trimestre Fiscal", each Date.QuarterOfYear([FechaBaseFiscal]), Int64.Type),
    #"Mes Fiscal Insertado" = Table.AddColumn(#"Trimestre Fiscal Insertado", "Mes Fiscal", each Date.Month([FechaBaseFiscal]), Int64.Type),
    #"Columnas Eliminadas" = Table.RemoveColumns(#"Mes Fiscal Insertado",{"FechaBaseFiscal"}),
    #"Edad Añadida" = Table.AddColumn(#"Columnas Eliminadas", "Edad", each [Fecha]-Hoy, type duration),
    #"Días Extraídos" = Table.TransformColumns(#"Edad Añadida",{{"Edad", Duration.Days, Int64.Type}}),
    #"Offset Día Añadido" = Table.AddColumn(#"Días Extraídos", "Desplazamiento Día", each [Fecha]-Hoy, type duration),
    #"Offset Mes Añadido" = Table.AddColumn(#"Offset Día Añadido", "Desplazamiento Mes", each (([Año]-Date.Year(Hoy))*12)+([Mes]-Date.Month(Hoy))),
    #"Offset Año Añadido" = Table.AddColumn(#"Offset Mes Añadido", "Desplazamiento Año", each [Año]-Date.Year(Hoy)),
    #"Offset Trimestre Añadido" = Table.AddColumn(#"Offset Año Añadido", "Desplazamiento Trimestre", each (([Año]-Date.Year(Hoy))*4)+([Trimestre]-Date.QuarterOfYear(Hoy))),
    #"Mes-Año Añadido" = Table.AddColumn(#"Offset Trimestre Añadido", "Mes-Año", each Date.ToText([Fecha],"MMM yyyy")),
    #"Código Mes-Año Añadido" = Table.AddColumn(#"Mes-Año Añadido", "Código Mes-Año", each Date.ToText([Fecha],"yyyyMM")),
    #"Tipo Cambiado5" = Table.TransformColumnTypes(#"Código Mes-Año Añadido",{{"Mes-Año", type text}, {"Código Mes-Año", Int64.Type}})
in
    #"Tipo Cambiado5"