#make_COM#
ORG  100H  

dat segment
	num_str db 0
	num_column db 0
dat ends
cod segment
assume cs: cod, ds: dat

start:  
mov ax, dat
mov ds,ax

mov cx,50	;���������� �������� � ����
mov num_str,0	;����� ������
mov num_column,50	;����� �������

cycle1:
call clear
call WRITE_column
	mov num_str,0  
	dec num_column 	
mov ax,4C00h
loop cycle1
int 21h    

;����� 3� ������� ��������
WRITE_column Proc Near:
push cx
mov cx,10
c2:
	call ST
       	call WRITE  
       	inc num_str
loop c2 	
pop cx
ret  
WRITE_column Endp

;��������� �������
ST Proc Near:
	MOV  AH,02          ;���������� ��������� �������
        MOV  BH,00          ;�������� 0
     	MOV  DH,num_str     ;������
      	MOV  DL,num_column     ;�������
       	INT  10H            ;������� BIOS
ret  
ST Endp


;����� 3-� �������	
WRITE Proc Near:
push cx
push ax
mov cx,3
	CYCLE:
	mov DL, 50;<��� ���������� �������>
	mov AH, 2
	int 21h
	loop CYCLE
pop ax
pop cx
ret  
WRITE Endp

;������� ������
CLEAR Proc Near:
push cx
push ax
	MOV  AX,0600H  ;AH 06 (���������)
	               ;AL 00 (���� �����)
	MOV  BH,07     ;���������� ������� (�����/�����)
	MOV  CX,0000   ;������� ����� �������
	MOV  DX,184FH  ;������ ������ �������
	INT  10H       ;�������� ���������� � BIOS
pop ax
pop cx
ret  
CLEAR Endp

cod ends
end start