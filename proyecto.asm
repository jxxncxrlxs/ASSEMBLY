; PROYECTO PROGRAMADO
; CURSO ORGANIZACIÓN DE ESTRUCTURAS
; REALIZADO POR ESTUDIANTES UNIVERSIDAD AMERICANA
; III CUATRIMESTRE - 2014
; PROF. FELIX CORDERO M.
; EMAIL: felixcorderom@gmail.com 
; TEL.: 8868-7002       
; IR A LA LINEA NÚMERO 53 PARA OMITIR ESTA INFORMACIÓN CON FINES PEDAGÓGICOS.
; MODELOS DE MEMORIA
; Model TINY CS = DS En 1 solo segmento de 64K
; Model SMALL CS = 64Kb DS = 64Kb
; Model MEDIUM CS > 64Kb DS < 64Kb
; Model COMPACT CS < 64Kb DS > 64Kb
; Model LARGE CS > 64Kb DS > 64Kb(Los arreglos de datos deben ocupar menos de 64 K)
; Model HUGE CS > 64Kb DS > 64Kb(Los arreglos de datos pueden ocupar mas de 64 Kb)
; REGISTROS DE USO GENERAL
; [0 0 0 0 0 0 0 0] [AH(8) AL(8)] [AX(16)]
; [0 0 0 0 0 0 0 0] [BH(8) BL(8)] [BX(16)]
; [0 0 0 0 0 0 0 0] [CH(8) CL(8)] [CX(16)]
; [0 0 0 0 0 0 0 0] [DH(8) DL(8)] [DX(16)]
; 2 ^ 8 = 256 -> 0..255 VALORES ADMITIDOS
; 2 ^ 8 x 2 ^ 8 = 65536 - 1 = 65538 LLENA EL REGISTRO
; ALGUNAS INTERRUPCIONES Y SUS RESPECTIVAS FUNCIONES
; SIEMPRE LA FUNCION SE PASA A LA PARTE ALTA DE AX, ES DECIR A AH
; INT. FUN. DESC.
; 10h 00h establece el modo de video
; 10h 01h establece el tamaño del cursor
; 10h 02h fija el cursor
; 10h 03h lee la posicion del cursor
; 10h 04h lee la posición de la pluma óptica
; 10h 05h selecciona la página activa
; 10h 06h recorre la pantalla hacia arriba
; 10h 07h recorre la pantalla hacia abajo
; 10h 08h lee el atributo o caracter que se encuentra en la posicion del cursor
; 10h 09h despliega el atributo o caracter que se encuentra en la posicion del cursor
; 10h 0ah despliega el caracter en la posición del cursor
; 10h 0bh establece la paleta de colores
; 10h 0ch escribe el pixel punto
; 10h 0dh lee el pixel punto
; 10h 0eh escribe el teletipo
; 10h 0fh obtiene el modo actual de video
; 10h 11h genera carácter
; 10h 12h selecciona rutina alterna de pantalla
; 10h 13h despliega cadena de caracteres
; 10h 1bh regresa la información de funcionalidad o estado
; 10h 1ch guarda o restaura el estado de vídeo
; 21h 02h despliega en pantalla digitos
; 21h 09h despliega en pantalla cadenas
; 21h 0Ah entrada desde teclado
; 21h 03Fh entrada desde teclado
; 21h 40h despliega en pantalla

;model LARGE CS > 64Kb DS > 64Kb(Los arreglos de datos deben ocupar menos de 64 K)
.model large
; se establece el tamaño de pila
.stack 64
; declaración de variables y constantes
; se usa casi siempre el formato de nomenclatura, ej_XX_mensaje_XX (para las cadenas), ej_XX_vector, ej_XX_contador_XX 
; de este modo se identifican las variables y constantes utilizadas en cada ejercicio facilitando el testing y mantenimiento del proyecto
.data                                                                                             
    menu_cadena_01 DB "················································································",13,10,"$"
    menu_cadena_02 DB "·                     INGENIERIA EN SISTEMAS DE INFORMACION                     ·",13,10,"$"
    menu_cadena_03 DB "·                            III CUATRIMESTRE 2014                             ·",13,10,"$"
    menu_cadena_04 DB "·                         ORGANIZACION DE ESTRUCTURAS                          ·",13,10,"$"
    menu_cadena_05 DB "·                                PROGRAMADORES                                 ·",13,10,"$"
    menu_cadena_06 DB "·KAREN SALAS - JOSEPH MORALES - JAIRO PICADO - GUILLERMO BRENES - JUAN SANCHEZ ·",13,10,"$"
    menu_cadena_07 DB "················································································",13,10,"$"
    menu_cadena_08 DB "· [A] HOLA MUNDO     [B] SUMA            [C] RESTA          [D] MULTIPLICACION ·",13,10,"$"
    menu_cadena_09 DB "· [E] DIVISION       [F] PALINDROMO      [G] CADENA IGUAL   [H] SUBCADENA      ·",13,10,"$"
    menu_cadena_10 DB "· [I] ESPERAR [ESC]  [J] ORDENAR 0-9     [K] ORDENAR 9-0    [X] SALIR          ·",13,10,"$"  
    menu_cadena_11 DB "················································································",13,10,"$"
    menu_cadena_12 DB "> INGRESE UNA OPCION: $"
    
    menu_cadena_13 DB "················································································",13,10,"$"
    menu_cadena_14 DB "·                                                                              ·",13,10,"$"
    menu_cadena_15 DB "·            _/_/        _/_/_/        _/_/_/        _/_/          _/_/_/      ·",13,10,"$"
    menu_cadena_16 DB "·         _/    _/      _/    _/        _/        _/    _/      _/             ·",13,10,"$"
    menu_cadena_17 DB "·        _/_/_/_/      _/    _/        _/        _/    _/        _/_/          ·",13,10,"$"
    menu_cadena_18 DB "·       _/    _/      _/    _/        _/        _/    _/            _/         ·",13,10,"$"
    menu_cadena_19 DB "·      _/    _/      _/_/_/        _/_/_/        _/_/        _/_/_/            ·",13,10,"$"
    menu_cadena_20 DB "·                                                                              ·",13,10,"$"
    menu_cadena_21 DB "·         COPYRIGHT © TODOS LOS DERECHOS RESERVADOS, C(AFEINA)++, 2014         ·",13,10,"$"
    menu_cadena_22 DB "·                                                                              ·",13,10,"$"
    menu_cadena_23 DB "················································································",13,10,"$"
    
    ; ejercicio 01
    ; cadenas
    ej_01_mensaje_01 DB "¡HOLA MUNDO!", 13, 10, "$"
    ; ejercicio 02
    ; cadenas
    ej_02_mensaje_01 DB       "VALOR 1 (12)   $"
    ej_02_mensaje_02 DB 13,10,"VALOR 2 (34)   $"
    ej_02_mensaje_03 DB 13,10,"             +____$"
    ej_02_mensaje_04 DB 13,10,"TOTAL          $"
    ; variable numéricas
    ej_02_auxiliar_01 DB 0
    ej_02_auxiliar_02 DB 0
    ; ejercicio 03 
    ; cadenas 
    ej_03_mensaje_01 DB 13,10,"             -____$"
    ; variables numéricas
    ej_03_auxiliar_01 DB 0
    ej_03_auxiliar_02 DB 0
    ; ejercicio 04        
    ; cadenas 
    ej_04_mensaje_01 DB 13,10,"             x____$"
    ; variables numéricas
    ej_04_auxiliar_01 DB 0
    ej_04_auxiliar_02 DB 0
    ; ejercicio 05
    ; cadenas 
    ej_05_mensaje_01 DB 13,10,"             ÷_____$"
    ; variable numéricas
    ej_05_auxiliar_01 DB 0
    ej_05_auxiliar_02 DB 0
    ; ejercicio 06
    ej_06_mensaje_01 DB "CADENA 1 $", 13, 10, "$"
    ej_06_mensaje_02 DB 13,10, "CADENA 2 $", 13, 10, "$"
    ej_06_mensaje_03 DB 13,10, "LAS CADENAS EQUIVALEN A UN PALINDROMO $"
    ej_06_mensaje_04 DB 13,10, "LAS CADENAS NO SON PALINDROMO $"
    ; variable numéricas
    ej_06_cadena_01 DB 20 dup('$')
    ej_06_cadena_02 DB 20 dup('$')
    ej_06_contador_01 DW 0
    ej_06_contador_02 DW 0
    ; ejercicio 07
    ; cadenas
    ej_07_mensaje_01 DB "CADENA 1 $", 13, 10, "$"
    ej_07_mensaje_02 DB 13,10,"CADENA 2 $"
    ej_07_mensaje_03 DB 13,10,"SON CADENAS IGUALES $"
    ej_07_mensaje_04 DB 13,10,"SON CADENAS DIFERENTES $"
    ; vectores
    ej_07_cadena_01 DB 50 dup('$')
    ej_07_cadena_02 DB 50 dup('$')
    ; ejercicio 09
    ; cadenas
    ej_09_mensaje_01 DB "'ENSAMBLADOR', PRESIONE [ESC] PARA SALIR... $"
    ej_09_mensaje_02 DB 13,10,"INGRESE UN CARÁCTER ", "$"
    ej_09_mensaje_03 DB 13,10,"PRESIONASTE [ESC], ES EL FIN DEL PROGRAMA ", "$"
    
    ; ejercicio 10
    ; cadenas
    ej_10_mensaje_01 DB "SE LEERAN VALORES (MAX. 10) HASTA PRESIONAR [ENTER] $"
    ej_10_mensaje_02 DB 13,10,"INGRESE UN VALOR ENTRE 0-9: $"
    ej_10_mensaje_03 DB "ORDENANDO ARREGLO, ESTO TOMARÁ UNOS SEGUNDOS... $"
    ej_10_mensaje_04 DB 13,10,"ARREGLO  DESORDENADO: $"
    ej_10_mensaje_05 DB 13,10,"ARREGLO ORDENADO 0-9: $"
    ; vector
    ej_10_vector DB 11 dup ("$")
    ; variables numéricas
    ej_10_contador DW 0
     
    ; ejercicio 11
    ; cadenas    
    ej_11_mensaje_01 DB "SE LEERAN VALORES (MAX. 10) HASTA PRESIONAR [ENTER] $"
    ej_11_mensaje_02 DB 13,10,"INGRESE UN VALOR ENTRE 0-9: $"
    ej_11_mensaje_03 DB "ORDENANDO ARREGLO, ESTO TOMARÁ UNOS SEGUNDOS... $"
    ej_11_mensaje_04 DB 13,10,"ARREGLO  DESORDENADO: $"
    ej_11_mensaje_05 DB 13,10,"ARREGLO ORDENADO 9-0: $"
    ; vector
    ej_11_vector DB 11 dup ("$")
    ; variables numéricas
    ej_11_contador DW 0
     
    ; simbolos genéricos
    punto DB ".$"     
    barra DB "  $"  
    nuevalinea DB 13,10,"$"
     
.code            

; termina el programa en ejecución
macro mc_generico_finalizar
    MOV ax, 0c07h                                           ; 0c07h espera a que el usuario presione una tecla
    INT 21h                                                 ; ejecuta la interrupción
    .exit                                                   ; macro propio de emu8086 para terminar el programa
endm  

; espera un carácter cualquiera, se usa como pausa
macro mc_generico_esperar
    MOV ah, 01h                                             ; funcion de lectura
    INT 21h                                                 ; ejecuta la interrupción
endm

; limpia la pantalla     
macro mc_limpiar_pantalla
    MOV ah, 00h                                             ; se asegura que en AH no haya nada
    MOV al, 03h                                             ; pasa la función usada para limpiar pantalla
    INT 10h                                                 ; ejecuta la interrupción
endm
                     
; macro de impresión del menú         
mc_generico_imprimir_menu macro    
    mc_limpiar_pantalla
    mc_generico_imprimir_mensaje menu_cadena_01
    mc_generico_imprimir_mensaje menu_cadena_02
    mc_generico_imprimir_mensaje menu_cadena_03
    mc_generico_imprimir_mensaje menu_cadena_04
    mc_generico_imprimir_mensaje menu_cadena_05
    mc_generico_imprimir_mensaje menu_cadena_06
    mc_generico_imprimir_mensaje menu_cadena_07
    mc_generico_imprimir_mensaje menu_cadena_08
    mc_generico_imprimir_mensaje menu_cadena_09
    mc_generico_imprimir_mensaje menu_cadena_10
    mc_generico_imprimir_mensaje menu_cadena_11    
    mc_generico_imprimir_mensaje menu_cadena_12
endm        

; macro para imprimir un mensaje de despedida al terminar el programa
mc_generico_imprimir_adios macro    
    mc_limpiar_pantalla             
    mc_generico_imprimir_mensaje menu_cadena_13
    mc_generico_imprimir_mensaje menu_cadena_15
    mc_generico_imprimir_mensaje menu_cadena_16
    mc_generico_imprimir_mensaje menu_cadena_17
    mc_generico_imprimir_mensaje menu_cadena_18
    mc_generico_imprimir_mensaje menu_cadena_19
    mc_generico_imprimir_mensaje menu_cadena_20
    mc_generico_imprimir_mensaje menu_cadena_21
    mc_generico_imprimir_mensaje menu_cadena_22
    mc_generico_imprimir_mensaje menu_cadena_23
endm
                              
; macro genérico para imprimir cadenas
; parametro: una cadena
mc_generico_imprimir_mensaje macro parametro         
    MOV ah, 00                                              ; inicializa ah
    MOV al, 00                                              ; inicializa ah
    MOV dx, 00                                              ; inicializa ah
    MOV dx, offset parametro                                ; pasa la dirección del parámetro recibido / los datos imprimir SIEMPRE deben ir al registro DX
    MOV ah, 09H                                             ; pasa la función de impresión en pantalla
    INT 21H                                                 ; ejecuta la interrupción
endm

; macro de uso genérico para leer cadenas ingresadas por teclado
; parámetro; una cadena
mc_generico_leer_cadena macro parametro
    LOCAL LEER                                              ; se establece una etiqueta local
    MOV si, 00h                                             ; inicializa SI que se usará como contador
    LEER:
        MOV ax, 0000                                        ; inicializa el contenido de AX
        MOV ah, 01h                                         ; funcion de lectura
        INT 21h                                             ; ejecuta la lectura
        MOV parametro[si], al                               ; guarda el caracter leído en la posición que tiene SI
        INC si                                              ; incrementa el contador
        CMP al, 0dh                                         ; revisa que no se ha presionado ENTER
        JNE LEER                                            ; si no es igual continúa leyendo
endm

; imprime un valor numérico de un dígito en base decimal
; parámetro un valor numerico de un dígito
mc_generico_imprimir_digito macro parametro         
    MOV dl, parametro                                       ; pasa a DL el dígito a imprimir
    ADD dl, 48                                              ; los digitos en ASCII estan entre 48 y 57
    MOV ah, 02h                                             ; funcion para imprimir
    INT 21h                                                 ; ejecuta la funcion anterior
endm

; macro para imprimir un arreglo de valores numéricos
; parámetro; un arreglo con valores numéricos de un dígito
mc_imprimir_arreglo macro parametro                 
    LOCAL CICLO_RECORRIDO, FINAL_CICLO, IMPRIMIR_DIGITO     ; se usa LOCAL para definir como locales las etiquetas
    MOV si, 00                                              ; inicializa SI (source index), SI y DI son los contadores para recorrer arreglos
    MOV al, "$"                                             ; inicializa AL
    CICLO_RECORRIDO:
        MOV al, parametro[si]                               ; apunta a la posición 0,1,2... en el arreglo recibido por parámetro
        CMP al, "$"                                         ; compara el valor en la posición especifica del arreglo con "$" para saber si es el fin del arreglo
        JNE IMPRIMIR_DIGITO                                 ; JNE = si no es igual a "S" imprima el dígito
        JE  FINAL_CICLO                                     ; JE  = si es igual a "S" vaya a la etiqueta que termina el ciclo
     
    IMPRIMIR_DIGITO:      
        mc_generico_imprimir_mensaje barra                  ; reutiliza código con el macro de imprimir cadenas para poner un espacio entre valor y valor 
        mc_generico_imprimir_digito parametro[si]           ; reutiliza código con el macro de imprimir dígito, en este caso el dígito en la posición que indica el contador SI
        INC si                                              ; incrementa el contador SI
        JMP CICLO_RECORRIDO                                 ; JMP = salte a la etiqueta que continúa con el ciclo
        
    FINAL_CICLO:                                            ; sale del ciclo, condición de fin del ciclo
        mc_generico_imprimir_mensaje nuevalinea             ; imprime un salto de línea 
endm

; macro para saber la longitud de una cadena, simplemente cuanta carácteres hasta encontrar un fin de línea, es decir un "$"
; parámetro: una cadena y un contador
macro mc_generico_contar_caracteres cadena, contador
    LOCAL CONTAR, PARAR, SEGUIR                             ; establece las etiquetas locales a utilizar
    MOV si, 00h                                             ; inicializa el contador, se usa SI para recorrer los vectores
    CONTAR:                                                 ; etiqueta que representa el ciclo
        ;MOV al, cadena[si]                                  
        CMP cadena[si], "$"                                 ; comparar el valor que se encuentra en la posición SI (0,1,2...) para saber si es o no es un "$" (fin de cadena)
        JE PARAR                                            ; si es un "$" va a la etiqueta usada para finalizar el ciclo
        JNE SEGUIR                                          ; si no es un "$" continúa contado
    SEGUIR:
        INC si                                              ; incrementa el contador
        JMP CONTAR                                          ; salta al ciclo para continuar recorriendo la cadena en busca de un "$"
    PARAR:
        DEC si ; quita eol                                  ; decrementa en 1 al valor del contador, usado para fin práctico porque los vectores empiezan en 0
        MOV contador, si                                    ; guarda en el parametro el valor del contador SI, así este valor se puede usar desde fuera del macro
endm

; macro para leer cifras de dos dígitos, primero lee las decenas, luego las unidades
; parámetro: una variable numérica
mc_generico_leer_cifra macro parametro
    LOCAL DECENA, UNIDAD                                    ; establece las etiquetas locales a utilizar 
    DECENA:                                                  
        MOV ah, 01h                                         ; se prepara para leer pasando la función respectiva
        INT 21h                                             ; ejecuta la interrupción
        SUB al, 48                                          ; resta 48 al carácter leído para obtener el valor real
        CMP al, 10                                          ; comparación para saber si realmente es un dífito lo ingresado
        JA DECENA                                           ; el primer valor leído es una decena
        MOV bl, 10                                          ; se pasa a BL el valor 10 para multiplicar el valor ingresado ESTO ES TEORIA FUNDAMENTAL DE NUMERACIÓN
                                                            ; 1234 = 1000 + 200 + 30 + 4
        MUL bl                                              ; hace la multiplicación, ejemplo: 94 = (9 * 10 elevado a la 1) + (9 * 10 elevado a la 0)
        MOV parametro, al                                   ; guarda en el parámetro el valor temporal
    UNIDAD:
        MOV ah, 01h                                         ; lee otro valor
        INT 21H                                             ; ejecuta la interrupción
        SUB al, 48                                          ; resta 48 al carácter leído para obtener el valor real
        CMP al, 10                                          ; comparación para saber si realmente es un dífito lo ingresado
        JA UNIDAD                                           
        ADD al, parametro                                   ; le suma al parámetro, es decir al valor temporal con las decenas, el valor de las unidades
        MOV parametro, al                                   ; ahora si, se guarda el valor final leído
endm

; este macro incializa todos los valores de un vector de 10 posiciones          
macro mc_inicializar_arreglo parametro
    MOV parametro[0], "$"    
    MOV parametro[1], "$"    
    MOV parametro[2], "$"    
    MOV parametro[3], "$"    
    MOV parametro[4], "$"    
    MOV parametro[5], "$"    
    MOV parametro[6], "$"    
    MOV parametro[7], "$"    
    MOV parametro[8], "$"    
    MOV parametro[9], "$"       
    MOV parametro[0ah], "$"       
endm


; macro para capturar valores de pantalla, lee 10 valores máximo o deja de capturar al presionar ENTER    
; parámetros: recibe el arreglo a llenar, y tres cadenas con mensajes para el usuario
mc_generico_llenar_arreglo macro arreglo, mensaje01, mensaje02, mensaje03
    LOCAL LECTURA, FIN_LECTURA,                             ; establece las etiquetas locales
    MOV si, 00                                              ; inicaliza SI
    LECTURA:
        CMP si, 9                                           ; compara si el contador SI es mayor a 9 (largo máximo del vector)
        JA  FIN_LECTURA                                     ; si es mayor SI a 9 entonces termina el ciclo
        mc_generico_imprimir_mensaje mensaje01              ; imprime un mensaje usando el macro ya definido para esa tareas
        MOV ax, 0000                                        ; incializa el registro AX
        MOV ah, 01h                                         ; pasa la función de captura de teclado
        INT 21h                                             ; ejecuta la interrupción 
        MOV bl, al                                          ; respaldo temporal en BL 
        SUB al, 30h                                         ; resta 48 al registro AL (donde se almacena la captura) para obtener el valor numérico ingresado
        MOV arreglo[si], al                                 ; guarda en el vector el valor ingresado
        INC si                                              ; incrementa el contador SI
        CMP bl, 0dh                                         ; verifica que no se haya ingresado un ENTER
        JE  FIN_LECTURA                                     ; si se presionó ENTER se deja de leer
        JNE LECTURA                                         ; si no es ENTER sigue leyendo hasta que el contador sea mayor a 9
 
    FIN_LECTURA: 
       mc_limpiar_pantalla                                  ; usa el macro de limpiar la pantalla
       mc_generico_imprimir_mensaje mensaje02               ; imprime mensajes informativos
       mc_generico_imprimir_mensaje mensaje03               ; imprime mensajes informativos
       mc_imprimir_arreglo arreglo                          ; imprime el vactor ingresado
endm    

                  
; ejercicio 01 - imprime "hola mundo"
macro mc_ej_01         
    mc_limpiar_pantalla                                     ; limpia la pantalla
    mc_generico_imprimir_mensaje ej_01_mensaje_01           ; usa el macro de imprimir cadenas y le pasa como parámetro el mensaje a mostrar en pantalla
    mc_generico_esperar                                     ; espera hasta que el usario presione una tecla, se usa un macro definido anteriormente
endm

; ejercicio 02 - suma dos valores de dos dígitos
; aclaración: la suma de valores debe ser inferior a 99
mc_ej_02 macro         
    mc_limpiar_pantalla                                     ; limpia la pantalla
    mc_generico_imprimir_mensaje ej_02_mensaje_01           ; mensaje para pedir al usuario un valor ingresado por teclado
    mc_generico_leer_cifra ej_02_auxiliar_01                ; llama al macro definido para captura de datos de teclado y le pasa la variable donde se almacenará ese valor
    mc_generico_imprimir_mensaje ej_02_mensaje_02           ; pide el segundo valor del mismo modo descrito anteriormente
    mc_generico_leer_cifra ej_02_auxiliar_02                ; captura el dato
    MOV al, ej_02_auxiliar_01                               ; asigna a AL el valor 
    ADD al, ej_02_auxiliar_02                               ; convierte byte en word 
    CBW                                                     ; mueve a BL el valor 10
    MOV bl, 10                                              ; ejecuta la división para obtener las decenas
    DIV bl                                                  ; guarda en AL el cociente y AH el residuo
    MOV ej_02_auxiliar_01, al                               ; traslada los datos a variables temporales para evitar perderla al imprimir porque el registro AX se sobre-escribe
    MOV ej_02_auxiliar_02, ah                               ; de igual modo respalda el contenido de AH
    mc_generico_imprimir_mensaje ej_02_mensaje_03           ; imprime "----" mensaje de resultado
    mc_generico_imprimir_mensaje ej_02_mensaje_04           ; imprime "----" mensaje de resultado
    mc_generico_imprimir_digito ej_02_auxiliar_01           ; con ayuda del macro de imprimir dígitos se muestra en pantallas las decenas
    mc_generico_imprimir_digito ej_02_auxiliar_02           ; imprime las unidades
    mc_generico_esperar                                     ; espera que el usuario presione una tecla
endm

; ejercicio 03 - resta dos valores de dos dígitos
; aclaración: la resta debe dar un número entre 0 y 99
mc_ej_03 macro         
    mc_limpiar_pantalla                                     ; limpia la pantalla
    mc_generico_imprimir_mensaje ej_02_mensaje_01           ; pide los valores a ingresar mediante teclado usando los macros correspondientes
    mc_generico_leer_cifra ej_03_auxiliar_01                ; captura el primer valor
    mc_generico_imprimir_mensaje ej_02_mensaje_02
    mc_generico_leer_cifra ej_03_auxiliar_02                ; captura el segundo valor
    MOV al, ej_03_auxiliar_01                               ; pasa a AL el primer valor
    SUB al, ej_03_auxiliar_02                               ; realiza la suma
    CBW                                                     ; convierte de byte a word
    MOV bl, 10                                              ; mueve a BL el valor 10
    DIV bl                                                  ; realiza una división para obtener unidades y decenas
    MOV ej_03_auxiliar_01, al                               ; respalda el cociente 
    MOV ej_03_auxiliar_02, ah                               ; respalda el residuo
    mc_generico_imprimir_mensaje ej_03_mensaje_01
    mc_generico_imprimir_mensaje ej_02_mensaje_04       
    mc_generico_imprimir_digito ej_03_auxiliar_01           ; imprime las decenas
    mc_generico_imprimir_digito ej_03_auxiliar_02           ; imprime las unidades
    mc_generico_esperar
endm

; ejercicio 04 - multiplica dos valores de dos dígitos
; aclaración: la multiplicación debe ser entre valores positivos y el resultado debe
; ser menor a o igual a 99
mc_ej_04 macro         
    mc_limpiar_pantalla
    mc_generico_imprimir_mensaje ej_02_mensaje_01           ; imprime un mensaje para pedir el primer valor de la multiplicación
    mc_generico_leer_cifra ej_04_auxiliar_01                ; captura el primer valor
    mc_generico_imprimir_mensaje ej_02_mensaje_02           ; pide el segundo valor
    mc_generico_leer_cifra ej_04_auxiliar_02                ; captura el segundo valor
    MOV al, ej_04_auxiliar_01                               ; pasa a AL el primer valor
    CBW                                                     ; convierte de byte a word
    MOV bl, ej_04_auxiliar_02                               ; pasa a BL el multiplicador, es decir el segundo valor
    MUL bl                                                  ; hace la operación
    MOV bl, 10                                              ; se hace una división entre 10 para obtener las unidades y decenas del resultado de la multiplicación
    DIV bl
    MOV ej_04_auxiliar_01, al                               ; respalda los resultados para no perderlos en el momento de imprimir ya que AX se sobre-escribe en la operación
    MOV ej_04_auxiliar_02, ah                    
    mc_generico_imprimir_mensaje ej_04_mensaje_01
    mc_generico_imprimir_mensaje ej_02_mensaje_04           
    mc_generico_imprimir_digito ej_04_auxiliar_01           ; imprime decenas
    mc_generico_imprimir_digito ej_04_auxiliar_02           ; imprime unidades
    mc_generico_esperar
endm

; ejercicio 05 - divide dos valores de dos dígitos
; aclaración: imprime el punto decimal
macro mc_ej_05         
    mc_limpiar_pantalla
    mc_generico_imprimir_mensaje ej_02_mensaje_01           ; pide y captura el primer valor
    mc_generico_leer_cifra ej_05_auxiliar_01
    mc_generico_imprimir_mensaje ej_02_mensaje_02           ; pide y captura el segundo valor
    mc_generico_leer_cifra ej_05_auxiliar_02
    MOV al, ej_05_auxiliar_01                               ; pasa a AL el primer valor, el dividendo
    CBW
    MOV bl, ej_05_auxiliar_02                               ; para a BL el valor del divisor
    DIV bl                                                  ; ejecuta la división 
    MOV ej_05_auxiliar_01, al                               ; respaldo el resultado, tanto el cociente como el residuo
    MOV ej_05_auxiliar_02, ah         
    mc_generico_imprimir_mensaje ej_05_mensaje_01
    mc_generico_imprimir_mensaje ej_02_mensaje_04       
    mc_generico_imprimir_digito ej_05_auxiliar_01           ; imprime las decenas
    mc_generico_imprimir_mensaje punto                      ; imprime el punto decimal
    mc_generico_imprimir_digito ej_05_auxiliar_02           ; imprime las unidades
    mc_generico_esperar
endm

; ejercicio 06 - verifica si dos cadenas ingresadas son palíndromos
; aclaración: solo acepta palabras de 20 caractéres como máximo
macro mc_ej_06         
    mc_limpiar_pantalla
    LOCAL RECORRER, CONTINUAR, SI_ES, NO_ES, FINALIZAR      ; establece como locales las etiquetas
    MOV ej_06_cadena_01, 2EH                                ; inicializa las variables
    MOV ej_06_cadena_02, 2EH
    mc_generico_imprimir_mensaje ej_06_mensaje_01           ; pide que se ingresa la cadena uno
    mc_generico_leer_cadena ej_06_cadena_01                 ; se captura la cadena
    mc_generico_imprimir_mensaje ej_06_mensaje_02           ; pide la cadena dos
    mc_generico_leer_cadena ej_06_cadena_02                 ; captura la cadena ingresada por teclado
    mc_generico_contar_caracteres ej_06_cadena_01, ej_06_contador_01        ; mediante un macro se obtiene la longitud de la cadena uno
    mc_generico_contar_caracteres ej_06_cadena_02, ej_06_contador_02        ; se obtiene la longitud de la cadena dos
    MOV ax, ej_06_contador_01                               ; mueve a AX la longitud de la cadena uno
    MOV bx, ej_06_contador_02                               ; mueve a BX la longitud de la cadena dos
    CMP ax, bx                                              ; compara las longitudes, si son diferentes jamás pueden ser un palíndromo
    JNE NO_ES                                               ; va a la etiqueta que contiene el código que imprime el mensaje respectivo, no es un palíndromo
    MOV si, 0                                               ; si las longitudes son iguales entonces hay posibilidades de que sean palíndromos entonces se inicializa el contador 
    MOV di, ej_06_contador_01                               ; se inicializa el segundo contado DI (destination index) para recorrer vectores
    dec di                                                  ; decrementa en 1 el valor del contador (practicidad)
    RECORRER:                                               ; ciclo para recorrer las cadenas
        CMP di, 0                                           ; si el contador DI es mayor o igual a 0 entonces continue
        JAE CONTINUAR                                       ; si el valor de DI es menor a cero, pare
        JB SI_ES
    CONTINUAR:                                              ; compara los valores del primer caracter de la cadena uno contra el último carácter de la segunda cadena
        MOV al, ej_06_cadena_01[si]                         ; SI apunta al inicio, DI apunta al final
        CMP al, ej_06_cadena_02[di]                         ; ejemplo de secuencia de comparaciones: 
        JNE NO_ES                                           ; [R]ATA == ATA[R] - R[A]TA == AT[A]R; RA[T]A == A[T]AR - RAT[A] == [A]TAR - FIN
        DEC di                                              ; decrementa el contador que apunta la final del vector
        INC si                                              ; incrementa el contador que apunta al inicio del vector
        JE RECORRER                                         ; salta a la etiqueta que ejecuta el ciclo
    SI_ES:
        mc_generico_imprimir_mensaje ej_06_mensaje_03       ; imprime un mensaje afirmando que es un palíndromo
        JMP FINALIZAR                                       
    NO_ES:
        mc_generico_imprimir_mensaje ej_06_mensaje_04       ; imprime un mensaje negando que es un palíndromo       
    
    FINALIZAR:
        mc_generico_esperar
endm

; ejercicio 07 - compara dos cadenas que ingresan por teclado e informa si son iguales o diferentes
macro mc_ej_07         
    mc_limpiar_pantalla
    mc_generico_imprimir_mensaje ej_07_mensaje_01           ; pide y captura la cadena uno
    mc_generico_leer_cadena ej_07_cadena_01                 ; captura de teclado
    mc_generico_imprimir_mensaje ej_07_mensaje_02           ; pide la segunda cadena
    mc_generico_leer_cadena ej_07_cadena_02                 ; captura de teclado
    MOV si, 00h                                             ; inicializa SI que se usará como contador para recorrer las cadenas o vectores
    REVISAR:
        MOV al, ej_07_cadena_01[si]                         ; pasa a AL el carácter de la cadena uno
        CMP ej_07_cadena_02[si], al                         ; compara el cáracter de la cadena uno contra el caracter de la cadena dos
        JE SEGUIR                                           ; si son iguales sigue comparando
        JNE PARAR                                           ; si no son iguales para de comparar y salta al fin del ciclo e imprime que no son iguales
    SEGUIR:
        CMP al, "$"                                         ; revisa que el carácter no se el final de la cadena
        JE IGUALES                                          ; si son iguales a "$", es el fin de la cadena y para de comparar e imprime que no son iguales
        JNE NO_EOL                                          ; si el carácter no es "$" sigue leyendo
    PARAR:
        JMP DIFERENTES                                      ; salta a la etiqueta e imprime que son cadenas diferentes
    NO_EOL:
        INC si                                              ; incrementa el contador para seguir revisando carácteres
        JMP REVISAR
    IGUALES:
        mc_generico_imprimir_mensaje ej_07_mensaje_03       ; imprime un mensaje afirmando que son cadenas idénticas
        JMP FINALIZAR
        
    DIFERENTES:
        mc_generico_imprimir_mensaje ej_07_mensaje_04       ; imprime un mensaje afirmando que son cadenas diferentes

    FINALIZAR:
        mc_generico_esperar
endm

; ejercicio 09 - lee carácteres hasta que se presione la tecla ESC
macro mc_ej_09  
    LOCAL CICLO, PARAR, SEGUIR
    mc_limpiar_pantalla
    mc_generico_imprimir_mensaje ej_09_mensaje_01
    CICLO:
        mc_generico_imprimir_mensaje ej_09_mensaje_02
        MOV al, 0H ; pongo un vacío en AL
        MOV ah, 01H ; funcion de lectura, lo leido se almacena en ah
        INT 21h ; ejecuta la función de lectura
        CMP AL, 1BH ; valor de ESC en HEX
        JNE SEGUIR
        JE PARAR
    SEGUIR:
        JMP CICLO     
    PARAR:
        mc_generico_imprimir_mensaje ej_09_mensaje_03
        mc_generico_esperar
endm      

; ejercicio 10 - captura y ordena un arreglo de máximo 10 valores numéricos
macro mc_ej_10  
    LOCAL LECTURA, FIN_LECTURA, CICLO_INTERNO, CICLO_EXTERNO, INTERCAMBIAR, EVALUAR, FIN
    mc_limpiar_pantalla
    mc_generico_imprimir_mensaje ej_10_mensaje_01
    mc_inicializar_arreglo ej_11_vector
    mc_generico_llenar_arreglo ej_10_vector, ej_10_mensaje_02, ej_10_mensaje_03, ej_10_mensaje_04
    mc_generico_contar_caracteres ej_10_vector, ej_10_contador
    INC ej_10_contador
    CICLO_EXTERNO:
        MOV si, 00
        MOV di, 01           
        DEC ej_10_contador
        CMP ej_10_contador, 0
        JA  CICLO_INTERNO
        JMP FIN
        
        CICLO_INTERNO:             
            MOV al, ej_10_vector[si]
            CMP al, ej_10_vector[di]
            JA INTERCAMBIAR
            JBE  EVALUAR
            
        INTERCAMBIAR:      
            MOV al, ej_10_vector[si]
            MOV bl, ej_10_vector[di]
            MOV ej_10_vector[di], al
            MOV ej_10_vector[si], bl
            JMP EVALUAR
        
        EVALUAR:                  
            CMP di, ej_10_contador
            JAE  CICLO_EXTERNO
            INC di
            INC si
            JMP CICLO_INTERNO
    FIN:
        mc_generico_imprimir_mensaje ej_10_mensaje_05       
        mc_imprimir_arreglo ej_10_vector  
        mc_generico_esperar
endm
    
; ejercicio 11 - captura y ordena un arreglo de máximo 10 valores numéricos
macro mc_ej_11
    LOCAL CICLO_INTERNO, CICLO_EXTERNO, INTERCAMBIAR, EVALUAR, FIN
    mc_limpiar_pantalla
    mc_generico_imprimir_mensaje ej_11_mensaje_01
    mc_inicializar_arreglo ej_11_vector
    mc_generico_llenar_arreglo ej_11_vector, ej_11_mensaje_02, ej_11_mensaje_03, ej_11_mensaje_04
    mc_generico_contar_caracteres ej_11_vector, ej_11_contador
    INC ej_11_contador
    CICLO_EXTERNO:
        MOV si, 00
        MOV di, 01           
        DEC ej_11_contador
        CMP ej_11_contador, 0
        JA  CICLO_INTERNO
        JMP FIN
        
        CICLO_INTERNO:             
            MOV al, ej_11_vector[si]
            CMP al, ej_11_vector[di]
            JAE EVALUAR
            JB  INTERCAMBIAR
            
        INTERCAMBIAR:      
            MOV al, ej_11_vector[si]
            MOV bl, ej_11_vector[di]
            MOV ej_11_vector[di], al
            MOV ej_11_vector[si], bl
            JMP EVALUAR
        
        EVALUAR:                  
            CMP di, ej_11_contador
            JAE  CICLO_EXTERNO
            INC di
            INC si
            JMP CICLO_INTERNO
    FIN:
        mc_generico_imprimir_mensaje ej_11_mensaje_05       
        mc_imprimir_arreglo ej_11_vector  
        mc_generico_esperar
endm 

; main 
.startup
    LOOP_MENU:      
        mc_generico_imprimir_menu                           ; usando un macro imprime el menú del programa
        mov ah, 01h                                         ; captura un carácter ingresado por teclado 
        int 21h
        
        ; se realizan comparaciones para saber cual de los ejercicios se ejecutará
        ; este codigo actua como IF ELSE, SWITCH o CASE
        CMP al, "A"                                         ; si el valor es una "A", ejecuta el ejercicio 1
        JE LBL_EJ_01                                        ; una comparación para saber si el carácter ingresado es una "A"
      
        CMP al, "B"
        JE LBL_EJ_02
        
        CMP al, "C"
        JE LBL_EJ_03
        
        CMP al, "D"
        JE LBL_EJ_04
        
        CMP al, "E"
        JE LBL_EJ_05
        
        CMP al, "F"
        JE LBL_EJ_06
        
        CMP al, "G" 
        JE LBL_EJ_07
        
        CMP al, "H"
        JE LBL_EJ_08
        
        CMP al, "I"
        JE LBL_EJ_09
        
        CMP al, "J"
        JE LBL_EJ_10
        
        CMP al, "K"
        JE LBL_EJ_11
        
        CMP al, "X"                                         ; ingresando una "X" se rompe el ciclo y termina el programa
        JE LBL_EJ_00
        
        JMP LBL_SEGUIR                                      ; si no se ingreso ningún valor válido entonces se vuelve a imprimir el menú
        
        
        ; se usan etiquetas para ejecutar la opción correspondiente
        LBL_EJ_01:                                          ; etiqueta para el ejercicio uno
            mc_ej_01                                        ; cuando termina el ejercicio vuelve al ciclo e imprime el menú 
            JMP LOOP_MENU
                         
        LBL_EJ_02:
            mc_ej_02 
            JMP LOOP_MENU
        
        LBL_EJ_03:
            mc_ej_03  
            JMP LOOP_MENU
            
        LBL_EJ_04:
            mc_ej_04
            JMP LOOP_MENU
            
        LBL_EJ_05:
            mc_ej_05
            JMP LOOP_MENU
            
        LBL_EJ_06:
            mc_ej_06
            JMP LOOP_MENU    
                         
        LBL_EJ_07:
            mc_ej_07
            JMP LOOP_MENU
        
        LBL_EJ_08:
            ;mc_ej_08
            JMP LOOP_MENU
            
        LBL_EJ_09:
            mc_ej_09
            JMP LOOP_MENU
            
        LBL_EJ_10:
            mc_ej_10
            JMP LOOP_MENU
            
        LBL_EJ_11:
        ;    mc_ej_11
            JMP LOOP_MENU
        
        LBL_EJ_00:  
            mc_generico_imprimir_adios
            mc_generico_finalizar
         
        LBL_SEGUIR:
            JMP LOOP_MENU   
end
