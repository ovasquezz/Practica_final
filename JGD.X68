*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------

JGDINIT
    ;MOVE.B      #88,D0
    ;MOVE.W      #10,D1
    ;MOVE.W      #369,D2
    ;MOVE.W      #40,D3
    ;MOVE.W      #399,D4
    MOVE.W  #JGDXINI,(JGDPOSX)
    MOVE.L  #JGDYINI<<16,(JGDPOSY)
    CLR.L   (JGDVELY)
    MOVE.L  #JGDXVEL,(JGDVELX)  ;X SPEED WHEN MOVING
    RTS
    
JGDUPD
    ;MOVE.B  (KBVALUE),D0
    ;AND.B   #(KBMSKLF+KBMSKRT),D0
    ;OR.B    (KBCHANG),D0
    ;MOVE.B  D0,(JGDMOT)
    
    ;update coordinate
    MOVE.W  D0,-(A7)
    
    MOVE.W  (JGDPOSY),D0
    BTST.B  #1,(KBVALUE)
    BEQ     .CHKDWN
    SUB.W   #JGDSPEED,D0
    
.CHKDWN 
    BTST.B  #3,(KBVALUE)
    BEQ     .CONT
    ADD.W   #JGDSPEED,D0
    
.CONT   ;CHECK COLLISIONS
    CMP.W   #JGDSIZE,D0
    BGE     .CONT2
    MOVE.W  #JGDSIZE,D0
    BRA     .DONE
        
.CONT2
    CMP.W   #SCRHEIGH-JGDSIZE,D0
    BLE     .DONE
    MOVE.W  #SCRHEIGH-JGDSIZE,D0

.DONE   ;UPDATE VARIABLE
        MOVE.W D0,(JGDPOSY)

    MOVE.W (A7)+,D0
    RTS
    
JGDPLOT
    MOVEM.L D0-D4,-(A7)

    ;PEN COLOR
    MOVE.B  #80,D0
    MOVE.L  #JGDPBGR,D1
    TRAP    #15
    
    ;FILL COLOR
    MOVE.B  #81,D0
    MOVE.L  #JGDFILL,D1
    TRAP    #15
    
    ;COORDENADAS
    
    MOVE.W      (JGDPOSX),D1
    SUB.W       #JGDSIZE,D1
    MOVE.W      (JGDPOSY),D2
    SUB.W       #JGDSIZE,D2
    MOVE.W      D1,D3
    ADD.W       #2*JGDSIZE,D3
    MOVE.W      D2,D4
    ADD.W       #2*JGDSIZE,D4
    MOVE.B      #88,D0
    TRAP #15

    MOVEM.L (A7)+,D0-D4
    RTS


*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~1~
*~Tab size~4~
