extern malloc
extern free
extern fprintf

section .data

section .text

global strCmp
global strClone
global strDelete
global strPrint
global strLen

; ** String **

; int32_t strCmp(char* a, char* b)
; a -> edi 
; b -> esi
strCmp:
	push rbp
	mov rbp, rsp ; alineado

	xor eax, eax ; ret = 0

	.ciclo: 
		mov dl, [rdi] ; a[i]
		mov cl, [rsi] ; b[i]

		cmp dl, 0
		je .termino_a ; a = ""

		cmp cl, 0
		je .a_mayor ; a != ""
					; b = ""

		cmp dl, cl
		jl .a_menor ; a < b
		jg .a_mayor

		add rdi, 1 ; siguiente 
		add rsi, 1 ; char

		jmp .ciclo ; 
	.termino_a:
		cmp cl, 0
		jne .a_menor ; a < b 

		jmp .fin
	.a_menor:
		add eax, 1

		jmp .fin
	.a_mayor:
		add eax, -1

		jmp .fin
	.fin:
		pop rbp
		ret
; char* strClone(char* a)
strClone:
	push rbp
	push r12
	sub rsp, 8

	mov rbp, rsp ; alineado

	xor rax, rax ; ret = 0

	mov r12, rdi

	call strLen ; rax = len (a)

	add rax, 1

	mov rdi, rax 

	call malloc
	
	mov rcx, rax ; dir de memoria clon


	.ciclo: 
		mov dl, BYTE [r12] ; a[i]

		cmp dl, 0 ; a = ""
		je .fin

		mov BYTE [rcx], dl ; x[i] = a[i] 

		add r12, 1
		add rcx, 1

		jmp .ciclo

	.fin:
		mov BYTE [rcx], 0

		add rsp, 8
		pop r12		
		pop rbp
		ret

; void strDelete(char* a)
strDelete:
	push rbp
	mov rbp, rsp ; alineado

	xor rax, rax ; ret = 0

	call free 

	pop rbp
	ret

; void strPrint(char* a, FILE* pFile)
strPrint:
	ret

; uint32_t strLen(char* a)
strLen:
	push rbp
	mov rbp, rsp ; alineado

	xor eax, eax ; ret = 0

	.ciclo: 
		mov dl, [rdi] ; a[i]

		cmp dl, 0
		je .fin ; a != ""

		add eax, 1
		add rdi, 1 ; siguiente 
		add rsi, 1 ; char

		jmp .ciclo ; 
	.fin:
		pop rbp
		ret


