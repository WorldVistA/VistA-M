DDW1 ;SFISC/PD KELTZ-LOAD, SAVE ;06:11 PM  25 Aug 2002
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**18,999**
 ;
LOAD ;Put up "box" and load document
 N DDWI,DDWX
 D BOX
 ;
 I $D(DWLC)[0 D
 . S DWLC=$S($D(@DDWDIC@(0))#2:+$P(@DDWDIC@(0),U,4),1:$O(@DDWDIC@(""),-1))
 . S:$D(@DDWDIC@(1))#2 $E(DDWBF,4)=1
 S DDWCNT=$S(DWLC:DWLC,1:1)  ;HOW MANY LINES WE HAVE TOTAL
 ;
 D:DDWCNT>1 MSG^DDW("...")
 F DDWI=DDWCNT:-1:DDWMR+1 D  ;PUT HIDDEN LINES INTO ^TMP
 . S DDWSTB=DDWSTB+1
 . S DDWX=$S('$E(DDWBF,4):$G(@DDWDIC@(DDWI,0)),1:$G(@DDWDIC@(DDWI)))
 . D:DDWX?.E1C.E CTRL
 . S ^TMP("DDW1",$J,DDWSTB)=DDWX
 ;
 F DDWI=1:1:DDWMR D  ;start writing from line 1 (!)
 . S DDWX=$S(DDWI>DDWCNT:"",'$E(DDWBF,4):$G(@DDWDIC@(DDWI,0)),1:$G(@DDWDIC@(DDWI)))
 . D:DDWX?.E1C.E CTRL
 . S DDWL(DDWI)=DDWX
 . I DDWC'>IOM,DDWRW'>DDWMR,DDWI'>DDWCNT,DDWX'?." " D
 .. D CUP(DDWI,1) W $E(DDWX,1,IOM) ;HERE'S WHERE A LINE IS WRITTEN OUT
 ;
 I DDWCNT=1,DDWL(1)?1." " S DDWL(1)=""
 D:DDWCNT>1 MSG^DDW()
 ;
CTRLREM D:$G(DDWED) MSG^DDW($C(7)_$P(DDGLVID,DDGLDEL,6)_$$EZBLD^DIALOG(8128)_$P(DDGLVID,DDGLDEL,10)) ;**'CONTROL CHARACTERS REPLACED'
 ;
 I DDWRW="B" D
 . D BOT^DDW3
 E  D LINE^DDWG(DDWRW,DDWC)
 Q
 ;
CTRL ;Strip control characters from DDWX
 N I
 S DDWED=1
 F I=1:1:$L(DDWX) S:$E(DDWX,I)?1C $E(DDWX,I)=" "
 Q
 ;
BOX ;Draw box
 N DDWX
 ;
 I $D(DIWETXT) D
 . D CUP(-1,1)
 . W $P(DDGLVID,DDGLDEL)_$E(DIWETXT,1,IOM)_$P(DDGLVID,DDGLDEL,10)
 ;
 I $D(DIWESUB) S DDWX=DIWESUB
 E  I $D(DH)#2,$D(DIE) S DDWX=DH
 S DDWX=$E($G(DDWX),1,30)
 ;
 D CUP(0,1) W $TR($J("",IOM)," ","=")
 I DDWRAP S DX=2 X IOXY W "[ WRAP ]"
 S DX=12 X IOXY W "["_$$UP^DILIBF($P($$EZBLD^DIALOG(7002),U,$S(DDWREP:2,1:1)))_"]" ;**INSERT/REPLACE
 S DX=40-($L(DDWX)\2) X IOXY W "< "_$E(DDWX,1,30)_" >"
 N DDWH S DDWH="["_$$EZBLD^DIALOG(8074)_"]",DX=76-$L(DDWH) X IOXY W DDWH ;**
 ;
 D CUP(DDWMR+1,1) W $E(DDWRUL,1,IOM)
 I DDWLMAR-DDWOFS'<1,DDWLMAR-DDWOFS'>IOM D
 . S DX=DDWLMAR-DDWOFS-1 X IOXY W "<"
 I DDWRMAR-DDWOFS'<1,DDWRMAR-DDWOFS'>IOM D
 . S DX=DDWRMAR-DDWOFS-1 X IOXY W ">"
 Q
 ;
AUTOTM ;Prompt for autosave time
 N DDWHLP,DDWANS,DDWCOD
 S DDWHLP(1)="  Enter the interval in MINUTES you wish to have the Screen Editor"
 S DDWHLP(2)="  automatically save the text. Enter a number between 0 and 120."
 S DDWHLP(3)="  A value of 0 means text is NOT automatically saved."
 D ASK^DDWG(5,"Interval in MINUTES to automatically save text: ",15,+$G(DDWAUTO),"D AUTOVAL^DDW1",.DDWHLP,.DDWANS,.DDWCOD)
 ;
 Q:DDWCOD="TO"!(DDWANS=U)
 I $G(DDWANS) D
 . S DDWAUTO=DDWANS
 . S DDWAUTO("H")=$H
 . S DDWAUTO("S")=DDWAUTO*60
 E  K DDWAUTO
 Q
 ;
AUTOVAL ;Validate autosave time
 K DDWERR
 I DDWX?."^"!($P($G(DDWCOD),U)="TO") S DDWX=U Q
 I $L(DDWX)>15 D
 . S DDWERR="  Response must not be more than 15 characters in length."
 I DDWX'=+$P(DDWX,"E") D
 . S DDWERR="  Response must be numeric."
 I DDWX>120!(DDWX<0) D
 . S DDWERR="  Response must be between 0 and 120."
 Q
 ;
AUTOSV ;Autosave
 I $D(DDWED) K DDWED D SV
 S DDWAUTO("H")=$H
 Q
 ;
SV ;Called from DDWT1 and AUTOSV
 D SAVE
 S:DDWCNT<1 DDWCNT=1
 I DDWRW+DDWA>DDWCNT D
 . D POS(DDWCNT-DDWA,"E","RN")
 E  D POS(DDWRW,DDWC)
 Q
 ;
SAVE ;Save document
 N DDWI,DDWLMEM,DDWLSTB,DDWX
 D MSG^DDW($$EZBLD^DIALOG(8075.5)) H .5 ;**'SAVING CHANGES'
 S DDWCNT=0
 K @DDWDIC
 ;
 F DDWI=1:1:DDWA D
 . S DDWCNT=DDWCNT+1,DDWX=$$NTS(^TMP("DDW",$J,DDWI))
 . I '$E(DDWBF,4) S @DDWDIC@(DDWCNT,0)=DDWX
 . E  S @DDWDIC@(DDWCNT)=DDWX
 ;
 S DDWLMEM=999
 F DDWI=1:1:DDWSTB+1 Q:DDWI>DDWSTB  Q:^TMP("DDW1",$J,DDWI)'?." "
 I DDWI'>DDWSTB S DDWLSTB=DDWI
 E  D
 . F DDWI=DDWMR:-1:0 Q:'DDWI  Q:DDWL(DDWI)'?." "
 . S DDWLMEM=DDWI
 ;
 F DDWI=1:1:$$MIN(DDWLMEM,DDWMR) D
 . S DDWCNT=DDWCNT+1,DDWX=$$NTS(DDWL(DDWI))
 . I '$E(DDWBF,4) S @DDWDIC@(DDWCNT,0)=DDWX
 . E  S @DDWDIC@(DDWCNT)=DDWX
 ;
 I $D(DDWLSTB) F DDWI=DDWSTB:-1:DDWLSTB D
 . S DDWCNT=DDWCNT+1,DDWX=$$NTS(^TMP("DDW1",$J,DDWI))
 . I '$E(DDWBF,4) S @DDWDIC@(DDWCNT,0)=DDWX
 . E  S @DDWDIC@(DDWCNT)=DDWX
 ;
 S DWLC=DDWCNT,DWHD=U
 I DDWCNT,'$E(DDWBF,4) S @DDWDIC@(0)=U_U_DWLC_U_DWLC_U_DT_U
 D MSG^DDW()
 Q
 ;
QUIT ;If any edits were made, issue confirmation prompt.
 S DDWFIN=""
 Q:$G(DDWFLAGS)["Q"!'$D(DDWED)
 ;
 N DDWHLP,DDWANS,DDWCOD
 S DDWHLP(1)="  Enter 'Yes' to save changes and quit."
 S DDWHLP(2)="  Enter 'No' to discard changes and quit."
 S DDWHLP(3)="  Enter '^' to return to the editor without saving or quitting."
 ;
 D ASK^DDWG(5,$$EZBLD^DIALOG(8075.1),3,"","D QUITVAL^DDW1",.DDWHLP,.DDWANS,.DDWCOD) ;**'DO YOU WANT TO SAVE CHANGES? '
 ;
 I DDWCOD="TO"!(DDWANS=U) K DDWFIN
 E  I DDWANS="Y" D SAVE K DUOUT ;GFT
 Q
 ;
QUITVAL ;Validate responses to the confirmation prompt
 K DDWERR
 I DDWX[U!($P(DDWCOD,U)="TO") S DDWX=U Q
 I DDWX="" S DDWERR=$$EZBLD^DIALOG(8041) Q  ;**'REQUIRED'
 ;
 S:DDWX?.E1L.E DDWX=$$UP^DILIBF(DDWX) ;**
 ;
 I $P("YES",DDWX)]"",$P("NO",DDWX)]"" D  Q
 . S DDWERR=$$EZBLD^DIALOG(1401) ;**'NOT VALID'
 ;
 S DDWX=$E(DDWX)
 Q
 ;
POS(R,C,F) ;Pos cursor based on char pos C
 N DDWX
 S:$G(C)="E" C=$L($G(DDWL(R)))+1
 S:$G(F)["N" DDWN=$G(DDWL(R))
 S:$G(F)["R" DDWRW=R,DDWC=C
 ;
 S DDWX=C-DDWOFS
 I DDWX>IOM!(DDWX<1) D SHIFT^DDW3(C,.DDWOFS)
 S DY=IOTM+R-2,DX=C-DDWOFS-1 X IOXY
 Q
 ;
CUP(Y,X) ;Cursor positioning
 S DY=IOTM+Y-2,DX=X-1 X IOXY
 Q
 ;
MIN(X,Y) ;Return the minimum of X and Y
 Q $S(X<Y:X,1:Y)
 ;
NTS(X) ;Change "" to " "
 Q $S(X="":" ",1:X)
 ;
TR(X,F) ;Strip trailing blanks
 ;If F["B" return " " if X=""
 I $G(X)]"" D
 . N I
 . F I=$L(X):-1:0 Q:$E(X,I)'=" "
 . S X=$E(X,1,I)
 I X="",$G(F)["B" S X=" "
 Q X
