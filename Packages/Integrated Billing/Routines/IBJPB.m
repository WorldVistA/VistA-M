IBJPB ;ALB/MAF,ARH - IBSP AUTOMATED BILLING SCREEN  ; 28-DEC-1995
 ;;Version 2.0 ; INTEGRATED BILLING ;**39,55**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ; -- main entry point for IBJP AUTO BILLING screen
 D EN^VALM("IBJP AUTO BILLING")
 Q
 ;
HDR ; -- header code
 S VALMHDR(1)="Only authorized persons may edit this data."
 Q
 ;
INIT ; -- init variables and list array
 K ^TMP("IBJPB",$J)
 D BLD
 Q
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K ^TMP("IBJPB",$J)
 D CLEAR^VALM1
 Q
 ;
BLD ; - build screen array, no variables required
 N IBNC,IBTC,IBTW,IBSW,IBLN,IBX,IBLR,IBJDATA,IBGRPB,IBGRPE,IBON
 S IBNC(1)=11,IBTC(1)=2,IBTW(1)=23,IBSW(1)=13,IBNC(2)=50,IBTC(2)=41,IBTW(2)=23,IBSW(2)=13
 ;
 S (VALMCNT,IBLN)=1,IBLR=1,IBLN=$$SET("","",IBLN,IBLR),IBGRPB=IBLN
 ;
 ; - general parameters controlling AB
 S IBJDATA=$G(^IBE(350.9,1,7))
 S IBLN=$$SETN("GENERAL PARAMETERS",IBLN,IBLR,1)
 S IBLN=$$SET("Auto Biller Frequency: ",+$P(IBJDATA,"^",1),IBLN,IBLR)
 S IBLN=$$SET("Date Last Completed: ",$$DATE^IBJU1($P(IBJDATA,"^",2)),IBLN,IBLR)
 S IBLN=$$SET("Inpatient Status: ",$$EXSET^IBJU1($P(IBJDATA,"^",3),350.9,7.03),IBLN,IBLR)
 ;
 ; - inpatient, outpatient, and prescription refill parameters
 F IBX=1,2,4 D 
 . I IBLR=1 S IBLN=IBGRPB,IBGRPE=IBLN,IBLR=2
 . E  S (IBLN,VALMCNT)=$S(IBLN>IBGRPE:IBLN,1:IBGRPE),IBLN=$$SET("","",IBLN,IBLR),IBGRPB=IBLN,IBLR=1
 . ;
 . S IBX=$O(^IBE(356.6,"AC",+IBX,0)),IBJDATA=$G(^IBE(356.6,+IBX,0))
 . S IBLN=$$SETN($P(IBJDATA,U,1),IBLN,IBLR,1),IBON=+$P(IBJDATA,"^",4)
 . S IBLN=$$SET("Automate Billing: ",$S(+IBON:"YES",1:"NO"),IBLN,IBLR)
 . S IBLN=$$SET("Billing Cycle: ",$S(+$P(IBJDATA,"^",5):$P(IBJDATA,"^",5),+IBON:"Monthly",1:""),IBLN,IBLR)
 . S IBLN=$$SET("Days Delay: ",$P(IBJDATA,"^",6),IBLN,IBLR)
 ;
 S (IBLN,VALMCNT)=$S(IBLN>IBGRPE:IBLN,1:IBGRPE)-1
 Q
 ;
SET(TTL,DATA,LN,LR) ;
 N IBY
 S IBY=$J(TTL,IBTW(LR))_DATA D SET1(IBY,LN,IBTC(LR),(IBTW(LR)+IBSW(LR)))
 S LN=LN+1
 Q LN
 ;
SETN(TTL,LN,LR,RV) ;
 N IBY
 S IBY=" "_TTL_" " D SET1(IBY,LN,IBNC(LR),$L(IBY),$G(RV))
 S LN=LN+1
 Q LN
 ;
SET1(STR,LN,COL,WD,RV) ; set up TMP array with screen data
 N IBX S IBX=$G(^TMP("IBJPB",$J,LN,0))
 S IBX=$$SETSTR^VALM1(STR,IBX,COL,WD)
 D SET^VALM10(LN,IBX) I $G(RV)'="" D CNTRL^VALM10(LN,COL,WD,IORVON,IORVOFF)
 Q
 ;
ABEDIT(IBJABP) ; -- IBJP AB EDIT ACTIONS (IP,OP,RX): Edit Automated Billing Parameters
 ; Entry Code (356.6,.08) of CT Type to edit passed in
 D FULL^VALM1
 S IBJABP=$O(^IBE(356.6,"AC",IBJABP,0)) I 'IBJABP S VALMSG="Parameter set not found."
 I +IBJABP S DIE="^IBE(356.6,",DA=+IBJABP,DR=".04;.05;.06" D ^DIE K DIE,DIC,DA,DR,X,Y
 D INIT S VALMBCK="R"
 Q
 ;
ABGEDIT ; -- IBJP AB GENERAL EDIT ACTION (GP): Edit General Automated Billing Parameters
 D FULL^VALM1 N IBFR,IBFR2,IBZWRT,DIE,DIC,DA,DR,X,Y,DIR,DIRUT
 S IBFR=$P($G(^IBE(350.9,1,7)),U,1)
 S DIE="^IBE(350.9,",DA=1,DR="7.01;7.03" D ^DIE I $D(Y) K DIE,DIC,DA,DR,X,Y
 S IBFR2=$P($G(^IBE(350.9,1,7)),U,1)
 S IBZWRT=1 D:'IBFR CLEAN^IBCDC D:'IBFR2 ABOFF^IBCDC I 'IBZWRT S DIR(0)="E" D ^DIR K DIR
 D INIT S VALMBCK="R"
 Q
