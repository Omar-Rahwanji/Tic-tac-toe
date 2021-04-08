;Done By; Omar Rahwanji ^_^ 20180286

org 100h
    .data 
    welcome db 'x_X Welcome to Tic Tac Toe game O_o$' 
    scoreP1 db 0
    scoreP2 db 0
    sc db 'SCORES',0ah,0dh,'------',0ah,0dh,'$'
    p1 db 'Player 1 (X):',0ah,0dh,'$'
    p2 db 'Player 2 (O): $'
    w db 'win $'
    l db 'lose$'
    d db 'draw$'
    flag db 1 
    row db 0
    col db 0 
    used db 0,0,0,0,0,0,0,0,0
    counter db 0 
    xs db 0
    os db 0
    winnerFlag db 0 
    nGame db 'Click to start$'
    rGame db 'Click to restart$' 
    aiFlag db 0
    
    .code
    mov ax,@data
    mov ds,ax
    
    Intro:
    mov ah,2
    mov bh,0 ;page number
    mov dh,11 ;row
    mov dl,23 ;column
    int 10h
    
    mov dx,offset welcome
    mov ah,9
    int 21h
    
    mov cx,300
    delay:
    loop delay
    
    mov ah,0  ; clearing the screen
    mov al,3
    int 10h
    
    Start:
    mov ah,2
    mov bh,0 ;page number
    mov dh,0 ;row
    mov dl,0 ;column
    int 10h
    
    mov dx,offset sc
    mov ah,9
    int 21h
    
        
    mov dx,offset p1
    mov ah,9
    int 21h
    
    mov dx,offset p2
    mov ah,9
    int 21h 
    
    mov ah,2
    mov bh,0  ;page number
    mov dh,2  ;row
    mov dl,14 ;column
    int 10h
    ;------------------
    ;Print
    mov dl,scoreP1
    add dl,30h
    mov ah,2
    int 21h 
        
        
        
    mov ah,2
    mov bh,0  ;page number
    mov dh,3  ;row
    mov dl,14 ;column
    int 10h
    ;------------------
    ;Print
    mov dl,scoreP2
    add dl,30h
    mov ah,2
    int 21h
           
    mov bx,0
    mov bl,1
    mov cx,23
    L1:
    push bx
    ;------------------
    mov ah,2
    mov bh,0 ;page number
    mov dh,bl ;row
    mov dl,33 ;column
    int 10h
    ;------------------
    ;Print 1
    mov dl,'|'
    mov ah,2
    int 21h  
    ;------------------
    mov ah,2
    mov bh,0 ;page number
    mov dh,bl ;row
    mov dl,47 ;column
    int 10h
    ;------------------
    ;Print 1
    mov dl,'|'
    mov ah,2
    int 21h
    ;------------------
    pop bx
    inc bl
    loop L1
    ;------------------
            
    mov bx,0
    mov bl,20        
    mov cx,41
    L2:
    push bx
    ;------------------
    mov ah,2
    mov bh,0   ;page number
    mov dh,8   ;row
    mov dl,bl  ;column
    int 10h
    ;------------------
    ;Print 1
    mov dl,'-'
    mov ah,2
    int 21h  
    ;------------------
    mov ah,2
    mov bh,0   ;page number
    mov dh,16  ;row
    mov dl,bl  ;column
    int 10h
    ;------------------
    ;Print 1
    mov dl,'-'
    mov ah,2
    int 21h
    ;------------------
    pop bx
    inc bl
    loop L2
    ;------------------
    
    
    L3: 
    cmp counter,9
    je gameover
    mov ax,3
    int 33h
    cmp bx,1
    je click
    jmp L3
    
    click:
    cmp cx,272  ; x-axis
    ja row0col1
    cmp cx,160
    jl L3
    cmp dx,64   ; y-axis
    ja row1col0
    cmp dx,16
    jl L3
    
;===================================================================== 


    row0col0:
    cmp used[0],'X'
    je L3 
    cmp used[0],'O'
    je L3
    cmp flag,0
    je O
    ;x[0][0]
    
    mov row,2
    mov col,22
    mov cx,5
    drawX1:     
    mov ah,2
    mov bh,0   ;page number
    mov dh,row   ;row
    mov dl,col  ;column
    int 10h
    mov dl,'*'
    mov ah,2
    int 21h  
    inc row
    add col,2
    loop drawX1
    
    mov row,2
    mov col,30
    mov cx,5
    drawX2:     ;X[0][0]
    mov ah,2
    mov bh,0   ;page number
    mov dh,row   ;row
    mov dl,col  ;column
    int 10h
    mov dl,'*'
    mov ah,2
    int 21h  
    inc row
    sub col,2
    loop drawX2
    mov flag,0
    mov used[0],'X'
    inc counter
    call Column1win
    call Row1win 
    call Diagonal1win
    jmp L3
    
    ;O[0][0]
    O: 
    mov col,23
    mov row,2
    mov cx,4
    drawO1:      
    ;9-14
    mov ah,2
    mov bh,0
    mov dh,row
    mov dl,col
    int 10h
    mov dl,'*'
    mov ah,2
    int 21h
    add col,2 
    loop drawO1
    
    mov col,22
    mov row,3
    mov cx,3
    drawO2:
    mov ah,2
    mov bh,0
    mov dh,row
    mov dl,col
    int 10h
    mov dl,'*'
    mov ah,2
    int 21h
    add col,8
    mov ah,2
    mov bh,0
    mov dh,row
    mov dl,col
    int 10h
    mov dl,'*'
    mov ah,2
    int 21h
    inc row
    mov col,22 
    loop drawO2
            
    mov col,23
    mov row,6
    mov cx,4
    drawO3:  
    ;9-14
    mov ah,2
    mov bh,0
    mov dh,row
    mov dl,col
    int 10h
    mov dl,'*'
    mov ah,2
    int 21h
    add col,2 
    loop drawO3
    mov flag,1
    mov used[0],'O'
    inc counter
    call Column1win
    call Row1win
    call Diagonal1win
    jmp L3
    
;=====================================================================

    row0col1:
    cmp cx,376  ; x-axis
    ja row0col2
    cmp dx,64  ; y-axis
    ja row1col1
    cmp dx,16
    jl L3
    cmp used[1],'X'
    je L3
    cmp used[1],'O'
    je L3
    cmp flag,0
    je O0                   
    
    
    ;x[0][1]
    mov row,2
    mov col,36
    mov cx,5
    drawX10:     
    mov ah,2
    mov bh,0   ;page number
    mov dh,row   ;row
    mov dl,col  ;column
    int 10h
    mov dl,'*'
    mov ah,2
    int 21h  
    inc row
    add col,2
    loop drawX10
    
    mov col,44
    mov row,2
    mov cx,5
    drawX20:     ;X[0][1]
    mov ah,2
    mov bh,0   ;page number
    mov dh,row   ;row
    mov dl,col  ;column
    int 10h
    mov dl,'*'
    mov ah,2
    int 21h  
    inc row
    sub col,2
    loop drawX20
    mov flag,0
    mov used[1],'X'
    inc counter
    call Column2win
    call Row1win    
    jmp L3
    
    ;O[0][1]
    O0:
    mov col,37
    mov row,2
    mov cx,4
    drawO10:      
    ;9-14
    mov ah,2
    mov bh,0
    mov dh,row
    mov dl,col
    int 10h
    mov dl,'*'
    mov ah,2
    int 21h
    add col,2 
    loop drawO10
    
    mov col,36
    mov row,3
    mov cx,3
    drawO20:
    mov ah,2
    mov bh,0
    mov dh,row
    mov dl,col
    int 10h
    mov dl,'*'
    mov ah,2
    int 21h
    add col,8
    mov ah,2
    mov bh,0
    mov dh,row
    mov dl,col
    int 10h
    mov dl,'*'
    mov ah,2
    int 21h
    inc row
    mov col,36 
    loop drawO20
            
    mov col,37
    mov row,6
    mov cx,4
    drawO30:  
    ;9-14
    mov ah,2
    mov bh,0
    mov dh,row
    mov dl,col
    int 10h
    mov dl,'*'
    mov ah,2
    int 21h
    add col,2 
    loop drawO30
    mov flag,1
    mov used[1],'O'
    inc counter 
    call Column2win
    call Row1win
    jmp L3
                   
;=====================================================================    
    
    row0col2:
    cmp cx,488
    ja L3
    cmp dx,64   ; y-axis
    ja row1col2         
    cmp dx,16
    jl L3
    cmp flag,0
    je O00                   
    cmp used[2],'X'
    je L3
    cmp used[2],'O'
    je L3
    ;x[0][2]
    mov row,2
    mov col,50
    mov cx,5
    drawX100:     
    mov ah,2
    mov bh,0   ;page number
    mov dh,row   ;row
    mov dl,col  ;column
    int 10h
    mov dl,'*'
    mov ah,2
    int 21h  
    inc row
    add col,2
    loop drawX100
    
    mov col,58
    mov row,2
    mov cx,5
    drawX200:     ;X[0][2]
    mov ah,2
    mov bh,0   ;page number
    mov dh,row   ;row
    mov dl,col  ;column
    int 10h
    mov dl,'*'
    mov ah,2
    int 21h  
    inc row
    sub col,2
    loop drawX200
    mov flag,0 
    mov used[2],'X'
    inc counter
    call Column3win
    call Row1win
    call Diagonal2win
    jmp L3
    
    ;O[0][2]
    O00:
    mov col,51
    mov row,2
    mov cx,4
    drawO100:      
    ;9-14
    mov ah,2
    mov bh,0
    mov dh,row
    mov dl,col
    int 10h
    mov dl,'*'
    mov ah,2
    int 21h
    add col,2 
    loop drawO100
    
    mov col,50
    mov row,3
    mov cx,3
    drawO200:
    mov ah,2
    mov bh,0
    mov dh,row
    mov dl,col
    int 10h
    mov dl,'*'
    mov ah,2
    int 21h
    add col,8
    mov ah,2
    mov bh,0
    mov dh,row
    mov dl,col
    int 10h
    mov dl,'*'
    mov ah,2
    int 21h
    inc row
    mov col,50
    loop drawO200
            
    mov col,51
    mov row,6
    mov cx,4
    drawO300:  
    ;9-14
    mov ah,2
    mov bh,0
    mov dh,row
    mov dl,col
    int 10h
    mov dl,'*'
    mov ah,2
    int 21h
    add col,2 
    loop drawO300
    mov flag,1
    mov used[2],'O'
    inc counter
    call Column3win
    call Row1win
    call Diagonal2win
    jmp L3
    
;=====================================================================    
    
    row1col0:
    cmp cx,272  ; x-axis
    ja row1col1
    cmp dx,128   ; y-axis
    ja row2col0
    cmp cx,168
    jl L3   
    cmp used[3],'X'
    je L3
    cmp used[3],'O'
    je L3
    cmp flag,0
    je O000
   
    ;x[1][0]
    mov row,10
    mov col,22
    mov cx,5
    drawX1000:     
    mov ah,2
    mov bh,0   ;page number
    mov dh,row   ;row
    mov dl,col  ;column
    int 10h
    mov dl,'*'
    mov ah,2
    int 21h  
    inc row
    add col,2
    loop drawX1000
    
    mov row,10
    mov col,30
    mov cx,5
    drawX2000:     ;X[1][0]
    mov ah,2
    mov bh,0   ;page number
    mov dh,row   ;row
    mov dl,col  ;column
    int 10h
    mov dl,'*'
    mov ah,2
    int 21h  
    inc row
    sub col,2
    loop drawX2000
    mov flag,0 
    mov used[3],'X'
    inc counter
    call Column1win
    call Row2win
    jmp L3
    
    ;O[1][0]
    O000:
    mov col,23
    mov row,10
    mov cx,4
    drawO1000:      
    ;9-14
    mov ah,2
    mov bh,0
    mov dh,row
    mov dl,col
    int 10h
    mov dl,'*'
    mov ah,2
    int 21h
    add col,2 
    loop drawO1000
    
    mov col,22
    mov row,11
    mov cx,3
    drawO2000:
    mov ah,2
    mov bh,0
    mov dh,row
    mov dl,col
    int 10h
    mov dl,'*'
    mov ah,2
    int 21h
    add col,8
    mov ah,2
    mov bh,0
    mov dh,row
    mov dl,col
    int 10h
    mov dl,'*'
    mov ah,2
    int 21h
    inc row
    mov col,22 
    loop drawO2000
            
    mov col,23
    mov row,14
    mov cx,4
    drawO3000:  
    ;9-14
    mov ah,2
    mov bh,0
    mov dh,row
    mov dl,col
    int 10h
    mov dl,'*'
    mov ah,2
    int 21h
    add col,2 
    loop drawO3000
    mov flag,1 
    mov used[3],'O'
    inc counter
    call Column1win
    call Row2win    
    jmp L3
    
;=====================================================================    
    
    row1col1:
    
    cmp cx,376  ; x-axis
    ja row1col2
    cmp dx,128   ; y-axis
    ja row2col1
    cmp used[4],'X'
    je L3
    cmp used[4],'O'
    je L3    
    cmp flag,0
    je O0000                   
    
    
    ;x[1][1]
    mov row,10
    mov col,36
    mov cx,5
    drawX10000:     
    mov ah,2
    mov bh,0   ;page number
    mov dh,row   ;row
    mov dl,col  ;column
    int 10h
    mov dl,'*'
    mov ah,2
    int 21h  
    inc row
    add col,2
    loop drawX10000
    
    mov col,44
    mov row,10
    mov cx,5
    drawX20000:     ;X[1][1]
    mov ah,2
    mov bh,0   ;page number
    mov dh,row   ;row
    mov dl,col  ;column
    int 10h
    mov dl,'*'
    mov ah,2
    int 21h  
    inc row
    sub col,2
    loop drawX20000
    mov flag,0
    mov used[4],'X'
    inc counter
    call Column2win
    call Row2win
    call Diagonal1win 
    call Diagonal2win
    jmp L3
    
    ;O[1][1]
    O0000:
    mov col,37
    mov row,10
    mov cx,4
    drawO10000:      
    ;9-14
    mov ah,2
    mov bh,0
    mov dh,row
    mov dl,col
    int 10h
    mov dl,'*'
    mov ah,2
    int 21h
    add col,2 
    loop drawO10000
    
    mov col,36
    mov row,11
    mov cx,3
    drawO20000:
    mov ah,2
    mov bh,0
    mov dh,row
    mov dl,col
    int 10h
    mov dl,'*'
    mov ah,2
    int 21h
    add col,8
    mov ah,2
    mov bh,0
    mov dh,row
    mov dl,col
    int 10h
    mov dl,'*'
    mov ah,2
    int 21h
    inc row
    mov col,36 
    loop drawO20000
            
    mov col,37
    mov row,14
    mov cx,4
    drawO30000:  
    ;9-14
    mov ah,2
    mov bh,0
    mov dh,row
    mov dl,col
    int 10h
    mov dl,'*'
    mov ah,2
    int 21h
    add col,2 
    loop drawO30000
    mov flag,1
    mov used[4],'O'
    inc counter 
    call Column2win
    call Row2win
    call Diagonal1win
    call Diagonal2win   
    jmp L3
    
;===================================================================== 
    
    row1col2:
    
    cmp cx,488
    ja L3
    cmp dx,128   ; y-axis
    ja row2col2         
    cmp used[5],'X'
    je L3
    cmp used[5],'O'
    je L3
    cmp flag,0
    je O00000                   
    
    ;x[1][2]
    mov row,10
    mov col,50
    mov cx,5
    drawX100000:     
    mov ah,2
    mov bh,0   ;page number
    mov dh,row   ;row
    mov dl,col  ;column
    int 10h
    mov dl,'*'
    mov ah,2
    int 21h  
    inc row
    add col,2
    loop drawX100000
    
    mov col,58
    mov row,10
    mov cx,5
    drawX200000:     ;X[1][2]
    mov ah,2
    mov bh,0   ;page number
    mov dh,row   ;row
    mov dl,col  ;column
    int 10h
    mov dl,'*'
    mov ah,2
    int 21h  
    inc row
    sub col,2
    loop drawX200000
    mov flag,0 
    mov used[5],'X'
    inc counter
    call Column3win
    call Row2win
    jmp L3
    
    ;O[1][2]
    O00000:
    mov col,51
    mov row,10
    mov cx,4
    drawO100000:      
    ;9-14
    mov ah,2
    mov bh,0
    mov dh,row
    mov dl,col
    int 10h
    mov dl,'*'
    mov ah,2
    int 21h
    add col,2 
    loop drawO100000
    
    mov col,50
    mov row,11
    mov cx,3
    drawO200000:
    mov ah,2
    mov bh,0
    mov dh,row
    mov dl,col
    int 10h
    mov dl,'*'
    mov ah,2
    int 21h
    add col,8
    mov ah,2
    mov bh,0
    mov dh,row
    mov dl,col
    int 10h
    mov dl,'*'
    mov ah,2
    int 21h
    inc row
    mov col,50
    loop drawO200000
            
    mov col,51
    mov row,14
    mov cx,4
    drawO300000:  
    ;9-14
    mov ah,2
    mov bh,0
    mov dh,row
    mov dl,col
    int 10h
    mov dl,'*'
    mov ah,2
    int 21h
    add col,2 
    loop drawO300000
    mov flag,1
    mov used[5],'O'
    inc counter
    call Column3win
    call Row2win
    jmp L3
    
;=====================================================================     
   
    row2col0:
    
    cmp cx,272  ; x-axis
    ja row2col1
    cmp dx,192   ; y-axis
    ja L3
    cmp cx,168
    jl L3   
    cmp used[6],'X'
    je L3
    cmp used[6],'O'
    je L3    
    cmp flag,0
    je O000000
   
    ;x[2][0]
    mov row,18
    mov col,22
    mov cx,5
    drawX1000000:     
    mov ah,2
    mov bh,0   ;page number
    mov dh,row   ;row
    mov dl,col  ;column
    int 10h
    mov dl,'*'
    mov ah,2
    int 21h  
    inc row
    add col,2
    loop drawX1000000
    
    mov row,18
    mov col,30
    mov cx,5
    drawX2000000:     ;X[2][0]
    mov ah,2
    mov bh,0   ;page number
    mov dh,row   ;row
    mov dl,col  ;column
    int 10h
    mov dl,'*'
    mov ah,2
    int 21h  
    inc row
    sub col,2
    loop drawX2000000
    mov flag,0 
    mov used[6],'X'
    inc counter
    call Column1win
    call Row3win
    call Diagonal2win
    jmp L3
    
    ;O[2][0]
    O000000:
    mov col,23
    mov row,18
    mov cx,4
    drawO1000000:      
    ;9-14
    mov ah,2
    mov bh,0
    mov dh,row
    mov dl,col
    int 10h
    mov dl,'*'
    mov ah,2
    int 21h
    add col,2 
    loop drawO1000000
    
    mov col,22
    mov row,19
    mov cx,3
    drawO2000000:
    mov ah,2
    mov bh,0
    mov dh,row
    mov dl,col
    int 10h
    mov dl,'*'
    mov ah,2
    int 21h
    add col,8
    mov ah,2
    mov bh,0
    mov dh,row
    mov dl,col
    int 10h
    mov dl,'*'
    mov ah,2
    int 21h
    inc row
    mov col,22 
    loop drawO2000000
            
    mov col,23
    mov row,22
    mov cx,4
    drawO3000000:  
    ;9-14
    mov ah,2
    mov bh,0
    mov dh,row
    mov dl,col
    int 10h
    mov dl,'*'
    mov ah,2
    int 21h
    add col,2 
    loop drawO3000000
    mov flag,1 
    mov used[6],'O'
    inc counter
    call Column1win
    call Row3win 
    call Diagonal2win
    jmp L3
    
;===================================================================== 
     
     
    row2col1:
    
    cmp cx,376  ; x-axis
    ja row2col2
    cmp dx,192   ; y-axis
    ja L3
    cmp used[7],'X'
    je L3
    cmp used[7],'O'
    je L3    
    cmp flag,0
    je O0000000                   
    
    
    ;x[2][1]
    mov row,18
    mov col,36
    mov cx,5
    drawX10000000:     
    mov ah,2
    mov bh,0   ;page number
    mov dh,row   ;row
    mov dl,col  ;column
    int 10h
    mov dl,'*'
    mov ah,2
    int 21h  
    inc row
    add col,2
    loop drawX10000000
    
    mov col,44
    mov row,18
    mov cx,5
    drawX20000000:     ;X[2][1]
    mov ah,2
    mov bh,0   ;page number
    mov dh,row   ;row
    mov dl,col  ;column
    int 10h
    mov dl,'*'
    mov ah,2
    int 21h  
    inc row
    sub col,2
    loop drawX20000000
    mov flag,0
    mov used[7],'X'
    inc counter
    call Column2win
    call Row3win
    jmp L3
    
    ;O[2][1]
    O0000000:
    mov col,37
    mov row,18
    mov cx,4
    drawO10000000:      
    ;9-14
    mov ah,2
    mov bh,0
    mov dh,row
    mov dl,col
    int 10h
    mov dl,'*'
    mov ah,2
    int 21h
    add col,2 
    loop drawO10000000
    
    mov col,36
    mov row,19
    mov cx,3
    drawO20000000:
    mov ah,2
    mov bh,0
    mov dh,row
    mov dl,col
    int 10h
    mov dl,'*'
    mov ah,2
    int 21h
    add col,8
    mov ah,2
    mov bh,0
    mov dh,row
    mov dl,col
    int 10h
    mov dl,'*'
    mov ah,2
    int 21h
    inc row
    mov col,36 
    loop drawO20000000
            
    mov col,37
    mov row,22
    mov cx,4
    drawO30000000:  
    ;9-14
    mov ah,2
    mov bh,0
    mov dh,row
    mov dl,col
    int 10h
    mov dl,'*'
    mov ah,2
    int 21h
    add col,2 
    loop drawO30000000
    mov flag,1
    mov used[7],'O'
    inc counter
    call Column2win
    call Row3win    
    jmp L3
    
;===================================================================== 
    
    row2col2:
    
    cmp cx,488   ; x-axis
    ja L3
    cmp dx,192   ; y-axis
    ja L3         
    cmp used[8],'X'
    je L3
    cmp used[8],'O'
    je L3
    cmp flag,0
    je O00000000                   
    
    ;x[2][2]
    mov row,18
    mov col,50
    mov cx,5
    drawX100000000:     
    mov ah,2
    mov bh,0   ;page number
    mov dh,row   ;row
    mov dl,col  ;column
    int 10h
    mov dl,'*'
    mov ah,2
    int 21h  
    inc row
    add col,2
    loop drawX100000000
    
    mov col,58
    mov row,18
    mov cx,5
    drawX200000000:     ;X[2][2]
    mov ah,2
    mov bh,0   ;page number
    mov dh,row   ;row
    mov dl,col  ;column
    int 10h
    mov dl,'*'
    mov ah,2
    int 21h  
    inc row
    sub col,2
    loop drawX200000000
    mov flag,0 
    mov used[8],'X'
    inc counter
    call Column3win
    call Row3win
    call Diagonal1win
    jmp L3
    
    ;O[2][2]
    O00000000:
    mov col,51
    mov row,18
    mov cx,4
    drawO100000000:      
    ;9-14
    mov ah,2
    mov bh,0
    mov dh,row
    mov dl,col
    int 10h
    mov dl,'*'
    mov ah,2
    int 21h
    add col,2 
    loop drawO100000000
    
    mov col,50
    mov row,19
    mov cx,3
    drawO200000000:
    mov ah,2
    mov bh,0
    mov dh,row
    mov dl,col
    int 10h
    mov dl,'*'
    mov ah,2
    int 21h
    add col,8
    mov ah,2
    mov bh,0
    mov dh,row
    mov dl,col
    int 10h
    mov dl,'*'
    mov ah,2
    int 21h
    inc row
    mov col,50
    loop drawO200000000
            
    mov col,51
    mov row,22
    mov cx,4
    drawO300000000:  
    ;9-14
    mov ah,2
    mov bh,0
    mov dh,row
    mov dl,col
    int 10h
    mov dl,'*'
    mov ah,2
    int 21h
    add col,2 
    loop drawO300000000
    mov flag,1
    mov used[8],'O'
    inc counter 
    call Column3win
    call Row3win 
    call Diagonal1win
    jmp L3
    
;=====================================================================    
    
    WinningPossibilities:
    
    proc Column1win
    mov xs,0
    mov os,0
    
    cmp used[0],'X'
    je c1x
    cmp used[0],'O'
    je c1o
    ret
    
    c1x:
    inc xs
    cmp used[3],'X'
    je c2x
    ret
    
    c1o:
    inc os
    cmp used[3],'O'
    je c2o
    ret

    
    c2x:
    inc xs
    cmp used[6],'X'
    je winC1x
    ret
    
    c2o:
    inc os
    cmp used[6],'O'
    je winC1o
    ret
    
    winC1x:
    cmp xs,2
    je drawCol1
    ret    
    winC1o:
    cmp os,2
    je drawCol1
    ret
   
    endp
    
;----------------------------------------------------------------------      
    
       
    proc Column2win  
    mov xs,0
    mov os,0
    
    cmp used[1],'X'
    je c3x
    cmp used[1],'O'
    je c3o
    ret
    
    c3x:
    inc xs
    cmp used[4],'X'
    je c4x
    ret
    
    c3o: 
    inc os
    cmp used[4],'O'
    je c4o
    ret
    
    c4x:
    inc xs
    cmp used[7],'X'
    je winC2x
    ret
    
    c4o:
    inc os
    cmp used[7],'O'
    je winC2o
    ret
    
    winC2x:
    cmp xs,2
    je drawCol2
    ret
    
    winC2o:
    cmp os,2
    je drawCol2
    ret
    
    endp
    
;----------------------------------------------------------------------      
    
    proc Column3win
    mov xs,0
    mov os,0
    
    cmp used[2],'X'
    je c5x
    cmp used[2],'O'
    je c5o
    ret
    
    c5x:
    inc xs
    cmp used[5],'X'
    je c6x
    ret
    
    c5o:
    inc os
    cmp used[5],'O'
    je c6o
    ret
    
    c6x:
    inc xs
    cmp used[8],'X'
    je winC3x
    ret
    
    c6o:
    inc os
    cmp used[8],'O'
    je winC3o
    ret
    
    winC3x:
    cmp xs,2
    je drawCol3
    ret
    
    winC3o:
    cmp os,2
    je drawCol3
    ret
    
    endp
    
;----------------------------------------------------------------------      
    
    proc Row1win
    mov xs,0
    mov os,0
    
    cmp used[0],'X'
    je c7x
    cmp used[0],'O'
    je c7o
    ret
    
    c7x:
    inc xs
    cmp used[1],'X'
    je c8x
    ret
    
    c7o:
    inc os
    cmp used[1],'O'
    je c8o
    ret
    
    c8x:
    inc xs
    cmp used[2],'X'
    je winR1x
    ret
    
    c8o:
    inc os
    cmp used[2],'O'
    je winR1o
    ret
    
    winR1x:
    cmp xs,2
    je drawRow1
    ret
    
    winR1o:
    cmp os,2
    je drawRow1
    ret
    
    endp

;----------------------------------------------------------------------    

    proc Row2win 
    mov xs,0
    mov os,0
    
    cmp used[3],'X'
    je c9x
    cmp used[3],'O'
    je c9o
    ret
    
    c9x:
    inc xs
    cmp used[4],'X'
    je c10x
    ret
    
    c9o:
    inc os
    cmp used[4],'O'
    je c10o
    ret
    
    c10x:
    inc xs
    cmp used[5],'X'
    je winR2x
    ret
    
    c10o:
    inc os
    cmp used[5],'O'
    je winR2o
    ret
    
    winR2x:
    cmp xs,2
    je drawRow2
    ret
    
    winR2o:
    cmp os,2
    je drawRow2
    ret
    
    endp
    
;----------------------------------------------------------------------       
    
    proc Row3win
    mov xs,0
    mov os,0
        
    cmp used[6],'X'
    je c11x
    cmp used[6],'O'
    je c11o
    ret
    
    c11x:
    inc xs
    cmp used[7],'X'
    je c12x
    ret
    
    c11o:
    inc os
    cmp used[7],'O'
    je c12o
    ret
    
    c12x:
    inc xs
    cmp used[8],'X'
    je winR3x
    ret
    
    c12o:
    inc os
    cmp used[8],'O'
    je winR3o
    ret
    
    winR3x:
    cmp xs,2
    je drawRow3
    ret
    
    winR3o:
    cmp os,2
    je drawRow3
    ret
    
    endp
    
;----------------------------------------------------------------------      
    
    proc Diagonal1win
    mov xs,0
    mov os,0
        
    cmp used[0],'X'
    je c13x
    cmp used[0],'O'
    je c13o
    ret
    
    c13x:
    inc xs
    cmp used[4],'X'
    je c14x
    ret
    
    c13o:
    inc os
    cmp used[4],'O'
    je c14o
    ret
    
    c14x:
    inc xs
    cmp used[8],'X'
    je winD1x
    ret
    
    c14o:
    inc os
    cmp used[8],'O'
    je winD1o
    ret
    
    winD1x:
    cmp xs,2
    je drawDiagonal1
    ret
    
    winD1o:
    cmp os,2
    je drawDiagonal1
    ret
    
    endp
    
;----------------------------------------------------------------------      
    
    proc Diagonal2win
    mov xs,0
    mov os,0
        
    cmp used[2],'X'
    je c15x
    cmp used[2],'O'
    je c15o
    ret
    
    c15x:
    inc xs
    cmp used[4],'X'
    je c16x
    ret
    
    c15o:
    inc os
    cmp used[4],'O'
    je c16o
    ret
    
    c16x:
    inc xs
    cmp used[6],'X'
    je winD2x
    ret
    
    c16o:
    inc os
    cmp used[6],'O'
    je winD2o
    ret
    
    winD2x:
    cmp xs,2
    je drawDiagonal2
    ret
    
    winD2o:
    cmp os,2
    je drawDiagonal2
    ret
    
    endp
    
;************************************************************
        
drawCol1:

    mov bx,0
    mov bl,1
    mov cx,23
    col1:
    ;------------------
    mov ah,2
    mov bh,0 ;page number
    mov dh,bl ;row
    mov dl,26 ;column
    int 10h
    ;------------------
    ;Print 1
    mov dl,'|'
    mov ah,2
    int 21h
    inc bl  
    loop col1
    
    cmp used[0],'X'
    je xwin1
    jmp next1
    xwin1:
    mov winnerFlag,'X'
    jmp gameover
    next1:
    mov winnerFlag,'O'
    jmp gameover
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

drawCol2:

    mov bx,0
    mov bl,1
    mov cx,23
    col2:
    ;------------------
    mov ah,2
    mov bh,0 ;page number
    mov dh,bl ;row
    mov dl,40 ;column
    int 10h
    ;------------------
    ;Print 1
    mov dl,'|'
    mov ah,2
    int 21h
    inc bl  
    loop col2
    
    cmp used[1],'X'
    je xwin2
    jmp next2
    xwin2:
    mov winnerFlag,'X'
    jmp gameover
    next2:
    mov winnerFlag,'O'
    jmp gameover            

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

drawCol3:

    mov bx,0
    mov bl,1
    mov cx,23
    col3:
    ;------------------
    mov ah,2
    mov bh,0 ;page number
    mov dh,bl ;row
    mov dl,54 ;column
    int 10h
    ;------------------
    ;Print 1
    mov dl,'|'
    mov ah,2
    int 21h
    inc bl  
    loop col3 
    
    cmp used[2],'X'
    je xwin3
    jmp next3
    xwin3:
    mov winnerFlag,'X'
    jmp gameover
    next3:
    mov winnerFlag,'O'
    jmp gameover
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

drawRow1:

    mov bl,20        
    mov cx,41
    row1:
    ;------------------
    mov ah,2
    mov bh,0   ;page number
    mov dh,4   ;row
    mov dl,bl  ;column
    int 10h
    ;------------------
    ;Print 1
    mov dl,'-'
    mov ah,2
    int 21h
    inc bl
    loop row1
    
    cmp used[0],'X'
    je xwin10
    jmp next10
    xwin10:
    mov winnerFlag,'X'
    jmp gameover
    next10:
    mov winnerFlag,'O'
    jmp gameover 
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

drawRow2:

    mov bl,20        
    mov cx,41
    row2:
    ;------------------
    mov ah,2
    mov bh,0   ;page number
    mov dh,12   ;row
    mov dl,bl  ;column
    int 10h
    ;------------------
    ;Print 1
    mov dl,'-'
    mov ah,2
    int 21h
    inc bl
    loop row2  
    
    cmp used[3],'X'
    je xwin20
    jmp next20
    xwin20:
    mov winnerFlag,'X'
    jmp gameover
    next20:
    mov winnerFlag,'O'
    jmp gameover   
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

drawRow3:

    mov bl,20        
    mov cx,41
    row3:
    ;------------------
    mov ah,2
    mov bh,0   ;page number
    mov dh,20   ;row
    mov dl,bl  ;column
    int 10h
    ;------------------
    ;Print 1
    mov dl,'-'
    mov ah,2
    int 21h
    inc bl
    loop row3
    
    cmp used[6],'X'
    je xwin30
    jmp next30
    xwin30:
    mov winnerFlag,'X'
    jmp gameover
    next30:
    mov winnerFlag,'O'
    jmp gameover
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

drawDiagonal1:
    mov row,1   ;row
    mov col,20  ;col      
    mov cx,7
    diagonal1:
    ;------------------
    mov ah,2
    mov bh,0   ;page number
    mov dh,row   ;row
    mov dl,col  ;column
    int 10h
    ;------------------
    ;Print 1
    mov dl,'\'
    mov ah,2
    int 21h
    inc row
    add col,2
    loop diagonal1
    
    
    mov row,9   ;row
    mov col,34  ;col      
    mov cx,7
    diagonal10:
    ;------------------
    mov ah,2
    mov bh,0   ;page number
    mov dh,row   ;row
    mov dl,col  ;column
    int 10h
    ;------------------
    ;Print 1
    mov dl,'\'
    mov ah,2
    int 21h
    inc row
    add col,2
    loop diagonal10 
    
    
    mov row,17   ;row
    mov col,48  ;col      
    mov cx,7
    diagonal100:
    ;------------------
    mov ah,2
    mov bh,0   ;page number
    mov dh,row   ;row
    mov dl,col  ;column
    int 10h
    ;------------------
    ;Print 1
    mov dl,'\'
    mov ah,2
    int 21h
    inc row
    add col,2
    loop diagonal100
    
    cmp used[0],'X'
    je xwin100
    jmp next100
    xwin100:
    mov winnerFlag,'X'
    jmp gameover
    next100:
    mov winnerFlag,'O'
    jmp gameover                                         

    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

drawDiagonal2:
    mov row,1   ;row
    mov col,60  ;col      
    mov cx,7
    diagonal2:
    ;------------------
    mov ah,2
    mov bh,0   ;page number
    mov dh,row   ;row
    mov dl,col  ;column
    int 10h
    ;------------------
    ;Print 1
    mov dl,'/'
    mov ah,2
    int 21h
    inc row
    sub col,2
    loop diagonal2
    
    
    mov row,9   ;row
    mov col,46  ;col      
    mov cx,7
    diagonal20:
    ;------------------
    mov ah,2
    mov bh,0   ;page number
    mov dh,row   ;row
    mov dl,col  ;column
    int 10h
    ;------------------
    ;Print 1
    mov dl,'/'
    mov ah,2
    int 21h
    inc row
    sub col,2
    loop diagonal20 
    
    
    mov row,17   ;row
    mov col,32  ;col      
    mov cx,7
    diagonal200:
    ;------------------
    mov ah,2
    mov bh,0   ;page number
    mov dh,row   ;row
    mov dl,col  ;column
    int 10h
    ;------------------
    ;Print 1
    mov dl,'/'
    mov ah,2
    int 21h
    inc row
    sub col,2
    loop diagonal200
    
    cmp used[2],'X'
    je xwin200
    jmp next200
    xwin200:
    mov winnerFlag,'X'
    jmp gameover
    next200:
    mov winnerFlag,'O'
     
    
gameover: 
mov counter,9
cmp winnerFlag,'X'
je p1win
cmp winnerFlag,'O'
je p2win
jmp draw


p1win:
mov ah,2
mov bh,0 ;page number
mov dh,2 ;row
mov dl,16 ;column
int 10h
;------------------
;Print
mov dx,offset w
mov ah,9
int 21h 

mov ah,2
mov bh,0 ;page number
mov dh,3 ;row
mov dl,16 ;column
int 10h

mov dx,offset l
mov ah,9
int 21h 

inc scoreP1
jmp score

p2win:
mov ah,2
mov bh,0 ;page number
mov dh,2 ;row
mov dl,16 ;column
int 10h
;------------------
;Print
mov dx,offset l
mov ah,9
int 21h

mov ah,2
mov bh,0 ;page number
mov dh,3 ;row
mov dl,16 ;column
int 10h 

mov dx,offset w
mov ah,9
int 21h 

inc scoreP2
jmp score

draw:

mov ah,2
mov bh,0 ;page number
mov dh,2 ;row
mov dl,16 ;column
int 10h
;------------------
;Print
mov dx,offset d
mov ah,9
int 21h 

mov ah,2
mov bh,0 ;page number
mov dh,3 ;row
mov dl,16 ;column
int 10h

mov dx,offset d
mov ah,9
int 21h 

;++++++++++++++++++++++++++++++++++++++++++++++++++++++

score:
mov ah,2
mov bh,0 ;page number
mov dh,2 ;row
mov dl,14 ;column
int 10h
;------------------
;Print
mov dl,scoreP1
add dl,30h
mov ah,2
int 21h 
    
    
    
mov ah,2
mov bh,0 ;page number
mov dh,3 ;row
mov dl,14 ;column
int 10h
;------------------
;Print
mov dl,scoreP2
add dl,30h
mov ah,2
int 21h   



mov counter,0
mov cx,9
mov di,offset used
mov al,0
rep stosb
mov flag,1
mov winnerFlag,0

;mov cx,200  ;Delay for displaying the scores
;delay:
;loop delay

mov ah,2
mov bh,0  ;page number
mov dh,23  ;row
mov dl,0 ;column
int 10h
;------------------
;Print
mov dx,offset nGame
mov ah,9
int 21h


mov ah,2
mov bh,0  ;page number
mov dh,23 ;row
mov dl,63 ;column
int 10h
;------------------
;Print
mov dx,offset rGame
mov ah,9
int 21h        
        
options:               
mov ax,3
int 33h
cmp bx,1
je clicked
jmp options   
clicked:
cmp cx,112  ; x-axis
jbe op1

cmp cx,504  ; x-axis
jae op2

jmp options

op1:
cmp dx,184   ; y-axis
jb options

mov ah,0  ; ; clearing the screen
mov al,3
int 10h 

jmp Start   


op2:          
cmp dx,184   ; y-axis
jb options

mov scoreP1,0
mov scoreP2,0

mov ah,0  ; clearing the screen
mov al,3
int 10h 

jmp Intro  

          
          
          
 