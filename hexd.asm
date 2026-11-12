section .text
global decode_byte

; Input:
;   AL = hexadecimal character
;
; Output:
;   AL = decoded nibble (0-15)
;   CF = 0 if valid, 1 if invalid

decode_nibble:
    cmp al, '0'
    jb .invalid

    cmp al, '9'
    jbe .decimal

    cmp al, 'A'
    jb .check_lowercase

    cmp al, 'F'
    jbe .uppercase

.check_lowercase:
    cmp al, 'a'
    jb .invalid

    cmp al, 'f'
    ja .invalid

    sub al, 'a'
    add al, 10
    clc
    ret

.decimal:
    sub al, '0'
    clc
    ret

.uppercase:
    sub al, 'A'
    add al, 10
    clc
    ret

.invalid:
    stc
    ret


; Input:
;   RSI = pointer to two hexadecimal characters
;
; Output:
;   AL = decoded byte
;   CF = 0 if valid, 1 if invalid

decode_byte:
    mov al, [rsi]
    call decode_nibble
    jc .invalid

    mov bl, al
    shl bl, 4

    mov al, [rsi + 1]
    call decode_nibble
    jc .invalid

    or al, bl
    clc
    ret

.invalid:
    stc
    ret
