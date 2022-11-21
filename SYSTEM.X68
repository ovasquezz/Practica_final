*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------

SYSINIT                  ; first instruction of program

    JSR SCRINIT
    JSR KBINIT
    
    MOVE.L #SCRPLOT,($80)
    MOVE.L #KBUPD,($84)
    
    MOVE.W SR,-(A7)
    ANDI.W #$DFFF,(A7)
    RTE

SCRINIT
; INPUT SCREEN, SET SCREEN RESOLUTION, SET WINDOWED MODE, CLEAR SCREEN

    MOVEM.L D0-D1,-(A7)
    
    MOVE.B #33,D0
    MOVE.L #SCRWIDTH<<16|SCRHEIGH,D1
    TRAP #15
    
    ; SET WINDOWED MODE
    MOVE.L #1,D1
    TRAP #15
    
    ;CLEAR SCREEN
    MOVE.B #11,D0
    MOVE.W #$FF00,D1
    TRAP   #15
    
    ;DOUBLE BUFFER
    MOVE.B  #92,D0
    MOVE.B  #17,D1
    TRAP    #15
    
    
    MOVEM.L (A7)+,D0-D1
    
    RTS
    
SCRPLOT

    MOVEM.W D0-D1,-(A7)
    ; UPDATE DOUBLE BUFFER
    MOVE.B  #94,D0
    TRAP    #15    
    
    ;CLEAR HIDDEN BUFFER
    MOVE.B  #11,D0
    MOVE.W  #$FF00,D1
    TRAP    #15 
    
    MOVEM.W (A7)+,D0-D1
    RTE
    
KBINIT

    CLR.B   (KBVALUE)
    CLR.B   (KBCHANG)
    RTS
    
KBUPD   ;UPDATE KEYBOARD
;7 ->
;6 ->
;5 ->
;4 -> PAUSE
;3 -> DOWN
;2 -> RIGHT
;1 -> UP
;0 -> LEFT
    MOVEM.L D0-D3,-(A7)
    MOVE.B  #19,D0
    MOVE.L  #KBP,D1
    TRAP    #15
    BSR     .STORE
    MOVE.L  #KBDOWN<<24+KBRIGHT<<16+KBUP<<8+KBLEFT,D1
    TRAP    #15
    BSR     .STORE
    
    MOVE.B  (KBVALUE),D0
    NOT.B   D0
    AND.B   D2,D0
    MOVE.B  D2,(KBVALUE)
    MOVE.B  D0,(KBCHANG)
    MOVEM.L (A7)+,D0-D3
        
    RTE


.STORE  MOVE.W  #3,D3
.LOOP   LSL.L   #8,D1
        ROXL.B  #1,D2
        DBRA.W  D3,.LOOP
        RTS






*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~1~
*~Tab size~4~
