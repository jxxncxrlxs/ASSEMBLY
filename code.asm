; crea un macro en ensamblador para imprimir un digito en consola

.model small
; MODELOS DE MEMORIA
; Model  TINY          CS = DS       En 1 solo segmento de 64K
; Model  SMALL         CS = 64Kb     DS = 64Kb
; Model  MEDIUM        CS > 64Kb     DS < 64Kb
; Model  COMPAC        CS < 64Kb     DS > 64Kb
; Model  LARGE         CS > 64Kb     DS > 64Kb(Los arreglos de datos deben ocupar menos de 64 K)
; Model  HUGE          CS > 64Kb     DS > 64Kb(Los arreglos de datos pueden ocupar mas de 64 Kb)

.data 
    cadena db 'hola mundo$'
 
.code
    imprimir_digito macro parametro
        MOV dl, parametro
        ADD dl, 48  ; los digitos en ASCII estan entre 48 y 57
        MOV ah, 02h ; funcion para imprimir
        INT 21h ; la interrupcion devuelve el control al sistema
    endm ; fin del macro 
    
    macro finalizar
        ;MOV ax, 0c07h
        INT 21h     
        .exit
    endm               
    
    imprimir_cadena macro parametro
        MOV dx, offset parametro
        MOV ah, 09h
    endm    
    
    sumar macro num1, num2
        MOV al, num1
        MOV bl, num2
        ADD al, bl
    endm
             
    multiplicar macro num1, num2
        MOV al, num1
        MOV bl, num2
        MUL bl
    endm
                          
.startup  
    imprimir_cadena cadena
    finalizar    

end





