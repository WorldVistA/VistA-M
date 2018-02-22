XVEMDL ;DJB/VEDD**Fld Global Location ;2017-08-15  12:16 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ; New Error trap in EN+1 (c) 2016 Sam Habiel
 ;
PRINT ;Called by START,LOOP
 Q:'$D(^DD(FILE(LEV),FLD(LEV),0))
 S ZDATA=^DD(FILE(LEV),FLD(LEV),0)
 S FLDNAM=$P(ZDATA,U),SYM=$P(ZDATA,U,2)
 I SYM]"" S SYM="["_SYM_"]"
 S NP=$S($P(ZDATA,U,4)=" ; ":"Computed",1:$P(ZDATA,U,4))
 S PIECE=$P($P(ZDATA,U,4),";",2)
 I PIECE=0 D  I 1
 . NEW TMP
 . S TMP="<-Mult"
 . I $P($G(^DD(+$P(ZDATA,U,2),.01,0)),U,2)["W" S TMP="<-WP"
 . S SYM=TMP_" "_SYM
 . I $G(^DD(FILE(LEV),FLD(LEV),8))]"" S SYM="R:"_^(8)_" "_SYM
 . I $G(^(8.5))]"" S SYM="D:"_^(8.5)_" "_SYM
 . I $G(^(9))]"" S SYM="W:"_^(9)_" "_SYM
 E  I $P(ZDATA,U,2)["P"!($P(ZDATA,U,2)["V") D
 . NEW TMP
 . S TMP="<-Pntr "
 . I $P(ZDATA,U,2)["V" S TMP=TMP_"Var"
 . S SYM=TMP_" "_SYM
 S XVVX=$J($S(FLAGP:"",PIECE=0:"",1:RCNT),3)_"  "_DASHES_NP
 S XVVX=XVVX_$J("",19-$L(XVVX))_$J(FLD(LEV),8)
 S XVVX=XVVX_$J("",29-$L(XVVX))_DASHES_FLDNAM
 S XVVX=XVVX_$J("",79-$L(XVVX)-$L(SYM)-1)_SYM
 I FLAGP W !,XVVX Q  ;Quit here if sending to printer
 ;Next: Save field name for F=Find utility
 S ^TMP("XVV","ID"_VEDDS,$J,"FLD",XVVT("BOT"))=FLDNAM
 I PIECE'=0 D  ;Multiple field
 . S ^TMP("XVV","VEDD"_VEDDS,$J,RCNT)=FILE(LEV)_U_FLD(LEV)_U_XVVT("BOT") ;REF number
 . S ^TMP("XVV","ID"_VEDDS,$J,"SCR",XVVT("BOT"))=RCNT ;This allows you to use highlight to select a node.
 . S RCNT=RCNT+1 ;REF column
 S XVVT=XVVX D ^XVEMDLI ;.......................Import to scroller
 Q
EN ;Entry Point
 N $ES,$ET S $ETRAP="D ERROR^XVEMDL1,UNWIND^XVEMSY"
 NEW A,BAR,FILE,FLD,HD,II,LENGTH,LEV,SFLD,SPACE,SUB,SUBCNT,SUBSEL,SUBTEXT,SYM,TABHLD,TOT,Z1,ZDSUB
 NEW DASHES,FLAGFIND,FLAGSTRT,FLDNAM,NP,PIECE,RCNT,ZDATA
 NEW DX,DY,XVVT NEW:'$D(XVVS) XVVS ;..........IMPORT (For scrolling)
 I $G(VEDDS)'>0 NEW VEDDS S VEDDS=0
 S VEDDS=VEDDS+1 ;Tracks migration to pointed-to files
 KILL ^TMP("XVV","VEDD"_VEDDS,$J),^TMP("XVV","ID"_VEDDS,$J)
 D ASK^XVEMDL1 G:FLAGQ EX
 I FLAGP S HD="HD" D INIT^XVEMDPR,HD^XVEMDL1,START,LOOP G EX
 D IMPORT,START,LOOP,FINISH^XVEMDLI
EX ;Exit
 I FLAGQ!FLAGE!FLAGP S:$E(XVVIOST,1,2)="P-" FLAGQ=1
 KILL ^TMP("XVV","VEDD"_VEDDS,$J),^TMP("XVV","ID"_VEDDS,$J)
 S VEDDS=VEDDS-1 ;.............This is done AFTER kill in above line
 Q
START ;Print if data, otherwise continue to loop.
 Q:'$D(^DD(FILE(LEV),FLD(LEV),0))#2
 D DASHES,PRINT
 I PIECE=0 S LEV=LEV+1,FILE(LEV)=+$P(ZDATA,U,2),FLD(LEV)=0
 Q
LOOP ;Start For Loop
 S FLD(LEV)=$O(^DD(FILE(LEV),FLD(LEV)))
 I +FLD(LEV)=0 S LEV=LEV-1 G:LEV LOOP Q
 D DASHES,PRINT Q:FLAGQ!FLAGE
 I PIECE=0 S LEV=LEV+1,FILE(LEV)=+$P(ZDATA,U,2),FLD(LEV)=0
 G:$Y'>XVVSIZE LOOP
 I FLAGP D  D HD^XVEMDL1 G LOOP
 . W @XVV("IOF") W:$E(XVVIOST,1,2)="P-" !!!
 G LOOP
DASHES ;Set dashes for mult level flds
 S (SPACE,BAR)="" F II=1:1:LEV-1 S SPACE=SPACE_" ",BAR=BAR_"-"
 S DASHES=SPACE_BAR
 Q
IMPORT ;Set up for scroller
 NEW HD,HD1,LINE,MAR
 S MAR=$G(XVV("IOM")) S:MAR'>0 MAR=80
 S $P(LINE,"=",MAR)=""
 S HD="File: "_ZNAM
 S HD=HD_$J("",MAR-$L(HD)-11)_"Branch: "_VEDDS
 S HD1="REF  NODE;PIECE     FLD NUM  FIELD NAME"
 S XVVT("HD")=3
 S XVVT("HD",1)=HD
 S XVVT("HD",2)=HD1
 S XVVT("HD",3)=LINE
 S XVVT("FT")=3
 S XVVT("FT",1)=LINE
 S XVVT("FT",2)="<>  'n',I=FldDD  DA=Data  F=Find  G=Goto  N=Node  P=Pointer  VGL=VGL  ?=Help"
 S XVVT("FT",3)=" Select: "
 S XVVT("S1")=4,XVVT("S2")=(XVV("IOSL")-3)
 S XVVT("GET")="D SETARRAY^XVEMDLI"
 D IMPORTS^XVEMKT("ID"_VEDDS)
 Q
