IBCNRP5 ;BHAM ISC/CMW - Group Plan Status Report ;01-NOV-2004
 ;;2.0;INTEGRATED BILLING;**276**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ;
 ; Initialize variables
 N STOP,IBCNRRTN,IBCNRSPC,RESORT,IBCNTYP,IBSEL
 D:'$D(IOF) HOME^%ZIS
 ;
 S STOP=0,IBPXT=$G(IBPXT)
 W @IOF
 W !,"ePHARM GROUP PLAN STATUS REPORT",!
 W !,"NCPDP process requires that the users match Group Plans to Pharmacy Plans."
 W !,"This report will assist users in matching Group Insurance Plans to Pharmacy"
 W !,"  Plans by searching through GIPF file for Group Plans that "
 W !,"    are linked to an Insurance with active Pharmacy Plan coverage."
 ;
 ; Prompts 
 ; lock global
 S IBCNRRPT=1
 N IBCNRDEV S IBCNRDEV=1
 L +^XTMP("IBCNRP5"):5 I '$T W !!,"Sorry, Status Report in use." H 2 G EXIT
 ;Check for prior compile
P10 D RESORT(.RESORT) I STOP G EXIT
 I $G(RESORT) G P30
 K ^XTMP("IBCNRP5")
 ; compile valid insurance file
P20 D GIPF
 ; select insurance company
P30 D INS I $G(IBSEL)="" G EXIT
 D TYPE I $G(IBCNTYP)="" G EXIT
 ; perform sort/selection
P40 D INSEL
 I '$D(^TMP("IBCNRP5")) G EXIT
 ; print selection
P50 D PRINT^IBCNRP5P
 ;
EXIT ; unlock global
 L -^XTMP("IBCNRP5")
 K IBPXT
 K IBCNSP,IBCPOL,IBIND,IBMULT,IBSEL,IBW,IBALR,IBGRP,IBCNGP
 K IBCNRRPT,IBCNTYP,IBCNRDEV,ZTDESC,ZTSTOP
 K IBCNRP,IBCNRI,IBCNRGP
 K IBICPT,IBICF,IBICL,IBIC,IBINA,IBIEN,INIEN
 K ^TMP("IBCNRP5",$J)
 Q
 ;
RESORT(RESORT) ; check for prior compile
 NEW DIR,BDT,EDT,RDT,HDR,IBDT,X,Y,DIRUT
 I '$D(^XTMP("IBCNRP5")) Q
 S RDT=$P($G(^XTMP("IBCNRP5",0)),U,2)
 S RESORT=0
 S HDR=$$FMTE^XLFDT(RDT,"5Z")
 W !!,"Current Insurance company list compiled on: ",HDR,!
 S DIR(0)="Y"
 S DIR("A")="Do you want to use the existing compiled file"
 S DIR("B")="YES"
 S DIR("?",1)=" Enter YES to use the existing compiled file."
 S DIR("?")=" Enter NO to DELETE existing file and recompile,"
 D ^DIR K DIR
 I $D(DIRUT) S STOP=1 G RESRTX
 S RESORT=Y
 S IBCNRSPC("RESORT")=Y
 ;
RESRTX ;RESORT EXIT
 Q
 ; 
GIPF ; compiler valid insurance
 W !,"*** COMPILING ......"
 N GST1,GP0,GP6,IBCOV,LIM,IBCVRD,IBIEN
 N GPIEN,GPNAM,GPNUM,IBINA
 S GST1=1,(GPIEN,INIEN)=""
 S ^XTMP("IBCNRP5",0)=($$NOW^XLFDT+30)_"^"_$$NOW^XLFDT_"^"_"Group Plan Status Report"
 F  S INIEN=$O(^IBA(355.3,"B",INIEN)) Q:INIEN=""  D
 . S IBINA=$P($G(^DIC(36,+INIEN,0)),U)
 . ; company does not reimburse
 . I $P($G(^DIC(36,+INIEN,0)),U,2)="N" Q
 . ; company is inactive
 . I $P($G(^DIC(36,INIEN,0)),U,5) Q
 . ;
 . F  S GPIEN=$O(^IBA(355.3,"B",INIEN,GPIEN)) Q:GPIEN=""  D
 .. ;chk for active group
 .. S GP0=$G(^IBA(355.3,GPIEN,0)),GP6=$G(^IBA(355.3,GPIEN,6))
 .. I $P(GP0,U,11)=1 Q
 .. ;
 .. ;chk for pharm plan coverage
 .. S IBCOV=$O(^IBE(355.31,"B","PHARMACY",""))
 .. S LIM="",IBCVRD=0
 .. F  S LIM=$O(^IBA(355.32,"B",GPIEN,LIM)) Q:LIM=""  D
 ... I $P(^IBA(355.32,LIM,0),U,2)'=IBCOV Q
 ... ;chk covered status
 ... S IBCVRD=$P(^IBA(355.32,LIM,0),U,4)
 ... I IBCVRD=0 Q
 ... ;set valid insurance/group array
 ... S ^XTMP("IBCNRP5",IBINA,INIEN,GPIEN)=""
 Q
 ;
INS ;
 S IBSEL=""
 W !,"Run Report "
 W " for (S)PECIFIC insurance companies or a (R)ANGE: RANGE// "
 R X:DTIME Q:'$T!(X["^")
 S:X="" X="R" S X=$E(X)
 I "RSrs"'[X W !,"Enter <CR> for Range; 'S' for specific insurance; '^' to quit." G INS
 W "  ",$S("Ss"[X:"SPECIFIC",1:"RANGE") G:"Rr"[X INSO1
INSO S DIC="^DIC(36,",DIC(0)="AEQMZ",DIC("S")="I '$G(^(5))"
 S DIC("A")="   Select "_$S($G(IBICPT):"another ",1:"")_"INSURANCE CO.: "
 D ^DIC K DIC I Y'>0 G INS:'$G(IBICPT) S IBSEL=1 Q
 I $D(IBICPT(+Y)) D  G INSO
 .W !!?3,"Already selected. Choose another insurance company.",!,*7
 S IBICPT(+Y)="",IBICPT=$G(IBICPT)+1 G INSO
 ;
INSO1 W !?3,"Start with INSURANCE COMPANY: FIRST// " R X:DTIME
 G:'$T!(X["^") INS
 I $E(X)="?" W !,"Enter value up to 40 char; <CR> to start with 'first' value; '^' to quit." G INSO1
 S IBICF=X
INSO2 W !?8,"Go to INSURANCE COMPANY: LAST// " R X:DTIME
 G:'$T!(X["^") INSO1
 I $E(X)="?" W !,"Enter value up to 40 char; <CR> to go to 'last' value; '^' to quit." G INSO1
 I X="" S IBICL="zzzzz" S:IBICF="" IBIC="ALL" S IBSEL=1 Q
 I IBICF]X D  G INSO2
 .W *7,!!?3,"The LAST value must follow the FIRST.",!
 S IBICL=X,IBSEL=1
 Q
 ;
TYPE ; Prompt to allow users to inquire for All group plans, or Matched group plans
 N DIR,X,Y,DIRUT
 S IBCNTYP="A"
 S DIR(0)="S^A:All Group Plans;M:Matched Group Plans"
 S DIR("A")=" Select the type of Group Plans you want to see for Insurance selected."
 S DIR("B")="A"
 S DIR("?",1)="  A - All Group Plans"
 S DIR("?",2)="  M - Matched Group Plans"
 D ^DIR K DIR
 I $D(DIRUT) G TYPEX
 S IBCNTYP=Y
TYPEX Q
 ;
INSEL ; - Perform selection for insurance company.
 S VALMCNT=0,VALMBG=1,IBCNGP=0
 K ^TMP("IBCNRP5",$J)
 ; check for specific insurance companies
 I $G(IBICPT) D  Q
 . S (IBINA,IBIEN)=""
 . F  S IBIEN=$O(IBICPT(IBIEN)) Q:IBIEN=""  D
 .. S IBINA=$P($G(^DIC(36,+IBIEN,0)),U)
 .. I '$D(^XTMP("IBCNRP5",IBINA,IBIEN)) D  Q
 ... W *7,!?3,"**NO pharmacy data found for "
 ... W $P(^DIC(36,IBIEN,0),U)_"  "_$P(^DIC(36,IBIEN,.11),U),! R X:2
 .. D INIT
 ;
 ; check for range of insurance companies
 I '$D(IBICL) Q
 S IBIEN=0,IBINA=""
 F  S IBINA=$O(^XTMP("IBCNRP5",IBINA)) Q:IBINA=""  D
 . F  S IBIEN=$O(^XTMP("IBCNRP5",IBINA,IBIEN)) Q:IBIEN=""  D
 ..; for selection "ALL"
 .. I $G(IBIC)="ALL" D INIT Q
 .. ;
 .. ;check for match within first/last range
 .. I (IBICF]IBINA)!(IBINA]IBICL) Q
 .. D INIT
 Q
 ;
INIT ; -- init variables and create list array or report array
 N IBGP0,IBCPOLD,X,IBCPD6,IBCNRPP,IBCOV,IBCVRD,LIM
 F  S IBCNGP=$O(^XTMP("IBCNRP5",IBINA,IBIEN,IBCNGP)) Q:'IBCNGP  D
 . I '$D(^IBA(355.3,+IBCNGP,0)) Q
 . ; if we want all plans, let it pass
 . I IBCNTYP="A" D  Q
 . . D SETPLAN(IBCNGP)
 . ; if we want Matched plans, check for existence of Plan ID
 . I IBCNTYP="M" D  Q
 . . I $P($G(^IBA(355.3,IBCNGP,6)),U)'="" D SETPLAN(IBCNGP)
 I VALMCNT=0 D
 . S ^TMP("IBCNRP5",$J,"DSPDATA",1)=IBIEN
 . S ^TMP("IBCNRP5",$J,"DSPDATA",2)="No data for this Insurance"
 Q
 ;
SETPLAN(IBCNGP) ;
 ; create text
 N IBGPZ,I,IBPLN,IBPLNA,LINE
 S VALMCNT=VALMCNT+1,$P(LINE,"-",80)=""
 S IBGPZ=^IBA(355.3,+IBCNGP,0)
 ; Group Name, Group #, Group Type, Plan ID, Plan Status
 S X=$$FO^IBCNEUT1($P(IBGPZ,U,3),18)
 S X=X_" "_$$FO^IBCNEUT1($P(IBGPZ,U,4),17)
 S X=X_" "_$$FO^IBCNEUT1($$EXPAND^IBTRE(355.3,.09,$P(IBGPZ,U,9)),13)
 S IBPLN=$P($G(^IBA(355.3,+IBCNGP,6)),U)
 ; check for plan
 I IBPLN="" D  Q
 . S ^TMP("IBCNRP5",$J,"DSPDATA",VALMCNT)=IBIEN_"^"_X
 . S VALMCNT=VALMCNT+1,^TMP("IBCNRP5",$J,"DSPDATA",VALMCNT)=IBIEN_"^"_"No Plan Found."
 . S VALMCNT=VALMCNT+1,^TMP("IBCNRP5",$J,"DSPDATA",VALMCNT)=IBIEN_"^"_LINE
 ; check plan status information
 S IBPLNA=$P($G(^IBCNR(366.03,IBPLN,0)),U)
 S X=X_" "_$$FO^IBCNEUT1(IBPLNA,13)
 ;
 N ARRAY D STCHK^IBCNRU1(IBPLN,.ARRAY)
 S X=X_"      "_$$FO^IBCNEUT1($S($G(ARRAY(1))="I":"INACTIVE",1:"ACTIVE"),8)
 S ^TMP("IBCNRP5",$J,"DSPDATA",VALMCNT)=IBIEN_"^"_X
 I $G(ARRAY(6)) D
 . N STATAR
 . D STATAR^IBCNRU1(.STATAR)
 . F I=1:1:$L(ARRAY(6),",") D
 .. S VALMCNT=VALMCNT+1
 .. S ^TMP("IBCNRP5",$J,"DSPDATA",VALMCNT)=IBIEN_"^"_"       "_$G(STATAR($P(ARRAY(6),",",I)))
 . S VALMCNT=VALMCNT+1,^TMP("IBCNRP5",$J,"DSPDATA",VALMCNT)=IBIEN_"^"_LINE
 ;
 Q
