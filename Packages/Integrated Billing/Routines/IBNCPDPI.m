IBNCPDPI ;DALOI/SS - ECME SCREEN INSURANCE VIEW AND UTILITIES ;3/6/08  16:21
 ;;2.0;INTEGRATED BILLING;**276,383,384,411**;21-MAR-94;Build 29
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;
EN1(DFN) ;
 I $G(DFN)'>0 Q
 N J,POP,START,X,VA,ALMBG,DIC,DT,C,CTRLCOL,DILN
 ;
 ;if the user does have IB keys to edit insurances
 I $D(^XUSEC("IB INSURANCE SUPERVISOR",DUZ))!($D(^XUSEC("IB INSURANCE COMPANY ADD",DUZ))) D  Q
 . N D1,DA,DDER,DDH,DIE,DR,I
 . N IBCH,IBCNS,IBCNSEH,IBCNT,IBCPOL,IBDT,IBDUZ,IBFILE,IBLCNT,IBN,IBNEW,IBPPOL
 . N IBTYP,IBYE,IBCDFN,IBCDFND1,IBCGN
 . D EN^VALM("IBNCPDP INSURANCE MANAGEMENT")
 ;if the user doesn't have insurance IB keys
 D
 . N D0,IBCAB,IBCDFN,IBCDFND1,IBCNS,IBCNT,IBCPOL,IBDT,IBEXP1
 . N IBEXP2,IBFILE,IBLCNT,IBN,IBPPOL
 . D EN1^IBNCPDPV(DFN)
 Q
 ;
INIT ; -- set up initial variables
 ;DFN should be defined
 I '$D(DFN) Q
 S U="^",VALMCNT=0,VALMBG=1
 K ^TMP("IBNSM",$J),^TMP("IBNSMDX",$J)
 S IBTYP="P"
 D BLD^IBCNSM
 Q
 ;
HDR ; -- screen header for initial screen
 D HDR^IBCNSM
 Q
 ;
HELP ; -- help code
 Q
 ;
EXIT ; -- exit code
 Q
 ;
EXPND ; -- expand code
 Q
 ;
SELINSUR(PRMTMSG,DFLTVAL) ;
 ;API for ECME (DBIA #4721)
 ;Insurance Company lookup API
 ;input:
 ; PRMTMSG - prompt message
 ; DFLTVAL - INSURANCE NAME as a default value for the prompt (optional)
 ;output:
 ; IEN^INSURANCE_NAME
 ;   0^  means ALL selected
 ;  -1^  nothing was selected, timeout expired or uparrow entered
 ; where: IEN is record number in file #36.
 ;
 N Y,DUOUT,DTOUT,IBQUIT,DIROUT
 S IBQUIT=0
 N DIC
 S DIC="^DIC(36,"
 S DIC(0)="AEMNQ"
 S:$L($G(DFLTVAL))>0 DIC("B")=DFLTVAL
 S DIC("A")=PRMTMSG_": "
 D ^DIC
 I (Y=-1)!$D(DUOUT)!$D(DTOUT) S IBQUIT=1
 I IBQUIT=1 Q "-1^"
 Q Y
 ;
RNB(IBRX,IBFL) ; Return the Claims Tracking Reason Not Billable for a Prescription
 ; API for ECME (DBIA #4729)
 ; Input:  IBRX - prescription ien (required)
 ;         IBFL - fill# (required)
 ; Output:  function value
 ;                [1] RNB ien (ptr to file# 356.8)
 ;                [2] RNB description
 ;                [3] RNB ECME flag
 ;                [4] RNB ECME paper flag
 ;                [5] RNB code
 ;                [6] RNB active/inactive flag
 ;          or 0 if no CT entry or if CT entry is billable
 ;
 N RNB,IBTRKRN
 S RNB=0
 S IBTRKRN=+$O(^IBT(356,"ARXFL",+$G(IBRX),+$G(IBFL),0)) I 'IBTRKRN G RNBX
 S RNB=+$P($G(^IBT(356,IBTRKRN,0)),U,19) I 'RNB G RNBX
 S RNB=RNB_U_$G(^IBE(356.8,RNB,0))
RNBX ;
 Q RNB
 ;
BILLINFO(IBRX,IBREF,IBPSEQ) ;
 ;API for ECME (DBIA #4729)
 ;Determine Bill# and Account Receivable information about the bill
 ;input:
 ; IBRX - pointer to file #52 (internal prescription number)
 ; IBREF - re-fill number
 ; IBPSEQ - payer sequence
 ;output:
 ;Returns a string of information about the bill requested:
 ; piece #1:  Bill number (field(#.01) of file (#399))
 ; piece #2:  Original Amount of bill
 ; piece #3:  Current Status (pointer to file #430.3)
 ; piece #4:  Current Balance
 ; piece #5:  Total Collected
 ; piece #6:  % Collected Returns null if no data or bill found.
 ;
 N IBIEN,IBBNUM,RCRET,IBRETV,IBARR,IBZ
 I +$G(IBPSEQ)=0 S IBPSEQ=1
 S RCRET="",IBRETV="",IBIEN=""
 I IBPSEQ=1 S IBBNUM=$$BILL^IBNCPDPU(IBRX,IBREF) ;get from the CT record
 ;find secondary bill, return null if none
 I IBPSEQ=2 S IBZ=$$RXBILL^IBNCPUT3(IBRX,IBREF,"S",,.IBARR) D  Q:+IBIEN=0 "^"  S IBBNUM=$P($G(IBARR(IBIEN)),U)
 . S IBIEN=$P(IBZ,U,2) Q:+IBIEN>0
 . ;if there is no active bill then get the latest bill with whatever status
 . S IBIEN=$O(IBARR(999999999),-1)
 I IBBNUM]"" D
 .I IBIEN="" S IBIEN=$O(^DGCR(399,"B",IBBNUM,"")) Q:IBIEN=""
 .S RCRET=$$BILL^RCJIBFN2(IBIEN)
 S IBRETV=IBBNUM_U_RCRET
 Q IBRETV
 ;
 ;
TPJI(DFN) ; entry point for TPJI option of the ECME User Screen
 I DFN>0 D EN^IBJTLA
 Q
 ;
INSNM(IBINSIEN) ; api to return insurance company name
 Q $P($G(^DIC(36,+$G(IBINSIEN),0)),"^")
 ;
ACPHONE() ; API to return the agent cashier's phone number
 Q $P($G(^IBE(350.9,1,2)),"^",6)
 ;
INSPL(IBPL) ; api to return the insurance company IEN from the plan
 ; passed in.
 Q $P($G(^IBA(355.3,+$G(IBPL),0)),"^")
 ;
MXTRNS(IBPLID) ; api to return MAXIMUM NCPDP TRANSACTIONS for a plan
 ; Input: IBPLID = ID from the PLAN file.
 ; Returns: Numeric value from field 10.1 of Plan file
 ;          Default's to 1 if undefined.
 Q:IBPLID="" 1
 Q:$O(^IBCNR(366.03,"B",$G(IBPLID),0))']"" 1
 Q $P($G(^IBCNR(366.03,$O(^IBCNR(366.03,"B",$G(IBPLID),0)),10)),"^",10)
 ;
EPHON() ; API to return if ePhamracy is on within IB
 ;   1 FOR Active
 ;   0 FOR Not Active
 ;
 Q +$G(^IBE(350.9,1,11))
 ;
