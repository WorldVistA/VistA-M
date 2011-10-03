IBCNRPSI ;BHAM ISC/ALA - Group Plan Status Inquiry ;14-NOV-2003
 ;;2.0;INTEGRATED BILLING;**276**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;**Program Description**
 ;  This program select an insurance company and displays group plans 
 ; (All, Pharmacy covered or Matched) for that insurance company
 Q
 ;
EN ; Select an insurance company (inquiry entry point)
 S IBCNRRPT=""
EN0 ;
 S DIR(0)="350.9,4.06"
 S DIR("A")="Select INSURANCE COMPANY",DIR("??")="^D ADH^IBCNSM3"
 S DIR("?")="Select the Insurance Company for the plan you are entering"
 D ^DIR K DIR S IBCNSP=+Y I Y<1 G EXIT
 I $P($G(^DIC(36,+IBCNSP,0)),"^",2)="N" W !,"This company does not reimburse.  "
 I $P($G(^DIC(36,+IBCNSP,0)),"^",5) W !,*7,"Warning: Inactive Company" H 3 K IBCNSP G EXIT
 ;
TYPE ; Prompt to allow users to inquire for All group plans, Pharmacy group
 ; plans or Matched group plans
 N DIR,DIRUT
 ;
 S DIR(0)="S^A:All Group Plans;P:Pharmacy Group Plans;M:Matched Group Plans"
 S DIR("A")=" Select the type of Group Plans you want to see"
 S DIR("B")="M"
 S DIR("?",1)="  A - All Group Plans"
 S DIR("?",2)="  P - Pharmacy Group Plans"
 S DIR("?",3)="  M - Matched Group Plans"
 D ^DIR K DIR
 I $D(DIRUT) G TYPEX
 S IBCNTYP=Y
 ;
 D EN^IBCNRPS2
 ;
TYPEX ; TYPE exit point
 ;
EXIT K IBCNSP,IBCPOL,IBIND,IBMULT,IBSEL,IBW,IBALR,IBGRP,IBCNGP
 K IBCNRRPT,IBCNTYP,ZTDESC,ZTSTOP,X,Y
 Q
 ;
PRINT ; Entry pt.
 ;
 ; Init vars
 N CRT,MAXCNT,IBPGC,IBBDT,IBEDT,IBPY,IBPXT,IBSRT,IBDTL
 N X,Y,DIR,DTOUT,DUOUT,LIN,TOTALS
 D:'$D(IOF) HOME^%ZIS
 ;
 S (IBPXT,IBPGC)=0
 ;
 ; Determine IO parameters
 I IOST["C-" S MAXCNT=IOSL-3,CRT=1
 E  S MAXCNT=IOSL-6,CRT=0
 ;
 D PRINTDT(MAXCNT,IBPGC)
 I $G(ZTSTOP)!IBPXT G EXIT3
 I CRT,IBPGC>0,'$D(ZTQUEUED) D
 . I MAXCNT<51 F LIN=1:1:(MAXCNT-$Y) W !
 . S DIR(0)="E" D ^DIR K DIR
 ;
EXIT3 ; Exit pt
 Q
 ;
PRINTDT(MAX,PGC) ; Print data
 ;
 ; Init vars
 N EORMSG,NONEMSG,TOTDASHS,DISPDATA,SORT,CT,PRT1,PRT2
 ;
 S EORMSG="*** END OF REPORT ***"
 S NONEMSG="* * * N O  D A T A  F O U N D * * *"
 S $P(TOTDASHS,"=",89)=""
 S CT=0
 ;
 ; Display lines of response
 D LINE
 K ^TMP("IBCNR",$J,"DSPDATA")
 Q
HEADER ; Print header info for each page
 ; Assumes vars from PRINT: CRT,PGC,IBPXT,MAX,SRT,BDT,EDT,PYR,RDTL,MAR
 ; Init vars
 N DIR,X,Y,DTOUT,DUOUT,OFFSET,HDR,DASHES,DASHES2,LIN
 ;
 I CRT,PGC>0,'$D(ZTQUEUED) D  I IBPXT G HEADERX
 . I MAX<51 F LIN=1:1:(MAX-$Y) W !
 . S DIR(0)="E" D ^DIR K DIR
 . I $D(DTOUT)!$D(DUOUT) S IBPXT=1 Q
 I $D(ZTQUEUED),$$S^%ZTLOAD() S (ZTSTOP,IBPXT)=1 G HEADERX
 S PGC=PGC+1
 W @IOF,!,?1,"ePHARM GROUP PLAN STATUS INQUIRY"
 S HDR=$$FMTE^XLFDT($$NOW^XLFDT,1)_"  Page: "_PGC
 S OFFSET=80-$L(HDR)
 W ?OFFSET,HDR
 W !,?1,"Report for "_$S(IBCNTYP="A":"All",IBCNTYP="P":"Pharmacy Covered",1:"Matched")_" Group Plans for "_$$GET1^DIQ(36,IBCNSP_",",.01)
 W !,?1,"Group Name",?20,"Group #",?38,"Plan Type",?52,"Plan ID"
 W ?71,"Pln Stat"
 S $P(DASHES,"=",80)=""
 W !,?1,DASHES
 ;
HEADERX ; HEADER exit pt
 Q
 ;
LINE ; Print line of data
 ; Assumes vars from PRINT: PGC,IBPXT,MAX
 ; Init vars
 N CT,II
 ;
 S CT=+$O(^TMP("IBCNR",$J,"DSPDATA",""),-1)
 I $Y+1+CT>MAX D HEADER I $G(ZTSTOP)!IBPXT G LINEX
 F II=1:1:CT D  Q:$G(ZTSTOP)!IBPXT
 . I $Y+1>MAX!('PGC) D HEADER I $G(ZTSTOP)!IBPXT Q
 . W !,?1,^TMP("IBCNR",$J,"DSPDATA",II)
 . Q
 ;
LINEX ; LINE exit pt
 Q
QUITX ;
 Q
