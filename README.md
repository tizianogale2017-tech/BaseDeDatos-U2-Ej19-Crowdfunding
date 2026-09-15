# BaseDeDatos-U2-Ej19-Crowdfunding
Base de Datos - Unidad 2 - Ejercicio 19

Consigna

Modelar una plataforma de micromecenazgo: usuarios que actúan como creadores o inversores, proyectos con objetivo financiero y fechas de campaña, niveles de recompensa (tiers) y aportes de los inversores con la recompensa seleccionada.

Lógica

USUARIO como entidad única con roles, no dos entidades separadas. Creador e inversor no son tipos distintos de persona: son papeles que se cumplen según la relación en la que el usuario participa. Es creador cuando aparece en crea (hacia PROYECTO) y es inversor cuando aparece en aporta (hacia APORTE). Nada impide que la misma persona publique un proyecto propio y aporte al de otro — de hecho es lo habitual en estas plataformas — y con dos entidades separadas habría que cargarla dos veces con los mismos datos de contacto y cobro.

RECOMPENSA como entidad débil de PROYECTO. El desarrollo requerido habla de "relación de dependencia": el tier no existe fuera de su proyecto y su numeración se repite entre proyectos (todos tienen un nivel 1). PK compuesta codigo_proyecto + id_recompensa, círculo y rombo dobles. Si se elimina el proyecto, sus recompensas no tienen sentido.

APORTE como entidad asociativa con tres vínculos. Relaciona al inversor, al proyecto y a la recompensa elegida. Tiene atributos propios (fecha y hora, monto) y es el hecho central del negocio.

La recompensa es opcional (0:N) y el proyecto obligatorio. Vale detenerse acá porque parece redundante: la recompensa ya determina el proyecto, así que Id_Proyecto en el aporte podría deducirse. Se mantienen las dos relaciones porque un aporte puede hacerse sin elegir recompensa (donación simple o monto que no alcanza ningún tier), y en ese caso Id_Recompensa queda en NULL pero el aporte igual tiene que saber a qué proyecto pertenece. La contrapartida es una restricción: si hay recompensa seleccionada, esa recompensa tiene que ser del mismo proyecto del aporte.

Atributos calculados (punto 4). Van dibujados con borde punteado, que es la notación para atributos derivados:

monto_recaudado en PROYECTO = suma de los monto_aportado de sus aportes confirmados. No se guarda como dato independiente porque quedaría desincronizado con los aportes; se calcula por agregación (o se mantiene como caché recalculada por trigger).
estado_financiacion = derivado de comparar monto_recaudado con objetivo_financiero a la fecha de cierre: En curso mientras la fecha actual sea anterior al cierre; Financiado con éxito si al cerrar el recaudado alcanzó o superó el objetivo; No alcanzado en caso contrario. Es un derivado de dos fuentes, un monto y una fecha, y por eso el par fecha_inicio_campana / fecha_cierre es el control temporal que da sentido a todo el cálculo.
unidades_reclamadas en RECOMPENSA = cantidad de aportes que eligieron ese tier, para compararla contra unidades_disponibles.

Restricciones de integridad a considerar: monto_aportado mayor o igual al valor_minimo de la recompensa elegida; unidades_reclamadas nunca mayor a unidades_disponibles; fecha_cierre posterior a fecha_inicio_campana; no se aceptan aportes con fecha posterior al cierre ni a proyectos que no estén En curso; y un creador no debería aportar a su propio proyecto.

Resultado
<img width="4800" height="2551" alt="BaseDeDatos-U2-Ej19-Crowdfunding" src="https://github.com/user-attachments/assets/9d8e67e9-a899-4ca6-b8ff-27b79518de28" />
