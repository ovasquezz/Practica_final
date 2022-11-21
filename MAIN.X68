*-----------------------------------------------------------
* Title      : Práctica final version 0.0
* Written by : Otto Vásquez
* Date       : 24/10/2022
* Description: Primer comienzo práctica final
*-----------------------------------------------------------
    ORG    $1000
    
    INCLUDE "SYSCONST.X68"
    INCLUDE "SYSTEM.X68"
    INCLUDE "CONST.X68"
    INCLUDE "JGD.X68"
    INCLUDE "BACKGROUND.X68"

    
    
START:                  ; first instruction of program

* Put program code here
    JSR SYSINIT
    JSR BGINIT
    JSR JGDINIT

.LOOP
    
;UPDATE

;READ INPUT DEVICES

    TRAP    #1

;UPDATE GAME LOGIC

    JSR JGDUPD

;SYNC

    ;MAL HECHO no se me ve nada en la pantalla, revisar videos
    ; 03 creacion de traps, buffer y teclado
    MOVE.B  #23,D0
    MOVE.L  #1,D1
    TRAP    #15

;PLOT

    JSR     JGDPLOT
    
    TRAP    #0  ; UPDATE DOUBLE BUFFER

    BRA     .LOOP
    

    SIMHALT             ; halt simulator

* Put variables and constants here

    INCLUDE "SYSVARS.X68"
    INCLUDE "VARS.X68"

    END    START        ; last line of source




*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~1~
*~Tab size~4~
