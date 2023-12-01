;******************************************
;File: bootsect.asm
;Author: Mustafa Kural
;Info: KurallOS BootSector
;******************************************
;This code find BOOTMGR.SYS in FAT32 Disk,  
;then load at [0x0000:0x0100] and jump it

BITS 16
[ORG 0]
Start:
    jmp Main

;*********************************************
;	BIOS Parameter Block
;*********************************************


;***************************************************
;	My Data
;***************************************************
msgLoading				db "LOADING...",0x0A, 0x0D, 0


;******************************************************
;	Prints A String On Display
;	Inputs	: SI=>String
;	Outputs	: 
;******************************************************
Print:
    pushad
.PRINTLOOP:
    lodsb
    test al, al
    je .PRINTDONE                  	
    mov ah, 0x0E	
    int 0x10
    jmp .PRINTLOOP

.PRINTDONE:
    popad
    ret


Main:
    cli
    ;code located at 0000:7C00
    mov ax, 0x07C0
    mov ds,ax
    mov es,ax
    mov fs,ax
    mov gs,ax
    ;create stack (64K) - sp at 0000:7C00 + 64K
    mov ax, 0
    mov ss,ax
    mov sp,0xFFFF
    sti

    ;print to screen 
    mov si, msgLoading
    call Print

    ;fill up to 510 bytes and 2 bytes boot signature(AA55)
    times 510-($-$$) db 0
    dw 0xAA55
