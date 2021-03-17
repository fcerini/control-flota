# SISEP Control de Flota
Modulo del SISEP para controlar el mantenimiento de las flotas de moviles.

## TODO
- Choferes ver si hay que hacerles un tratamiento diferente que a los moviles...


## Resumen
Este modulo toma los moviles ya cargados en el SISEP y les agrega la opcion de controlar diferentes variables ya sea por fechas limite, periodos de tiempo o kilometros.

Para cada movil se le pueden agregar reglas como por ejemplo:
- cambiar el aceite cada 10.000 Kms o 12 meses.
- renovar la VTV a partir de cierta fecha.

## Base de datos
A todas las tablas se les agrega tambien borrado y fechaActualizacion...

### Grupo
Agrupa los servicios que se pueden realizar segun los tipos de moviles, seguramente estara bastante relacionado con la Marca, Modelo y o el año, o el tipo de uso, etc...
- grupId
- grupNombre
- grupDescripcion

### Servicio
Diferentes servicios que pueden hacerse a los moviles. Los servicios pueden ser programados periodicamente por tiempo, por Kms o bien tener simplemente una fecha limite. Tambien pueden ser 
- servId
- servNombre
- servDescripcion
- servPeriodo: numero de dias periodicos por defecto
- servKM: numero de KMs por defecto
- servFecha: bool si se controla una fecha limite. O sea no se usa un periodo sino que simplemente se pide la proxima fecha. Ejemplo la VTV o el carnet de conducir.

### Tarea
Lista opcional de tareas posibles que se realizan en un servicio. Ejemplo cambio de aceite, cambio de filtros, reparacion x, etc.. Cuando se reliza un servicio en un movil se toma esta lista como ejemplo pero despues se le pueden cargar mas.
- tareId
- tareNombre
- tareDescripcion
- tareUnidadMedida unidades, litros, gramos,  etc
- tareCantidad cantidad por defecto o cero
- tareCosto costo por defecto de la tarea

### ServicioTarea
Template de las tareas tipicas por defecto de un servicio
- setaId
- setaServId servicio
- setaTareId tarea

### GrupoServicio
Template de los diferentes servicios para cada grupo de moviles.
- grusId
- grusGrupId grupo
- grusServId servicio
- grusPeriodo: numero de dias por defecto en este grupo
- grusKM: numero de KMs por defecto en este grupo
- grusFecha: bool si se controla una fecha limite


### MovilServicio
Servicios programados para un movil. Es una copia del template de GrupoServicios para cada movil. Al asignar el grupo al movil se le dan de alta estos servicios con sus valores por defecto, pero en cada movil se podrian cambiar o agregar alguno mas.
- moseId
- moseMoviId movil
- moseServId servicio
- mosePeriodo: numero de dias
- moseKM: numero de KMs
- moseFecha: bool si se controla una fecha limite

### MovilBitacora
Log de todos los servicios y controles que se le realizan a un movil. Esta tabla tambien se usa para ver todos los controles programados **Pendientes** que estan vencidos o por vencer segun **ProximaFecha o ProximoOdometro**.
- mobiId
- mobiMoviId movil
- mobiMoseId servicio programado. Podria estar en NULL si se hizo un servicio no programado.
- mobiServId servicio
- mobiFecha fecha del servicio 
- mobiObservaciones
- mobiOdometro odometro del movil al momento del servicio
- mobiProximoOdometro se calcula segun moseKM
- mobiProximaFecha se calcula segun mosePeriodo o se carga si moseFecha=1
- mobiIdAnterior servicio anterior, puede estae en null si es el primero o es no programado
- mobiIdSiguiente servicio siguiente, esta en null hasta que no se haga el proximo servicio
- mobiPendiente esta en 1 hasta que no se haga el prox. servicio.

### BitacoraTarea
Tareas especificas realizadas durante el servicio al movil, se suguieren desde ServicioTareas + Tareas
- bitaId
- bitaMobiId MovilBitacora
- bitaTareId Tarea
- bitaObservaciones
- bitaCantidad  
- bitaCosto se suguiere desde Tarea


### MovilOdometro
Log de Odometros diarios por movil. Al cargar uno nuevo se registra el ultimo en el Movil.
- modoId
- modoMoviId
- modoFecha
- modoOdometro

### MovilGrupo
Por si el movil puede estar en mas de un grupo...
- mogrId
- mogrMoviId movil
- mogrGrupId: grupo de moviles

### Movil
En esta tabla se agregan todos los moviles a los que se les va a hacer mantenimiento preventivo. Se relaciona por idmovil con la tabla [AVL_Estructura].[dbo].[Movil].

- moviId: relacion 1:1 con AVL_Estructura.dbo.Movil
- moviModoFecha: copia del ultimo odometro
- moviModoOdometro



## Eventos (pantallas)
Las grillas tienen las funciones de ordenar, filtrar y paginar.

Y las acciones de editar, borrar y agregar.

### Grilla de Grupos
- grupId
- grupNombre
- grupDescripcion

### Form de Grupos
- grupNombre
- grupDescripcion

#### Grilla + Formulario de GrupoServicios
Similar al caso de la carga del Pedido-Detalle, Servicio seria como Producto
- servNombre
- grusPeriodo: numero de dias por defecto en este grupo
- grusKM: numero de KMs por defecto en este grupo
- grusFecha: bool si se controla una fecha limite

Al elegir el servicio sugerir los campos periodo KM y fecha.

### Grilla de Servicios
- servId
- servNombre
- servDescripcion
- servPeriodo: numero de dias periodicos por defecto
- servKM: numero de KMs por defecto
- servFecha: bool

### Form de Servicios
- servNombre
- servDescripcion
- servPeriodo: numero de dias periodicos por defecto
- servKM: numero de KMs por defecto
- servFecha: bool

#### Grilla + Formulario de ServicioTareas
- Mostrar tareNombre
- No Mostrar (automaticos)
  - setaId automatico
  - setaServId servicio seleccionado en el formulario
  - setaTareId tarea viene del select de tareas

### Grilla de Tareas
Todos los campos
#### Form de Tareas
Todos los campos. tareUnidadMedida cargarlo desde el API, o sea no hay una tabla pero en el PHP devolver un array con las opciones.

### Grilla de Moviles
Muestra todos los moviles que tienen control de flota.
Opciones de filtrar por patente, descripcion o dependencia.
Dejar tambien el buscador de la grilla, en memoria despues del filtro.
Boton Agregar Movil.
En cada fila de la grilla botones de Mantenimiento, Editar y Borrar.

### Grilla de Agregar Movil
Muestra TODOS los moviles.
Opciones de filtrar por patente, descripcion o dependencia.
Dejar tambien el buscador de la grilla, en memoria despues del filtro.

En cada fila de la grilla:
- Si el movil no tiene control de flota (borrado=null) mostrar boton de Agregar.
- Si el movil esta borrado aclararlo y mostrar boton de Reactivar? Pedir confirmacion y cambiar borrado=0
- Si el movil ya tiene control de flota aclararlo y no poner ningun boton.

### Formulario del Movil: Agregar Movil
Al confirmar agrega el movil a la tabla Moviles.
Permite asignar los Grupos en una grilla de MovilGrupo porque pueden ser varios.
Opcionalmente se podria inicializar el odometro, o sea se agregaria el primer registro en MovilOdometro y se actualizarian los datos en Movil.

### Formulario del Movil: Editar Movil
Permite asignar los Grupos en una grilla de MovilGrupo porque pueden ser varios.
Al asignar un nuevo grupo deberia copiarse a MovilServicios todos los Servicios de ese grupo que figuran en GrupoServicio

Mostrar y editar los campos de tabla relacionada AVL_Estructura. 

Para visualizar:
- activa
- patente
- compid + Comp.Nombre
- tipomovilid + TipoMovil.Nombre
- tienepatrullaje
- borrado
- fechaalta
- movilestadoid + MovilEstado.Estado

Pueden Editarse, segun permisos:
- descripcion
- marca
- modelo
- anio
- chasis
- numeromovil
- color
- seguro
- poliza
- numeromotor

### Mantenimiento Servicios
Muestra una grilla de todos los servicios para ese movil de la tabla MovilServicios.

Boton de Agregar

Acciones en la grilla: Modificar, Borrar, Realizar Servicio

Realizar Servicio: lleva al formulario de bitacora en modo agregar con ese servicio seleccionado.


### Mantenimiento Bitacora
Muestra una grilla de de los ultimos X servicios realizados para ese movil de la tabla MovilBitacora, ordenados descendentes.

Boton de Agregar.

Acciones en la grilla: Modificar, Borrar, Realizar Servicio

Realizar Servicio: lleva al formulario de bitacora en modo agregar con ese servicio seleccionado (mobiMoseId y mobiServId) y una referencia al registro de la bitacora anterior (mobiId).

Al confirmar la nueva bitacora se setean los siguientes campos:

Nueva Bitacora
- mobiMoviId movil seleccionado
- mobiMoseId servicio programado desde la tabla MovilServicio. Se asigna desde los botones [Realizar Servicio], o queda en NULL si se hizo un servicio no programado.
- mobiServId servicio elegido
- mobiFecha fecha del servicio 
- mobiObservaciones
- mobiOdometro odometro del movil al momento del servicio
- mobiProximoOdometro se calcula segun MovilServicio moseKM
- mobiProximaFecha se calcula segun MovilServicio mosePeriodo o se carga si moseFecha=1
- mobiIdAnterior: mobiId de Bitacora Anterior, si se entro a este formulario desde la accion Realizar Servicio de la grilla de bitacora.
- mobiIdSiguiente: null
- mobiPendiente: 1

Bitacora Anterior
- mobiIdSiguiente: mobiId nuevo
- mobiPendiente: 0



### Otros eventos
- Grilla (buscador) de Moviles
  - Alta de Movil
  - Edicion del Movil
    - MovilGrupos
  - Mantenimiento del Movil
    - MovilServicios
    - MovilBitacora
      - BitacoraTareas
    - MovilOdometro
- Proximos vencimientos
