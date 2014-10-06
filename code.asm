; Práctica de programación en Lenguaje Ensamblador
; Se implementa el uso de macros (son como las funciones en lenguajes de alto nivel, tipo c, java etc)
; 
; 3/10/2014
; UAM 

.model small
; MODELOS DE MEMORIA
; Model  TINY          CS = DS       En 1 solo segmento de 64K
; Model  SMALL         CS = 64Kb     DS = 64Kb
; Model  MEDIUM        CS > 64Kb     DS < 64Kb
; Model  COMPAC        CS < 64Kb     DS > 64Kb
; Model  LARGE         CS > 64Kb     DS > 64Kb(Los arreglos de datos deben ocupar menos de 64 K)
; Model  HUGE          CS > 64Kb     DS > 64Kb(Los arreglos de datos pueden ocupar mas de 64 Kb)

.data ; declaración de variables 
    
    cadena db 'hola mundo$'
 
.code ; declaración de macros
    ; macro para imprimir UN digito
    imprimir_digito macro parametro
        MOV dl, parametro
        ADD dl, 48  ; los digitos en ASCII estan entre 48 y 57
        MOV ah, 02h ; funcion para imprimir
        INT 21h ; la interrupcion devuelve el control al sistema
    endm ; fin del macro 
    
    ; macro de uso general para terminar los programas
    macro finalizar
        ;MOV ax, 0c07h
        INT 21h     
        .exit
    endm               
    
    imprimir_cadena macro parametro
        MOV dx, offset parametro ; el offeset es un array
        MOV ah, 09h              ; envia interrupcion de salida en pantalla 
    endm    
    
    sumar macro num1, num2
        MOV al, num1            
        MOV bl, num2
        ADD al, bl               ; el resultado se almacena en la parte baja de AX, es decir AL
    endm
             
    multiplicar macro num1, num2
        MOV al, num1
        MOV bl, num2             ; MUL solo recibe el multiplicador y lo multiplica por lo que tenga AL
        MUL bl                   ; el resultado se almacena en la parte baja de Ax, es decir AL
    endm
                          
.startup  ; "programa" principal, es el main de java, por ejemplo
    ; llamar macro con 
    finalizar    
end
