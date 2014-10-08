; práctica de programación en lenguaje ensamblador
; 5 de octubre 2014
; UAM
; por: Juan C. Sánchez

.model small
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

.data                                  
    ; VARIABLES
    ; DB para Byte.
    ; DW para Word.       
    ;
    ; CONSTANTES
    ; constante EQU 5
    ;
    ; ARRAYS
    arreglo DB 1,2,3
        
    ; en este caso se declaran cadenas 
    cadena DB 'hola mundo$'
    igualdad DB 'igualdad$'      
    diferencia DB 'diferencia$' 
    counter DB 0d
    
.code
    ; imprime un valor numérico de un dígito en base decimal
    imprimir_digito macro parametro
        MOV dl, parametro
        ADD dl, 48               ; los digitos en ASCII estan entre 48 y 57
        MOV ah, 02h              ; funcion para imprimir
        INT 21h                  ; ejecuta la funcion anterior
    endm                         ; fin del macro 
    
    ; esta macro es de uso general y se usa para terminar el programa
    macro finalizar
        MOV ax, 0c07h            ; 0c07h espera a que el usuario presione una tecla
        INT 21h 
        .exit
    endm               
    
    imprimir_cadena macro parametro
        MOV dx, offset parametro ; el offset es un array ej: en una cadena "abcde", "c" es el offset 2 de esa cadena
        MOV ah, 09h              ; interrupcion para imprimir cadena, en ensamblador las letras se tratan diferente a un digito
        ; otra forma de hacerlo
        ; MOV ah, 09h
        ; LEA dx, parametro
        INT 21h
    endm    
    
    ; realiza la suma de dos valores
    sumar macro num1, num2
        MOV al, num1               
        MOV bl, num2
        ADD al, bl              ; la suma SIEMPRE se almacena en AL
    endm
    
    restar macro minuendo, sustraendo
        MOV al, minuendo        
        MOV bl, sustraendo
        SUB al, bl              ; el resultado se almacena en al y se almacena en hexadecimal, pasado por comp. a 1 y comp. a 2
                                ; 10 - 13 = FD porque 1111 0011 -> 1111 1100 -> 1111 1100 + 1 = 1111 1101 -> 1101 = 13 = D
                                ; -8 (1{}{}{}) + 5({}101) = -3
    endm
             
    ; realiza la multiplicación de dos números que recibe por parámetro
    multiplicar macro multiplicando, multiplicador
        MOV al, multiplicando   ; pasa un numero a un registro
        MOV bl, multiplicador   ; pasa el otro numero a un registro, el que multiplica
        DIV bl                  ; MUL recibe un parametro y SIEMPRE multiplica ese parametro por lo que este en AL 
                                 
    endm   
    
    ; realiza una división de dos número que recibe por parámetro
    division macro dividendo, divisor
        MOV al, dividendo
        MOV bl, divisor
        DIV al                   ; divide lo que esta en AL
                                 ; guarda el cociente en AL y el residuo en AH
    endm
    
    ; representa como almacenar en un registro valores en diferentes bases, binaria y octal
    ; es posible introducir valores en bases diferentes a la decimal
    macro bases                 
        MOV al, 11111111b        ; binario
        MOV ah, 377o             ; octal
    endm 
    
    ; muestra como se crea un ciclo infinito utilizando etiquetas y un jumper
    ciclo_infinito macro parametro
        ;ejecutar con este codigo en el programa principal
        ;while:
            ;ciclo_infinito 0    
        MOV dl, parametro
        ADD dl, 48             
        MOV ah, 02h            
        INT 21h              
        jmp while                ; uso de jmp o jumper, salta a la etiqueta while
    endm
     
    ; ejemplo de como se crea un IF ELSE 
    comparacion macro parametro1, parametro2
            ;JUMPERS DE COMPARACION
            ; JE  a == b                                      
            ; JNE a <> b
            ; JA  a > b
            ; JB  a < b
            ; JAE a >= b
            ; JBE a <= b    
            MOV al, parametro1
            MOV bl, parametro2
            CMP al, bl
            JE IGUALES
            JNE DIFERENTES
            
            IGUALES: 
                imprimir_cadena igualdad  
                finalizar
                
            DIFERENTES:
                imprimir_cadena diferencia            
    endm  
    
    ; escribe los valores entre en el rango especificado en los parámetros
    ; es un bucle o ciclo con contador
    macro ciclo_finito inicio, final
        MOV bl, inicio
        CICLO:    
            CMP bl, final        ; CMP permite comparar registro completos tambien, ejemplo: CMP AX, BX
            JB  SEGUIR
            JA  PARAR
            
        SEGUIR:
          imprimir_digito bl
          INC bl                 ; uso de incremento en 1
          JMP CICLO              ; para decrementar en 1 se usa DEC

        PARAR:
          .exit
    endm
        
    macro ciclo_finito_mejorado inicio, final
        MOV bl, inicio
        CICLO:
            imprimir_digito bl
            INC bl
            CMP bl, final
            JB CICLO
            JA PARAR
        PARAR:
            .exit
    endm
    
    ; invierte una cifra decimal positiva de cuatro digitos como máximo
    invertir_cifra macro parametro  
        MOV ax, parametro             ; uso todo el registro porque AL max. 255
        MOV cl, 10               ; divisor 10 segun tfn
        
        while:
            DIV cl               ; divido lo que tiene AX
                                 ; AL = cociente / AH residuo
            MOV bx, ax           ; respaldo AX moviendo a BX
                                 ; previendo corrupcion por imprimir
            imprimir_digito ah
            MOV ax, bx           ; restauro valores
            MOV ah, 0            ; limpiar basura de la int. imprimir
            CMP al, 0            ; al > 0 es decir, el cociente sea mayor a cero
            JA while             ; iteracion
    endm 
                                             
    ; imprime una cadena en las posiciones x, y
    ; el prompt es de 80 x 25
    ; [***     PROMPT     ***]
    ; [0,0               0,79]
    ; [                      ]
    ; [                      ]
    ; [                      ]
    ; [                      ]
    ; [                      ]
    ; [                      ]
    ; [                      ]
    ; [                      ]
    ; [24,0             24,79]
    imprimir_con_posicion macro cadena, x, y 
        MOV ah, 02h              ; FUNC. 02h de la INT. 10h para fijar el cursor
        MOV bh, 00d              ; no hace nada, solo fija el valor 00 al registro bh
        MOV dh, x                ; las coordenadas se pasan a DX
        MOV dl, y
        INT 10h                  ; ejecuta la función que posiciona el cursor
        
        MOV ah, 09h              ; envia la funcion de imprimir en pantalla
        LEA dx, cadena           ; "LEA" carga la direccion de la variable cadena
                                 ; pudo hacerse de otro modo:
                                 ; MOV dx, offset, cadena
        INT 21h
    endm 
    
    ; ejemplo de como accesar a los valores de un arreglo numero de tres elementos
    imprimir_arreglo macro parametro  
        MOV ah, 02h
        MOV dl, parametro[0] 
        ADD dl, 48
        INT 21h           
        
        MOV ah, 02h
        MOV dl, parametro[0] 
        ADD dl, 48
        INT 21h  
        
        MOV ah, 02h
        MOV dl, parametro[0] 
        ADD dl, 48
        INT 21h  
    endm     
    
    ; este macro lee un carácter de pantalla y lo despliega enseguida
    macro leer_caracter 
        MOV al, 00d
        MOV ah, 01h              ; funcion de lectura, lo leido se almacena en ah
        INT 21h                  ; ejecuta la función de lectura                  
        MOV ah, 02h              ; pasa a ah la función de despliegue en pantalla
        MOV dl, al               ; 02h imprime lo que esté almacenado en DX
        INT 21h                  ; interrupcion que ejecuta la funcion de imprimir 
    endm                   ;
    
.startup     
    ; aqui ponga la funcion que quiere utilizar
    ; los macros se llaman:
    ; nombre_macro parametro_uno [,OTRO_PARAMETRO...] 
end             
