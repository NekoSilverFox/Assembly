    DOSSEG
   .MODEL TINY
   .STACK 100h
   .DATA
        arr1 dw 1199,1181,1170,1164, 56, 44, 36, 24, 17, 10
        arr2 dw 11, 9, 10, 8, 8, 22, 12, 6, 1, 5
        arr3 dw 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        arr4 dw 10 dup (1234)
        arr5 dw '0','1','2','3','4'
   .CODE

start:
   mov    ax,@Data
   mov    ds,ax
   
   ;mov al, 0
   ;mov ah, 2
   ;mov dx, arr5[3]
   ;int 21h
   ;mov cx, 10
   ;call loopDivArr
   
   ;mov ax, arr1[1]
   ;call printNum
   ;call printSpace
  
   ;mov ax, offset arr1[0]
   ;mov si, ax 
   ;mov cx, 2
   ;call loopShowArr
   
   call inputNum
   call printSpace
   call printNum
   
   
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
                         mov bx, arr2[bp]
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
    ; Loop show array
    ; Times    --> cx
    ; Arrar    --> ds:si
    loopShowArr:     push ax
                     push cx
                     push si
                     mov si, 0
          _loopShowArr:  mov ax, arr1[si]
                         call printNum
                         call printSpace
                         add si, 1
                         loop _loopShowArr    
                     pop si
                     pop cx
                     pop ax
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
                 mov bp, 0
             _jmpDiv:     mov dx, 0
                          div bx
                          cmp dx, 0
                          je _printStack
                          add dx, 30h
                          push dx                     
                          inc bp
                          jmp _jmpDiv 
         
         _printStack:     mov cx, bp
                          mov ax, 0
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
                 mov bx, arr2[bp]
                 div bx
                 mov arr3[bp], ax
                 inc bp
                 loop _div_32

                 pop bp
                 pop cx
                 pop bx
                 pop ax
                 rep
END start