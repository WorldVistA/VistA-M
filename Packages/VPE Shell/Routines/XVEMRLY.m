XVEMRLY ;DJB/VRR**RTN VER - ..LBRY Options ;2017-08-15  2:07 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ; Various tiny changes in INQUIRE and ERROR (c) Sam Habiel 2016
 ;
INQ ;Inquire
 NEW DATA,FLAGQ,I,LINE,LINE1,IEN,POP,RTN,VER
 ;
 Q:'$D(^XVV(19200.112))  ;...Version file doesn't exist
 W !,"*** INQUIRE VERSION HISTORY ***",!
 S RTN=$$GETRTN() Q:RTN']""
 ;
 W ! D ^%ZIS G:POP INQEX U IO ;Allow use of a printer
 D INQINIT,INQHD,INQHD1
 ;
 ;Display all versions
 S VER=0
 F  S VER=$O(^XVV(19200.112,"AKEY",RTN,VER)) Q:'VER  D  Q:FLAGQ
 . S IEN=$O(^XVV(19200.112,"AKEY",RTN,VER,"")) Q:'IEN
 . S DATA=$G(^XVV(19200.112,IEN,0))
 . W !,VER ;...............................Version
 . W ?9,$$FMTE^XLFDT($P(DATA,"^",4),"2D") ;Date
 . W ?19,$P(DATA,"^",3) ;..................Description
 . Q:'$O(^XVV(19200.112,"AKEY",RTN,VER))  ;Don't display PAUSE here.
 . I $Y>(IOSL-5) D INQPG Q:FLAGQ
 ;
 ;Pause the screen
 I FLAGQ!($E(IOST,1,2)="P-") G INQEX
 F I=$Y:1:(IOSL-5) W !
 D PAUSE^XVEMKU(2)
INQEX ;Exit
 D ^%ZISC
 Q
 ;
INQINIT ;Initialize variables
 S FLAGQ=0
 S $P(LINE,"=",220)=""
 S $P(LINE1,"-",220)=""
 Q
 ;
INQPG ;Page
 I $E(IOST,1,2)="P-" W @IOF Q
 D PAUSE^XVEMKU(1,"Q") Q:FLAGQ
 W @IOF D INQHD1
 Q
 ;
INQHD ;Heading
 NEW HD
 I $E(IOST,1,2)="C-" W @IOF
 E  W !!!
 S HD="VERSION HISTORY"
 W !?(IOM-$L(HD)\2),HD
 S HD="Routine: "_RTN
 W !,HD,?61 D ^%D,^%T
 W !,$E(LINE,1,IOM),!
 Q
INQHD1 ;
 W !,"VERSION",?9,"DATE",?19,"DESCRIPTION"
 W !,$E(LINE1,1,7),?9,$E(LINE1,1,8),?19,$E(LINE1,1,60)
 Q
 ;==================================================================
DESC ;Update DESCRIPTION field.
 NEW D,D0,DA,DI,DIC,DIE,DQ,DR
 NEW IEN,RTN,VER
 ;
 Q:'$D(^XVV(19200.112))  ;...Version file doesn't exist
 ;
 F  W @IOF,!,"*** UPDATE DESCRIPTION FIELD ***",! S RTN=$$GETRTN() Q:RTN']""  D  ;
 . F  W ! S VER=$$GETVER(RTN) Q:'VER  D  ;
 .. S IEN=$$GETIEN(RTN,VER) Q:'IEN
 .. ;
 .. ;Edit Description field
 .. S DIE=19200.112
 .. S DA=IEN
 .. S DR=3
 .. D ^DIE
 Q
 ;==================================================================
REVIEW ;Review a routine from the Version file (19200.112).
 NEW IEN,RTN,VER
 ;
 Q:'$D(^XVV(19200.112))  ;...Version file doesn't exist
 ;
 F  W @IOF,!,"*** REVIEW A VERSION ***",! S RTN=$$GETRTN() Q:RTN']""  D  ;
 . F  S VER=$$GETVER(RTN) Q:'VER  D  ;
 .. S IEN=$$GETIEN(RTN,VER) Q:'IEN
 .. D REVIEW1 ;Use Rtn Editor to display selected entry
 .. ;D VERSION^XVEMKT(IEN) ;Use Lister to display selected entry
 Q
 ;
REVIEW1 ;Call Rtn Editor to display rtn from the version file.
 NEW %1,FLAGPRM,FLAGVPE
 S FLAGPRM=1
 S $P(FLAGVPE,"^",4)="LBRY"
 S %1=$P($G(^XVV(19200.112,IEN,0)),U,1) ;Routine name
 Q:%1']""
 S ^TMP("XVV","LBRY",$J)=IEN ;Store IEN so REVIEW2 can use it
 D PARAM^XVEMR(RTN) ;Call Editor
 Q
 ;
REVIEW2 ;
 NEW I,IEN,TXT
 S IEN=$G(^TMP("XVV","LBRY",$J))
 Q:'$G(IEN)
 Q:'$D(^XVV(19200.112,IEN,"WP"))
 KILL ^TMP("XVV","VRR",$J,VRRS)
 KILL ^TMP("XVV","IR"_VRRS,$J)
 S ^TMP("XVV","VRR",$J,1,"NAME")=RTN
 X "F I=1:1 S TXT=$G(^XVV(19200.112,IEN,""WP"",I,0)) Q:TXT=""""  S TXT=$P(TXT,"" "")_$C(9)_$P(TXT,"" "",2,999),^TMP(""XVV"",$J,I)=TXT"
 D SET^XVEMRS1
 KILL ^TMP("XVV",$J)
 KILL ^TMP("XVV","LBRY",$J)
 Q
 ;==================================================================
RESTORE ;Restore a routine from the Version file (19200.112).
 NEW CD,CNT,FLAGQ,I,IEN,RTN,XVVS,VER,VRRPGM,X
 ;
 Q:'$D(^XVV(19200.112))  ;...Version file doesn't exist
 N $ES,$ET S $ET="D ERROR,UNWIND^XVEMSY"
 ;
 W !,"*** RESTORE A VERSION ***",!
 S RTN=$$GETRTN() Q:RTN']""
 ;
 ;Quit if routine is currently being edited.
 L +VRRLOCK(RTN):0 E  D  Q
 . W $C(7),!!,"This program is currently being edited. Try later.",!
 . D PAUSE^XVEMKU(2,"P")
 ;
 S VER=$$GETVER(RTN) Q:'VER
 S IEN=$$GETIEN(RTN,VER) Q:'IEN
 ;
 W ! Q:$$ASK^XVEMKU("Do you want to restore this version now")'="Y"
 ;
 ;Put word processing field into ^UTILITY($J) global.
 KILL ^UTILITY($J)
 S CNT=1
 F I=1:1 S CD=$G(^XVV(19200.112,IEN,"WP",I,0)) Q:CD=""  D  ;
 . S ^UTILITY($J,0,CNT)=CD
 . S CNT=CNT+1
 ;
 ;Save routine
 S FLAGQ=0 D ZSAVE^XVEMKY3 Q:FLAGQ
 S VRRPGM=RTN D E2^XVSE ; X ^XVEMS("E",2)
 ;
 W !!,"Version "_VER_" restored."
 L -VRRLOCK(RTN) ;Unlock routine editing
 D PAUSE^XVEMKU(2)
 KILL ^UTILITY($J)
 Q
 ;
 ;==================================================================
GETRTN() ;Select a routine from the Version file (19200.112)
 ;Return: Routine name
 NEW %,%Y,D,DIC,RTN,X,Y
 S DIC=19200.112
 S DIC(0)="QEAS"
 S DIC("A")="Select ROUTINE: "
 S D="UNIQ"
 D IX^DIC I Y<0 Q ""
 S RTN=$P(Y,"^",2)
 Q RTN
 ;
GETVER(RTN) ;Select a version of a routine
 ;Return: Version number
 NEW PREV,VER
 Q:$G(RTN)']""
 S PREV=$$PREVIOUS^XVEMRLV(RTN)
 W !!,"Versions on file: "
 W $E(PREV,2,$L(PREV)-1) ;Strip beginning/ending commas.
GETVER1 W !,"Select VERSION: "
 R VER:300 S:'$T VER="^" I "^"[VER Q 0
 I PREV'[(","_VER_",") W "   Invalid selection." G GETVER1
 Q VER
 ;
GETIEN(RTN,VER) ;Get IEN from Version file (19200.112).
 ;RTN=Routine name
 ;VER=Version number
 ;
 I $D(XVSIMERR) S $EC=",U-SIM-ERROR,"
 NEW IEN
 Q:$G(RTN)']""
 Q:'$G(VER)
 S IEN=$O(^XVV(19200.112,"AKEY",RTN,VER,""))
 Q +IEN
 ;
ERROR ;Error trap
 NEW ZE
 S @("ZE="_XVV("$ZE"))
 I $G(RTN)]"" L -VRRLOCK(RTN) ;Unlock routine editing
 W !!,"An error has occurred"
 W !,"ERROR: ",ZE
 D PAUSE^XVEMKU(2,"P")
 Q
