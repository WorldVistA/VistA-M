PRSNAC01 ;WOIFO/DWA - Approval for Corrected Nurse POC records;10/5/2009
 ;;4.0;PAID;**126**;Sep 21, 1995;Build 59
 ;;Per VHA Directive 2004-038,this routine should not be modified.
 Q
EN ; Entry point for approval of POC records for a pay period.
 N A,CHECK,IEN200,PRSD,PRSPPD,PRSIEN,PRSSN,POCREC,PRSVER,POCSEG
 N POCCNT,DIR,FOUND,GROUP,GRPIEN,GRPSC,GRPNM,I,LOC,POCP,POCC,REC
 N STOP,ZEROFND,PRSDAY,PRSDIV,PRSDIVE,PRSDIVI,PRSPRM
 S STOP=0
 D ACCESS^PRSNUT02(.GROUP,"A",DT)
 I $P($G(GROUP(0)),U,2)="E" D  Q
 . W !!,"There are no groups assigned or selected."
 ;
 S PRSPRM=$P(GROUP(0),U,2)
 S GRPNM=0,GRPNM=$O(GROUP(GRPNM))
 S GRPIEN=$P(GROUP(GRPNM),U)
 I PRSPRM="N" S GRPSC=$P(^NURSF(211.4,GRPIEN,0),U)
 S PRSDIVI=$P(GROUP(GRPNM),U,2)
 S PRSDIVE=$P(GROUP(GRPNM),U,3)
 ;
 D LOCCOR
 ;
 Q
 ;
 ;
LOCCOR ;
 S LOC=0
 F  S LOC=$O(GROUP(LOC)) Q:LOC=""  D
 . I PRSPRM="N" S CHECK(+GROUP(LOC))=""
 . I PRSPRM="T" S CHECK(LOC)=""
 S (PRSDIV,ZEROFND)=0
 F  S PRSDIV=$O(^PRSN(451,"ACE",PRSDIV)) Q:'PRSDIV  D  Q:STOP
 . S PRSPPD=0
 . F  S PRSPPD=$O(^PRSN(451,"ACE",PRSDIV,PRSPPD)) Q:'PRSPPD  D  Q:STOP
 . . S PRSIEN=0
 . . F  S PRSIEN=$O(^PRSN(451,"ACE",PRSDIV,PRSPPD,PRSIEN)) Q:'PRSIEN  D  Q:STOP
 . . . I PRSPRM="N" D GRPLOC
 . . . I PRSPRM="T" D TLLOC
 . . . Q:'FOUND
 . . . S PRSDAY=0
 . . . F  S PRSDAY=$O(^PRSN(451,"ACE",PRSDIV,PRSPPD,PRSIEN,PRSDAY)) Q:'PRSDAY  D  Q:STOP
 . . . . K POCP
 . . . . D L1^PRSNRUT1(.POCP,PRSPPD,PRSIEN,PRSDAY,"P"),SETREC(.POCP)
 . . . . K POCC
 . . . . D L1^PRSNRUT1(.POCC,PRSPPD,PRSIEN,PRSDAY,"C"),SETREC(.POCC)
 . . . . D DSPMM
 . . . . Q:STOP
 . . . . D DISPTM
 . . . . Q:STOP
 . . . . D ACTION
 ;
 I 'ZEROFND W !!,"There are no corrected records to approve.",!!
 ;
 Q
 ;
DISPTM ;Display the time records
 D HDR
 W !,?(80-26)/2,"** Previous Time Record **",!
 D DSPREC(.POCP)
 W !,?(80-26)/2,"** Current Time Record **",!
 D DSPREC(.POCC)
 Q
 ;
GRPLOC ; Find records for selected group
 S FOUND=0
 I $D(CHECK(+$$PRIMLOC^PRSNUT03(^PRSPC(PRSIEN,200)))) S (FOUND,ZEROFND)=1
 ;
 Q
 ;
TLLOC ; Find records for selected T&L Unit
 S FOUND=0
 N TLE
 S TLE=$P(^PRSPC(PRSIEN,0),U,8)
 ;separated employee, get T&L from archived time record
 I TLE="" D
 .N PAYPRD
 .S PAYPRD=$P($G(^PRST(458,PRSPPD,0)),U)
 .D CHECKTLE^PRSADP2(PAYPRD,PRSIEN,.TLE)
 .Q
 Q:TLE=""
 I $D(CHECK(TLE)) S (FOUND,ZEROFND)=1
 ;
 Q
 ;
SETREC(REC) ; Set up current record for display
 S A=0
 F  S A=$O(REC(A)) Q:'A  D
 . S PRSVER=$P(REC(A),U,11)
 . S:$P(REC(A),U,5)]""&($P(REC(A),U,5)?1.N) $P(REC(A),U,5)=$P($$ISACTIVE^PRSNUT01(DT,$P(REC(A),U,5)),U,2)
 . S:$P(REC(A),U,6)]""&($P(REC(A),U,6)?1.N) $P(REC(A),U,6)=$P(^PRSN(451.5,$P(REC(A),U,6),0),U,2)
 . S:$P(REC(A),U,8)]""&($P(REC(A),U,8)?1.N) $P(REC(A),U,8)=$P(^PRSN(451.6,$P(REC(A),U,8),0),U,2)
 . QUIT
 I $O(REC(0)) S $P(REC($O(REC(0))),U,12)=$P(^PRST(458,PRSPPD,2),U,PRSDAY)
 ;
 Q
 ;
DSPREC(REC) ;  Display current record
 N A
 S A=0
 ;I REC(0)=0 W ?(80-20)/2,"Time Record Deleted",!
 F  S A=$O(REC(A)) Q:'A  D  Q:STOP
 . W $P($P(REC(A),U,12)," "),?12,$P(REC(A),U),?21,$P(REC(A),U,3)
 . W ?28,$P(REC(A),U,4),?38,$P($P(REC(A),U,5)," ")
 . W ?51,$P($P(REC(A),U,6)," "),?64,$P($P(REC(A),U,8)," ")
 . W ?77,$P(REC(A),U,7),!
 . W $P($P(REC(A),U,12)," ",2,999),?12,$P(REC(A),U,2),?38
 . W $P($P(REC(A),U,5)," ",2),?51,$P($P(REC(A),U,6)," ",2),?64
 . W $P($P(REC(A),U,8)," ",2),!
 . ;
 . I (IOSL-6)<$Y S STOP=$$ASK^PRSLIB00() I 'STOP D HDR W !
 ;
 Q
 ;
DSPMM ;  Display the mismatch report before asking for approval
 D PPMM^PRSNRMM(PRSIEN,PRSPPD,,.STOP)
 Q:STOP
 W !!,?5,"Return to Approvals.",!
 S STOP=$$ASK^PRSLIB00(1)
 ;
 Q
 ;
ACTION ;  Approve or Bypass current record
 N DIR,X,Y
 S DIR("A")="Enter an 'A' to Approve or Return to Bypass: "
 S DIR(0)="SAO^A:Approve" D ^DIR
 I Y="" Q
 I Y["^" S STOP=1 Q
 I Y="A" D UPDTPOCD^PRSNCGP(PRSPPD,PRSIEN,PRSDAY,PRSVER,Y)
 ;
 Q
 ;
HDR ;  Header for display of records
 W:$E(IOST,1,2)="C-" @IOF
 W $P(^PRSPC(PRSIEN,0),U),?(80-28)/2,"Approve Corrected POC Record"
 W ?63,$S(PRSPRM="N":"Location: "_GRPNM,1:"T&L Unit: "_GRPNM),!
 W ?58,"SSN: ",$E($P(^PRSPC(PRSIEN,0),U,9)),"XXXXX",$E($P(^PRSPC(PRSIEN,0),U,9),6,9),!
 W "Date",?12,"Start/",?20,"Meal",?26,"Type of",?38,"Location",?51
 W "Type of",?66,"OT",?76,"OT",!
 W ?12,"Stop",?27,"Time",?52,"Work",?64,"Reason",?75,"Mand",!
 F I=1:1:80 W "-"
 ;
 ;
 Q
