include irvine32.inc
.data
	board byte  "1", "2", "3",
		    "4", "5", "6",
		    "7", "8", "9", 0
    player1Msg BYTE "PLAYER 1 (O) TURN ENTER NUMBER : ", 0
    player2Msg BYTE "PLAYER 2 (X) TURN ENTER NUMBER : ", 0
    player1WinMsg BYTE "PLAYER 1 WINS", 0
    player2WinMsg BYTE "PLAYER 2 WINS", 0
    drawMsg BYTE "ITS A DRAW", 0
    invalidMsg BYTE "INVALID MOVE", 0
.code
main proc
    mov ecx, 9
    mov esi, 0
    l1:
       call displayboard
       mov edx, offset player1Msg
       call writestring
       call readdec

       dec al
       movzx esi, al
       cmp board[esi], '1'
       jge l2
       jmp invalid

       l2:
       cmp board[esi], '9'
       jle l3
       jmp invalid

       l3:
       cmp board[esi], 'O'
       jne l4
       jmp invalid

       l4:
       cmp board[esi], 'X'
       jne l5
       jmp invalid

       invalid:
            mov edx, offset invalidMsg
            call writestring
            call crlf
            jmp l1

       l5:
       movzx edi, al
       mov board[edi], 'O'

       call checkforwin
       cmp al, 10
       je player1wins
       call movesleft
       cmp al, 0
       je drawmatch

       l6:
       call displayboard
       mov edx, offset player2Msg
       call writestring
       call readdec

       dec al
       movzx esi, al
       cmp board[esi], '1'
       jge l12
       jmp invalid2

       l12:
       cmp board[esi], '9'
       jle l13
       jmp invalid2

       l13:
       cmp board[esi], 'O'
       jne l14
       jmp invalid2

       l14:
       cmp board[esi], 'X'
       jne l7
       jmp invalid2

       invalid2:
            mov edx, offset invalidMsg
            call writestring
            call crlf
            jmp l6

       l7:
       movzx edi, al
       mov board[edi], 'X'

       call checkforwin
       cmp al, 5
       je player2wins
       call movesleft
       cmp al, 0
       je drawmatch

       jmp l1

    player1wins:
        mov edx, offset player1WinMsg
        call writestring
        call displayboard
        jmp endgame

    player2wins:
        mov edx, offset player2WinMsg
        call writestring
        call displayboard
        jmp endgame

    drawmatch:
        mov edx, offset drawMsg
        call writestring
        call displayboard
       

	endgame:
	exit
main endp

displayboard proc
    call crlf
    mov esi, 0
    mov ecx, 8
    printloop:
        mov al, board[esi]
        call writechar
        inc esi
        cmp esi, 3
        je nextrow
        cmp esi, 6
        je nextrow
        mov al, ' '
        call writechar
        loop printloop
        call crlf
        ret
    nextrow:
        call crlf
        jmp printloop

displayboard endp

movesleft proc
    push ecx
    mov ecx, 8
    mov esi, 0

    l1:
        cmp board[esi], '1'
        jge dusriconditioncheckkro
        jmp conditionfalsehy

        dusriconditioncheckkro:
        cmp board[esi], '9'
        jle conditiontruehogaehy
        jmp conditionfalsehy

        conditiontruehogaehy:
            pop ecx
            mov al, 1
            ret

        conditionfalsehy:
            inc esi
            loop l1

    pop ecx
    mov al, 0
    ret
movesleft endp

checkforwin proc
    ; Check horizontally
    mov esi, 0              ; Start with the first row
    mov ecx, 3              ; Check 3 rows
    checkHorizontal:
        ; Compare the three positions in the row
        mov al, board[esi]  ; Load board[0], board[1], board[2]
        mov bl, board[esi + 1]
        mov dl, board[esi + 2]

        cmp al, bl
        jne noHorizontalWin  ; If not the same, no horizontal win
        cmp al, dl
        jne noHorizontalWin  ; If not the same, no horizontal win

        ; We found a horizontal win
        cmp al, 'O'
        je playerOWin        ; Player 1 (O) wins
        cmp al, 'X'
        je playerXWin        ; Player 2 (X) wins

    noHorizontalWin:
        add esi, 3           ; Move to the next row
        loop checkHorizontal

    ; Check vertically
    mov esi, 0              ; Start with the first column
    mov ecx, 3              ; Check 3 columns
    checkVertical:
        ; Compare the three positions in the column
        mov al, board[esi]   ; Load board[0], board[3], board[6]
        mov bl, board[esi + 3]
        mov dl, board[esi + 6]

        cmp al, bl
        jne noVerticalWin    ; If not the same, no vertical win
        cmp al, dl
        jne noVerticalWin    ; If not the same, no vertical win

        ; We found a vertical win
        cmp al, 'O'
        je playerOWin        ; Player 1 (O) wins
        cmp al, 'X'
        je playerXWin        ; Player 2 (X) wins

    noVerticalWin:
        inc esi              ; Move to the next column
        loop checkVertical

    ; Check diagonally (first diagonal)
    mov al, board[0]        ; board[0], board[4], board[8]
    mov bl, board[4]
    mov dl, board[8]

    cmp al, bl
    jne noDiagonalWin       ; If not the same, no diagonal win
    cmp al, dl
    jne noDiagonalWin       ; If not the same, no diagonal win

    ; We found a diagonal win
    cmp al, 'O'
    je playerOWin           ; Player 1 (O) wins
    cmp al, 'X'
    je playerXWin           ; Player 2 (X) wins

    noDiagonalWin:

    ; Check diagonally (second diagonal)
    mov al, board[2]        ; board[2], board[4], board[6]
    mov bl, board[4]
    mov dl, board[6]

    cmp al, bl
    jne noSecondDiagonalWin ; If not the same, no second diagonal win
    cmp al, dl
    jne noSecondDiagonalWin ; If not the same, no second diagonal win

    ; We found a second diagonal win
    cmp al, 'O'
    je playerOWin           ; Player 1 (O) wins
    cmp al, 'X'
    je playerXWin           ; Player 2 (X) wins

    noSecondDiagonalWin:

    ; If no win found, return 0
    mov al, 0
    ret

playerOWin:
    mov al, 10              ; Player 1 (O) wins
    ret

playerXWin:
    mov al, 5               ; Player 2 (X) wins
    ret
checkforwin endp
end main
