;����� ����������� �������� �� ������������ ��������
; ����� ������� �(I,J). ���������� �������������
;�������� ������ ������� �������� � ���� ������������.
;I, J=1,2,...,5.
.model small
dat segment	
	mas db 1,7,2,5,4
		db 6,2,4,1,3
		db 2,3,1,4,5
		db 2,9,6,3,1
		db 3,5,8,7,2
	;������ ������ nxm
	n db 5
	m db 5
	min_of_max db ? ;���������
dat ends
cod segment
	assume cs: cod, ds: dat
start:
    mov ax, dat
    mov ds,ax
    lea si, mas
    mov cl,0
    call str_max
    mov [min_of_max], dl
cycl1:
    call str_max
    cmp dl, [min_of_max]
    jae label2
    mov min_of_max, dl
label2:
    inc cl
    cmp cl, n
    jl cycl1
    
mov ax,4C00h
int 21h
	
;��������� dl = str_max(cx)
;������� �������� cx - ����� ������
;�������� �������� dl - ������������ ������� ������ cx
str_max Proc Near
    push cx
    mov al, [m]      ;���������� ��������� � ������
    mul cl          ;�������� �� ���������� �����
    mov bp, ax      ;� ������� �������-��������� �������� ������ ������� �������� ������ ������
    mov cx, 0
    mov dl,[si][bp] ;������������, ��� ������� ������� ������ cx - ������������
cycl3:
    cmp [si][bp], dl
    jle label1      ;���� ������� ������� ������ dl - �������
    mov dl,[si][bp] ;��������� ������� ������������ ������� 
label1:
    inc bp          ;��������� � ���������� �������� ������ cx
    inc cx
    cmp cl, [m]     ;���������� � �������� �������
    jl cycl3        
    pop cx
	ret             ;������� � ���������� ���������
str_max Endp        ;����� ���������
cod ends
end start
