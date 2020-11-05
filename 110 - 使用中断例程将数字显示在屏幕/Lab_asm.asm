    DOSSEG
   .MODEL TINY
   .STACK 100h
   .DATA
        arr1 dw 18199,11871,1170,1164, 956, 44, 36, 24, 17, 10, 0
        arr2 db 11, 9, 10, 8, 8, 22, 12, 6, 1, 5, 0
        arr3 dw 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        arr4 dw 10 dup ('A')
        arr5 dw '0','1','2','3','4'
   .CODE

start:
   mov    ax,@Data
   mov    ds,ax
   
   mov cx, 10
   mov bp, 2
   mov si, offset arr1[0]
   call loopShowArr
   

   
   
   ;call inputNum
   ;call printSpace
   ;call printNum
   ;call printSpace 
   
   mov ax, 4c00h
   int 21h
    ; =============================================
    ; Input num
    ; Answer --> ax
    inputNum:        push cx
                     push dx
                     push bp
                     
                     mov ax, 0
                     mov bp, 10
                     mov cx, 4
            _loopInput:    push ax
                           mov ah, 1
                           mov al, 0
                           int 21h
                           cmp al, 30h
                           jb _retInputNum
                           cmp al, 39h
                           ja _retInputNum
                           mov bl, al
                           sub bl, 30h
                           pop ax
                           mul bp
                           add al, bl
                           loop _loopInput
                           push ax 
            _retInputNum:  pop ax
                           pop bp
                           pop dx
                           pop cx
                           ret
                           
   
    ; =============================================
    ; Print space on screen
      printSpace:    push ax
                     push dx
                     
                     mov ax, 0
                     mov ah, 2
                     mov dx, ' '
                     int 21h
                     
                     pop dx
                     pop ax
                     ret
                     
    ; =============================================
    ; Loop show array (16bit - dw)
    ; Times    --> cx
    ; Adress for array(First element)  --> si
    ; Arrar    --> ds:si
    loopShowArr:     ;push ax
                     push cx
                     push si
                     push bp
                     
          _loopShowArr:  cmp bp, 2
                         je _next2
                         cmp bp, 1
                         mov ah, 0
                         mov al, [si]
                         je _next1
                         
          _next2:        mov ax, [si]
          _next1:        call printNum
                         call printSpace
                         add si, bp
                         loop _loopShowArr
                         mov ax, 0
                     
                     pop bp
                     pop si
                     pop cx
                     ;pop ax
                     rep
                      
    ; =============================================
    ; Function: Print numberon screen (MAX 16bit)
    ; Number which need to show  --> ax
     printNum:   push ax
                 push bx
                 push cx
                 push dx
                 push bp
                      
                 mov bx, 10
                 mov cx, 0   ; count
             _jmpDiv:     mov dx, 0
                          div bx
                          add dx, 30h
                          push dx                     
                          inc cx
                          cmp ax, 0
                          je _inStack
                          jmp _jmpDiv 
         
         _inStack:        mov ax, 0
                          mov ah, 2
                          
             _loopPrintStack:      pop dx
                                   int 21h
                                   loop _loopPrintStack
                                   ;call printSpace               
                 pop bp
                 pop dx
                 pop cx
                 pop bx
                 pop ax
                 ret




    ; =============================================
    ; Function:  loop div, use numbers in arr2 div arr1, tha answer put in arr3
    ; Dividend   -> arr1
    ; Divisor    -> arr2
    ; Answer     -> arr3
    ; Times      -> cx
    loopDiv_32:  push ax
                 push bx
                 push cx
                 push bp
                 
                 mov bp, 0
        _div_32: mov dx, 0
                 mov ax, arr1[bp]
                 ;mov bx, arr2[bp]
                 div bx
                 mov arr3[bp], ax
                 inc bp
                 loop _div_32

                 pop bp
                 pop cx
                 pop bx
                 pop ax
                 rep
                 
    ; =============================================
    ; Loop div array
    ; Times    --> cx
    ; Dividend --> arr1
    ; Divisor  --> arr2
    ; Answer   --> arr3
    loopDivArr:      push ax
                     push bx
                     push cx
                     push dx
                     push bp
                     
                     mov bp, 0
        _loopDivArr:     mov dx, 0
                         mov ax, arr1[bp]
                         ; mov bx, arr2[bp]
                         div bx
                         mov arr3[bp], ax
                         inc bp
                         loop _loopDivArr

                     pop bp
                     pop dx
                     pop cx
                     pop bx
                     pop ax
                     ret
END start