XVEMGI ;DJB/VGL**Loop,Print,Import ;2017-08-15  12:36 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ; New Error trap in TOP+1 and PRINT (c) 2016 Sam Habiel
 ;
TOP(ZGR) ;ZGR contains starting point, such as ^VA(200).
 N $ESTACK,$ETRAP S $ETRAP="D ERROR^XVEMGI1,UNWIND^XVEMSY"
 I FLAGOPEN NEW GLB,FLAGSKIP,SKIPHLD,STK D  D:$D(@GLB(STK))#2 PRINT Q
 . S STK=1,GLB(STK)=ZGR,FLAGSKIP=0 KILL SKIPHLD
 NEW ZCHK,ZORD,GLB,FLAGSKIP,SKIPHLD,STK
 S STK=1,GLB(STK)=ZGR,ZORD(STK)="",FLAGSKIP=0 KILL SKIPHLD
LOOP ;Loop to increment and decrement STK to go up and down the subscript.
 S ZCHK=$D(@GLB(STK)) D:ZCHK#2 PRINT Q:FLAGQ!FLAGE
 I ZCHK=0 S STK=STK-1 Q:STK=0
LOOP1 ;When ZORD(STK) is null come here
 ;Convert double quotes to single quotes
 I ZORD(STK)["""""" S ZORD(STK)=$$QUOTES1^XVEMKU(ZORD(STK))
 S ZORD(STK)=$O(@GLB(STK)@(ZORD(STK)))
 I ZORD(STK)="" S STK=STK-1 Q:STK=0  G LOOP1
 ;Convert single quotes to double quotes
 I ZORD(STK)["""" S ZORD(STK)=$$QUOTES2^XVEMKU(ZORD(STK))
 I GLB(STK)?.E1")" S XVVX=$E(GLB(STK),1,$L(GLB(STK))-1)_","""_ZORD(STK)_""")",STK=STK+1,ZORD(STK)="",GLB(STK)=XVVX G LOOP
 S XVVX=ZGL_"("""_ZORD(STK)_""")",STK=STK+1,GLB(STK)=XVVX,ZORD(STK)=""
 G LOOP
 ;==================================================================
PRINT ;Print a single node
 ;Next line: restrict levels because user entered commas.
 I $D(XVSIMERR7) S $EC=",U-SIM-PROT-ERROR,"
 I FLAGC S SUBCHK=$$ZDELIM^XVEMGU(GLB(STK)) Q:FLAGC1="NP"&($L(SUBCHK,ZDELIM)<FLAGC)  Q:FLAGC1="P"&($L(SUBCHK,ZDELIM)'=FLAGC)
 I XVVT("STATUS")'["START" D IMPORTS^XVEMKT("IG"_GLS) S $P(XVVT("STATUS"),"^",1)="START"
 S GLNAM=GLB(STK),GL=$P(GLNAM,"("),GLVAL=@GLB(STK)
 S GLSUB=$P($E(GLNAM,1,$L(GLNAM)-1),"(",2,99)
 ;Next strip quotes from numeric subscripts.
 F I=1:1 S XVVX=$P(GLSUB,",",I) Q:XVVX=""  D
 . I XVVX?1"""".E1"""",XVVX'["E",XVVX'["e" D
 . . S XVVX=$E(XVVX,2,$L(XVVX)-1) I +XVVX=XVVX S $P(GLSUB,",",I)=XVVX
 I GLSUB]"" S GLNAM=GL_"("_GLSUB_")"
 I CODE'=0 X CODE E  R XVVX#1:0 Q:'$T  D  Q
 . S CODE=0,$P(XVVT("STATUS"),"^",4)="" ;Hit any key to quit
 S ^TMP("XVV","VGL"_GLS,$J,ZREF)=GLNAM
 I $G(VGLREV) S GLNAM("REV")=$$GLOBNAME^XVEMGI1(GLNAM)
 S XVVT=GLNAM D SETARRAY,LIST
 S ZREF=ZREF+1
 Q
 ;====================[ IMPORT TO SCROLLER ]=========================
GETXVVT ;Set XVVT=Display text
 S XVVT=$G(^TMP("XVV","IG"_GLS,$J,XVVT("BOT")))
 Q
LIST ;Display text
 Q:'$D(^TMP("XVV","IG"_GLS,$J,XVVT("BOT")))  D GETXVVT
 I XVVT[$C(127) D REVERSE^XVEMGI1(XVVT) I 1
 E  W !,XVVT
 S XVVT("BOT")=XVVT("BOT")+1
 S:XVVT("GAP") XVVT("GAP")=XVVT("GAP")-1
 S XVVT("HLN")=XVVT("HLN")+1
 S:XVVT("H$Y")<XVVT("S2") XVVT("H$Y")=XVVT("H$Y")+1
 I XVVT=" <> <> <>"!'XVVT("GAP") D READ^XVEMGM Q:FLAGQ!FLAGE
 G LIST
SETARRAY ;Set scroll array - ^TMP("XVV","IG"_GLS,$J
 NEW LN,NUM,SP,VAL
 S NUM=XVVT("BOT"),XVVT=$G(XVVT)
 I XVVT']""!(XVVT=" <> <> <>") D  Q
 . S ^TMP("XVV","IG"_GLS,$J,NUM)=" <> <> <>"
 ;Next line tracks what scroll nodes are associated to what VGL nodes.
 S ^TMP("XVV","IG"_GLS,$J,"SCR",NUM)=ZREF
 S @("LN="_XVVT)
 I LN?.E1C.E S LN=$$CC(LN) ;Control characters
 S SP=$J(ZREF,3)_") "_$S('$G(VGLREV):XVVT,1:GLNAM("REV"))
 S LN=SP_" = "_LN,SP=$L(SP)
 F NUM=NUM:1 D  Q:LN']""
 . S VAL=$E(LN,1,XVV("IOM")-1)
 . S ^TMP("XVV","IG"_GLS,$J,NUM)=VAL
 . S LN=$E(LN,XVV("IOM"),999) Q:LN']""
 . I $L(XVVT)<40 S LN=$J("",SP)_" = "_LN Q
 . I NUM=XVVT("BOT"),($L(XVVT)+10)>XVV("IOM") S LN="          "_LN Q
 . S LN="          = "_LN
 Q
CC(TXT) ;Display control characters
 ;Example: replace $C(9) with /009.
 NEW I,TXT1,VAL
 I $G(TXT)']"" Q ""
 S TXT1=TXT,TXT=""
 F I=1:1:$L(TXT1) S VAL=$A($E(TXT1,I)) D  ;
 . I VAL>31 S TXT=TXT_$C(VAL) Q
 . S TXT=TXT_"/"_$E("000",1,3-$L(VAL))_VAL
 Q TXT
FINISH ;Call here AFTER calling IMPORT
 Q:$G(XVVT("STATUS"))'["START"  S $P(XVVT("STATUS"),"^",2)="FINISH"
 ;Next terminate any Code Search
 S $P(XVVT("STATUS"),"^",4)="" I CODE'=0 W $C(7),$C(7) S CODE=0
 I $G(FLAGSKIP) W $C(7) S FLAGSKIP=0 KILL SKIPHLD ;Turn off node skip
 I 'FLAGQ,'FLAGE S XVVT=" <> <> <>" D SETARRAY,LIST
 D ENDSCR^XVEMKT2 ;Reset scroll region to full screen
 Q
