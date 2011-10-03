PRSA8BTH ;WOIFO/JAH - Tour Hours Display ;7/9/08
 ;;4.0;PAID;**117,110**;Sep 21, 1995;Build 7
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
TOURHRP ;Tour Hours Display for payroll
 N PRSTLV,FORWHO,TLS
 S PRSTLV=7
 S TLS=0
 S FORWHO="for Payroll"
 D MAIN
 Q
 ;
TOURHRT ; Tour hours display for timekeeper
 N TLS,PRSTLV,FORWHO S TLS=1,PRSTLV=2,FORWHO="for Timekeeper"
 D MAIN
 Q
 ;
TOURHRS ; Tour hours for T&L supervisor
 N PRSTLV,TLS,FORWHO S TLS=1,PRSTLV=3,FORWHO="for T&A Supervisor"
 D MAIN
 Q
 ;
MAIN ;
 N DIR,DIRUT,Y,PPI,PPE,NOTOUR,NOTCARD,PPRANGE,DAILYHRS,EP,SP,SDT,EDT
 N SHONOTES,PRSIEN,TLI
 S PRSIEN=0
 I TLS=1 D
 .  D ^PRSAUTL
 .  Q:TLS=1&($G(TLI)="")
 .  S PRSIEN=$$SELEMP(TLE)
 E  D
 .  S PRSIEN=$$SELEMP(0)
 Q:TLS=1&($G(TLI)="")!(PRSIEN'>0)
 ;
 S PPI=$$GETPP^PRSA8BNI()
 Q:PPI'>0
 S PPE=$P($G(^PRST(458,PPI,0)),U)
 S SDT=$P($G(^PRST(458,PPI,2)),U)
 S EDT=$P($G(^PRST(458,PPI,2)),U,14)
 S SP=$L(SDT," ")
 S EP=$L(EDT," ")
 S PPRANGE=$P(SDT," ",SP)_" thru "_$P(EDT," ",EP)
 ;
 S SHONOTES=$$SHONOTES^PRSA8BNI() ; want to see footnotes to display?
 Q:SHONOTES<0
 ;
 N %ZIS,POP,IOP,ZTSK
 S %ZIS="MQ"
 D ^%ZIS
 Q:POP
 I $D(IO("Q")) D
 .  K IO("Q")
 .  N ZTDESC,ZTRTN,ZTSAVE
 .  S ZTDESC="PAID REPORT: TOUR HOURS DISPLAY"
 .  S ZTRTN="TOUR8B^PRSA8BTH(PRSIEN)"
 .  S ZTSAVE("PRSTLV")=""
 .  S ZTSAVE("PRSIEN")=""
 .  S ZTSAVE("TLE")=""
 .  S ZTSAVE("PPI")=""
 .  S ZTSAVE("PPE")=""
 .  S ZTSAVE("TLS")=""
 .  S ZTSAVE("PPRANGE")=""
 .  S ZTSAVE("FORWHO")=""
 .  S ZTSAVE("SHONOTES")=""
 .  D ^%ZTLOAD
 .  I $D(ZTSK) W !,"Task ",ZTSK," Queued."
 E  D
 .  D TOUR8B(PRSIEN)
 K PRSTLV
 D ^%ZISC K %ZIS,IOP
 W ! S OUT=$$ASK^PRSLIB00(1)
 Q
 ;
SELEMP(TLE) ;Select employee by T&L or any employee if TLE = 0
 ;
 N DIC,EMPLOYEE,D,Y
 S DIC("A")="Select EMPLOYEE: "
 S DIC(0)="AEQM"
 S DIC="^PRSPC("
 I TLE]0 D
 . S D="ATL"_TLE
 . S DIC("S")="I $P(^(0),""^"",8)=TLE"
 . D IX^DIC
 E  D
 . D ^DIC
 S EMPLOYEE=+Y
 Q EMPLOYEE
 ;
TOUR8B(PRSIEN) ;
 U IO
 N DFN,OUT,TLECNT,TSTAMP,Y,%,%I,PG,ATL,ENT
 N EMPNODE,PRSENAME,HRS,EMPND1,SEPIND,WEEKHRS,PRSD,PRSSN
 I $D(ZTQUEUED) S ZTREQ="@"
 D NOW^%DTC S Y=% D DD^%DT S TSTAMP=$P(Y,":",1,2)
 S (OUT,PG)=0
 D HDR^PRSA8BNI(.PG,TSTAMP,0,FORWHO,PPE,PPRANGE,1)
 ;  skip Extended LWOP or anyone without a timecard
 I $G(^PRST(458,PPI,"E",PRSIEN,0))="" D  Q
 .  W !,"Employee doesn't have a timecard in this pay period"
 I $P($G(^PRST(458,PPI,"E",PRSIEN,"D",1,0)),U,2)="" D  Q
 .  W !,"Employee doesn't have a tour of duty in this pay period" Q
 ;
 ; Try to get employee entitlement from the pay period being displayed
 ; otherwise we'll have to settle for current entitlement
 N ENTPOINT
 S ENTPOINT=$P($G(^PRST(458,PPI,"E",PRSIEN,"D",1,0)),U,5)
 I ENTPOINT>0 D
 .  S ENT=$G(^PRST(457.5,ENTPOINT,0))
 I $G(ENT)="" D
 .  S DFN=PRSIEN D ^PRSAENT
 I $E(ENT)="D"!($E(ENT,1,2)="0D") D  Q
 .  W !,"This employee is on daily tours with no tour hours"
 S EMPNODE=$G(^PRSPC(PRSIEN,0))
 S EMPND1=$G(^PRSPC(PRSIEN,1))
 S SEPIND=$P(EMPND1,U,33)
 Q:EMPNODE=""!(SEPIND="Y")
 ; call to get tour hours and 8b normal hours for the pay period, but
 ; if no 8b string on file then normal hours are current normal hrs.
 S WEEKHRS=$$GETHOURS^PRSA8BNI(PPI,PRSIEN)
 S PRSENAME=$P($G(^PRSPC(PRSIEN,0)),U)
 S PRSSN=$P($G(^PRSPC(PRSIEN,0)),U,9)
 S PRSSN=$S(PRSTLV=7:$E(PRSSN,1,3)_"-"_$E(PRSSN,4,5),PRSTLV'<2:$E(PRSSN,1)_"XX-XX",1:"XXX-XX")_"-"_$E(PRSSN,6,9)
 D EMPINFO^PRSA8BNI(PRSENAME,PRSSN,WEEKHRS)
 ;  show the actual tour hours for each day
 N HRS,I
 D TOURHRS^PRSARC07(.HRS,PPI,PRSIEN)
 D TRHDR^PRSA8BNI
 F PRSD=1:1:7 D  Q:OUT
 .  I $Y>(IOSL-4) S OUT=$$RET^PRSA8BNI(TSTAMP) Q:OUT  D EMPINFO^PRSA8BNI(PRSENAME,PRSSN,WEEKHRS),TRHDR^PRSA8BNI
 .  Q:OUT
 .  D TOURDISP^PRSA8BNH(PPI,PRSIEN,PRSD,.HRS)
 I SHONOTES S OUT=$$ASK^PRSLIB00() I 'OUT W @IOF D FOOTNOTE^PRSA8BNI(1)
 Q
