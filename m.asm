;##############################################
;para usar GBD (debugger)
;EL4313 - Laboratorio de Estructura de Microprocesadores
;##############################################
;--------------------Segmento de datos--------------------
section .data
linea_1: db 'Bienvenido al emulador MIPS',0xa
l1_tamano: equ $-linea_1
linea_2: db 'EL-4313-Lab. Estructura de microprocesadores',0xa
l2_tamano: equ $-linea_2
linea_3: db '1S-2017',0xa
l3_tamano: equ $-linea_3
linea_4: db 'Buscando archivo ROM.txt',0xa
l4_tamano: equ $-linea_4
linea_5: db 'Archivo ROM.txt no encontrado',0xa
l5_tamano: equ $-linea_5
linea_6: db 'Archivo ROM.txt encontrado',0xa
l6_tamano: equ $-linea_6 ;
linea_7: db 'Enter',0xa
l7_tamano: equ $-linea_7 ;
linea_8: db 'Ejecución Exitosa',0xa
l8_tamano: equ $-linea_8 
linea_9: db 'Ejecución Fallida',0xa
l9_tamano: equ $-linea_9 
linea_10: db 'Ruth Campos Artavia, 2013026084',0xa
l10_tamano: equ $-linea_10
linea_11: db 'Allan Chacón Cordero, 2013071786 ',0xa
l11_tamano: equ $-linea_11
linea_12: db 'Fabricio Saborío Corea, 2014080886',0xa
l12_tamano: equ $-linea_12
linea_13: db 'Mario Valenciano Rojas, 2013099217',0xa
l13_tamano: equ $-linea_13

ROM db "ROM.txt",0 ; link para abrir archivo

section .bss
	MEM1 resb 4950 ; 150 lineas de codigo ascii de 33 bytes  --Memoria ascci
	MEMP resq 150 ; 150 lineas de instrucciones de 64 bits -- Memoria de Programa
	MEMD resq 100 ; 100 datos de 64 bits --Memoria de datos
	STACK resq 100 ; capacidad de 100 palabras de 64 bits --stack

;Definicion de banco de registros de 64bits

	$s0 resq 1
	$s1 resq 1
	$s2 resq 1
	$s3 resq 1
	$s4 resq 1
	$s5 resq 1
	$s6 resq 1
	$s7 resq 1
	$a0 resq 1
	$a1 resq 1
	$a2 resq 1
	$a3 resq 1
	$sp resq 1
	$v0 resq 1
	$v1 resq 1
;	$pc resq 1; de 8 en 8

section .text
	global _start

_start:

	call _PB ;llamar pantalla bienvenida
	

;open
	mov rax, 2	;abrir
	mov rdi, ROM	;LINK archivo
	mov rsi, 0	
	mov rdx, 0
	syscall
;read
	push rax
	mov rdi, rax
	mov rax, 0
	mov rsi, MEM1
	mov rdx, 576 ; cantidad de chars de ROM.TXT
	syscall
;close
	mov rax, 3
	pop rdi
	syscall
	
	mov rdi, rax
	mov rax, 1
	mov rsi, MEM1
	mov rdx, 576 ; cantidad de chars a imprimir
	syscall
	call _print	
	call _PS ; llamar pantalla de salida
;salir
	mov rax, 60
	mov rdi, 0
	syscall

_print: 
	mov rax,1;rax = sys_write (1)
	mov rdi,1;rdi = 1
	mov rsi, MEM1 ;rsi = linea_uno
	mov rdx,1 ;rdx = tamano de linea_uno	
	syscall  ;Llamar al sistema
	
	mov rsi, MEM1 ; puntero de direccion
	mov al, [rsi] ; dato de primera dir
	;mov ,  ;48 ascii cero 
	cmp al,  00000030h
	je _print2

	ret

_print2:
	mov rax,1;rax = sys_write (1)
	mov rdi,1;rdi = 1
	mov rsi, linea_1 ;rsi = linea_uno B
	mov rdx,1 ;rdx = tamano de linea_uno
	syscall  ;Llamar al sistema
	ret
_PB:
	;Imprimir la primera linea
	mov rax,1;rax = sys_write (1)
	mov rdi,1;rdi = 1
	mov rsi,linea_1 ;rsi = linea_uno
	mov rdx,l1_tamano ;rdx = tamano de linea_uno
	syscall  ;Llamar al sistema

	;Imprimir la segunda línea
	mov rax,1;rax
	mov rdi,1;rdi
	mov rsi,linea_2;rsi
	mov rdx,l2_tamano;rdx
	syscall

	;Imprimir la tercer línea
        mov rax,1;rax
        mov rdi,1;rdi
        mov rsi,linea_3;rsi
        mov rdx,l3_tamano;rdx
	syscall

	ret
_PS:
	;Imprimir el primer nombre
	mov rax,1;rax = sys_write (1)
	mov rdi,1;rdi = 1
	mov rsi,linea_10 ;rsi = linea_uno
	mov rdx,l10_tamano ;rdx = tamano de linea_uno
	syscall  ;Llamar al sistema

	;Imprimir el segundo nombre
	mov rax,1;rax
	mov rdi,1;rdi
	mov rsi,linea_11;rsi
	mov rdx,l11_tamano;rdx
	syscall

	;Imprimir el tercer nombre
        mov rax,1;rax
        mov rdi,1;rdi
        mov rsi,linea_12;rsi
        mov rdx,l12_tamano;rdx
	syscall

	;Imprimir el cuarto nombre
        mov rax,1;rax
        mov rdi,1;rdi
        mov rsi,linea_13;rsi
        mov rdx,l13_tamano;rdx
	syscall
	ret

