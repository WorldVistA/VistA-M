XTERPUR ;ISC-SF.SEA/JLI - DELETE ENTRIES FROM ERROR TRAP ;02/11/11
 ;;8.0;KERNEL;**243,431**;Jul 10, 1995;Build 35
 ;Per VHA Directive 2004-038, this routine should not be modified.
 N I,X,XTDAT,XTDAT1,%DT
EN1 W !!,"To Remove ALL entries except the last N days, simply enter the number N at the"
 W !,"prompt.    OTHERWISE, enter return at the first prompt, and a DATE at the"
 W !,"second prompt.  If no ending date is entered at the third prompt, then only"
 W !,"the date specified will be deleted.  If an ending date is entered that range",!,"of dates INCLUSIVE will be deleted from the error log.",!!
 ;
 W !!,"Number of days to leave in error trap: " R X:DTIME Q:'$T!(X[U)  I X'="",X'=+X W:$E(X)'="?" $C(7),"  ??" W !?5,"Enter a number (zero or greater) of days to be left in the Error Log.",!,"A RETURN will result in a request for dates" G EN1
 I X=+X S X=$H-X D KRANGE(1,X) W !!?10,"DONE" D COUNT Q
 ;
EN2 R !,"Starting Date to DELETE ERRORS from: ",X:DTIME Q:'$T!(X[U)!(X="")  S %DT="EQXP" D ^%DT G:Y'>0 EN2 S XTDAT=Y
 R !,"Ending Date to DELETE ERRORS to: ",X:DTIME I '$T!(X[U) W $C(7),"  ??" Q
 S:X="" X=XTDAT,%DT="QXP" D ^%DT G:Y'>0 EN2 S XTDAT1=Y
 S XTDAT=$$FMTH^XLFDT(XTDAT),XTDAT1=$$FMTH^XLFDT(XTDAT1) I XTDAT1<XTDAT W $C(7)," ??  CAN NOT BE EARLIER" Q
 D KRANGE(XTDAT,XTDAT1),COUNT
 Q
 ;
COUNT ;Update FM zero node counts
 N I,X,XTDAT
 S X=0,XTDAT=0 F I=0:0 S I=$O(^%ZTER(1,I)) Q:I'>0  S X=X+1,XTDAT=I
 S $P(^%ZTER(1,0),U,3,4)=$S(X'>0:"",1:XTDAT_U_X)
 F XTDAT=0:0 S XTDAT=$O(^%ZTER(1,"B",XTDAT)) Q:XTDAT'>0  I '$D(^%ZTER(1,XTDAT)) K ^%ZTER(1,"B",XTDAT)
 Q
TYPE ;To purge a type of error.
 N %DT,XTDAT,XTSTR,IX,Y,CNT
 S %DT="AEX" D ^%DT Q:Y'>1  S XTDAT=+$$FMTH^XLFDT(Y)
 R !,"ERROR STRING TO LOOK FOR: ",XTSTR:DTIME
 Q:'$L(XTSTR)
 S CNT=0 W !
 F IX=0:0 S IX=$O(^%ZTER(1,XTDAT,1,IX)) Q:IX'>0  D
 . I $G(^(IX,"ZE"))[XTSTR K ^%ZTER(1,XTDAT,1,IX) W "-" Q
 . W "." S CNT=CNT+1 Q
 ;Full reference of ^(IX,"ZE") is ^%ZTER(1,XTDAT,1,IX,"ZE")
 S $P(^%ZTER(1,XTDAT,0),"^",2)=CNT ;Reset count
 Q
AUTO ;Auto clean of error over ZTQPARAM days ago.
 N XTDT,XUSX
 S XUSX=$P($G(^XTV(8989.3,1,"ZTER")),U,3)
 ;S:$G(ZTQPARAM)<1 ZTQPARAM=7
 S:$G(XUSX)<1 XUSX=7
 ;S XTDT=$P($G(^XTV(8989.3,1,"ZTER"),"^^7"),U,3),XTDT=$H-$S(XTDT>ZTQPARAM:XTDT,1:ZTQPARAM)
 S XTDT=$P($G(^XTV(8989.3,1,"ZTER"),"^^7"),U,3),XTDT=$H-$S(XTDT>XUSX:XTDT,1:XUSX)
 D KRANGE(1,XTDT),PURGE^XTERSUM1
 Q
 ;
KRANGE(XTST,XTDAT) ;Kill error trap before this date
 N XTDH
 I (XTDAT>$H)!('XTDAT) Q
 S XTDH=+$G(XTST,1)-1
 F  S XTDH=$O(^%ZTER(1,XTDH)) Q:(XTDH'>0)!(XTDH'<XTDAT)  D KILLDAY(XTDH)
 Q
KILLDAY(%H) ;Kill all errors on one day
 ;L +^%ZTER(1):60 K ^%ZTER(1,%H),^%ZTER(1,"B",%H) L -^%ZTER(1)
 N DIK,DA
 L +^%ZTER(1,%H):60 S DIK="^%ZTER(1,",DA=%H D ^DIK L -^%ZTER(1,%H)
 Q
 ;
