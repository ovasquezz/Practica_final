*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------

BGINIT
    MOVEM.L D0-D2,-(A7)
    MOVE.B #84,D0
    MOVE.W #0,D1                ;COOR X PUNTO 1
    MOVE.W #400,D2              ;COOR Y PUNTO 1
    MOVE.W #SCRWIDTH,D3         ;COOR X PUNTO 2
    MOVE.W #400,D4              ;COOR Y PUNTO 2
    TRAP #15
    MOVEM.L (A7)+,D0-D2 
    RTS

*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~1~
*~Tab size~4~
