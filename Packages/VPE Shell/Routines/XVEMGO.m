XVEMGO ;DJB/VGL**CODE SEARCH,SKIP ;2017-08-15  12:42 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ; New Error trap in CODE1+4 (c) 2016 Sam Habiel
 ;
SKIP ;Skipping over nodes. Also, see first line of PRINT^XVEMGI.
 Q:'$G(FLAGSKIP)  NEW SUBCHK D GETSUB Q:$G(SUBCHK)']""
 S FLAGSKIP=$S(FLAGSKIP<1:0,FLAGSKIP>$L(SUBCHK,ZDELIM):0,1:FLAGSKIP)
 Q:'FLAGSKIP  S SKIPHLD=$P(SUBCHK,ZDELIM,FLAGSKIP)
 Q
GETSUB ;Get SUBCHK
 NEW ND,NUM S NUM=XVVT("BOT")-1
 F NUM=NUM:-1:0 S ND=$G(^TMP("XVV","IG"_GLS,$J,"SCR",NUM)) Q:ND>0
 Q:ND'>0  S ND=^TMP("XVV","VGL"_GLS,$J,ND),SUBCHK=$$ZDELIM^XVEMGU(ND)
 Q
SKIPCHK ;See if node should be skipped
 NEW ND,NUM S NUM=XVVT("BOT")-1
 I '$D(^TMP("XVV","IG"_GLS,$J,"SCR",NUM)) D  Q
 . S XVVT("TOP")=XVVT("TOP")+1
 S ND=^(NUM),ND=^TMP("XVV","VGL"_GLS,$J,ND)
 S SUBCHK=$$ZDELIM^XVEMGU(ND)
 I $P(SUBCHK,ZDELIM,FLAGSKIP)=SKIPHLD D  Q
 . S XVVT("TOP")=XVVT("TOP")+1
 S FLAGSKIP=0 KILL SKIPHLD
 S XVVT("TOP")=XVVT("BOT")-1 D REDRAW^XVEMKT2()
 Q
 ;====================================================================
CODE ;Get CODE for doing a Code Search.
 W !!?2,"The following variables are available:"
 W !!?5,"GLNAM = ""^DIC(4,1,0)"""
 W !?5,"   GL = ""^DIC"""
 W !?5,"GLSUB = ""4,1,0"""
 W !?5,"GLVAL = The data in node ^DIC(4,1,0)"
 W !?5,"    U = ""^""",!
CODE1 R !?1,"Enter Mumps Code: ",CODE:XVV("TIME") S:'$T CODE=0
 I "^"[CODE S CODE=0 Q:CODE=0
 I $E(CODE)="?" D  G CODE1
 . W "   If code evaluates to TRUE, node will be displayed."
 N $ESTACK,$ETRAP S $ETRAP="D ERROR1^XVEMGY,UNWIND^XVEMSY"
 X CODE
 Q
CDSRCH ;CODE search. Quit if search is currently active
 NEW GLNAM,GLSUB,GLVAL,I,ZREF
 Q:XVVT("STATUS")["SEARCH"  S $P(XVVT("STATUS"),"^",4)="SEARCH"
 KILL ^TMP("XVV",$J),^TMP("XVV","IG"_GLS,$J)
 S ^TMP("XVV","IG"_GLS,$J,1)=" CODE SEARCH IN PROGRESS.."
 S ^TMP("XVV","IG"_GLS,$J,2)=" Hit any key to abort. BEEP indicates search is finished."
 S ^TMP("XVV","IG"_GLS,$J,3)="~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
 S ZREF=0,XVVT("BOT")=4,XVVT("TOP")=1
 F  S ZREF=$O(^TMP("XVV","VGL"_GLS,$J,ZREF)) Q:ZREF'>0  D  Q:CODE=0
 . S GLNAM=^(ZREF),GL=$P(GLNAM,"("),GLVAL=@GLNAM
 . S GLSUB=$P($E(GLNAM,1,$L(GLNAM)-1),"(",2,99)
 . X CODE E  R XVVX#1:0 S:$T CODE=0 Q  ;Hit any key to quit
 . S ^TMP("XVV",$J,ZREF)=GLNAM
 . S XVVT=GLNAM D SETARRAY^XVEMGI
 . F I=XVVT("BOT"):1 I '$D(^TMP("XVV","IG"_GLS,$J,I)) Q
 . S XVVT("BOT")=I ;Reset to include number of lines displayed
 KILL ^TMP("XVV","VGL"_GLS,$J)
 I $D(^TMP("XVV",$J)) S ZREF=0 F  S ZREF=$O(^TMP("XVV",$J,ZREF)) Q:ZREF'>0  S ^TMP("XVV","VGL"_GLS,$J,ZREF)=^(ZREF)
 KILL ^TMP("XVV",$J)
 I XVVT("STATUS")["FINISH" D
 . S CODE=0,^TMP("XVV","IG"_GLS,$J,XVVT("BOT"))=" <> <> <>"
 . W $C(7),$C(7) S $P(XVVT("STATUS"),"^",4)=""
 S XVVT("BOT")=XVVT("TOP")
 S XVVT("HLN")=XVVT("TOP"),XVVT("H$Y")=XVVT("S1")-1
 Q
