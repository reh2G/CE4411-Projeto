; Mapeamento de Hardware (8051)
    RS      equ     P1.3    ; Reg Select ligado em P1.3
    EN      equ     P1.2    ; Enable ligado em P1.2

org 0000h
	LJMP START

org 0003h
intTemp0:
	ACALL clearDisplay
	ACALL memoria

org 0013h
intTemp1:
	ACALL clearDisplay

	MOV A, B

Pais0:
	CJNE A, #00h, Pais1
	MOV A, #0Fh
	MOV B, A

	MOV A, #00h
	ACALL posicionaCursor

	MOV DPTR, #selecionado
	ACALL escreveStringROM

	MOV A, #40h
	ACALL posicionaCursor

	MOV DPTR, #BR
	ACALL escreveStringROM

	RETI	; Retorna da interrupção

Pais1:
	CJNE A, #0Fh, Pais2
	MOV A, #1Fh
	MOV B, A

	MOV A, #00h
	ACALL posicionaCursor

	MOV DPTR, #selecionado
	ACALL escreveStringROM

	MOV A, #40h
	ACALL posicionaCursor

	MOV DPTR, #USA
	ACALL escreveStringROM

	RETI	; Retorna da interrupção

Pais2:
	CJNE A, #1Fh, Pais3
	MOV A, #2Fh
	MOV B, A

	MOV A, #00h
	ACALL posicionaCursor

	MOV DPTR, #selecionado
	ACALL escreveStringROM

	MOV A, #40h
	ACALL posicionaCursor

	MOV DPTR, #SRB
	ACALL escreveStringROM

	RETI	; Retorna da interrupção

Pais3:
	CJNE A, #2Fh, Pais4
	MOV A, #3Fh
	MOV B, A

	MOV A, #00h
	ACALL posicionaCursor

	MOV DPTR, #selecionado
	ACALL escreveStringROM

	MOV A, #40h
	ACALL posicionaCursor

	MOV DPTR, #JPN
	ACALL escreveStringROM

	RETI	; Retorna da interrupção

Pais4:
	CJNE A, #3Fh, Pais5
	MOV A, #4Fh
	MOV B, A

	MOV A, #00h
	ACALL posicionaCursor

	MOV DPTR, #selecionado
	ACALL escreveStringROM

	MOV A, #40h
	ACALL posicionaCursor

	MOV DPTR, #VA
	ACALL escreveStringROM

	RETI	; Retorna da interrupção

Pais5:
	CJNE A, #4Fh, Pais1
	MOV A, #0Fh
	MOV B, A

	MOV A, #00h
	ACALL posicionaCursor

	MOV DPTR, #selecionado
	ACALL escreveStringROM

	MOV A, #40h
	ACALL posicionaCursor

	MOV DPTR, #BR
	ACALL escreveStringROM

	RETI	; Retorna da interrupção

selecionado:
	DB "     Pais atual"
	DB 0

BR:
	DB "Brasil"
	DB 0

USA:
	DB "Estados Unidos"
	DB 0

SRB:
	DB "Servia"
	DB 0

JPN:
	DB "Japao"
	DB 0

VA:
	DB "Vaticano"
	DB 0

org 0100h
START:
	ACALL lcdInit

seletor:
	SETB EA  ; habilita as interrupções
	SETB EX0 ; habilita a interrupção 0
	SETB EX1 ; habilita a interrupção 2
	SETB IT0 ; trabalhando com borda de descida
	SETB IT1 ; trabalhando com borda de descida

	SJMP $ ; laço de repetição

memoria:
	MOV 70H, #'#'
	MOV 71H, #'0'
	MOV 72H, #'*'
	MOV 73H, #'9'
	MOV 74H, #'8'
	MOV 75H, #'7'
	MOV 76H, #'6'
	MOV 77H, #'5'
	MOV 78H, #'4'
	MOV 79H, #'3'
	MOV 7AH, #'2'
	MOV 7BH, #'1'

inicio:
	MOV A, #00h

	MOV P0, #11111110b
	CALL columVerify

	MOV P0, #11111101b
	CALL columVerify

	MOV P0, #11111011b
	CALL columVerify

	MOV P0, #11110111b
	CALL columVerify

	JMP inicio

resetLoop:
	MOV A, #00h
	ACALL posicionaCursor

	MOV A, B

Brasil:
	CJNE A, #0Fh, EUA			; if A == #0Fh
	ACALL leituraTeclado
	ACALL leituraDirecao

	LJMP Brasil1

EUA:
	CJNE A, #1Fh, Servia		; if A == #1Fh
	ACALL leituraTeclado
	ACALL leituraDirecao

	LJMP EUA1

Servia:
	CJNE A, #2Fh, Japao			; if A == #1Fh
	ACALL leituraTeclado
	ACALL leituraDirecao

	LJMP Servia1

Japao:
	CJNE A, #3Fh, Vaticano		; if A == #1Fh
	ACALL leituraTeclado
	ACALL leituraDirecao

	LJMP Japao1

Vaticano:
	CJNE A, #4Fh, resetLoop		; if A == #1Fh
	ACALL leituraTeclado
	ACALL leituraDirecao

	LJMP Vaticano1

; Brasil

NO1:
	DB "Colombia"
	DB 0

N1:
	DB "Guiana Francesa"
	DB 0

NE1:
	DB "Oceano Atlantico"
	DB 0

O1:
	DB "Bolivia"
	DB 0

C1:
	DB "Brasil"
	DB 0

L1:
	DB "Oceano Atlantico"
	DB 0

SO1:
	DB "Argentina"
	DB 0

S1:
	DB "Uruguai"
	DB 0

SE1:
	DB "Oceano Atlantico"
	DB 0

Brasil1:
	CJNE A, #'1', Brasil2	 ; |
	MOV DPTR, #NO1			 ; |
	ACALL escreveStringROM	 ; |
	ACALL continue			 ; | if A == '1'

Brasil2:
	CJNE A, #'2', Brasil3	 ; |
	MOV DPTR, #N1			 ; |
	ACALL escreveStringROM	 ; |
	ACALL continue			 ; | if A == '2'

Brasil3:
	CJNE A, #'3', Brasil4	 ; |
	MOV DPTR, #NE1			 ; |
	ACALL escreveStringROM	 ; |
	ACALL continue			 ; | if A == '3'

Brasil4:
	CJNE A, #'4', Brasil5	 ; |
	MOV DPTR, #O1			 ; |
	ACALL escreveStringROM	 ; |
	ACALL continue			 ; | if A == '4'

Brasil5:
	CJNE A, #'5', Brasil6	 ; |
	MOV DPTR, #C1			 ; |
	ACALL escreveStringROM	 ; |
	ACALL continue			 ; | if A == '5'

Brasil6:
	CJNE A, #'6', Brasil7	 ; |
	MOV DPTR, #L1			 ; |
	ACALL escreveStringROM	 ; |
	ACALL continue			 ; | if A == '6'

Brasil7:
	CJNE A, #'7', Brasil8	 ; |
	MOV DPTR, #SO1			 ; |
	ACALL escreveStringROM	 ; |
	ACALL continue			 ; | if A == '7'

Brasil8:
	CJNE A, #'8', Brasil9	 ; |
	MOV DPTR, #S1			 ; |
	ACALL escreveStringROM	 ; |
	ACALL continue			 ; | if A == '8'

Brasil9:
	CJNE A, #'9', Brasil1	 ; |
	MOV DPTR, #SE1			 ; |
	ACALL escreveStringROM	 ; |
	ACALL continue			 ; | if A == '9'

; EUA

NO2:
	DB "Alasca"
	DB 0

N2:
	DB "Canada"
	DB 0

NE2:
	DB "Canada"
	DB 0

O2:
	DB "Oceano Pacifico"
	DB 0

C2:
	DB "Estados Unidos"
	DB 0

L2:
	DB "Oceano Atlantico"
	DB 0

SO2:
	DB "Mexico"
	DB 0

S2:
	DB "Cuba"
	DB 0

SE2:
	DB "Bahamas"
	DB 0

EUA1:
	CJNE A, #'1', EUA2 		 ; |
	MOV DPTR, #NO2			 ; |
	ACALL escreveStringROM	 ; |
	ACALL continue			 ; | if A == '1'

EUA2:
	CJNE A, #'2', EUA3		 ; |
	MOV DPTR, #N2			 ; |
	ACALL escreveStringROM	 ; |
	ACALL continue			 ; | if A == '2'

EUA3:
	CJNE A, #'3', EUA4		 ; |
	MOV DPTR, #NE2			 ; |
	ACALL escreveStringROM	 ; |
	ACALL continue			 ; | if A == '3'

EUA4:
	CJNE A, #'4', EUA5		 ; |
	MOV DPTR, #O2			 ; |
	ACALL escreveStringROM	 ; |
	ACALL continue			 ; | if A == '4'

EUA5:
	CJNE A, #'5', EUA6		 ; |
	MOV DPTR, #C2			 ; |
	ACALL escreveStringROM	 ; |
	ACALL continue			 ; | if A == '5'

EUA6:
	CJNE A, #'6', EUA7		 ; |
	MOV DPTR, #L2			 ; |
	ACALL escreveStringROM	 ; |
	ACALL continue			 ; | if A == '6'

EUA7:
	CJNE A, #'7', EUA8		 ; |
	MOV DPTR, #SO2			 ; |
	ACALL escreveStringROM	 ; |
	ACALL continue			 ; | if A == '7'

EUA8:
	CJNE A, #'8', EUA9		 ; |
	MOV DPTR, #S2		 	 ; |
	ACALL escreveStringROM	 ; |
	ACALL continue			 ; | if A == '8'

EUA9:
	CJNE A, #'9', EUA1		 ; |
	MOV DPTR, #SE2			 ; |
	ACALL escreveStringROM	 ; |
	ACALL continue			 ; | if A == '9'

; Servia

NO3:
	DB "Croacia"
	DB 0

N3:
	DB "Hungria"
	DB 0

NE3:
	DB "Romenia"
	DB 0

O3:
	DB "Boznia"
	DB 0

C3:
	DB "Servia"
	DB 0

L3:
	DB "Bulgaria"
	DB 0

SO3:
	DB "Montenegro"
	DB 0

S3:
	DB "Kosovo"
	DB 0

SE3:
	DB "Macedonia"
	DB 0

Servia1:
	CJNE A, #'1', Servia2	 ; |
	MOV DPTR, #NO3			 ; |
	ACALL escreveStringROM	 ; |
	ACALL continue			 ; | if A == '1'

Servia2:
	CJNE A, #'2', Servia3	 ; |
	MOV DPTR, #N3			 ; |
	ACALL escreveStringROM	 ; |
	ACALL continue			 ; | if A == '2'

Servia3:
	CJNE A, #'3', Servia4  	 ; |
	MOV DPTR, #NE3			 ; |
	ACALL escreveStringROM	 ; |
	ACALL continue		     ; | if A == '3'

Servia4:
	CJNE A, #'4', Servia5	 ; |
	MOV DPTR, #O3			 ; |
	ACALL escreveStringROM	 ; |
	ACALL continue			 ; | if A == '4'

Servia5:
	CJNE A, #'5', Servia6	 ; |
	MOV DPTR, #C3			 ; |
	ACALL escreveStringROM	 ; |
	ACALL continue			 ; | if A == '5'

Servia6:
	CJNE A, #'6', Servia7	 ; |
	MOV DPTR, #L3			 ; |
	ACALL escreveStringROM	 ; |
	ACALL continue			 ; | if A == '6'

Servia7:
	CJNE A, #'7', Servia8	 ; |
	MOV DPTR, #SO3			 ; |
	ACALL escreveStringROM	 ; |
	ACALL continue			 ; | if A == '7'

Servia8:
	CJNE A, #'8', Servia9 	 ; |
	MOV DPTR, #S3			 ; |
	ACALL escreveStringROM	 ; |
	ACALL continue			 ; | if A == '8'

Servia9:
	CJNE A, #'9', Servia1 	 ; | 
	MOV DPTR, #SE3			 ; |
	ACALL escreveStringROM	 ; |
	ACALL continue		 	 ; | if A == '9'

; Japão

NO4:
	DB "Coreia do Norte"
	DB 0

N4:
	DB "Russia"
	DB 0

NE4:
	DB "Russia"
	DB 0

O4:
	DB "Coreia do Sul"
	DB 0

C4:
	DB "Japao"
	DB 0

L4:
	DB "Oceano Pacifico"
	DB 0

SO4:
	DB "China"
	DB 0

S4:
	DB "Filipinas"
	DB 0

SE4:
	DB "Oceano Pacifico"
	DB 0

Japao1:
	CJNE A, #'1', Japao2	 ; |
	MOV DPTR, #NO4			 ; |
	ACALL escreveStringROM	 ; |
	ACALL continue			 ; | if A == '1'

Japao2:
	CJNE A, #'2', Japao3	 ; |
	MOV DPTR, #N4			 ; |
	ACALL escreveStringROM	 ; |
	ACALL continue			 ; | if A == '2'

Japao3:
	CJNE A, #'3', Japao4  	 ; |
	MOV DPTR, #NE4			 ; |
	ACALL escreveStringROM	 ; |
	ACALL continue		     ; | if A == '3'

Japao4:
	CJNE A, #'4', Japao5	 ; |
	MOV DPTR, #O4			 ; |
	ACALL escreveStringROM	 ; |
	ACALL continue			 ; | if A == '4'

Japao5:
	CJNE A, #'5', Japao6	 ; |
	MOV DPTR, #C4			 ; |
	ACALL escreveStringROM	 ; |
	ACALL continue			 ; | if A == '5'

Japao6:
	CJNE A, #'6', Japao7	 ; |
	MOV DPTR, #L4			 ; |
	ACALL escreveStringROM	 ; |
	ACALL continue			 ; | if A == '6'

Japao7:
	CJNE A, #'7', Japao8	 ; |
	MOV DPTR, #SO4			 ; |
	ACALL escreveStringROM	 ; |
	ACALL continue			 ; | if A == '7'

Japao8:
	CJNE A, #'8', Japao9  	 ; |
	MOV DPTR, #S4			 ; |
	ACALL escreveStringROM	 ; |
	ACALL continue			 ; | if A == '8'

Japao9:
	CJNE A, #'9', Japao1  	 ; | 
	MOV DPTR, #SE4			 ; |
	ACALL escreveStringROM	 ; |
	ACALL continue		 	 ; | if A == '9'

; Vaticano

NO5:
	DB "Italia"
	DB 0

N5:
	DB "Italia"
	DB 0

NE5:
	DB "Italia"
	DB 0

O5:
	DB "Italia"
	DB 0

C5:
	DB "Vaticano"
	DB 0

L5:
	DB "Italia"
	DB 0

SO5:
	DB "Italia"
	DB 0

S5:
	DB "Italia"
	DB 0

SE5:
	DB "Italia"
	DB 0

Vaticano1:
	CJNE A, #'1', Vaticano2	 ; |
	MOV DPTR, #NO5			 ; |
	ACALL escreveStringROM	 ; |
	ACALL continue			 ; | if A == '1'

Vaticano2:
	CJNE A, #'2', Vaticano3	 ; |
	MOV DPTR, #N5			 ; |
	ACALL escreveStringROM	 ; |
	ACALL continue			 ; | if A == '2'

Vaticano3:
	CJNE A, #'3', Vaticano4  ; |
	MOV DPTR, #NE5			 ; |
	ACALL escreveStringROM	 ; |
	ACALL continue		     ; | if A == '3'

Vaticano4:
	CJNE A, #'4', Vaticano5	 ; |
	MOV DPTR, #O5			 ; |
	ACALL escreveStringROM	 ; |
	ACALL continue			 ; | if A == '4'

Vaticano5:
	CJNE A, #'5', Vaticano6	 ; |
	MOV DPTR, #C5			 ; |
	ACALL escreveStringROM	 ; |
	ACALL continue			 ; | if A == '5'

Vaticano6:
	CJNE A, #'6', Vaticano7	 ; |
	MOV DPTR, #L5			 ; |
	ACALL escreveStringROM	 ; |
	ACALL continue			 ; | if A == '6'

Vaticano7:
	CJNE A, #'7', Vaticano8	 ; |
	MOV DPTR, #SO5			 ; |
	ACALL escreveStringROM	 ; |
	ACALL continue			 ; | if A == '7'

Vaticano8:
	CJNE A, #'8', Vaticano9  ; |
	MOV DPTR, #S5			 ; |
	ACALL escreveStringROM	 ; |
	ACALL continue			 ; | if A == '8'

Vaticano9:
	CJNE A, #'9', Vaticano1  ; | 
	MOV DPTR, #SE5			 ; |
	ACALL escreveStringROM	 ; |
	ACALL continue		 	 ; | if A == '9'

continue:
	JNB P0.4, $
	JNB P0.5, $
	JNB P0.6, $

	CLR F0
	ACALL clearDisplay

	JMP inicio

columVerify:
	JNB P0.4, longReset
	INC A

	JNB P0.5, longReset
	INC A

	JNB P0.6, longReset
	INC A

	RET

longReset:
	LJMP resetLoop

escreveStringROM:
 	MOV R1, #00h 	; inicia a escrita da String no Display LCD

loop:
 	MOV A, R1
	MOVC A, @A+DPTR 	 	; lê da memória de programa
	JZ finish					; if A is 0, then end of data has been reached - jump out of loop
	ACALL sendCharacter	; send data in A to LCD module
	INC R1						; point to next piece of data
 	MOV A, R1
	JMP loop		; repeat

leituraTeclado:
	MOV R0, #0			; clear R0 - the first key is key0

	; scan row0
	MOV P0, #0FFh	
	CLR P0.0			; clear row0
	CALL colScan		; call column-scan subroutine
	JB F0, finish		; | if F0 is set, jump to end of program 
						; | (because the pressed key was found and its number is in  R0)
	; scan row1
	SETB P0.0			; set row0
	CLR P0.1			; clear row1
	CALL colScan		; call column-scan subroutine
	JB F0, finish		; | if F0 is set, jump to end of program 
						; | (because the pressed key was found and its number is in  R0)
	; scan row2
	SETB P0.1			; set row1
	CLR P0.2			; clear row2
	CALL colScan		; call column-scan subroutine
	JB F0, finish		; | if F0 is set, jump to end of program 
						; | (because the pressed key was found and its number is in  R0)
	; scan row3
	SETB P0.2			; set row2
	CLR P0.3			; clear row3
	CALL colScan		; call column-scan subroutine
	JB F0, finish		; | if F0 is set, jump to end of program 
						; | (because the pressed key was found and its number is in  R0)

leituraDirecao:
	MOV A, #70h
	ADD A, R0
	MOV R0, A
	MOV A, @R0

	RET				; return from subroutine

finish:
	RET

; column-scan subroutine
colScan:
	JNB P0.4, gotKey	; if col0 is cleared - key found
	INC R0					; otherwise move to next key
	JNB P0.5, gotKey	; if col1 is cleared - key found
	INC R0					; otherwise move to next key
	JNB P0.6, gotKey	; if col2 is cleared - key found
	INC R0					; otherwise move to next key

	RET						; return from subroutine - key not found

gotKey:
	SETB F0				; key found - set F0

	RET					; and return from subroutine

; initialise the display
; see instruction set for details
lcdInit:
	CLR RS		; clear RS - indicates that instructions are being sent to the module

; function set	
	CLR P1.7		; |
	CLR P1.6		; |
	SETB P1.5		; |
	CLR P1.4		; | high nibble set

	SETB EN		; |
	CLR EN		; | negative edge on E

	CALL delay		; wait for BF to clear	
					; function set sent for first time - tells module to go into 4-bit mode
; Why is function set high nibble sent twice? See 4-bit operation on pages 39 and 42 of HD44780.pdf.

	SETB EN		; |
	CLR EN		; | negative edge on E
					; same function set high nibble sent a second time

	SETB P1.7		; low nibble set (only P1.7 needed to be changed)

	SETB EN		; |
	CLR EN		; | negative edge on E
				; function set low nibble sent
	CALL delay		; wait for BF to clear

; entry mode set
; set to increment with no shift
	CLR P1.7		; |
	CLR P1.6		; |
	CLR P1.5		; |
	CLR P1.4		; | high nibble set

	SETB EN		; |
	CLR EN		; | negative edge on E

	SETB P1.6		; |
	SETB P1.5		; | low nibble set

	SETB EN		; |
	CLR EN		; | negative edge on E

	CALL delay		; wait for BF to clear

; display on/off control
; the display is turned on, the cursor is turned on and blinking is turned on
	CLR P1.7		; |
	CLR P1.6		; |
	CLR P1.5		; |
	CLR P1.4		; | high nibble set

	SETB EN		; |
	CLR EN		; | negative edge on E

	SETB P1.7		; |
	SETB P1.6		; |
	SETB P1.5		; |
	SETB P1.4		; | low nibble set

	SETB EN		; |
	CLR EN		; | negative edge on E

	CALL delay		; wait for BF to clear

	RET

sendCharacter:
	SETB RS  			; setb RS - indicates that data is being sent to module
	MOV C, ACC.7		; |
	MOV P1.7, C			; |
	MOV C, ACC.6		; |
	MOV P1.6, C			; |
	MOV C, ACC.5		; |
	MOV P1.5, C			; |
	MOV C, ACC.4		; |
	MOV P1.4, C			; | high nibble set

	SETB EN			; |
	CLR EN			; | negative edge on E

	MOV C, ACC.3		; |
	MOV P1.7, C			; |
	MOV C, ACC.2		; |
	MOV P1.6, C			; |
	MOV C, ACC.1		; |
	MOV P1.5, C			; |
	MOV C, ACC.0		; |
	MOV P1.4, C			; | low nibble set

	SETB EN			; |
	CLR EN			; | negative edge on E

	CALL delay			; wait for BF to clear
	CALL delay			; wait for BF to clear

	RET

;Posiciona o cursor na linha e coluna desejada.
;Escreva no Acumulador o valor de endereço da linha e coluna.
;|--------------------------------------------------------------------------------------|
;|linha 1 | 00 | 01 | 02 | 03 | 04 |05 | 06 | 07 | 08 | 09 |0A | 0B | 0C | 0D | 0E | 0F |
;|linha 2 | 40 | 41 | 42 | 43 | 44 |45 | 46 | 47 | 48 | 49 |4A | 4B | 4C | 4D | 4E | 4F |
;|--------------------------------------------------------------------------------------|
posicionaCursor:
	CLR RS	          ; clear RS - indicates that instruction is being sent to module
	SETB P1.7		 	   	; |
	MOV C, ACC.6			; |
	MOV P1.6, C				; |
	MOV C, ACC.5			; |
	MOV P1.5, C				; |
	MOV C, ACC.4			; |
	MOV P1.4, C				; | high nibble set

	SETB EN			; |
	CLR EN			; | negative edge on E

	MOV C, ACC.3			; |
	MOV P1.7, C				; |
	MOV C, ACC.2			; |
	MOV P1.6, C				; |
	MOV C, ACC.1			; |
	MOV P1.5, C				; |
	MOV C, ACC.0	 		; |
	MOV P1.4, C				; | low nibble set

	SETB EN			; |
	CLR EN			; | negative edge on E

	CALL delay			; wait for BF to clear

	RET

;Retorna o cursor para primeira posição sem limpar o display
retornaCursor:
	CLR RS	   ; clear RS - indicates that instruction is being sent to module
	CLR P1.7		; |
	CLR P1.6		; |
	CLR P1.5		; |
	CLR P1.4		; | high nibble set

	SETB EN		; |
	CLR EN		; | negative edge on E

	CLR P1.7		; |
	CLR P1.6		; |
	SETB P1.5		; |
	SETB P1.4		; | low nibble set

	SETB EN		; |
	CLR EN		; | negative edge on E

	CALL delay		; wait for BF to clear

	RET

;Limpa o display
clearDisplay:
	CLR RS	   ; clear RS - indicates that instruction is being sent to module
	CLR P1.7		; |
	CLR P1.6		; |
	CLR P1.5		; |
	CLR P1.4		; | high nibble set

	SETB EN		; |
	CLR EN		; | negative edge on E

	CLR P1.7		; |
	CLR P1.6		; |
	CLR P1.5		; |
	SETB P1.4		; | low nibble set

	SETB EN		; |
	CLR EN		; | negative edge on E

	CALL delay		; wait for BF to clear

	RET

delay:
	MOV R0, #50
	DJNZ R0, $

	RET
