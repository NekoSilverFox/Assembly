                            DOSSEG
   .MODEL TINY
   .STACK 100h
   .DATA
       arr1 db "       I  II III  IV   V  VI VIIVIII  IX"
       arr2 db "       X  XX XXX  XL   L  LX LXXLXXX  XC"
       arr3 db "       C  CC CCC  CD   D  DC DCCDCCC  CM"
       arr4 db "       M  MM MMM                        "

   mInt2Roman MACRO
   loopRun: call inputNum
            cmp ax, 1000
            jnb _notPrintNum
            call printNum
       _notPrintNum:    call printTab 
            call intToRoman
            call printEnter
            jmp loopRun   
   endm
       
   .CODE
; ------------------------------------------------------------------------------
start:
   mov    ax,@Data
   mov    ds,ax
   
   mInt2Roman

   ; mov ax, 2687   
   mov ax, 4c00h
   int 21h
; ------------------------------------------------------------------------------  
 
   ; =============================================
   ; Run: Print the 4 Byte (in array) on screen, with out `space`
   ;      Min value: 0     Max value: 3999
   ; Input: (array) offset address  --> si
   ;        offest within the array --> dx (Should use function `append_1XXX`)
   ; Output: String on screen without space
   printRomanNum:    push ax
                     push bx
                     push cx
                     push dx
                     push si
                     
                     mov bx, dx
                     add bx, dx
                     add bx, bx
                     add bx, si
                     
                     mov cx, 4
                     
                     mov ax, 0
                     mov ah, 2               
                     mov dh, 0
                     
        _printRomanNum:    mov dl, ds:[bx]
                           cmp dx, 20H
                           je _nextLoopPrRomNum
                           int 21H
        _nextLoopPrRomNum: inc bx
                           loop _printRomanNum
                     
                     pop si
                     pop dx
                     pop cx
                     pop bx
                     pop ax
                     ret
     
    ; =============================================
    ; Run: Convert Arabic numberals to Roman numberals 
    ; Input: Arabic number which need turn to Roman number --> ax
    ; Output: On screen
    intToRoman:      push dx
                     push bp
                     push ax
    
                     call append_1000
                     mov si, offset arr4[0]
                     call printRomanNum
                     
                     call append_100
                     mov si, offset arr3[0]
                     call printRomanNum
                     
                     call append_10
                     mov si, offset arr2[0]
                     call printRomanNum
                     
                     call append_1
                     mov si, offset arr1[0]
                     call printRomanNum
    
                     pop ax
                     pop bp
                     pop dx
                     ret
                               
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
         
            _inStack:     mov ax, 0
                          mov ah, 2
                          
            _loopPrintStack:       pop dx
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
    ; Run: Print Tab on screen
      printTab:      push ax
                     push dx
                     
                     mov ax, 0
                     mov ah, 2
                     mov dx, 9
                     int 21h
                     
                     pop dx
                     pop ax
                     ret
                     
    ; =============================================
    ; Run: Print Enter on screen
      printEnter:    push ax
                     push dx
                     
                     mov ax, 0
                     mov ah, 2
                     mov dx, 10
                     int 21h
                     
                     pop dx
                     pop ax
                     ret
                        
    ; =============================================
    ; Run:    (ax) / 1000 % 10
    ; Input number  --> ax
    ; Output answer --> dx
    append_1000:     push ax
                     push bx
                         
                     mov dx, 0
                     mov bx, 1000
                     div bx
                     mov dx, 0
                     mov bx, 10
                     div bx
                     
                     pop bx
                     pop ax                            
                     ret
    
    ; =============================================
    ; Run:    (ax) / 100 % 10
    ; Input number  --> ax
    ; Output answer --> dx
    append_100:      push ax
                     push bx
                         
                     mov dx, 0
                     mov bx, 100
                     div bx
                     mov dx, 0
                     mov bx, 10
                     div bx
                     
                     pop bx
                     pop ax                            
                     ret
                     
    ; =============================================
    ; Run:    (ax) / 10 % 10
    ; Input number  --> ax
    ; Output answer --> dx
    append_10:       push ax
                     push bx
                         
                     mov dx, 0
                     mov bx, 10
                     div bx
                     mov dx, 0
                     mov bx, 10
                     div bx
                     
                     pop bx
                     pop ax                            
                     ret

    ; =============================================
    ; Run:    (ax) % 10
    ; Input number  --> ax
    ; Output answer --> dx
    append_1:        push ax
                     push bx
                         
                     mov dx, 0
                     mov bx, 10
                     div bx
                     
                     pop bx
                     pop ax                            
                     ret

END start