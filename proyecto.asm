; PROYECTO PROGRAMADO
; CURSO ORGANIZACIÓN DE ESTRUCTURAS
; REALIZADO POR ESTUDIANTES UNIVERSIDAD AMERICANA
; III CUATRIMESTRE - 2014
; IR A LA LINEA NÚMERO 50 PARA OMITIR ESTA INFORMACIÓN CON FINES PEDAGÓGICOS.
; MODELOS DE MEMORIA
; Model TINY CS = DS En 1 solo segmento de 64K
; Model SMALL CS = 64Kb DS = 64Kb
; Model MEDIUM CS > 64Kb DS < 64Kb
; Model COMPAC CS < 64Kb DS > 64Kb
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

.model compact
.stack 64
.data                                                                                             
    menu_cadena_01 DB "················································································",13,10,"$"
    menu_cadena_02 DB "·                    INGENIERIA EN SISTEMAS DE INFORMACION                     ·",13,10,"$"
    menu_cadena_03 DB "·                         ORGANIZACION DE ESTRUCTURAS                          ·",13,10,"$"
    menu_cadena_04 DB "·                            III CUATRIMESTRE 2014                             ·",13,10,"$"
    menu_cadena_05 DB "·                                 PROGRAMADOR                                  ·",13,10,"$"
    menu_cadena_06 DB "·KAREN         JOSEPH        JAIRO          GUILLERMO         JUAN             ·",13,10,"$"
    menu_cadena_07 DB "················································································",13,10,"$"
    menu_cadena_08 DB "· [A] HOLA MUNDO     [B] SUMA            [C] RESTA          [D] MULTIPLICACION ·",13,10,"$"
    menu_cadena_09 DB "· [E] DIVISION       [F] PALINDROMO      [G] CADENA IGUAL   [H] SUBCADENA      ·",13,10,"$"
    menu_cadena_10 DB "· [I] ESPERAR [ESC]  [J] ORDENAR A-Z     [K] ORDENAR Z-A    [X] SALIR          ·",13,10,"$"  
    menu_cadena_11 DB "················································································",13,10,"$"
    menu_cadena_12 DB "> INGRESE UNA OPCION: $"
    
    menu_cadena_13 DB "················································································",13,10,"$"
    menu_cadena_14 DB "·                                                                              ·",13,10,"$"
    menu_cadena_15 DB "·                                                                              ·",13,10,"$"
    menu_cadena_16 DB "·            _/_/        _/_/_/        _/_/_/        _/_/          _/_/_/      ·",13,10,"$"
    menu_cadena_17 DB "·         _/    _/      _/    _/        _/        _/    _/      _/             ·",13,10,"$"
    menu_cadena_18 DB "·        _/_/_/_/      _/    _/        _/        _/    _/        _/_/          ·",13,10,"$"
    menu_cadena_19 DB "·       _/    _/      _/    _/        _/        _/    _/            _/         ·",13,10,"$"
    menu_cadena_20 DB "·      _/    _/      _/_/_/        _/_/_/        _/_/        _/_/_/            ·",13,10,"$"
    menu_cadena_21 DB "·                                                                              ·",13,10,"$"
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
    ej_10_mensaje_04 DB 13,10,"ARREGLO  DESORDENADO:$"
    ej_10_mensaje_05 DB 13,10,"ARREGLO ORDENADO 0-9:$"
    ; vector
    ej_10_vector DB 11 dup ("$")
    ; variables numéricas
    ej_10_contador DW 0
     
    ; ejercicio 11
    ; cadenas
    ej_11_mensaje_01 DB 13,10,"ARREGLO ORDENADO 0-9:$"
     
    ; simbolos genéricos
    punto DB ".$"     
    barra DB "  $"  
    nuevalinea DB 13,10,"$"
 
.code            

; termina el programa en ejecución
macro mc_generico_finalizar
    ;MOV ah, 0h
    ;INT 16h
    MOV ax, 0c07h ; 0c07h espera a que el usuario presione una tecla
    INT 21h
    .exit
endm  

; espera un carácter cualquiera, se usa como pausa
macro mc_generico_esperar
    MOV ah, 01h ; funcion de lectura
    INT 21h 
endm

; limpia la pantalla
macro mc_limpiar_pantalla
    MOV ah, 00h
    MOV al, 03h
    INT 10h
endm
                              
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

mc_generico_imprimir_adios macro    
    mc_limpiar_pantalla
    mc_generico_imprimir_mensaje menu_cadena_13
    mc_generico_imprimir_mensaje menu_cadena_14
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
mc_generico_imprimir_mensaje macro parametro
    MOV dx, offset parametro
    MOV ah, 09H
    INT 21H
endm

; macro de uso genérico para leer cadenas ingresadas por teclado
mc_generico_leer_cadena macro parametro
    LOCAL LEER
    MOV si, 00h       ; inicializa SI que se usará como contador
    LEER:
        MOV ax, 0000 ; inicializa el contenido de AX
        MOV ah, 01h ; funcion de lectura
        INT 21h ; ejecuta la lectura
        MOV parametro[si], al ; guarda el caracter leído en la posición que tiene SI
        INC si ; incrementa el contador
        CMP al, 0dh ; revisa que no se ha presionado ENTER
        JNE LEER ; si no es igual continúa leyendo
endm

; imprime un valor numérico de un dígito en base decimal
mc_generico_imprimir_digito macro parametro
    MOV dl, parametro
    ADD dl, 48 ; los digitos en ASCII estan entre 48 y 57
    MOV ah, 02h ; funcion para imprimir
    INT 21h ; ejecuta la funcion anterior
endm

; macro para imprimir un arreglo de valores numéricos
mc_imprimir_arreglo macro parametro
    LOCAL CICLO, FINAL, IMPRIMIR
    MOV si, 00
    
    CICLO:
        MOV al, parametro[si]
        CMP al, "$"
        JNE IMPRIMIR
        JE  FINAL
     
    IMPRIMIR:      
        mc_generico_imprimir_mensaje barra
        mc_generico_imprimir_digito parametro[si]
        INC si
        JMP CICLO
        
    FINAL: 
        mc_generico_imprimir_mensaje nuevalinea
endm

; macro para saber la longitud de una cadena
macro mc_generico_contar_caracteres cadena, contador
    LOCAL CONTAR, PARAR, SEGUIR
    MOV si, 00h
    CONTAR:
    MOV al, cadena[si]
    CMP cadena[si], "$"
    JE PARAR
    JNE SEGUIR
    SEGUIR:
    INC si
    JMP CONTAR
    PARAR:
    DEC si ; quita eol
    MOV contador, si
    endm
    ; macro para leer cifras de dos dígitos, primero lee las decenas, luego las unidades
    mc_generico_leer_cifra macro parametro
    LOCAL DECENA, UNIDAD
    DECENA:
    MOV ah, 01h
    INT 21h
    SUB al, 48
    CMP al, 10
    JA DECENA
    MOV bl, 10
    MUL bl
    MOV parametro, al
    UNIDAD:
    MOV ah, 01h
    INT 21H
    SUB al, 48
    CMP al, 10
    JA UNIDAD
    ADD al, parametro
    MOV parametro, al
endm
          
macro mc_inicializar_arreglo 
    MOV ej_10_vector[0], "$"    
    MOV ej_10_vector[1], "$"    
    MOV ej_10_vector[2], "$"    
    MOV ej_10_vector[3], "$"    
    MOV ej_10_vector[4], "$"    
    MOV ej_10_vector[5], "$"    
    MOV ej_10_vector[6], "$"    
    MOV ej_10_vector[7], "$"    
    MOV ej_10_vector[8], "$"    
    MOV ej_10_vector[9], "$"       
    MOV ej_10_vector[0ah], "$"       
endm
                  
; ejercicio 01 - imprime "hola mundo"
macro mc_ej_01         
    mc_limpiar_pantalla
    mc_generico_imprimir_mensaje ej_01_mensaje_01 
    mc_generico_esperar   
endm

; ejercicio 02 - suma dos valores de dos dígitos
; aclaración: la suma de valores debe ser inferior a 99
mc_ej_02 macro         
    mc_limpiar_pantalla
    mc_generico_imprimir_mensaje ej_02_mensaje_01
    mc_generico_leer_cifra ej_02_auxiliar_01
    mc_generico_imprimir_mensaje ej_02_mensaje_02
    mc_generico_leer_cifra ej_02_auxiliar_02
    MOV al, ej_02_auxiliar_01
    ADD al, ej_02_auxiliar_02
    CBW
    MOV bl, 10
    DIV bl
    MOV ej_02_auxiliar_01, al
    MOV ej_02_auxiliar_02, ah
    mc_generico_imprimir_mensaje ej_02_mensaje_03
    mc_generico_imprimir_mensaje ej_02_mensaje_04        ; imprime mensaje de resultado
    mc_generico_imprimir_digito ej_02_auxiliar_01
    mc_generico_imprimir_digito ej_02_auxiliar_02
    mc_generico_esperar
endm

; ejercicio 03 - resta dos valores de dos dígitos
; aclaración: la resta debe dar un número entre 0 y 99
mc_ej_03 macro         
    mc_limpiar_pantalla
    mc_generico_imprimir_mensaje ej_02_mensaje_01
    mc_generico_leer_cifra ej_03_auxiliar_01
    mc_generico_imprimir_mensaje ej_02_mensaje_02
    mc_generico_leer_cifra ej_03_auxiliar_02
    MOV al, ej_03_auxiliar_01
    SUB al, ej_03_auxiliar_02
    CBW
    MOV bl, 10
    DIV bl
    MOV ej_03_auxiliar_01, al
    MOV ej_03_auxiliar_02, ah       
    mc_generico_imprimir_mensaje ej_03_mensaje_01
    mc_generico_imprimir_mensaje ej_02_mensaje_04       
    mc_generico_imprimir_digito ej_03_auxiliar_01
    mc_generico_imprimir_digito ej_03_auxiliar_02
    mc_generico_esperar
endm

; ejercicio 04 - multiplica dos valores de dos dígitos
; aclaración: la multiplicación debe ser entre valores positivos y el resultado debe
; ser menor a o igual a 99
mc_ej_04 macro         
    mc_limpiar_pantalla
    mc_generico_imprimir_mensaje ej_02_mensaje_01
    mc_generico_leer_cifra ej_04_auxiliar_01
    mc_generico_imprimir_mensaje ej_02_mensaje_02
    mc_generico_leer_cifra ej_04_auxiliar_02
    MOV al, ej_04_auxiliar_01
    CBW
    MOV bl, ej_04_auxiliar_02
    MUL bl
    MOV bl, 10
    DIV bl
    MOV ej_04_auxiliar_01, al
    MOV ej_04_auxiliar_02, ah                    
    mc_generico_imprimir_mensaje ej_04_mensaje_01
    mc_generico_imprimir_mensaje ej_02_mensaje_04       
    mc_generico_imprimir_digito ej_04_auxiliar_01
    mc_generico_imprimir_digito ej_04_auxiliar_02
    mc_generico_esperar
endm

; ejercicio 05 - divide dos valores de dos dígitos
; aclaración: imprime el punto decimal
macro mc_ej_05         
    mc_limpiar_pantalla
    mc_generico_imprimir_mensaje ej_02_mensaje_01
    mc_generico_leer_cifra ej_05_auxiliar_01
    mc_generico_imprimir_mensaje ej_02_mensaje_02
    mc_generico_leer_cifra ej_05_auxiliar_02
    MOV al, ej_05_auxiliar_01
    CBW
    MOV bl, ej_05_auxiliar_02
    DIV bl
    MOV ej_05_auxiliar_01, al
    MOV ej_05_auxiliar_02, ah         
    mc_generico_imprimir_mensaje ej_05_mensaje_01
    mc_generico_imprimir_mensaje ej_02_mensaje_04       
    mc_generico_imprimir_digito ej_05_auxiliar_01
    mc_generico_imprimir_mensaje punto
    mc_generico_imprimir_digito ej_05_auxiliar_02
    mc_generico_esperar
endm

; ejercicio 06 - verifica si dos cadenas ingresadas son palíndromos
; aclaración: solo acepta palabras de 20 caractéres como máximo
macro mc_ej_06         
    mc_limpiar_pantalla
    LOCAL RECORRER, CONTINUAR, SI_ES, NO_ES, FINALIZAR
    MOV ej_06_cadena_01, 2EH
    MOV ej_06_cadena_02, 2EH
    mc_generico_imprimir_mensaje ej_06_mensaje_01
    mc_generico_leer_cadena ej_06_cadena_01
    mc_generico_imprimir_mensaje ej_06_mensaje_02
    mc_generico_leer_cadena ej_06_cadena_02
    mc_generico_contar_caracteres ej_06_cadena_01, ej_06_contador_01
    mc_generico_contar_caracteres ej_06_cadena_02, ej_06_contador_02
    MOV ax, ej_06_contador_01
    MOV bx, ej_06_contador_02
    CMP ax, bx
    JNE NO_ES
    MOV si, 0
    MOV di, ej_06_contador_01
    dec di
    RECORRER:
        CMP di, 0
        JAE CONTINUAR
        JB SI_ES
    CONTINUAR:
        MOV al, ej_06_cadena_01[si]
        CMP al, ej_06_cadena_02[di]
        JNE NO_ES
        DEC di
        INC si
        JE RECORRER
    SI_ES:
        mc_generico_imprimir_mensaje ej_06_mensaje_03
        JMP FINALIZAR
    NO_ES:
        mc_generico_imprimir_mensaje ej_06_mensaje_04              
    
    FINALIZAR:
        mc_generico_esperar
endm

; ejercicio 07 - compara dos cadenas que ingresan por teclado e informa si son iguales o diferentes
macro mc_ej_07         

    mc_limpiar_pantalla
    mc_generico_imprimir_mensaje ej_07_mensaje_01
    mc_generico_leer_cadena ej_07_cadena_01
    mc_generico_imprimir_mensaje ej_07_mensaje_02
    mc_generico_leer_cadena ej_07_cadena_02
    MOV si, 00h ; inicializa SI que se usará como contador para recorrer las cadenas
    REVISAR:
        MOV al, ej_07_cadena_01[si]
        CMP ej_07_cadena_02[si], al
        JE SEGUIR
        JNE PARAR
    SEGUIR:
        CMP al, "$"
        JE IGUALES
        JNE NO_EOL
    PARAR:
        JMP DIFERENTES
    NO_EOL:
        INC si
        JMP REVISAR
    IGUALES:
        mc_generico_imprimir_mensaje ej_07_mensaje_03
        JMP FINALIZAR
        
    DIFERENTES:
        mc_generico_imprimir_mensaje ej_07_mensaje_04

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
    LOCAL LECTURA, REVISAR_INFERIOR, REVISAR_SUPERIOR, FIN_LECTURA, CICLO_INTERNO, CICLO_EXTERNO, INTERCAMBIAR, EVALUAR, FIN
    mc_limpiar_pantalla
    mc_generico_imprimir_mensaje ej_10_mensaje_01
    mc_inicializar_arreglo
    MOV si, 00
    LECTURA:
        CMP si, 9
        JA  FIN_LECTURA
        mc_generico_imprimir_mensaje ej_10_mensaje_02
        MOV ax, 0000 
        MOV ah, 01h 
        INT 21h    
        MOV bl, al 
        SUB al, 30h
        MOV ej_10_vector[si], al  
        INC si 
        CMP bl, 0dh        
        JE  FIN_LECTURA     
        JNE LECTURA
 
    FIN_LECTURA: 
       mc_limpiar_pantalla
       mc_generico_imprimir_mensaje ej_10_mensaje_03
       mc_generico_imprimir_mensaje ej_10_mensaje_04
       mc_imprimir_arreglo ej_10_vector
    
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
            JA  INTERCAMBIAR
            JMP EVALUAR
            
        INTERCAMBIAR:      
            MOV al, ej_10_vector[si]
            MOV bl, ej_10_vector[di]
            MOV ej_10_vector[di], al
            MOV ej_10_vector[si], bl
            JMP EVALUAR 
        
        EVALUAR:                  
            CMP si, ej_10_contador
            INC di
            INC si
            JA  CICLO_EXTERNO
            JMP CICLO_INTERNO             

    FIN:       
        mc_generico_imprimir_mensaje ej_10_mensaje_05
        mc_imprimir_arreglo ej_10_vector          
endm 

; ejercicio 11 - captura y ordena un arreglo de máximo 10 valores numéricos
macro mc_ej_11                                  
    
endm

; main 
.startup
    LOOP_MENU:      
        mc_generico_imprimir_menu
        mov ah, 01h
        int 21h
        
        CMP al, "A"
        JE LBL_EJ_01
        
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
        
        CMP al, "X"
        JE LBL_EJ_00
        
        JMP LBL_SEGUIR
        
        LBL_EJ_01:
            mc_ej_01       
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
            ;mc_ej_11
            JMP LOOP_MENU
        
        LBL_EJ_00:  
            mc_generico_imprimir_adios
            mc_generico_finalizar
         
        LBL_SEGUIR:
            JMP LOOP_MENU   
end
