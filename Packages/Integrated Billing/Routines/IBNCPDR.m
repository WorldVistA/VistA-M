IBNCPDR ;ALB/BDB - ROI MANAGEMENT, LIST MANAGER ;30-NOV-07
 ;;2.0;INTEGRATED BILLING;**384,550**;21-MAR-94;Build 25
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;Reference to $$PSSBILSD^PSS50 is supported by IA# 6245
 ;
% ; -- main entry point
EN ;
 D DT^DICRW
 K XQORS,VALMEVL
 D EN^VALM("IBNCR PATIENT RELEASE OF INFO")
ENQ K DFN
 Q
 ;
 ;
INIT ; -- set up inital variables
 S U="^",VALMCNT=0,VALMBG=1
 K ^TMP("IBNCR",$J)
 D:'$D(DFN) PAT G:$D(VALMQUIT) INITQ
 D BLD
INITQ Q
 ;
 ;
PAT ; -- select patient you are working with
 N DPTNOFZY S DPTNOFZY=1  ;Suppress PATIENT file fuzzy lookups
 S DIC(0)="AEQMN",DIC="^DPT(" D ^DIC K DIC I +Y<1 S VALMQUIT="" Q
 S DFN=+Y
 Q
 ;
 ;
BLD ; -- build list of ROI'S
 K ^TMP("IBNCR",$J)
 N IBNCRI,IBNCRJ,IBNCRK,IBNCRL,IBNCRM,IBNCRX,IBNCRF
 S (IBNCRI,IBNCRJ,IBNCRK,IBNCRL,VALMCNT)=0
 ;
 ; -- find all ROI'S
 K IBNCRJ S IBNCRJ=0
 S IBNCRK=0 F  S IBNCRK=$O(^IBT(356.25,"AC",DFN,IBNCRK)) Q:'IBNCRK  S IBNCRL=0 F  S IBNCRL=$O(^IBT(356.25,"AC",DFN,IBNCRK,IBNCRL)) Q:'IBNCRL  D
 .; -- add to list
 . S IBNCRM=0 F  S IBNCRM=$O(^IBT(356.25,"AC",DFN,IBNCRK,IBNCRL,IBNCRM)) Q:'IBNCRM  D
 .. S IBNCRJ=IBNCRJ+1,IBNCRX=""
 .. S IBNCRX=$$SETFLD^VALM1(IBNCRJ,IBNCRX,"NUMBER")
 .. S IBNCRF=^IBT(356.25,IBNCRM,0)
 .. I $P(IBNCRF,"^",7)="0" S IBNCRX=IBNCRX_"I "
 .. S IBNCRX=$$SETFLD^VALM1($$DRUG^IBRXUTL1(IBNCRK),IBNCRX,"DRUG")
 .. I $D(^DIC(36,+IBNCRL,0)) S IBNCRX=$$SETFLD^VALM1($P(^(0),"^"),IBNCRX,"INSUR")
 .. S IBNCRX=$$SETFLD^VALM1($$DAT1^IBOUTL($P(IBNCRF,"^",5)),IBNCRX,"EFFDT")
 .. I $P(IBNCRF,"^",6)]"" S IBNCRX=IBNCRX_"thru"
 .. S IBNCRX=$$SETFLD^VALM1($$DAT1^IBOUTL($P(IBNCRF,"^",6)),IBNCRX,"EXPIRE")
 .. D SET(IBNCRX)
BLDQ ;
 I VALMCNT=0 D SET("  -- No ROI's on file for patient --")
 Q
 ;
SET(X) ; -- set arrays
 S VALMCNT=VALMCNT+1,^TMP("IBNCR",$J,VALMCNT,0)=X
 S ^TMP("IBNCR",$J,"IDX",VALMCNT,IBNCRJ)=""
 S ^TMP("IBNCRDX",$J,IBNCRJ)=$G(IBNCRM)
 Q
 ;
HDR ; -- screen header for initial screen
 D PID^VADPT
 S VALMHDR(1)="ROI Management for Patient: "_$E($P($G(^DPT(DFN,0)),"^"),1,20)_" "_$E($G(^(0)),1)_VA("BID")
 S VALMHDR(2)=" "
 Q
 ;
FNL ; -- exit and clean up
 K ^TMP("IBNCR",$J)
 D CLEAN^VALM10
 K VA,VAERR
 Q
 ;
SENS(DRUG,IBBDAR) ; Sensitive Diagnosis Drug API
 ; Input: DRUG = drug file ien
 ; Output: IBBDAR (optional parameter)  Pass by reference. Array of values for ECME processing
 ; Function value:  1 if the drug is a sensitive diagnosis drug, 0 otherwise
 ;
 N EPHNODE
 I '$G(DRUG) Q 0
 S EPHNODE=$$PSSBILSD^PSS50(DRUG) ;using PSS API to obtain this information IA#6245
 S IBBDAR("DRUG-SENSITIVE DX")=$P(EPHNODE,U,4)
 I $P(EPHNODE,U,4)=1 Q 1
 Q 0
