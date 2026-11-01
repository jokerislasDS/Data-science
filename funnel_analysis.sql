-- Análisis--atención al cliente
WITH Etapas AS (
    SELECT 
        id_usuario,
        MIN(CASE WHEN evento = 'inicio_sesion' THEN fecha_hora END) AS inicio,
        MIN(CASE WHEN evento = 'seleccion_menu' THEN fecha_hora END) AS seleccion,
        MIN(CASE WHEN evento = 'hablar_con_agente' THEN fecha_hora END) AS contacto,
        MIN(CASE WHEN evento = 'resolucion' THEN fecha_hora END) AS resolucion
    FROM eventos_usuarios
    GROUP BY id_usuario
)
SELECT 
    COUNT(inicio) AS usuarios_inicio,
    COUNT(seleccion) AS usuarios_seleccion,
    COUNT(contacto) AS usuarios_contacto,
    COUNT(resolucion) AS usuarios_resolucion,
    -- Calcular tasa de abandono entre etapas
    CAST((COUNT(inicio) - COUNT(resolucion)) * 100.0 / COUNT(inicio) AS DECIMAL(5,2)) AS tasa_abandono_total_porcentaje
FROM Etapas;