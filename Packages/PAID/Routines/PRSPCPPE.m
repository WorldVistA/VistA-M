PRSPCPPE ; HISC/MGD - DISPLAY PP ESR EXCEPTIONS ;05/18/05
 ;;4.0;PAID;**93**;Sep 21, 1995;Build 7
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
TK ; TimeKeeper Entry
 S PRSTLV=2 D T0 Q
SUP ; Supervisor Entry
 S PRSTLV=3
T0 D TOP ; print header
 S USR="",SSN=$P($G(^VA(200,DUZ,1)),"^",9)
 I SSN="" D  D EXIT Q
 . W !!,*7,"Your SSN was not found in the New Person File!"
 . S TLI=""
 S USR=$O(^PRSPC("SSN",SSN,0))
 D TLL ; Loop to prompt for T&Ls
 K DIC
 I '$D(PRSTL) D EXIT Q
 ; Prompt for Pay Period Date
 S PPI=""
 D DATE
 I Y<1!(PPI<1) D EXIT Q
 D DEVICE I POP D EXIT Q
 I $D(IO("Q")) D  D EXIT Q
 . S PRSAPGM="QEN^PRSPCPPE"
 . S PRSALST="MDAT^PPE^PPI^PRSIEN^PRSTL("
 . D QUE^PRSAUTL
 ;
QEN ; queued entry point
 ;
 ; Loop through T&Ls identifying PTP's w/ exceptions
 D LOOP
 ; Display Exceptions
 D DISPLAY
 D EXIT
 Q
 ;
TLL ; Loop to allow enting more than one T&L unit
 ; Select T&L from among those allowed
 K DIC,PRSTL
 S Z1=$S(PRSTLV="2":"T",PRSTLV="3":"S",1:"*")
 S TLI=$O(^PRST(455.5,"A"_Z1,DUZ,0))
 I TLI<1 D  Q
 . W !!,*7,"No T&L Units have been assigned to you!"
 . S TLI="^"
 I $O(^PRST(455.5,"A"_Z1,DUZ,TLI))<1 D  Q
 . S TLE=$P($G(^PRST(455.5,TLI,0)),"^",1)
 . S PRSTL(TLE)="",TLI=""
 S DIC("S")="I $D(^PRST(455.5,+Y,Z1,DUZ))"
TL S DIC="^PRST(455.5,",DIC(0)="AEQM",DIC("A")="Select T&L Unit: "
 F  D  Q:TLI=""!(TLI="^")
 . W !
 . I $D(PRSTL) S DIC("A")="Select Another T&L Unit: "
 . D ^DIC
 . I "^"[X!$D(DTOUT) S TLI="^" Q
 . S TLI=+Y
 . Q:'TLI
 . S TLE=$P($G(^PRST(455.5,TLI,0)),"^",1)
 . S PRSTL(TLE)=""
 Q
 ;
DATE S %DT="AEPX",%DT("A")="Posting Date: ",%DT(0)=-DT W ! D ^%DT
 Q:Y<1
 S D1=Y S Y=$G(^PRST(458,"AD",D1)),PPI=$P(Y,"^",1)
 Q:PPI<1
 S PPE=$P($G(^PRST(458,PPI,0)),U,1)
 S MDAT=$P($G(^PRST(458,PPI,1)),U,1)
 Q
 ;
DEVICE W !
 S %ZIS("A")="Select DEVICE: ",%ZIS="MQ"
 D ^%ZIS Q:POP
 ;
LOOP ; Loop through T&Ls identifying PTP's w/ exceptions
 K ^TMP($J,"PRSPCPPE DATA")
 S TLE="",QT=0
 F  S TLE=$O(PRSTL(TLE)) Q:TLE=""  D  Q:QT
 . S TL="ATL"_TLE
 . S NAME="",DATA1=$G(^PRST(458,PPI,1))
 . F  S NAME=$O(^PRSPC(TL,NAME)) Q:NAME=""  D  Q:QT
 . . S PRSIEN=$O(^PRSPC(TL,NAME,0))
 . . Q:'PRSIEN
 . . Q:'+$$MIEN^PRSPUT1(PRSIEN,MDAT)  ; Employee is not a PTP w/ Memo
DAYCHK . . ; Loop through the days in the PP checking the ESR status
 . . S (DAYCHK,IDAYS)=0
 . . F DAY=1:1:14 Q:$P(DATA1,U,DAY)>DT  D
 . . . S DAYCHK=$P($G(^PRST(458,PPI,"E",PRSIEN,"D",DAY,7)),U,1)
 . . . Q:DAYCHK>3  ; Not an exception
 . . . S IDAYS=IDAYS+1
 . . Q:IDAYS=0
 . . ; Found at least 1 incomplete ESR
 . . S ^TMP($J,"PRSPCPPE DATA",$P(^PRSPC(PRSIEN,0),U,1))=PRSIEN_"^"_IDAYS
 Q
 ;
DISPLAY ; Display ESR for entire Pay Period.  Sorted alphabetically
 U IO
 S QT=0,(NAME,PRSIEN)="",$P(DASH,"_",80)="_"
 D LOOP^PRSPCPP1
 D ^%ZISC K %ZIS,IOP
 Q
 ;
 ;====================================================================
TOP W:$E(IOST,1,2)="C-" @IOF W !?26,"VA TIME & ATTENDANCE SYSTEM"
 W !?27,"DISPLAY PP ESR EXCEPTIONS"
 Q
 ;
 ;====================================================================
 ;
EXIT ; Clean up variables
 K %DT,%ZIS,D1,DASH,DATA,DATA0,DATA1,DATA5,DATA6,DATA7,DAY,DAY1,DAYCHK
 K DFN,DIR,DIRUT,DTOUT,EDLSM,HRS,IDAYS,MDAT,MIEN,MT,NAME,PDT,PG,POP
 K PPE,PPI,PRSALST,PRSAPGM,PRSIEN,PRSTL,PRSTLV,PTPRMKS,QT,QUIT,RC,RCEX
 K SCRTTL,SEG,SSN,START,STAT,STATEX,STOP,SUPRMKS,T1,T1EX,T2,T2EX
 K TL,TLE,TLI,TLSCREEN,TOT,TOTEX,USR,X,Y,Z1
 K ^TMP($J,"PRSPCPPE DATA")
 Q
