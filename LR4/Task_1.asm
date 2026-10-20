.model small
.stack 100h

MAXLEN  EQU 200
CR      EQU 0Dh
LF      EQU 0Ah
STDOUT  EQU 1

print_str MACRO out_str
    mov ah, 09h
    lea dx, out_str
    int 21h
ENDM

.data
buf_max   DB MAXLEN+1
buf_len   DB ?
str_buf   DB MAXLEN+1 DUP(?)
str_len   DW 0

msg_start DB 'Sort characters by ASCII code', CR, LF, '$'
msg_src   DB 'Enter string (max 200): $'
msg_res   DB 'Sorted: $'
msg_e1    DB 'Error: string is empty', CR, LF, '$'
crlf      DB CR, LF, '$'

.code
start:
    mov ax, @data
    mov ds, ax

    print_str msg_start
    print_str msg_src

    mov ah, 0Ah
    lea dx, buf_max
    int 21h
    print_str crlf

    mov al, buf_len
    mov ah, 0
    mov str_len, ax
    cmp str_len, 0
    jne sort
    print_str msg_e1
    mov ax, 4C01h
    int 21h

sort:
    mov dx, str_len
    cmp dx, 2
    jb  show
    dec dx
ss_outer:
    lea bx, str_buf
    mov cx, dx
ss_inner:
    mov al, [bx]
    mov ah, [bx+1]
    cmp al, ah
    jbe NO_SWAP
    mov [bx], ah
    mov [bx+1], al
NO_SWAP:
    inc bx
    loop ss_inner
    dec dx
    jnz ss_outer

show:
    print_str msg_res
    mov ah, 40h
    mov bx, STDOUT
    mov cx, str_len
    lea dx, str_buf
    int 21h
    print_str crlf
    mov ax, 4C00h
    int 21h

end start