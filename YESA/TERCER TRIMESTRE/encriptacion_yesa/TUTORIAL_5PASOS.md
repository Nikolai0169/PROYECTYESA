# TUTORIAL RÁPIDO: IMPLEMENTACIÓN DE SHA2-256 EN 5 PASOS

## ⏱️ Tiempo estimado: 10 minutos

---

## PASO 1: PREPARAR LOS ARCHIVOS (2 min)

### Lo que necesitas:
- ✅ Acceso a phpMyAdmin
- ✅ Archivo: `yesa_sql_encrypted.sql` o `yesa_nosql_encrypted.sql`
- ✅ Editor de texto (Notepad++, VSCode, Sublime)

### Acciones:
1. Abre el archivo SQL en tu editor de texto
2. Selecciona TODO el contenido (Ctrl+A)
3. Copia (Ctrl+C)
4. Mantén esto listo en tu portapapeles

---

## PASO 2: ABRIR PHPMYADMIN (1 min)

### Acciones:
1. Abre tu navegador
2. Ve a: `http://localhost/phpmyadmin` (o tu URL de phpMyAdmin)
3. Inicia sesión si es necesario (usuario/contraseña)

### Resultado esperado:
```
┌─────────────────────────┐
│   phpMyAdmin            │
│   Servidores            │
│   Base de datos         │
└─────────────────────────┘
```

---

## PASO 3: EJECUTAR EL SCRIPT SQL (3 min)

### Pasos exactos:

#### 3.1 Haz clic en la pestaña "SQL"
```
[Estructura] [SQL] [Exportar] [Importar]
                 ↑
            Haz clic aquí
```

#### 3.2 Limpia el área de texto (si hay contenido anterior)
```
┌─────────────────────────────────────┐
│ Editor SQL                          │
│                                     │
│ (Borra lo que haya aquí)            │
│                                     │
└─────────────────────────────────────┘
```

#### 3.3 Pega el contenido del archivo SQL
```
Ctrl+V (o clic derecho → Pegar)
```

El editor debería mostrar:
```
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";
...
CREATE TABLE `usuario` (
...
INSERT INTO `usuario` (idUsuario, nombre, correo, contraseña...)
VALUES (1, 'Juan Pérez', 'juan.perez@yesa.com', SHA2(...
...
```

#### 3.4 Ejecuta el script
```
Busca el botón azul: [Continuar] o [Go]
Haz clic en él
```

### ¿Qué esperar?
```
✅ ÉXITO:
"Se han ejecutado 1 sentencia SQL"

❌ ERROR:
"Error SQL: ...número de error..."
(ve a Paso 5 - Solucionar errores)
```

---

## PASO 4: VALIDAR QUE FUNCIONÓ (2 min)

### Validación 1: Ver la tabla creada

Haz clic en la base de datos `yesa_sql` o `yesa_nosql` en el menú izquierdo

Deberías ver las tablas:
```
✓ artista
✓ asignacionartista
✓ barrio
✓ categoria
✓ cliente
✓ comunicacionsolicitud
✓ historialsolicitud
✓ inventario
✓ localidad
✓ material
✓ movimientoinventario
✓ pantillapersonalizacion
✓ producto
✓ revisionartista
✓ solicitudpersonalizacion
✓ usuario  ← IMPORTANTE
```

### Validación 2: Verificar la encriptación

1. Haz clic en la tabla `usuario`
2. Haz clic en la pestaña "Datos"
3. Observa la columna `contraseña`

Debería ver algo como:
```
idUsuario | nombre        | correo          | contraseña (primeros 20 caracteres)
1         | Juan Pérez    | juan.perez@...  | a7f3c8d2e1b9f4a6c5d8...
2         | María García  | maria.garcia@... | c5d8e7f3a1b2c4d5e6f7...
```

✅ Si ves 64 caracteres hexadecimales (0-9, a-f) → **FUNCIONA CORRECTAMENTE**
❌ Si ves texto plano como "Segura#2024" → **ALGO SALIÓ MAL**

### Validación 3: Test de login rápido

1. Ve a la pestaña "SQL"
2. Copia y pega esto:

```sql
SELECT * FROM Usuario
WHERE correo = 'juan.perez@yesa.com'
AND contraseña = SHA2('Segura#2024', 256);
```

3. Ejecuta (botón Continuar/Go)

**Resultado esperado:**
```
Resultado de consulta: 1 fila
idUsuario: 1
nombre: Juan Pérez
correo: juan.perez@yesa.com
contraseña: a7f3c8d2e1b9f4a6c5d8e7f3a1b2c4d5e6f7a8b9c1d2e3f4a5b6c7d8e9f0a1
rol: Cliente
```

✅ **¡Éxito! El login funciona correctamente.**

---

## PASO 5: SOLUCIONAR ERRORES (si los hay)

### Error #1: "Base de datos 'yesa_sql' ya existe"

**Problema:** Intentas crear una BD que ya existe

**Soluciones (elige una):**

Opción A: Dropear la BD anterior
```sql
DROP DATABASE yesa_sql;
```

Opción B: Cambiar nombre en el script
```sql
-- Busca la línea:
CREATE DATABASE `yesa_sql`

-- Cámbiala a:
CREATE DATABASE `yesa_sql_v2`
```

Opción C: Importar datos en BD existente
```sql
-- Busca la línea:
USE `yesa_sql`;

-- Ejecuta primero estas líneas manualmente:
DELETE FROM usuario;
DELETE FROM cliente;
DELETE FROM artista;
-- ... (tabla por tabla en orden inverso)

-- Luego pega el resto del script
```

### Error #2: "Syntax error"

**Problema:** El SQL está corrupto o incompleto

**Soluciones:**

1. Verifica que copiaste EL ARCHIVO COMPLETO
2. No cortaste accidentalmente el contenido
3. Intenta nuevamente desde el archivo original

### Error #3: "MySQL server has gone away"

**Problema:** La conexión se perdió

**Soluciones:**

1. Recarga phpMyAdmin
2. Intenta de nuevo
3. Si persiste, contacta al administrador del servidor

### Error #4: "Contraseña no está encriptada"

**Problema:** Ves "Segura#2024" en lugar de hash

**Soluciones:**

1. Borrar y reimportar
2. Verificar que usaste el archivo _encrypted.sql
3. Revisar Validación 2 del Paso 4

---

## TEST FINAL: CONFIRMAR ENCRIPTACIÓN COMPLETA

Copia estos comandos en phpMyAdmin (pestaña SQL) uno por uno:

### Test 1: Verificar usuarios creados
```sql
SELECT COUNT(*) as total_usuarios FROM Usuario;
```
**Resultado esperado:** 10 o 11

### Test 2: Verificar hashes válidos
```sql
SELECT COUNT(*) as usuarios_encriptados 
FROM Usuario 
WHERE LENGTH(contraseña) = 64;
```
**Resultado esperado:** 10 o 11 (todos)

### Test 3: Login correcto
```sql
SELECT * FROM Usuario
WHERE correo = 'juan.perez@yesa.com'
AND contraseña = SHA2('Segura#2024', 256);
```
**Resultado esperado:** 1 registro (Juan Pérez)

### Test 4: Login incorrecto
```sql
SELECT * FROM Usuario
WHERE correo = 'juan.perez@yesa.com'
AND contraseña = SHA2('ContraseñaMala', 256);
```
**Resultado esperado:** 0 registros (vacío)

### Test 5: Intentar desencriptar (demuestra imposibilidad)
```sql
SELECT AES_DECRYPT(contraseña, 'clave') as intento_desencriptar
FROM Usuario LIMIT 1;
```
**Resultado esperado:** Basura o NULL (SHA2 no es reversible)

---

## ✅ CHECKLIST DE FINALIZACIÓN

- [ ] Paso 1: Preparé los archivos ✓
- [ ] Paso 2: Abrí phpMyAdmin ✓
- [ ] Paso 3: Ejecuté el script SQL ✓
- [ ] Paso 4: Validé encriptación ✓
- [ ] Paso 5: Tests pasados ✓
- [ ] Confirmé contraseña de Juan: Segura#2024 ✓

**Si todos los checks están marcados:** 🎉 **¡IMPLEMENTACIÓN EXITOSA!**

---

## 📋 TABLA DE CONTRASEÑAS RÁPIDA

Para probar logins, usa estas contraseñas:

| Correo | Contraseña Original |
|--------|-------------------|
| juan.perez@yesa.com | Segura#2024 |
| maria.garcia@yesa.com | MariaArt#2024 |
| carlos.lopez@yesa.com | CarlosLop#2024 |
| ana.rodriguez@yesa.com | AnaArt#2024 |
| fernando.torres@yesa.com | Admin#2024Seg |

**Test rápido:**
```sql
SELECT * FROM Usuario
WHERE correo = 'juan.perez@yesa.com'
AND contraseña = SHA2('Segura#2024', 256);
```

---

## 🎯 PRÓXIMOS PASOS

Una vez que confirmes éxito:

1. **Lee la documentación completa:**
   - RESUMEN_ENCRIPTACION.md (visión general)
   - ENCRIPTACION_GUIA.md (detalles técnicos)

2. **Implementa en tu aplicación:**
   - Usa los ejemplos de PHP de ENCRIPTACION_GUIA.md
   - Crea formulario de login
   - Prueba contra BD

3. **Agrega seguridad adicional:**
   - Rate limiting (máx 5 intentos/minuto)
   - HTTPS/SSL
   - Logs de intentos fallidos
   - 2FA (autenticación de dos factores)

---

## 💡 TIPS FINALES

✅ **DO:**
- Usar los archivos _encrypted.sql proporcionados
- Validar todos los 5 tests
- Guardar las contraseñas de prueba (para testing)
- Leer ENCRIPTACION_GUIA.md antes de implementar en producción

❌ **DON'T:**
- Intentar "desencriptar" la contraseña (imposible por design)
- Cambiar el tipo de columna contraseña de VARCHAR(64)
- Mezclar datos de BD anterior con nueva
- Usar contraseñas de prueba en producción

---

## 📞 AYUDA RÁPIDA

**"Terminé en 10 minutos pero tengo dudas técnicas"**
→ Lee: ENCRIPTACION_GUIA.md sección 1

**"Quiero entender por qué SHA2 es seguro"**
→ Lee: COMPARATIVA_SEGURIDAD.md

**"Necesito validar que funciona"**
→ Lee: TESTS_ENCRIPTACION.md (suite de tests)

**"Voy a implementar en PHP"**
→ Lee: ENCRIPTACION_GUIA.md sección 8

**"Tengo un error que no sale en Paso 5"**
→ Lee: TESTS_ENCRIPTACION.md (procedimientos de diagnóstico)

---

## 🏁 RESUMEN

```
5 pasos → 10 minutos → 1 BD segura con SHA2-256
```

**¡Lo hiciste! Felicidades, la encriptación está implementada.** 🎉

---

*Tutorial v1.0 - Diciembre 2025*
*Tiempo promedio de lectura: 5 minutos*
*Tiempo promedio de implementación: 10 minutos*
*Dificultad: ⭐ Muy fácil*