IBCSC4D ;ALB/ARH - ADD/ENTER DIAGNOSIS ;11/9/93
 ;;2.0;INTEGRATED BILLING;**55,62,91,106,124,51,210,403,400,461,516,522**;21-MAR-94;Build 11
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
EN ;add/edit diagnosis for a bill, IBIFN required
 N IBINP,POAEDIT
 S POAEDIT=0 ; flag for editing POA indicators, set in DXINPT^IBCSC4E
 S IBX=$G(^DGCR(399,+IBIFN,0))
 S IBINP=$$INPAT^IBCEF(+IBIFN)
 D DELALL^IBCSC4E(+IBIFN)
 I IBINP D DXINPT^IBCSC4E(IBIFN)
 I 'IBINP D DXOPT(IBIFN)
 S IBDIFN=0 D SET(IBIFN,.IBDXA,.IBPOA) D:+IBDXA DISP(.IBPOA)
 I IBINP,$D(^IBA(362.3,"AO",IBIFN)),$$FT^IBCEF(IBIFN)=3,POAEDIT D POAASK^IBCSC4E
 ;
 ; esg - IB*2*400 - ask for PPS (DRG) for inpatient, UB claims
 I IBINP,$$FT^IBCEF(IBIFN)=3 D  I $D(Y) G EXIT
 . N DIE,DA,DR,ICDVDT
 . S ICDVDT=$$BDATE^IBACSV(IBIFN)
 . S DIE=399,DA=IBIFN,DR="170T" D ^DIE
 . W !
 . Q
 ;
E1 S IBDX=$$ASKDX I +IBDX>0 S IBDIFN=+$G(IBDXA(+IBDX)) S:'IBDIFN IBDIFN=$$ADD(+IBDX,IBIFN) G:+IBDIFN=0 E1 I +IBDIFN>0 D EDIT(+IBDIFN) D SET(IBIFN,.IBDXA,.IBPOA) G E1
 S IBX=$G(^DGCR(399,+IBIFN,0)) I $P(IBX,U,5)<3,$P(IBX,U,27)'=2 S DGRVRCAL=1
EXIT K IBDIFN,IBDXA,IBPOA,IBDX,IBX
 Q
 ;
ASKDX() ;
 N X,Y,IBDATE,IBDTTX,ICDVDT
 ;S DIR("A")="Select ICD DIAGNOSIS",DIR(0)="362.3,.01O" D ^DIR K DIR
 S IBDATE=$$BDATE^IBACSV(IBIFN),ICDVDT=IBDATE
 S IBDTTX=$$DAT1^IBOUTL(IBDATE)
 I $G(IBIFN),$$INPAT^IBCEF(IBIFN) D
 . N Z S Z=$$EXPAND^IBTRE(399,215,+$G(^DGCR(399,IBIFN,"U2")))
 . W !,$S(Z'="":"",1:"NO ")_"Admitting Diagnosis"_$S(Z'="":": "_Z,1:" found"),!
AD S DIR("??")="^D HELP^IBCSC4D"
 S DIR("?",1)="Enter a diagnosis for this bill.  Duplicates are not allowed."
 S DIR("?")="Only diagnosis codes active on "_IBDTTX_", no duplicates for a bill, and bill must not be authorized or cancelled."
 S DIR("S")="I $$ICD9VER^IBACSV(+Y)="_$$ICD9SYS^IBACSV(IBDATE) ; inactive allowed but either ICD-9 or ICD-10 *461
 S DIR(0)="PO^80:EAMQI"
 D ^DIR K DIR
 I Y>0,'$D(IBDXA(+Y)),'$$ICD9ACT^IBACSV(+Y,IBDATE) D  G AD
 . W !!,*7,"The Diagnosis code is inactive for the date of service ("_IBDTTX_").",!
 Q Y
 ;
ADD(DX,IFN,DXPOA) ;
 I $$ICD9VER^IBACSV(DX)=1,$E($$ICD9^IBACSV(DX,$$BDATE^IBACSV(IFN)))="E",$$MAXECODE^IBCSC4F(IFN) W !!,*7,"Only 3 External Cause of Injury diagnoses are allowed per claim.",! Q 0
 S DIC("DR")=".02////"_IFN I $G(DXPOA)'="" S DIC("DR")=DIC("DR")_";.04///"_DXPOA
 S DIC="^IBA(362.3,",DIC(0)="AQL",X=DX K DA,DO D FILE^DICN K DA,DO,DIC,X
 Q Y
 ;
EDIT(IBDXIFN) ;
 N NEEDPOA
 S DIDEL=362.3,DIE="^IBA(362.3,",DA=IBDXIFN
 ; only ask for POA if inpatient UB-04 claim
 S NEEDPOA=IBINP&($$FT^IBCEF(IBIFN)=3)
 S DR=".01Diagnosis"_$S(NEEDPOA:";.04POA Indicator",1:"")_";.03Order"
 D ^DIE K DIE,DR,DA,DIC,DIDEL
 ;
 I $D(^IBA(362.3,IBDXIFN,0)),$$FIRSTDX(IBDXIFN) D  G EDITQ
 . N DIE,DR,DA,Y,X,IB0
 . S IB0=^IBA(362.3,IBDXIFN,0)
 . S DIE="^DGCR(399,",DA=+$P(IB0,U,2),DR="215////"_+IB0 D ^DIE
 ;
 ; MRD;IB*2.0*516 - Added '$D check *before* removing the dangling
 ; pointers; and added code to 'shift' subsequent pointers, if any.
 ; If the entry was deleted, remove dangling pointers from #399.0304.
 I '$D(^IBA(362.3,IBDXIFN)) D
 . N IBPROC,IBPROCD,IBPIECE,IBHIT
 . S (IBHIT,IBPROC)=0
 . F  S IBPROC=$O(^DGCR(399,IBIFN,"CP",IBPROC)) Q:'IBPROC  S IBPROCD=$G(^(IBPROC,0)) I IBPROCD]"" D
 . . F IBPIECE=11:1:14 I +$P(IBPROCD,"^",IBPIECE)=IBDXIFN S IBHIT=1 D UPD^IBCU72("@",IBPIECE-1)
 . . Q
 . ;
 . ; If a pointer to the deleted DX code was found and removed, then
 . ; sound <bell>, display message, and 'shift' any other associated
 . ; DX codes to close the gap, if any.
 . I IBHIT D
 . . W *7,!,"This diagnosis was removed as a procedure diagnosis."
 . . ;
 . . S IBPROC=0
 . . F  S IBPROC=$O(^DGCR(399,IBIFN,"CP",IBPROC)) Q:'IBPROC  S IBPROCD=$G(^(IBPROC,0)) I IBPROCD]"" D
 . . . F IBPIECE=11:1:13 D
 . . . . ; If DX field is blank, and next one is not blank, then shift it 'up'.
 . . . . I $P(IBPROCD,"^",IBPIECE)="",$P(IBPROCD,"^",IBPIECE+1)'="" D
 . . . . . D UPD^IBCU72("@",IBPIECE)                          ; Delete from one slot...
 . . . . . D UPD^IBCU72($P(IBPROCD,"^",IBPIECE+1),IBPIECE-1)  ; Add to the blank slot.
 . . . . . S IBPROCD=$G(^DGCR(399,IBIFN,"CP",IBPROC,0))  ; Grab updated version of this node.
 . . . . . Q
 . . . . Q
 . . . Q
 . . Q
 . Q
 ;
EDITQ Q
 ;
SET(IFN,DXARR,POARR) ;setup arrays of all dx's for bill, array names should be passed by reference
 ;returns: DXARR(DX)=DX IFN, POARR(ORDER)=DX ^ PRINT ORDER ^ POA,  (DXARR,POARR)=IFN ^ dx count
 ;if a dx does not have a print order then PRINT ORDER=(999+count of dx) so will be in order of entry if no print order
 N CNT,IBX,IBY,IBZ,DIFN,IBC,ARR K DXARR,POARR S IBC="AIFN"_$G(IFN)
 S (CNT,IBX)=0 F  S IBX=$O(^IBA(362.3,IBC,IBX)) Q:'IBX  D
 . S DIFN=$O(^IBA(362.3,IBC,IBX,0)),IBY=$G(^IBA(362.3,DIFN,0)) Q:'IBY
 . S CNT=CNT+1,IBZ=+$P(IBY,U,3) I 'IBZ S IBZ=999+CNT
 . S DXARR(+IBY)=DIFN,ARR(IBZ)=+IBY_U_$P(IBY,U,3,4)
 S (IBX,IBY)=0 F  S IBY=$O(ARR(IBY)) Q:'IBY  S IBX=IBX+1,POARR(IBX)=ARR(IBY)
 S (DXARR,POARR)=$G(IFN)_"^"_CNT
 Q
 ;
DISP(POARR) ;screen display of existing dx's for a bill,
 ;input should be print order array returned by SET^IBCSC4D: POARR(PRINT ORDER)=DX, passed by reference
 N IBX,IBY,IBZ,IBDATE,POA
 S IBDATE=$$BDATE^IBACSV(+$G(IBIFN)) ; The bill date of service
 W !!,?5,"-----------------  Existing Diagnoses for Bill  -----------------",!
 S IBX=0 F  S IBX=$O(POARR(IBX)) Q:'IBX  S IBZ=POARR(IBX),IBY=$$ICD9^IBACSV(+IBZ,IBDATE) D
 .S POA="" I $$INPAT^IBCEF(IBIFN),$$FT^IBCEF(IBIFN)=3 S POA=$P(IBZ,U,3) S:POA=1 POA="" S:POA'="" POA="("_POA_")"
 . W !,$P(IBY,U),?9,POA,?13,$P(IBY,U,3),?75,$S($P(IBZ,U,2)<1000:"("_$P(IBZ,U,2)_")",1:"")
 W !
 Q
 ;
DISP1(IFN) ;
 I +$G(IFN) N POARR D SET(IFN,"",.POARR),DISP(.POARR)
 Q
HELP ;called for help from dx enter to display existing dx's
 Q:'$G(IBIFN)  N IBX
 D SET(IBIFN,.IBDXA,"") S IBX=$G(^DGCR(399,+IBIFN,0)) I IBX="" Q
 I $P(IBX,U,5)>2 S DFN=$P(IBX,U,2),IBX=$G(^DGCR(399,+IBIFN,"U")) D OPTDX(DFN,$P(IBX,U,1),$P(IBX,U,2),.IBOEDX,.IBDXA),DISPOE(.IBOEDX,.IBDXA)
 D SET(IBIFN,.IBDXA,.IBPOA) D:+IBDXA DISP(.IBPOA)
 Q
 ;
ADD1(IFN) ;does not work, but it should replace ask add, and edit
 ;S DIC="^IBA(362.3,",DIC(0)="EMAQ",D="AIFN"_$G(IFN) D IX^DIC K DA,DO,DIC,D
 Q
 ;
 ; ******************************************************************************************
 ;
DXOPT(IBIFN) ; display and ask user to select PCE diagnosis
 N IBDXA,IBOEDX,IBLIST,DFN,IBX
 D SET(IBIFN,.IBDXA,"")
 S DFN=$P($G(^DGCR(399,+IBIFN,0)),U,2),IBX=$G(^DGCR(399,+IBIFN,"U"))
 D OPTDX(DFN,$P(IBX,U,1),$P(IBX,U,2),.IBOEDX,.IBDXA),DISPOE(.IBOEDX,.IBDXA)
 I +$P($G(IBOEDX),U,2) D NEWDX(+IBOEDX) I $D(IBLIST) D ADDNEW(IBIFN,IBLIST,.IBOEDX)
 Q
 ;
OPTDX(DFN,DT1,DT2,ARRAY,IBDXE) ; get diagnosis from PCE for encounters within date range
 ; ARRAY(X)= DX ^ ORDER ^ OUTPATIENT ENCOUNTER (409.68) ^ DATE/TIME ^ TRUE IF NON-BILL ^ NON-BILL MESS ^ CLINIC
 N IBDT,IBOE,IBDX,IBDXN,IBDXA,IBDXB,IBCNT,IBCNT1,ARR,IBI,IBJ,IBK,IBVAL,IBCBK
 K ARRAY
 S (IBCNT,IBCNT1)=0,DT1=$G(DT1)-.0001,DT2=$S(+$G(DT2):DT2,1:9999999)+.7999
 ;
 S IBVAL("DFN")=DFN,IBVAL("BDT")=DT1,IBVAL("EDT")=DT2
 S IBCBK="D OEDX^IBCU81(Y,.IBDXA,.IBDXB)"
 D SCAN^IBSDU("PATIENT/DATE",.IBVAL,"",IBCBK,1) K ^TMP("DIERR",$J)
 ;
 S (IBCNT,IBCNT1,IBI)=0 F  S IBI=$O(IBDXA(IBI)) Q:'IBI  D
 . S IBJ=0 F  S IBJ=$O(IBDXA(IBI,IBJ)) Q:'IBJ  D
 .. S IBK=0 F  S IBK=$O(IBDXA(IBI,IBJ,IBK)) Q:'IBK  D
 ... S IBDXN=0 F  S IBDXN=$O(IBDXA(IBI,IBJ,IBK,IBDXN)) Q:'IBDXN  D
 .... S IBDX=IBDXA(IBI,IBJ,IBK,IBDXN) I $D(ARR(+IBDX))!(+$P(IBDX,U,5)&(+$G(IBDXB(+IBDX)))) Q
 .... S IBCNT=IBCNT+1 I '$D(IBDXE(+IBDX)) S IBCNT1=IBCNT1+1
 .... S ARRAY(IBCNT)=IBDX S ARR(+IBDX)=""
 S ARRAY=IBCNT_"^"_IBCNT1 K IBDXA,IBDXB,ARR
 Q
 ;
NEWDX(IBX) ; user select PCE diagnosis to add to bill
 Q:'$G(IBX)  N X,Y,DIR,DIRUT K IBLIST W !
NEWDX1 S DIR("?",1)="Enter the number preceding the Diagnosis you want added to the bill.",DIR("?",2)="Multiple entries may be added separated by commas or ranges separated by a dash."
 S DIR("?")="The diagnosis will be added to the bill with a print order corresponding to its position in this list."
 S DIR("A")="SELECT NEW DIAGNOSES TO ADD THE BILL"
 S DIR(0)="LO^1:"_+IBX D ^DIR K DIR G:'Y!$D(DIRUT) NEWDXE
 S IBLIST=Y
 ;
 S DIR("A")="YOU HAVE SELECTED "_IBLIST_" TO BE ADDED TO THE BILL IS THIS CORRECT",DIR("B")="YES"
 S DIR(0)="YO" D ^DIR K DIR I $D(DIRUT) K IBLIST G NEWDXE
 I 'Y G NEWDX1
NEWDXE Q
 ;
ADDNEW(IBIFN,LIST,IBOEA) ; add selected PCE diagnosis to bill
 Q:'LIST  N IBI,IBX,IBDX,IBDT,IBQ,IBY,IBPIFN,IBZ
 F IBI=1:1 S IBX=$P(LIST,",",IBI) Q:'IBX  I $D(IBOEA(IBX)) D
 . S IBDX=+IBOEA(IBX) I $D(^IBA(362.3,"AIFN"_IBIFN,IBDX)) Q
 . I $$ADD(IBDX,IBIFN) W "."
 Q
 ;
DISPOE(OEARR,EXARR) ; display outpatient PCE diagnosis
 N IBCNT,IBDX,IBX,IBY,IBDATE
 W @IOF,!,"============================= DIAGNOSIS SCREEN ==============================",!
 S IBDATE=$$BDATE^IBACSV(+$G(IBIFN)) ; The bills date of service
 S IBCNT=0 F  S IBCNT=$O(OEARR(IBCNT)) Q:'IBCNT  D
 . S IBY=OEARR(IBCNT),IBDX=$$ICD9^IBACSV(+IBY,IBDATE)
 . S IBX="" I $D(EXARR(+OEARR(IBCNT))) S IBX="*"
 . W !,$J(IBCNT,2),")",?4,IBX,?5,$P(IBDX,U),?14,$E($P(IBDX,U,3),1,19)
 . I +$P(IBY,U,7) W ?35,$E($P($G(^SC(+$P(IBY,U,7),0)),U,1),1,15)
 . I $P(IBY,U,2)'="" W ?52,$E($$EXPAND^IBTRE(9000010.07,.12,$P(IBY,U,2)),1,3)
 . I $P(IBY,U,4)'="" W ?57,$$FMTE^XLFDT($E($P(IBY,U,4),1,12),2)
 . I $P(IBY,U,6)'="" W ?72,$E($P(IBY,U,6),1,7)
 Q
 ;
DISPID ; Display the Associated Dx and Rx # for a procedure in the identifier.
 ;  Input:  Naked reference to the 0th node of an entry in the
 ;          Procedures (#304) sub-file of the Bill/Claims (#399) file.
 N I,X,IBY,Z
 S X=^(0),IBY=Y
 S I=$$PRCNM^IBCSCH1($P(X,U,1),$P(X,U,2)) W " ",$E($P(I,U,2)_$J("",27),1,27)
 S Z=$O(^DGCR(399,DA(1),"RC","ACP",+IBY,0))
 I Z S Z=$P($G(^DGCR(399,DA(1),"RC",Z,0)),U,11) W $E("  Rx: "_$S(Z:$P($G(^IBA(362.4,+Z,0)),U),1:"Missing")_$J("",14),1,14)
 I +$P(X,U,11) S I=+$G(^IBA(362.3,+$P(X,U,11),0)) W "  Dx 1: ",$P($$ICD9^IBACSV(+I,$$BDATE^IBACSV(DA(1))),U)
 Q
FIRSTDX(DA) ; Called by trigger cross reference #2 on file 362.3,.03
 ; DA is the ien of the entry in file 362.3
 ; Check if the corresponding bill is for an inpatient episode, the
 ; admitting dx for the corresponding bill is null and the dx being
 ; entered is the first for the bill.  If this is all true, admitting
 ; dx should be set to the dx.
 ;
 N OK,Z
 S Z=$G(^IBA(362.3,DA,0)),OK=0
 I $$INPAT^IBCEF(+$P(Z,U,2)),$P($G(^DGCR(399,+$P(Z,U,2),"U2")),U)="",'$O(^IBA(362.3,"AO",+$P(Z,U,2),+$P(Z,U,3)),-1) S OK=1
 Q OK
 ;
