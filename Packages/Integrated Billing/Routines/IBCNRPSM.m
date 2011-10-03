IBCNRPSM ;DAOU/CMW - Match Test Payer Sheet to a Pharmacy Plan ;10-DEC-2003
 ;;2.0;INTEGRATED BILLING;**251**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;; ;
EN(IBCNSP)      ; Main entry point for IBCNR PAYERSHEET MATCH (LIST TEMPLATE)
 D EN^VALM("IBCNR PAYERSHEET MATCH")
 Q
 ;
HDR ; Header code
 N IBCNS0,IBCNSID,IBCNSNM,IBCNS10,IBCNSPBM,IBCNSBIN,IBCNSPCN,IBCNS3
 N IBCNSNST,IBCNSLST,IBCNSHDR,X
 S IBCNS0=$G(^IBCNR(366.03,+IBCNSP,0))
 S IBCNSID=$P(IBCNS0,"^",1) ;id
 S IBCNSNM=$P(IBCNS0,"^",2) ;name
 S IBCNS10=$G(^IBCNR(366.03,+IBCNSP,10))
 S IBCNSPBM=$P(IBCNS10,"^",1) ;pbm
 I IBCNSPBM S IBCNSPBM=$P($G(^IBCNR(366.02,+IBCNSPBM,0)),"^",1) ; pbm name
 S IBCNSBIN=$P(IBCNS10,"^",2) ;bin
 S IBCNSPCN=$P(IBCNS10,"^",3) ;pcn
 S IBCNS3=$G(^IBCNR(366.03,+IBCNSP,3,1,0)) ; appl
 S IBCNSNST=$S($P(IBCNS3,"^",2)=0:"Inactive",1:"Active")
 S IBCNSLST=$S($P(IBCNS3,"^",3)=0:"Inactive",1:"Active")
 ; Header Line 1
 S IBCNSHDR="PLAN: "
 S X=IBCNSID_" - "_IBCNSNM
 S VALMHDR(1)=$$SETSTR^VALM1(X,IBCNSHDR,$L(IBCNSHDR)+1,80)
 ; Header Line 2
 S IBCNSHDR="PBM: "_IBCNSPBM
 S X="   BIN: "_IBCNSBIN_"   PCN: "_IBCNSPCN
 S VALMHDR(2)=$$SETSTR^VALM1(X,IBCNSHDR,$L(IBCNSHDR)+1,80)
 ; Header Line 3
 S IBCNSHDR="STATUS: "
 S X="National "_IBCNSNST_"/Local "_IBCNSLST
 S VALMHDR(3)=$$SETSTR^VALM1(X,IBCNSHDR,$L(IBCNSHDR)+1,80)
 Q
 ;
INIT ; Init variables and list array
 N TCODE,IBCNS10,I,TPS,X,NUMBER,PSN
 K ^TMP("IBCNR",$J),TCODE
 S VALMCNT=0,VALMBG=1
 S TCODE(1)="BILLING (B1)"
 S TCODE(2)="REVERSAL (B2)"
 S TCODE(3)="REBILL (B3)"
 S IBCNS10=$G(^IBCNR(366.03,IBCNSP,10))
 F I=1:1:3 S TPS=$P(IBCNS10,"^",10+I) D
 . ; Set up Index Number
 . S VALMCNT=I
 . S X=$$SETFLD^VALM1(VALMCNT,"","NUMBER")
 . ; Set up Transaction code
 . S X=$$SETFLD^VALM1(TCODE(I),X,"TCODE")
 . ; Set up the payer sheet name
 . I $G(TPS) S PSN=$G(^BPSF(9002313.92,TPS,0))
 . I '$G(TPS) S PSN="NOT FOUND"
 . S X=$$SETFLD^VALM1(PSN,X,"PSHEET")
 . ; Set up temporary array
 . S ^TMP("IBCNR",$J,VALMCNT,0)=X
 . S ^TMP("IBCNR",$J,"IDX",VALMCNT,VALMCNT)=IBCNSP
 Q
 ;
HELP ; Help code
 I $D(X),X'["??" D
 . W !,"Possible actions are the following:"
 . S X="?" D DISP^XQORM1,PAUSE^VALM1
 Q
 ;
EXIT ; Exit code
 K ^TMP("IBCNR",$J),VALMY
 D CLEAN^VALM10
 Q
 ;
EXPND ; Expand code
 Q
 ;
SEL ; Add Payer Sheet to Plan
 ; Get the transaction code
 N IBX,IBSEL,IBDR
 D S1
 I 'IBX Q
 ; Get the Payer Sheet Name
 N DIC,Y,X,DTOUT,DUOUT
 N DA,DIE,DR
 S DIC="^BPSF(9002313.92,",DIC(0)="AEMZ",DIC("S")="I $P(^(1),U,6)=2"
 D ^DIC
 I +Y<1 W !!,"No Payer Sheet Selected!" D PAUSE^VALM1 Q
 ; Do the insert
 S DA=IBSEL,DIE="^IBCNR(366.03,",DR=IBDR_"////^S X="_+Y
 D ^DIE
 ; Rebuild ListMan screen data
 D INIT
 Q
 ;
DEL ; Delete Payer Sheet from Plan
 ; Get the transaction code
 N IBX,IBSEL,IBDR
 D S1
 I 'IBX Q
 ; Do the deletion
 N DA,DIE,DR
 S DA=IBSEL,DIE="^IBCNR(366.03,",DR=IBDR_"///@"
 D ^DIE
 ; Rebuild ListMan screen data
 D INIT
 Q
 ;
S1 ; Prompt for transaction code
 N VALMY
 D FULL^VALM1,EN^VALM2($G(XQORNOD(0)),"S")
 ; Store transaction code in IBX
 S IBX=$O(VALMY(0))
 ; Set variable to refresh the screen when returning from the action
 S VALMBCK="R"
 ; Display error if not transaction code was picked and exit
 I 'IBX W !!,"No Transaction Code Selected!" D PAUSE^VALM1 Q
 ; Build variables needed for insert or deletion
 S IBSEL=+$G(^TMP("IBCNR",$J,"IDX",IBX,IBX))
 S IBDR=$S(IBX=1:10.11,IBX=2:10.12,1:10.13)
 Q
