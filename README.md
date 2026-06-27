# AM-Exocad

Repositorio central de integración y personalización de **Exocad** para la clínica **AM Estética Dental**. Aquí se concentran los protocolos de conexión local con la aplicación web principal y las guías de personalización de marca e interfaz.

---

## 🔌 1. Conexión Local: Protocolo de Apertura Directa

Este sistema permite que desde la aplicación clínica web, al hacer clic en **"Diseñar en Exocad"**, se ejecute Exocad de forma local en la PC de la clínica abriendo directamente el proyecto del paciente.

### Archivos incluidos
* **`install-protocol.ps1`**: Script instalador que registra el protocolo personalizado `am-clinica-exocad://` en el Registro de Windows (`regedit`).
* **`open-exocad.ps1`**: El script controlador principal. Procesa los parámetros de URL entrantes, resuelve las rutas locales de Google Drive del paciente, localiza los archivos `.project`/`.dentalproject` e inicia Exocad o abre la carpeta en el Explorador de Windows.
* **`open-exocad.bat`**: Lanzador silencioso que delega la ejecución de PowerShell de forma invisible para que no aparezcan ventanas de consola negras.
* **`exocad-config.json`**: Archivo de configuración local donde se definen las rutas base del Google Drive institucional y del ejecutable `DentalDB.exe`.

### Guía de Instalación (Una sola vez por PC)

1. Abre una consola de **PowerShell como Administrador**.
2. Navega a la carpeta de este repositorio.
3. Ejecuta el comando de instalación para registrar el protocolo en Windows:
   ```powershell
   Set-ExecutionPolicy Bypass -Scope Process -Force; .\install-protocol.ps1
   ```
4. Edita el archivo generado **`exocad-config.json`** si la ruta de tu Google Drive o del ejecutable de Exocad varía de los valores predeterminados:
   ```json
   {
     "driveBasePath": "G:\\Mi unidad\\Pacientes",
     "exocadPath": "C:\\Program Files\\exocad\\DentalDB\\bin\\DentalDB.exe"
   }
   ```

---

## 🎨 2. Personalización Visual de Exocad (Branding)

Para que Exocad refleje la identidad visual de la clínica **AM Estética Dental**, podemos personalizar los colores, splash-screens y logos de la interfaz de DentalCAD.

### Cambio del Color de Fondo
1. Abre **DentalCAD** y dirígete al menú superior en **Tools** (Herramientas).
2. Selecciona **Settings** (Configuración) y ve a la sección de **Interface Theme** (Tema de Interfaz).
3. Podrás cambiar entre temas *Claro* y *Oscuro* generales.
4. Para añadir un color de fondo personalizado (de tu paleta de marca), presiona el botón **`+`** en la selección de color de fondo, introduce tus códigos de color personalizados y guarda el preset.

### Reemplazo de Logo e Interfaz de Carga (Splash Screen)
Los recursos gráficos de la interfaz de Exocad están dentro de su carpeta de instalación.
1. Navega al directorio de instalación de tu versión de Exocad (ej. `C:\Program Files\exocad\DentalCAD\Skin\`).
2. Dentro de la carpeta `Skin` (o subcarpetas de imágenes de tu distribuidor/OEM), busca los archivos de imagen principales del logo y la pantalla de carga (normalmente son archivos `.png` o `.bmp`).
3. Realiza una **copia de seguridad** de los archivos originales.
4. Reemplaza los archivos con el logotipo de **AM Estética Dental** manteniendo exactamente el **mismo nombre de archivo, extensión y dimensiones (en píxeles)** para evitar distorsiones.

---

## 🗄️ 3. Mapeo Automático de Proyectos

Para evitar tener que seleccionar manualmente la carpeta de destino de cada paciente y asegurar que todos los proyectos creados en Exocad queden guardados dentro de tu Google Drive local sincronizado:

1. Ve a la carpeta de configuración de DentalDB:
   `C:\Program Files\exocad\DentalDB\config\`
2. Edita el archivo de configuración **`settings.xml`** o **`settings-db.xml`** (usa un editor de texto como Bloc de notas).
3. Busca la etiqueta **`<ProjectDirectory>`** (Directorio de Proyectos).
4. Cambia su valor para apuntar directamente a tu directorio local sincronizado de Google Drive:
   ```xml
   <ProjectDirectory>G:\Mi unidad\Pacientes</ProjectDirectory>
   ```
5. Guarda los cambios. A partir de ahora, todo proyecto nuevo creado desde la base de datos de DentalDB se almacenará de manera automática en la nube sincronizada de la clínica.
