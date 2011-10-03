IBCSC8B ;BP/YMG - ADD/ENTER PATIENT REASON FOR VISIT DATA ;10/15/2008
 ;;2.0;INTEGRATED BILLING;**400**;21-MAR-94;Build 52
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
EN ; entry point
 N DATE,DATE1,DFN,I,IBDX,IBLIST,LOC,PRV0,PRVIEN,PRVS,SCREEN,TCNT,TMP,VCNT,VISITS
 D:$$CHKPRV<3 DELALL(IBIFN)
 ; only try to fetch PRVs if Quadramed file (19640.11) exists
 I $D(^DSIPPRV) D
 .S DFN=$P(^DGCR(399,IBIFN,0),U,2)
 .; try to get all visits for OP Visit dates on the claim
 .;
 .; use only the date portion of date&time field in VISIT file for screening
 .; if OP Visit field contains only a month, only compare month and year
 .S SCREEN="N Z S Z=$P($P(^(0),U),""."") S:'+$E(DATE,6,7) Z=$E(Z,1,5) I Z=DATE"
 .S DATE=0,VCNT=1 F  S DATE=$O(^DGCR(399,IBIFN,"OP",DATE)) Q:'DATE  D
 ..D FIND^DIC(9000010,,"@;.01I","QPX",DFN,,"C",SCREEN,,"TMP") Q:'$P(TMP("DILIST",0),U)
 ..S TCNT=0 F  S TCNT=$O(TMP("DILIST",TCNT)) Q:'TCNT  S VISITS(VCNT)=$P(TMP("DILIST",TCNT,0),U),VCNT=VCNT+1
 ..Q
 .I '$D(VISITS) D
 ..; couldn't find anything for OP Visit dates (or there are no OP Visit dates on the claim)
 ..; try to use Statement Covers From and Statement Covers To fields instead
 ..S DATE=$P($G(^DGCR(399,IBIFN,"U")),U) Q:'DATE  ;
 ..S DATE1=$P($G(^DGCR(399,IBIFN,"U")),U,2) Q:'DATE1  ;
 ..S SCREEN="N Z S Z=$P($P(^(0),U),""."") I Z>=DATE&(Z<=DATE1)"
 ..D FIND^DIC(9000010,,"@;.01I","QPX",DFN,,"C",SCREEN,,"TMP") Q:'$P(TMP("DILIST",0),U)
 ..S TCNT=0,VCNT=1 F  S TCNT=$O(TMP("DILIST",TCNT)) Q:'TCNT  S VISITS(VCNT)=$P(TMP("DILIST",TCNT,0),U),VCNT=VCNT+1
 ..Q
 .I $D(VISITS) D
 ..; we have found some visits, try to fetch corresponding PRVs from file 19640.11 into PRVS array
 ..; PRVS node structure: PRV dx ien ^ hospital location ^ visit date&time
 ..S TCNT=1,VCNT=0 F  S VCNT=$O(VISITS(VCNT)) Q:'VCNT  D
 ...S PRVIEN=$O(^DSIPPRV("B",VISITS(VCNT),"")) Q:'PRVIEN
 ...S PRV0=$G(^DSIPPRV(PRVIEN,0))
 ...S LOC=$$GET1^DIQ(9000010,VISITS(VCNT),.22)
 ...S DATE=$$GET1^DIQ(9000010,VISITS(VCNT),.01)
 ...F I=2:1:4 I $P(PRV0,U,I)'="" S PRVS(TCNT)=$P(PRV0,U,I)_U_LOC_U_DATE,TCNT=TCNT+1
 ...Q
 ..Q
 .Q
 D DISP D:+$G(TCNT)>0 NEWDX(TCNT-1) I $D(IBLIST) D ADDNEW
 D DISPEX(IBIFN)
 D CLEAN^DILF
EN1 ;
 S IBDX=$$ASKDX I +IBDX>0 D ADD($P(IBDX,U)),EDIT(+IBDX) G EN1
 Q
 ;
DISP ; display PRV diagnoses
 N CNT,DXCODE,I,IBDX,PRV
 W @IOF,!,"===================Pt. Reason for Visit Diagnosis Screen ====================",!
 I '$D(PRVS) W !,?13,"No available Pt. Reason for Visit Diagnoses found." Q
 S CNT=0 F  S CNT=$O(PRVS(CNT)) Q:'CNT  D
 .S IBDX=$$ICD9^IBACSV($P(PRVS(CNT),U),$$BDATE^IBACSV(IBIFN)),DXCODE=$P(IBDX,U)
 .F I=8:1:10 S PRV=$P($G(^DGCR(399,IBIFN,"U3")),U,I) I PRV=+PRVS(CNT) S DXCODE="*"_DXCODE Q
 .W !,$J(CNT,2),")",?4,DXCODE,?13,$E($P(IBDX,U,3),1,24),?37,$E($P(PRVS(CNT),U,2),1,24),?62,$P(PRVS(CNT),U,3)
 .Q
 Q
 ;
DISPEX(IBIFN) ; display existing PRV diagnoses for a bill
 N I,IBDX,IBDXDT
 W !!,?5,"------  Existing Pt. Reason for Visit Diagnoses for Bill  -------",!
 F I=8:1:10 S IBDX=$P($G(^DGCR(399,IBIFN,"U3")),U,I) I IBDX'="" D
 .S IBDXDT=$$ICD9^IBACSV(IBDX,$$BDATE^IBACSV(IBIFN))
 .W !,?12,$P(IBDXDT,U),?26,$P(IBDXDT,U,3)
 .Q
 W:'$G(IBDXDT) !,?13,"No existing Pt. Reason for Visit Diagnoses found."
 W !
 Q
 ;
CHKPRV() ; check how many PRVs are not populated (out of 3)
 N CNT,I
 S CNT=3 F I=8:1:10 I $P($G(^DGCR(399,IBIFN,"U3")),U,I)'="" S CNT=CNT-1
 Q CNT
 ;
PRVFLD(DXIEN) ; returns the field number that contains DXIEN
 ; if DXIEN="", returns the first empty PRV field number
 ; if no match found (or no empty fields), returns 0
 N I,FLD
 S FLD=0 F I=8:1:10 I $P($G(^DGCR(399,IBIFN,"U3")),U,I)=DXIEN S FLD=I+241 Q
 Q FLD
 ;
ERR ; display error message
 W !,?6,"You may add a maximum of 3 PRV diagnoses to a claim."
 Q
 ;
NEWDX(IBX) ; select PRV diagnosis to add to bill
 ; IBX - max. number of PRV diagnoses available
 N X,Y,DIR,DIRUT
 Q:'IBX!('$$CHKPRV)  ;
 W !
NEWDX1 S DIR("?",1)="Enter the number preceding the PRV diagnosis you want added to the bill.",DIR("?")="Multiple entries may be added separated by commas or ranges separated by a dash."
 S DIR("A")="Select Pt. Reason for Visit Diagnosis to add to bill"
 S DIR(0)="LO^1:"_+IBX D ^DIR K DIR G:'Y!$D(DIRUT) NEWDXE
 S IBLIST=Y
 S DIR("A")="You have selected "_IBLIST_" to be added to the bill. Is this correct",DIR("B")="YES"
 S DIR(0)="YO" D ^DIR K DIR I $D(DIRUT) K IBLIST G NEWDXE
 I 'Y G NEWDX1
 I $L(IBLIST,",")-1>$$CHKPRV D ERR G NEWDX1
NEWDXE Q
 ;
ADD(DXIEN) ; add single PRV diagnosis with file 80 ien DXIEN to the bill
 Q:'DXIEN!$$PRVFLD(DXIEN)  ; quit if no dx ien of if such PRV already exists
 N FLD
 ; if there are already 3 PRVs on the claim, complain and bail out
 I '$$CHKPRV D ERR Q
 S FLD=$$PRVFLD("") I FLD S DIE="^DGCR(399,",DA=IBIFN,DR=FLD_"////"_DXIEN D ^DIE K DA,DIE
 Q
 ;
ADDNEW ; add selected PRV diagnoses to the bill
 Q:'$D(PRVS)
 N I,IBX
 F I=1:1 S IBX=$P(IBLIST,",",I) Q:'IBX  I $D(PRVS(IBX)) D ADD(+PRVS(IBX))
 Q
 ;
ASKDX() ; enter extra PRV diagnosis
 ; returns dx ien in file 80 ^ dx code
 N X,Y,IBDATE,IBDTTX
 S IBDATE=$$BDATE^IBACSV(IBIFN)
 S IBDTTX=$$DAT1^IBOUTL(IBDATE)
AD ;
 S DIR("?")="Enter a diagnosis for this bill. Only diagnosis codes active on "_IBDTTX_" are allowed."
 S DIR(0)="PO^80:EAMQ",DIR("A")="Enter Pt. Reason for Visit Diagnosis"
 D ^DIR K DIR
 I Y>0,'$$PRVFLD(+Y),'$$ICD9ACT^IBACSV(+Y,IBDATE) D  G AD
 . W !!,*7,"The Diagnosis code is inactive for the date of service ("_IBDTTX_").",!
 Q Y
 ;
EDIT(DXIEN) ; edit/delete PRV diagnosis
 N IBU3,FLD,PRV2,PRV3
 Q:'DXIEN  S FLD=$$PRVFLD(DXIEN) I FLD S DIE="^DGCR(399,",DA=IBIFN,DR=FLD D ^DIE K DIE,DR,DA
 ; if PRV was deleted, rearrange PRVs to maintain their order of entry
 S IBU3=$G(^DGCR(399,IBIFN,"U3")) I $P(IBU3,U,FLD-241)="" D
 .; PRV(1) was deleted, PRV(2) is not empty
 .I FLD=249 S PRV2=$P(IBU3,U,9) S:PRV2'="" PRV3=$P(IBU3,U,10),DR="249////"_PRV2_";"_$S(PRV3'="":"250////"_PRV3_";251///@",1:"250///@")
 .; PRV(2) was deleted, PRV(3) is not empty
 .I FLD=250 S PRV3=$P(IBU3,U,10) I PRV3'="" S DR="250////"_PRV3_";251///@"
 .; if PRV(3) is deleted, no rearrangements are necessary
 .Q
 I $G(DR)'="" S DIE="^DGCR(399,",DA=IBIFN D ^DIE K DIE,DR,DA
 Q
 ;
DELALL(IBIFN) ; ask/delete all PRV diagnoses on the bill
 N DIE,DA,DR,DIR,DIRUT,DUOUT,DTOUT,X,Y W !
 S DIR("?")="Enter Yes to delete all PRV diagnoses currently defined for a bill.",DIR("??")="^D DISPEX^IBCSC8B("_IBIFN_")"
 S DIR("A")="Delete all Patient Reason for Visit diagnoses on bill"
 S DIR(0)="YO",DIR("B")="NO" D ^DIR K DIR Q:Y'=1
 ;
 S DIE="^DGCR(399,",DA=IBIFN,DR="249///@;250///@;251///@" D ^DIE
 W " .... deleted"
 Q
