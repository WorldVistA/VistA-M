PRSPCORE ;WOIFO/JAH - pt phys report on Core Hour Tours ;01/22/05
 ;;4.0;PAID;**93**;Sep 21, 1995;Build 7
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;  Report all tours of duty that currently have a Core Hours 
 ;  designation in the TOUR OF DUTY(#457.1)
 ;
 ; The Payroll Supervisor will need to remove the
 ; designation from the indicated tour.
 ;
 Q
COREHRS ; main driver for the core hours report
 ; Get Station Number
 N Y,%,TSTAMP,%ZIS,POP,INCLUDE,PPI,PPE
 D NOW^%DTC S Y=% D DD^%DT S TSTAMP=Y
 ;
 ; look for core designation in the tours
 ;
 D INTRO
 Q:$$ASK^PRSLIB00(1)
 S INCLUDE=$$INCLEMP^PRSPCORE()
 Q:INCLUDE<0
 S PPI=0
 I INCLUDE S PPI=$$WHICHPP() Q:PPI<0
 I PPI>0 S PPE=$P(^PRST(458,PPI,0),U)
 ; if the pay period is not open then don't try to print employee list
 I PPI=0 S INCLUDE=0
 ;
 S %ZIS="MQ"
 D ^%ZIS
 Q:POP
 I $D(IO("Q")) D
 . K IO("Q")
 . N ZTDESC,ZTRTN,ZTSAVE
 . S ZTDESC="PAID TOURS WITH CORE TIME REPORT",ZTRTN="TOURCHK^PRSPCORE"
 . S ZTSAVE("TSTAMP")="",ZTSAVE("INCLUDE")="",ZTSAVE("PPI")="",ZTSAVE("PPE")=""
 . D ^%ZTLOAD
 .;
 E  D
 .  D TOURCHK
 Q
 ;
INTRO ;always show the option description to the user since this is 
 ; standalone secondary option.
 N X,Y,DIC,PRSHLP,PRSER,OPTIEN,LN
 W @IOF,!
 S X="PRSP PS CORE HRS RPT"
 S DIC="^DIC(19,"
 S DIC(0)="MZ"
 D ^DIC
 Q:$G(Y)'>0
 S OPTIEN=+$G(Y)
 S X=$$GET1^DIQ(19,OPTIEN,3.5,,"PRSHLP","PRSER")
 S LN=0
 F  S LN=$O(PRSHLP(LN)) Q:LN'>0  D
 . W !,PRSHLP(LN)
 S LN=0
 F  S LN=$O(PRSER(LN)) Q:LN'>0  D
 . W !,PRSER(LN)
 Q
HDR(TSTAMP) ;
 N I,L1
 W @IOF,!
 I $G(INCLUDE) W ?2,"Employee search in PP ",PPE," included."
 W ?(IOM-$L(TSTAMP)-1),TSTAMP
 S L1="PAID - TOURS OF DUTY WITH PHYS/DENT CORE HOURS SEGMENTS REPORT"
 W !,?(IOM-$L(L1))/2,L1
 W !," TOUR #",?10,"TOUR NAME",?50,"SEGMENT"
 W !
 F I=1:1:IOM-1 W "-"
 Q
 ;
RET(TSTAMP) ;
 I ($E(IOST,1,2)'="C-")!($D(ZTQUEUED)) D HDR(TSTAMP) Q 0
 ;
 N OUT
 S OUT=$$ASK^PRSLIB00(1)
 I 'OUT D HDR(TSTAMP)
 Q OUT
 ;
TOURCHK ; check tour of duty file for tours with special time Phy/Dent core
 ;
 ; STIEN-SPECIAL TOUR INDICATOR IEN (457.2)
 ; STPTR-POINTER FROM TOUR OF DUTY FILE TO THE SPECIAL TOUR IND FILE
 ;
 U IO
 N I,ZNODE,NODE1,OUT,STPTR,STIEN,STCNT,SEGCNT,HASCORE,NODEX,TOUR
 ; Loop through tours
 ;
 S STIEN=$O(^PRST(457.2,"B","Phy/Den Core Hours",0))
 I STIEN'>0 D  Q
 .  D HDR(TSTAMP)
 .  W !!,"REPORT ABORTED!"
 .  W !,"No Phy/Den Core Hours entry found in file 457.2"
 S (STCNT,TOUR,OUT)=0,NODEX=1
 D HDR(TSTAMP)
 F  S TOUR=$O(^PRST(457.1,TOUR)) Q:TOUR'>0!(OUT)  D
 . S HASCORE=0
 . S ZNODE=$G(^PRST(457.1,TOUR,0))
 . S NODE1=$G(^PRST(457.1,TOUR,1))
 . ;
 . ; Loop through 7 Special Codes looking for code
 . ; #3 Phy/Den Core Hours
 . ; 
 . S SEGCNT=0
 . F I=3:3:21 D
 ..  S STPTR=$P(NODE1,U,I)
 ..  I STPTR=STIEN S SEGCNT=SEGCNT+1 D
 ...   S HASCORE=1
 ...   I SEGCNT=1 D
 ....    S STCNT=STCNT+1
 ....    W !!,$J(TOUR,7),?10,$P(ZNODE,U)
 ...   E  D
 ....    W !
 ...   W ?50,I/3,": ",$P(NODE1,U,I-2)," - ",$P(NODE1,U,I-1)
 .;
 . I $Y>(IOSL-3) S OUT=$$RET(TSTAMP) Q:OUT
 . I HASCORE S OUT=$$TLLIST^PRSPCORE(TOUR,TSTAMP) Q:OUT
 . I INCLUDE,HASCORE S OUT=$$EMPLIST(TSTAMP,TOUR,PPI,TOUR) S HASCORE=0 Q:OUT
 ;
 ;
 I STCNT=0 W !!,?5,"No Tours were found with Special Tour Indicator of Phy/Den Core Hrs"
 D ^%ZISC
 I $D(ZTSK) S ZTREQ="@"
 Q
WHICHPP() ;
 N PPI,SRT,DFN
 S PPI=$P($G(^PRST(458,"AD",DT)),U)
 I PPI'>0 S PPI=$O(^PRST(458,99999),-1)
 Q:PPI'>0
 S DFN=0 D NOL^PRSATE2
 S PPI=$S(SRT="L":PPI-1,SRT="N":PPI+1,SRT="C":PPI,1:-1)
 Q:PPI<0 PPI
 I '$G(^PRST(458,PPI,0)) S PPI=0 W !,"No employee tour data available for the unopened pay period."
 Q PPI
INCLEMP() ;ASK USER IF THEY WANT TO INCLUDE EMPLOYEES WITH THE TOUR
 N DIR,DIRUT,Y,INCLUDE
 S DIR(0)="YA0"
 S DIR("B")="N"
 S DIR("A")="List employees with Phys/Den Core Hours Tours?"
 D ^DIR
 S INCLUDE=+Y
 I $D(DIRUT) S INCLUDE=-1
 Q INCLUDE
EMPLIST(TS,TR,PPI,STIEN) ;LOOP THRU PP TO DISPLAY EMPS W/ PHY/DEN CORE TOURS
 ;
 N PRSIEN,PRSD,TRNODE,TR1,TR2,CORECNT,FOUND,OUT
 S OUT=0
 W !
 S (CORECNT,PRSIEN,OUT)=0
 ; ^PRST(458,236,"E",12717,"D",12,0) = 12^295^0^9^13198^3050114.11 ...
 ;
 F  S PRSIEN=$O(^PRST(458,PPI,"E",PRSIEN)) Q:PRSIEN'>0!(OUT)  D
 .  S (PRSD,FOUND)=0
 .  F PRSD=1:1:14 D
 ..   S TRNODE=$G(^PRST(458,PPI,"E",PRSIEN,"D",PRSD,0))
 ..   S TR1=$P(TRNODE,U,2)
 ..   S TR2=$P(TRNODE,U,13)
 ..   I (TR1=STIEN)!(TR2=STIEN) S FOUND=1,CORECNT=CORECNT+1 Q
 .  S ZNODE=$G(^PRSPC(PRSIEN,0))
 .  I FOUND W !,?12,$P(ZNODE,U),?45,"T&L: ",$P(ZNODE,U,8),?67,"nnn-nn-",$E($P(ZNODE,U,9),6,9)
 . I $Y>(IOSL-3) S OUT=$$RET(TSTAMP) Q:OUT
 I CORECNT=0 W !,?12,"No employees with this core hours tour in pp ",PPE
 Q OUT
 ;
TLLIST(TIE,TSTAMP) ;LOOP THRU TOUR TO DISPLAY ASSOCIATED T&Ls
 ; INPUT : Tour Internal Entry number
 ; local vars:
 ;    ATL - Associated T & L unit
 ;    ATLCT - count the assoc tls
 N ATL,ATLCT,OUT
 W !,?12,"Associated T&Ls: "
 I $$GET1^DIQ(457.1,TIE,4,,,)="YES" D  Q 0
 . W "This tour is available to all T&L units."
 ;
 S (OUT,ATLCT,ATL)=0
 F  S ATL=$O(^PRST(457.1,TIE,"T","B",ATL)) Q:ATL'>0!(OUT)  D
 .  I $X>(IOM-10) D
 ..   W ", ",!,?29
 .  E  D
 ..   I ATLCT>0 W ", "
 .  I $Y>(IOSL-3) S OUT=$$RET(TSTAMP) Q:OUT  W !!,?12,"Associated T&Ls: "
 .  S ATLCT=ATLCT+1
 .  W $$GET1^DIQ(455.5,ATL,.01,,,)
 I ATLCT=0 W "No T&L units are associated with this tour."
 Q OUT
