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

;REGISTROS DE USO GENERAL

;[0 0 0 0 0 0 0 0] [AH(8) AL(8)] [AX(16)] 
;[0 0 0 0 0 0 0 0] [BH(8) BL(8)] [BX(16)] 
;[0 0 0 0 0 0 0 0] [CH(8) CL(8)] [CX(16)] 
;[0 0 0 0 0 0 0 0] [DH(8) DL(8)] [DX(16)] 
                                          
;2 ^ 8 = 256 -> 0..255 VALORES ADMITIDOS  
;2 ^ 8 x 2 ^ 8 = 65536 - 1 = 65538 LLENA EL REGISTRO 

.data 
    ; en este caso se declaran cadenas 
    cadena db 'hola mundo$'
    igualdad db 'igualdad$'      
    diferencia db 'diferencia$'  
    
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
        ;MOV ax, 0c07h
        INT 21h 
        .exit
    endm               
    
    imprimir_cadena macro parametro
        MOV dx, offset parametro ; el offset es un array ej: en una cadena "abcde", "c" es el offset 2 de esa cadena
        MOV ah, 09h              ; interrupcion para imprimir cadena, en ensamblador las letras se tratan diferente a un digito
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
    
    ; escribe los valores entre en el rango especificado en los parámetros
    macro ciclo_finito inicio, final
        MOV bl, inicio
        CICLO:    
            CMP bl, final        ; permite comparar registro completos tambien, ejemplo: CMP AX, BX
            JB  SEGUIR
            JA  PARAR
            
        SEGUIR:
          imprimir_digito bl
          INC bl
          JMP CICLO

        PARAR:
          .exit
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
                                      
.startup  
    
    ; aqui ponga la funcion que quiere utilizar     
    
    finalizar    

end             
