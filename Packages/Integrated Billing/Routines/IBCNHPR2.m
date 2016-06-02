IBCNHPR2 ;ALB/CJS - HPID ADDED TO BILLING CLAIM REPORT (PRINT) ;15-DEC-14
 ;;2.0;INTEGRATED BILLING;**525**;21-MAR-94;Build 105
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Print the report.
 ;
 ; Input Parameter:  IBOUT = "R" for Report format or "E" for Excel format (defaults to "R")
 ;  Required Input:
 ;                   Global print array ^TMP($J,"IBHP",HPID edit date,Bill/Claim IEN,HPID edit index)=
 ; patient name^last 4 SSN^insurance company name^HPID^station number-claim number^user name^date HPID added^professional ID^institutional ID
 ; 
EN(IBOUT) N %,IBHDT,IBI,IBJ,IBK,IBLN,IBPAG,IBQUIT
 ;
 I '$D(^TMP($J,"IBHP")) W !,"*** No claim-level HPIDs added within date range ***" D PAUSE G END
 ;
 I "^R^E^"'[(U_$G(IBOUT)_U) S IBOUT="R"
 S (IBI,IBJ,IBK,IBQUIT,IBPAG)=0
 S IBLN=""
 D NOW^%DTC S IBHDT=$$DAT2^IBOUTL($E(%,1,12))
 ;
 ;Excel header
 I IBOUT="E" D PHDL
 ;
 ;Report header
 I IBOUT="R" D HDR
 ;
 ;Data output
 F  S IBI=$O(^TMP($J,"IBHP",IBI)) Q:'IBI  D  Q:IBQUIT
 .S IBJ=0 F  S IBJ=$O(^TMP($J,"IBHP",IBI,IBJ)) Q:'IBJ  D  Q:IBQUIT
 ..S IBK=0 F  S IBK=$O(^TMP($J,"IBHP",IBI,IBJ,IBK)) Q:IBK=""  S IBLN=$G(^(IBK)) D  Q:IBQUIT
 ...I IBOUT="E" W !,IBLN Q
 ...I $Y>(IOSL-4) D PAUSE Q:IBQUIT  D HDR
 ...D LINE
 ;
 I 'IBQUIT D PAUSE
 ;
END K IBI,IBJ,IBK,IBLN,IBQUIT,IBPAG,IBHDT
 Q
 ;
 ;
HDR ; Print header
 I $E(IOST,1,2)="C-"!(IBPAG) W @IOF
 S IBPAG=IBPAG+1
 W !,"MANUALLY ADDED HPIDs TO BILLING CLAIM REPORT"
 W ?IOM-34,IBHDT,?IOM-10,"Page: ",IBPAG
 ;
 ; - sub-header
 W !!,"PT NAME",?21,"SSN",?27,"PAYER",?47,"HPID",?59,"CLAIM #",?72,"USER NAME",?93,"DATE HPID ADDED"
 W ?110,"PROF ID",?121,"INST ID"
 W !,$TR($J(" ",IOM)," ","-")
 Q
 ;
LINE ; Print claim information.
 W !,$E($P(IBLN,U),1,18),?21,$P(IBLN,U,2),?27,$E($P(IBLN,U,3),1,18),?47,$P(IBLN,U,4),?59,$E($P(IBLN,U,5),1,11)
 W ?72,$E($P(IBLN,U,6),1,18),?94,$E($P(IBLN,U,7),1,10),?110,$E($P(IBLN,U,8),1,10),?121,$E($P(IBLN,U,9),1,10)
 Q
 ;
PAUSE ; Pause for screen output.
 N IBJJ,DIR,DIRUT,DTOUT,DUOUT
 Q:$E(IOST,1,2)'["C-"
 ;F IBJJ=$Y:1:(IOSL-7) W !   ; IB*2.0*525 - CJS - Fix scrolling problem
 S DIR(0)="E" D ^DIR K DIR I $D(DIRUT)!($D(DUOUT)) S IBQUIT=1 K DIRUT,DTOUT,DUOUT
 Q
 ;
PHDL ; - Print the header line for the Excel spreadsheet
 N X
 S X="Patient Name^SSN^Payer^HPID^Claim Number^User Name^Date HPID Added^"
 S X=X_"Professional ID^Institutional ID"
 W !,X
 Q
