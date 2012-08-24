PRSNAA01 ;WOIFO/DWA - Pay period approval for Nurse POC records;10/5/2009
 ;;4.0;PAID;**126**;Sep 21, 1995;Build 59
 ;;Per VHA Directive 2004-038,this routine should not be modified.
 Q
EN ; Entry point for approval of POC records for a pay period.
 N A,B,DAY,DAYREC,DIC,DIR,DIRUT,DSPFLG,GROUP,GRPIEN,GRPSC,I,IEN200
 N IEN450,NURSNM,PAYPD,PREVPD,PRSD,PRSFLG,PRSIEN,PRSPD,PRSPDE
 N PRSPDI,PRSPRM,PRSSTAT,STOP,REC,SEG
 K ^TMP($J,"PRSNAA")
 D ACCESS^PRSNUT02(.GROUP,"A",DT)
 I $P($G(GROUP(0)),U,2)="E" D  Q
 . W !!,"There are no groups assigned or selected."
 ;
 S PRSPRM=$P(GROUP(0),U,2)
 S STOP=0
 S GRPIEN=0,GRPIEN=$O(GROUP(GRPIEN))
 I PRSPRM="N" S GRPSC=$P(GROUP(GRPIEN),U,4)
 S PRSPDI=$G(^PRST(458,"AD",DT)) S:PRSPDI="" PRSPDI=$G(^PRST(458,"AD",$O(^PRST(458,"AD",":"),-1)))
 I $P(PRSPDI,U,2)<12 S PRSPDI=+PRSPDI-1
 E  S PRSPDI=+PRSPDI
 ;
 D PREV
 I PRSFLG D SETPPD
 I 'PRSFLG W "There are no POC records to approve for this "_$S(PRSPRM="N":"Nurse Location.",1:"T&L Unit.")
 ;
 D CLEANUP
 ;
 Q
 ;
SETPPD ; back up default of current pay period if it doesn't have any data
 S PRSPDI=$O(^TMP($J,"PRSNAA",PRSPDI+1),-1)
 ;
 N DIC,X,Y,DUOUT,DTOUT
 S DIC("B")=PRSPDI
 S DIC="^PRSN(451,",DIC(0)="AEQMZ"
 S DIC("A")="Select a Pay Period: "
 S DIC("S")="I +Y'>PRSPDI&($D(^TMP($J,""PRSNAA"",+Y)))"
 D ^DIC
 Q:$D(DUOUT)!$D(DTOUT)!(+$G(Y)'>0)
 S PRSPDE=$P(^PRST(458,+Y,0),U)
 ;
 ;no need to have separate approval subroutines because
 ;they have already been filtered by PREV subroutine
 ;just set date to selected date and process
 I +Y<PRSPDI S PRSPDI=+Y
 D APPREV
 ;
 Q
PREV ;
 N PREVPD,PRSNAM
 S (PRSFLG,PRSIEN,PRSSTAT)=0
 F  S PRSIEN=$O(^PRSN(451,"AE",PRSIEN)) Q:'PRSIEN  D
 .; if the access parameter matches the current nurses location or T&L unit, then display
 .;
 . S PREVPD=0
 . S PRSNAM=$P($G(^PRSPC(PRSIEN,0)),U)
 . I PRSNAM="" S PRSNAM=" "
 . N PML,TLI,TLE
 . S PML=+$$PRIMLOC^PRSNUT03($P($G(^PRSPC(PRSIEN,200)),U))
 . I PRSPRM="N"&(PML=+GROUP(GRPIEN)) D
 .. F  S PREVPD=$O(^PRSN(451,"AE",PRSIEN,PREVPD)) Q:'PREVPD!(PREVPD>PRSPDI)  D
 ... S ^TMP($J,"PRSNAA",PREVPD,PRSNAM,PRSIEN)="",PRSFLG=1
 . I PRSPRM="T" D
 .. S TLE=$P($G(^PRSPC(PRSIEN,0)),U,8)
 .. S TLI=$S(TLE="":"",1:$O(^PRST(455.5,"B",TLE,"")))
 .. F  S PREVPD=$O(^PRSN(451,"AE",PRSIEN,PREVPD)) Q:'PREVPD!(PREVPD>PRSPDI)  D
 ... ;separated employee, get T&L from archived time record
 ... I TLE="" D
 .... N PAYPRD
 .... S PAYPRD=$P($G(^PRST(458,PREVPD,0)),U)
 .... D CHECKTLE^PRSADP2(PAYPRD,PRSIEN,.TLE)
 .... S TLI=$S(TLE="":"",1:$O(^PRST(455.5,"B",TLE,"")))
 ... I TLI=+GROUP(GRPIEN) D
 .... S ^TMP($J,"PRSNAA",PREVPD,PRSNAM,PRSIEN)="",PRSFLG=1
 I PRSFLG D DSPREV
 W !!
 ;
 Q
 ;
DSPREV ;  Display previous pay period records
 ;
 W !!,"The following previous pay periods have unapproved POC records"
 W !,"in this "_$S(PRSPRM="N":"Nurse Location",1:"T&L Unit")_":",!!
 S PREVPD=0
 F  S PREVPD=$O(^TMP($J,"PRSNAA",PREVPD)) Q:'PREVPD  D
 . W "Pay period ",$P(^PRST(458,PREVPD,0),U),!
 ;
 Q
 ;
APPROV(PRSPD,PRSIEN) ; Complete approval process
 N DAY,DAYREC,REC,SEG,DSPFLG,Y
 S DSPFLG=0
 F DAY=1:1:14 D
 . K DAYREC
 . D L1^PRSNRUT1(.DAYREC,PRSPD,PRSIEN,DAY)
 . Q:'$O(DAYREC(0))
 . S SEG=0,DSPFLG=1
 . F  S SEG=$O(DAYREC(SEG)) Q:'SEG  D
 . . S REC(DAY,SEG)=DAYREC(SEG)
 . D SETREC(.REC,PRSPD)
 Q:'DSPFLG
 D DSPMM(PRSIEN,PRSPD)
 Q:STOP
 D HDR(PRSPD,PRSIEN)
 D DSPREC(.REC)
 Q:STOP
 D ACTION(PRSPD,PRSIEN)
 Q
 ;
APPREV ; Process previous pay periods
 N A,B,C
 ;
 S A=PRSPDI,B=""
 F  S B=$O(^TMP($J,"PRSNAA",A,B)) Q:(B="")!STOP  D
 . S C=""
 . F  S C=$O(^TMP($J,"PRSNAA",A,B,C)) Q:(C="")!STOP  D
 .. D APPROV(A,C)
 Q
 ;
SETREC(REC,PAYPD) ; Set up record for display
 ;
 N A,B
 S (A,B)=0
 F  S A=$O(REC(A)) Q:'A  D
 . F  S B=$O(REC(A,B)) Q:'B  D
 . . S:$P(REC(A,B),U,5)]""&($P(REC(A,B),U,5)?1.N) $P(REC(A,B),U,5)=$P($$ISACTIVE^PRSNUT01(DT,$P(REC(A,B),U,5)),U,2)
 . . S:$P(REC(A,B),U,6)]""&($P(REC(A,B),U,6)?1.N) $P(REC(A,B),U,6)=$P(^PRSN(451.5,$P(REC(A,B),U,6),0),U,2)
 . . S:$P(REC(A,B),U,8)]""&($P(REC(A,B),U,8)?1.N) $P(REC(A,B),U,8)=$P(^PRSN(451.6,$P(REC(A,B),U,8),0),U,2)
 . . QUIT
 . I $O(REC(A,0)) S $P(REC(A,$O(REC(A,0))),U,12)=$P(^PRST(458,PAYPD,2),U,A)
 . QUIT
 ;
 QUIT
 ;
DSPREC(REC) ; Display the record
 N A,B
 S (A,B)=0
 F  S A=$O(REC(A)) Q:'A  D  Q:STOP
 . F  S B=$O(REC(A,B)) Q:'B  D  Q:STOP
 . . W $P($P(REC(A,B),U,12)," "),?12,$P(REC(A,B),U),?21,$P(REC(A,B),U,3)
 . . W ?28,$P(REC(A,B),U,4),?38,$P($P(REC(A,B),U,5)," ")
 . . W ?51,$P($P(REC(A,B),U,6)," "),?64,$P($P(REC(A,B),U,8)," ")
 . . W ?77,$P(REC(A,B),U,7),!
 . . W $P($P(REC(A,B),U,12)," ",2,999),?12,$P(REC(A,B),U,2),?38
 . . W $P($P(REC(A,B),U,5)," ",2),?51,$P($P(REC(A,B),U,6)," ",2),?64
 . . W $P($P(REC(A,B),U,8)," ",2),!
 . . ;
 . . I (IOSL-6)<$Y S STOP=$$ASK^PRSLIB00() I 'STOP D HDR(PRSPD,PRSIEN) W !
 . W !
 ;
 Q
 ;
DSPMM(PRSIEN,PRSPD) ; Display mismatch report
 D PPMM^PRSNRMM(PRSIEN,PRSPD,,.STOP)
 Q:STOP
 W !!,?5,"Return to Approvals.",!
 S STOP=$$ASK^PRSLIB00(1)
 Q
 ;
ACTION(A,B) ; Approve or bypass current record
 N DIR,X,Y
 S PAYPD=A,PRSIEN=B
 S DIR("A")="Enter an 'A' to Approve or Return to Bypass: "
 S DIR(0)="SAO^A:Approve" D ^DIR ;K DIR
 I Y="" Q
 I $D(DIRUT) S STOP=1 Q
 I Y="A" D UPDTPOC^PRSNCGR1(PAYPD,PRSIEN,Y)
 ;
 Q
 ;
HDR(PAYPD,IEN450) ;
 ;
 S PRSPDE=$$GET1^DIQ(458,PAYPD,.01),PRSIEN=IEN450
 W:$E(IOST,1,2)="C-" @IOF
 W $$GET1^DIQ(450,PRSIEN,.01),?26,"Approve Pay Period POC Records"
 W ?66,"Pay Pd: ",PRSPDE,!!
 W "Date",?12,"Start/",?20,"Meal",?26,"Type of",?38,"Location",?51
 W "Type of",?66,"OT",?76,"OT",!
 W ?12,"Stop",?27,"Time",?52,"Work",?64,"Reason",?75,"Mand",!
 F I=1:1:80 W "-"
 ;
 Q
 ;
CLEANUP ;
 K PRSIEN,PRSPDI,PRSPDE,GROUP,GRPIEN,GRPSC,REC,NURSNM,IEN200
 K PRSFLG,DSPFLG,PREVPD,PRSPRM,PRSSTAT,PRSD,A,B,Y,X,DIC
 K ^TMP($J,"PRSNAA")
 Q
