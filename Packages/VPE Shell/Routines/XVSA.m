XVSA ; Paideia/SMH,TOAD - VPE Main Shell Loop ;2017-08-16  10:56 AM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; (c) 2010-2016 Sam Habiel
 ; Contains code from ^XVEMS("ZA")
EN ; ZA1
ZA1 ;
 D ZO2^XVSO ; X ^XVEMS("ZO",2) ; Populate ^XVEMS("CLH","UCI"); kill shells in other UCIs
 F  D  I $G(XVVSHC)]"" Q:XVVSHC="^"  ; process read and handle qwiks
 . S $ETRAP="G ERROR^XVEMSY" ; Replace ^XV error trap; don't new!
 . N $ESTACK ; We want to quit to this level for CLH
 . D READ
 . I $G(XVVSHC)'="",XVVSHC="^" QUIT
 . W ! ; new line
 . D ZO1^XVSO ; X ^XVEMS("ZO",1) ; reset $ZR and $T
 . X XVVSHC ; execute command
 . D RESET^XVEMSY ; reset $T and naked reference
 . D RESTORE^XVSS ; X ^XVEMS("ZS",2)
 Q
 ;
PROCESS ; ZA2 ; Processes user input after user hits return
ZA2 ;
 D NOZU^XVSK ; block ^ZU
 D HELP ; did user enter ? or Esc H
 D HALT ; did user enter ^ or any variation of halt
 Q:"^"[XVVSHC  ; get out if user halted
 D:XVVSHC="<TO>" ^XVST ; timeout
 Q:"^"[XVVSHC  ; get out if user timed out
 D PROCCLH^XVSS ; X ^XVEMS("ZS",4) ; store history
 ; X $S(XVVSHC?1.2".":^XVEMS("ZQ",1),XVVSHC?1.2"."1A.E:^XVEMS("ZQ",1),1:^XVEMS("ZA",3)) ; Do qwiks; otherwise, 
 I XVVSHC?1.2"." D ^XVSQ QUIT  ; X ^XVEMS("ZQ",1) QUIT
 I XVVSHC?1.2"."1A.E D ^XVSQ QUIT  ;X ^XVEMS("ZQ",1) QUIT
 D QWIK ; otherwise...
 QUIT
 ;
QWIK ; QWIKs Help, Boxes and Command Line History - ZA3
ZA3 ;
 I XVVSHC?1"<".E1">"!(XVVSHC?1.2"."1N.E) D
 . D ^XVEMSQ
 . S XVVSHC=$S(XVVSHC?1"**".E:$E(XVVSHC,3,999),1:"")
 . I XVVSHC]"" D PROCESS
 Q
 ;
HELP ; Handles help ; ZA4
ZA4 ;
 S:XVVSHC?.E1P1"XVVSHL".1P.E XVVSHC=""
 S:$E(XVVSHC)="?"!(XVVSHC="<ESCH>") XVVSHC="D ^XVEMSH"
 QUIT
 ;
HALT ; Handle a request for a halt ("^" or H)
 I ",^,H,h,HALT,halt,"[(","_XVVSHC_",") S XVVSHC="^"
 QUIT
RESET ; Reset variables ; ZA5
ZA5 ;
 D RESET^XVSS ; X ^XVEMS("ZS",3)
 D ZO2^XVSO   ; X ^XVEMS("ZO",2)
 KILL XVVWARN
 S XVVSHL="RUN"
 D USEZERO^XVEMSU
 QUIT  ;--> RESET
 ;
READ ; Perform read and associated processing ; ZA6
ZA6 ;
 D RESET ; Reset Vars
 D ZR1^XVSR ; X ^XVEMS("ZR",1) ; Perform read
 Q:"^"[XVVSHC
 D PROCESS ; Perform processing (block ^ZU, handle "^", qwiks)
 Q:"^"[XVVSHC
 D ^XVSC ; check for global kill
 KILL XVVWARN
 Q
 ;
