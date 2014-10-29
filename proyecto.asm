; PROYECTO PROGRAMADO
; CURSO ORGANIZACIÓN DE ESTRUCTURAS
; REALIZADO POR ESTUDIANTES UNIVERSIDAD AMERICANA
; III CUATRIMESTRE - 2014

; IR A LA LINEA NÚMERO 55 PARA OMITIR ESTA INFORMACIÓN CON FINES PEDAGÓGICOS.
; MODELOS DE MEMORIA
; Model  TINY          CS = DS       En 1 solo segmento de 64K
; Model  SMALL         CS = 64Kb     DS = 64Kb
; Model  MEDIUM        CS > 64Kb     DS < 64Kb
; Model  COMPAC        CS < 64Kb     DS > 64Kb
; Model  LARGE         CS > 64Kb     DS > 64Kb(Los arreglos de datos deben ocupar menos de 64 K)
; Model  HUGE          CS > 64Kb     DS > 64Kb(Los arreglos de datos pueden ocupar mas de 64 Kb)

; REGISTROS DE USO GENERAL

; [0 0 0 0 0 0 0 0] [AH(8) AL(8)] [AX(16)] 
; [0 0 0 0 0 0 0 0] [BH(8) BL(8)] [BX(16)] 
; [0 0 0 0 0 0 0 0] [CH(8) CL(8)] [CX(16)] 
; [0 0 0 0 0 0 0 0] [DH(8) DL(8)] [DX(16)] 
                                          
; 2 ^ 8 = 256 -> 0..255 VALORES ADMITIDOS  
; 2 ^ 8 x 2 ^ 8 = 65536 - 1 = 65538 LLENA EL REGISTRO 

; ALGUNAS INTERRUPCIONES Y SUS RESPECTIVAS FUNCIONES
; SIEMPRE LA FUNCION SE PASA A LA PARTE ALTA DE AX, ES DECIR A AH
; INT. FUN.   DESC.
; 10h  00h    establece el modo de video
; 10h  01h    establece el tamaño del cursor
; 10h  02h    fija el cursor                
; 10h  03h    lee la posicion del cursor
; 10h  04h    lee la posición de la pluma óptica
; 10h  05h    selecciona la página activa
; 10h  06h    recorre la pantalla hacia arriba       
; 10h  07h    recorre la pantalla hacia abajo
; 10h  08h    lee el atributo o caracter que se encuentra en la posicion del cursor
; 10h  09h    despliega el atributo o caracter que se encuentra en la posicion del cursor
; 10h  0ah    despliega el caracter en la posición del cursor
; 10h  0bh    establece la paleta de colores
; 10h  0ch    escribe el pixel punto
; 10h  0dh    lee el pixel punto
; 10h  0eh    escribe el teletipo
; 10h  0fh    obtiene el modo actual de video
; 10h  11h    genera carácter
; 10h  12h    selecciona rutina alterna de pantalla
; 10h  13h    despliega cadena de caracteres
; 10h  1bh    regresa la información de funcionalidad o estado
; 10h  1ch    guarda o restaura el estado de vídeo
; 21h  02h    despliega en pantalla digitos
; 21h  09h    despliega en pantalla cadenas
; 21h  0Ah    entrada desde teclado
; 21h  03Fh   entrada desde teclado
; 21h  40h    despliega en pantalla

.model compact      
.stack 64
.data 
    ; ejercicio 01   
    ; cadenas
    ej_01_mensaje_01 DB "¡HOLA MUNDO!", 13, 10, "$"
    
    ; ejercicio 02
    ; cadenas
    ej_02_mensaje_01 DB "INGRESE EL PRIMER VALOR DE DOS DIGITOS $"
    ej_02_mensaje_02 DB 13,10,"INGRESE EL SEGUNDO VALOR DE DOS DIGITOS $"
    ej_02_mensaje_03 DB 13,10,"RESULTADO: $"
    ; variable numéricas
    ej_02_auxiliar_01 DB 0
    ej_02_auxiliar_02 DB 0
     
    ; ejercicio 03
    ; variables numéricas
    ej_03_auxiliar_01 DB 0
    ej_03_auxiliar_02 DB 0 
    
    ; ejercicio 04
    ; variables numéricas
    ej_04_auxiliar_01 DB 0
    ej_04_auxiliar_02 DB 0 
        
    ; ejercicio 05
    ; variable numéricas
    ej_05_auxiliar_01 DB 0
    ej_05_auxiliar_02 DB 0     
    
    ; ejercicio 06      
    ej_06_mensaje_01 DB "INGRESE UNA CADENA $", 13, 10, "$"
    ej_06_mensaje_02 DB 13,10,"ES UN PALINDROMO $"
    ej_06_mensaje_03 DB "NO ES UN PALINDROMO $"
    ; variable numéricas
    ej_06_cadena_01 DB 20 dup('$')
    ej_06_cadena_02 DB 20 dup('$')
    ej_06_contador_01 DW 0 
    ej_06_contador_02 DW 0
                
    ; ejercicio 07
    ; cadenas
    ej_07_mensaje_01 DB "INGRESE UNA CADENA $", 13, 10, "$"
    ej_07_mensaje_02 DB 13,10,"INGRESE OTRA CADENA $"
    ej_07_mensaje_03 DB "LAS CADENAS SON IGUALES $"
    ej_07_mensaje_04 DB 13,10,"LAS CADENAS SON DIFERENTES $"
    ; vectores
    ej_07_cadena_01 DB 50 dup('$')
    ej_07_cadena_02 DB 50 dup('$')  
    
    ; ejercicio 09
    ; cadenas
    ej_09_mensaje_01 DB "ENSABLADOR, PRESIONE [ESC] PARA SALIR...", 13, 10, "$"
    ej_09_mensaje_02 DB 13,10,"INGRESE UN CARÁCTER ", "$"
    ej_09_mensaje_03 DB 13,10,"LO CONSEGUISTE, FIN DEL PROGRAMA ", "$"
    
    ; simbolos genéricos
    punto DB ".$"
    
.code  
    ; termina el programa en ejecución           
    macro mc_generico_finalizar
        MOV ah, 0h                    
        INT 16h          
        MOV ax, 0c07h                 ; 0c07h espera a que el usuario presione una tecla
        INT 21h
        .exit
    endm 
    
    ; limpia la pantalla       
    macro mc_limpiar_pantalla
        MOV ah, 00h
        MOV al, 03h
        INT 10h
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
        MOV si, 00h                            ; inicializa SI que se usará como contador
        LEER:
            MOV ax, 0000                       ; inicializa el contenido de AX
            MOV ah, 01h                        ; funcion de lectura
            INT 21h                            ; ejecuta la lectura
            MOV parametro[si], al              ; guarda el caracter leído en la posición que tiene SI 
            INC si                             ; incrementa el contador          
            CMP al, 0dh                        ; revisa que no se ha presionado ENTER
            JNE LEER                           ; si no es igual continúa leyendo  
    endm
    
    ; imprime un valor numérico de un dígito en base decimal
    mc_generico_imprimir_digito macro parametro
        MOV dl, parametro
        ADD dl, 48                    ; los digitos en ASCII estan entre 48 y 57
        MOV ah, 02h                   ; funcion para imprimir
        INT 21h                       ; ejecuta la funcion anterior
    endm                                              
    
    ; macro para saber la longitud de una cadena
    macro mc_generico_contar_caracteres cadena, contador
        LOCAL CONTAR, PARAR, SEGUIR
        MOV si, 00h                            
        CONTAR:  
            MOV al, cadena[si]
            CMP cadena[si], "$"
            JE  PARAR
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
          
    ; ejercicio 01 - imprime "hola mundo"        
    macro mc_ej_01 
        mc_generico_imprimir_mensaje ej_01_mensaje_01    
    endm     
                  
    ; ejercicio 02 - suma dos valores de dos dígitos
    ; aclaración: la suma de valores debe ser inferior a 99
    mc_ej_02 macro                         
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
        mc_generico_imprimir_mensaje ej_02_mensaje_03  ; imprime mensaje de resultado
        mc_generico_imprimir_digito ej_02_auxiliar_01
        mc_generico_imprimir_digito ej_02_auxiliar_02
    endm
    
    ; ejercicio 03 - resta dos valores de dos dígitos
    ; aclaración: la resta debe dar un número entre 0 y 99
    mc_ej_03 macro                         
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
        mc_generico_imprimir_mensaje ej_02_mensaje_03  ; imprime mensaje de resultado
        mc_generico_imprimir_digito ej_03_auxiliar_01
        mc_generico_imprimir_digito ej_03_auxiliar_02
    endm
    
    ; ejercicio 04 - multiplica dos valores de dos dígitos
    ; aclaración: la multiplicación debe ser entre valores positivos y el resultado debe
    ; ser menor a o igual a 99
    mc_ej_04 macro                         
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
        mc_generico_imprimir_mensaje ej_02_mensaje_03  ; imprime mensaje de resultado
        mc_generico_imprimir_digito ej_04_auxiliar_01
        mc_generico_imprimir_digito ej_04_auxiliar_02
    endm
    
    ; ejercicio 05 - divide dos valores de dos dígitos
    ; aclaración: imprime el punto decimal
    macro mc_ej_05 
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
        mc_generico_imprimir_mensaje ej_02_mensaje_03  ; imprime mensaje de resultado
        mc_generico_imprimir_digito ej_05_auxiliar_01
        mc_generico_imprimir_mensaje punto 
        mc_generico_imprimir_digito ej_05_auxiliar_02
    endm
    
    ; ejercicio 06 - verifica si dos cadenas ingresadas son palíndromos
    ; aclaración: solo acepta palabras de 20 caractéres como máximo
    macro mc_ej_06                             
        LOCAL RECORRER, CONTINUAR, SI_ES, NO_ES
        
        MOV ej_06_cadena_01, 2EH
        MOV ej_06_cadena_02, 2EH
        
        mc_generico_imprimir_mensaje ej_06_mensaje_01
        mc_generico_leer_cadena ej_06_cadena_01 
        mc_limpiar_pantalla   
        mc_generico_imprimir_mensaje ej_06_mensaje_01
        mc_generico_leer_cadena ej_06_cadena_02
    
        mc_generico_contar_caracteres ej_06_cadena_01, ej_06_contador_01
        mc_generico_contar_caracteres ej_06_cadena_02, ej_06_contador_02
        mc_limpiar_pantalla
                                    
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
            JB  SI_ES
             
        CONTINUAR: 
            MOV al, ej_06_cadena_01[si] 
            CMP al, ej_06_cadena_02[di]
            JNE NO_ES 
            DEC di
            INC si
            JE  RECORRER     
                                           
        SI_ES:
            mov bl, 1
            mc_generico_imprimir_mensaje ej_06_mensaje_02
            .exit
            
        NO_ES:        
            mov bl, 0
            mc_generico_imprimir_mensaje ej_06_mensaje_03
            .exit
    endm
            
    ; ejercicio 07 - compara dos cadenas que ingresan por teclado e informa si son iguales o diferentes
    macro mc_ej_07                  
        mc_generico_imprimir_mensaje ej_07_mensaje_01
        mc_generico_leer_cadena ej_07_cadena_01
         
        mc_generico_imprimir_mensaje ej_07_mensaje_02
        mc_generico_leer_cadena ej_07_cadena_02
        
        MOV si, 00h                            ; inicializa SI que se usará como contador para recorrer las cadenas
        REVISAR:
            MOV al, ej_07_cadena_01[si] 
            CMP ej_07_cadena_02[si], al
            JE  SEGUIR
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
            .exit
            
        DIFERENTES:
            mc_generico_imprimir_mensaje ej_07_mensaje_04
            .exit
    endm
    
    ; ejercicio 09 - lee carácteres hasta que se presione la tecla ESC
    macro mc_ej_09
        mc_generico_imprimir_mensaje ej_09_mensaje_01
        CICLO:
            mc_generico_imprimir_mensaje ej_09_mensaje_02
            MOV al, 0H                         ; pongo un vacío en AL   
            MOV ah, 01H                        ; funcion de lectura, lo leido se almacena en ah
            INT 21h                            ; ejecuta la función de lectura 
            CMP AL, 1BH                        ; valor de ESC en HEX
            JNE SEGUIR
            JE PARAR        
        SEGUIR:
            JMP CICLO                          ; para decrementar en 1 se usa DEC
        PARAR:  
            mc_generico_imprimir_mensaje ej_09_mensaje_03
    endm
    
.startup     
    ; para ejecutar quitar el comentario al macro correspondiente
    ;mc_ej_01  
    ;mc_ej_02  
    ;mc_ej_03  
    ;mc_ej_04
    ;mc_ej_05
    ;mc_ej_06  
    ;mc_ej_07     
    ;mc_ej_09                
end
