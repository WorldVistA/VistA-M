XVEMDLI ;DJB/VEDD**Import ;2017-08-15  12:15 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ; SIMERR testing code by Sam Habiel (c) 2016
 Q:FLAGP  D SETARRAY,LIST
 Q
 ;===================================================================
GETXVVT ;Set XVVT=Display text
 S XVVT=$G(^TMP("XVV","ID"_VEDDS,$J,XVVT("BOT")))
 Q
LIST ;Display text
 Q:'$D(^TMP("XVV","ID"_VEDDS,$J,XVVT("BOT")))
 D GETXVVT W !,XVVT
 S XVVT("BOT")=XVVT("BOT")+1
 S:XVVT("GAP") XVVT("GAP")=XVVT("GAP")-1
 S XVVT("HLN")=XVVT("HLN")+1
 S:XVVT("H$Y")<XVVT("S2") XVVT("H$Y")=XVVT("H$Y")+1
 I $G(FLAGSTRT)]"" D FINDCHK(1) G:$G(FLAGSTRT)]"" LIST ;Starting field
 I XVVT=" <> <> <>"!'XVVT("GAP") D READ Q:FLAGQ!FLAGE
 G LIST
SETARRAY ;Set scroll array - ^TMP("XVV","ID"_VEDDS
 NEW NUM S NUM=XVVT("BOT")
 I $G(XVVT)']""!($G(XVVT)=" <> <> <>") D  Q
 . S ^TMP("XVV","ID"_VEDDS,$J,NUM)=" <> <> <>"
 S ^TMP("XVV","ID"_VEDDS,$J,NUM)=XVVT
 Q
ENDFILE() ;1=End-of-file  0=Ok
 I XVVT("GAP") W $C(7) Q 1
 I ^TMP("XVV","ID"_VEDDS,$J,XVVT("BOT")-1)=" <> <> <>" W $C(7) Q 1
 Q 0
READ ;Get input
 I $G(FLAGFIND)]"" D FINDCHK(2) Q:$G(FLAGFIND)]""  ;Find a field
 NEW KEY,PKG
READ1 S PKG="ID"_VEDDS W @XVVS("CON") ;Turn cursor back on
 D CURSOR^XVEMKU1(9,XVVT("S2")+XVVT("FT")-1,1)
 S KEY=$$READ^XVEMKTM(PKG) Q:KEY="QUIT"
 I KEY="<TAB>" D  ;
 . S TABHLD=XVVT("HLN")_"^"_XVVT("H$Y") ;Keeps highlight at same node
 . S KEY=XVVT("HLN")-1,KEY=$G(^TMP("XVV",PKG,$J,"SCR",KEY))
 . S:KEY']"" KEY="***"
 I ",?,<ESCH>,D,DA,F,G,I,G,N,P,VGL,"'[(","_KEY_","),KEY'?1.N W $C(7) G READ1
 D RUN^XVEMDLM(KEY) Q:FLAGQ  D REDRAW^XVEMKT2()
 Q
FINDCHK(TYPE) ;Find a field
 ;TYPE - 1=Starting Field  2=Field Search
 NEW NAM
 I XVVT=" <> <> <>" W $C(7) KILL FLAGFIND,FLAGSTRT Q
 S NAM=$G(^TMP("XVV","ID"_VEDDS,$J,"FLD",XVVT("BOT")-1)) Q:NAM']""
 I $G(TYPE)=2,$E(NAM,1,$L(FLAGFIND))=FLAGFIND KILL FLAGFIND Q
 I $G(TYPE)=1,$E(NAM,1,$L(FLAGSTRT))=FLAGSTRT KILL FLAGSTRT Q
 S XVVT("TOP")=XVVT("TOP")+1
 Q
FINISH ;Call here AFTER calling IMPORT
 I $G(FLAGFIND)]"" W $C(7) KILL FLAGFIND
 I 'FLAGQ,'FLAGE S XVVT=" <> <> <>" D SETARRAY,LIST
 D ENDSCR^XVEMKT2 ;Reset scroll region to full screen
 I $G(XVSIMERR) S $EC=",U-SIM-ERROR,"
 Q
