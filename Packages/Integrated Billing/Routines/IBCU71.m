IBCU71 ;ALB/AAS - INTERCEPT SCREEN INPUT OF PROCEDURE CODES ; 29-OCT-91
 ;;2.0;INTEGRATED BILLING;**41,60,91,106,125,138,210,245,349**;21-MAR-94;Build 46
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;MAP TO DGCRU71
 ;
ADDCPT ;  - store cpt codes in visits file
 Q:$D(DGCPT)'>9
 N DA,DIC,DR,DIE,DIRUT,DUOUT,DTOUT,DIROUT,VADM
 S DIR(0)="Y",DIR("A")="OK to add CPT codes to Visits file",DIR("B")="Y" D ^DIR K DIR Q:'Y!$D(DIRUT)
 N IBPKG,IBCLIN,IBVDATE,IBPROC,IBK,IBCOUNT,IBRESULT,IBOTH
 S IBPKG=$O(^DIC(9.4,"C","IB",0)) Q:'IBPKG
 W !!,"Adding Procedures to PCE..."
 S IBCLIN=0 F  S IBCLIN=$O(DGCPT(IBCLIN)) Q:'IBCLIN  D
 .;
 .K ^TMP("IBPXAPI",$J)
 .;
 .; - set up encounter data
 .S IBVDATE=DGPROCDT D VISDT
 .S ^TMP("IBPXAPI",$J,"ENCOUNTER",1,"ENC D/T")=IBVDATE,^("PATIENT")=DFN,^("HOS LOC")=IBCLIN,^("SERVICE CATEGORY")="X",^("ENCOUNTER TYPE")="A"
 .;
 .; - set up procedure and diagnosis data
 .S IBK=0,IBPROC=0 F  S IBPROC=$O(DGCPT(IBCLIN,IBPROC)) Q:'IBPROC  D
 ..S IBOTH="" F  S IBOTH=$O(DGCPT(IBCLIN,IBPROC,IBOTH)) Q:IBOTH=""  D
 ...S IBK=IBK+1
 ...;
 ...; - load first procedure diagnosis as visit diagnosis
 ...I +$P(IBOTH,U,2) S ^TMP("IBPXAPI",$J,"DX/PL",IBK,"DIAGNOSIS")=+$P(IBOTH,U,2)
 ...;
 ...; - count number of times procedure performed
 ...S (X,IBCOUNT)=0 F  S X=$O(DGCPT(IBCLIN,IBPROC,IBOTH,X)) Q:'X  S IBCOUNT=IBCOUNT+1
 ...;
 ...; - load procedure information
 ...S ^TMP("IBPXAPI",$J,"PROCEDURE",IBK,"PROCEDURE")=IBPROC,^("QTY")=IBCOUNT,^("EVENT D/T")=IBVDATE
 ...I +$P(IBOTH,U,1) S ^TMP("IBPXAPI",$J,"PROCEDURE",IBK,"ENC PROVIDER")=+$P(IBOTH,U,1)
 ...I +$P(IBOTH,U,3) S ^TMP("IBPXAPI",$J,"PROCEDURE",IBK,"MODIFIERS",$P($$MOD^ICPTMOD(+$P(IBOTH,U,3),"I"),U,2))=""
 .;
 .; - call the PCE interface
 .Q:'$D(^TMP("IBPXAPI",$J,"PROCEDURE"))
 .;
 .S IBRESULT=$$DATA2PCE^PXAPI("^TMP(""IBPXAPI"",$J)",IBPKG,"IB DATA",,DUZ,0)
 .W !,"  Procedures in ",$P(^SC(IBCLIN,0),"^")," "
 .I IBRESULT>0 W "were added okay." Q
 .W "were not added - error code is ",IBRESULT
 ;
 K ^TMP("IBPXAPI",$J)
 Q
 ;
 ;
DISPDX ;  - display diagnosis codes available for associated dx (CMS-1500)  NO LONGER USED?
 N I,J,X,IBDX,IBDXL,IBDATE
 S IBDATE=$$BDATE^IBACSV(IBIFN)
 F I=1:1:4 S IBDX=$P($G(^DGCR(399,IBIFN,"C")),"^",(I+13)),X=$$ICD9^IBACSV(+IBDX,IBDATE) I X'="" S IBDXL(I)=IBDX_"^"_X
 I '$D(IBDXL) W !!,"Bill has no ICD DIAGNOSIS." Q
 W !!,?24,"<<<ASSOCIATED ICD-9 DIAGNOSIS>>>",!!
 F I=1,2 W ! S X=0 F J=0,2 I $D(IBDXL(I+J)) S IBDX=IBDXL(I+J) D  S X=40
 . W ?X,"    ",$P(IBDX,"^",2),?(X+13),$E($P(IBDX,"^",4),1,28)
 W !
 Q
 ;
SCREEN(X,Y) ; -- screen logic for active procs or surgeries - OBSOLETE
 ; -- input x = date to check,  y = procedure
 ; -- output 0 if not active for billing or amb proc on date,  1 if either active
 ;
 Q 0
 ;
VISDT ; Find the actual encounter for the visit; update visit date/time
 ; input DGPROCDT, DFN, IBCLIN
 N IBD,IBF,IBOEN,IBEVT,IBVAL,IBCBK,IBFILTER
 S IBF=0,IBD=DGPROCDT-.1
 S IBVAL("DFN")=DFN,IBVAL("BDT")=DGPROCDT-.1,IBVAL("EDT")=DGPROCDT\1_".99"
 S IBFILTER=""
 S IBCBK="I IBCLIN=$P(Y0,U,4) S IBVDATE=+Y0,SDSTOP=1"
 D SCAN^IBSDU("PATIENT/DATE",.IBVAL,IBFILTER,IBCBK,1)
 Q
 ;
PRCDT(IBIFN,ARR) ; return array of bill's procedures in date then code order
 ; returns    ARR(DATE, NAME, CPIFN) = 399.0304 node
 N IBI,IBX,IBNAME K ARR
 S IBI=0 F  S IBI=$O(^DGCR(399,+$G(IBIFN),"CP",IBI)) Q:'IBI  D
 . S IBX=$G(^DGCR(399,IBIFN,"CP",IBI,0))
 . S IBNAME=$P($$PRCNM^IBCSCH1($P(IBX,U,1)),U,1)_" "
 . S ARR($P(IBX,U,2),IBNAME,IBI)=IBX
 Q
 ;
PRCDIV(IBIFN) ; change Bills Default Division (399,.22) to reflect care provided
 ; - set Bill Division to the first Procedures Division (399,304,5), if defined
 ; - or else if bill is an inpatient bill then get the Division of the Ward the patient was Admitted to
 ; return null if no change or 'new division ifn^message'
 ;
 N IB0,IBCPT,IBPDIV,IBWRD,IBX,DIC,DIE,DA,DR,X,Y S IBX="",IBPDIV=0
 S IB0=$G(^DGCR(399,+$G(IBIFN),0))
 ;
 I +$G(IBIFN) S IBCPT=$O(^DGCR(399,IBIFN,"CP",0)) I +IBCPT D  ; if CPT division defined, use it
 . S IBCPT=$G(^DGCR(399,IBIFN,"CP",IBCPT,0)) S IBPDIV=+$P(IBCPT,U,6)
 ;
 I 'IBPDIV,+$P(IB0,U,8) D  ; for inpatient, get Ward Division
 . S IBWRD=$G(^DGPT(+$P(IB0,U,8),535,1,0)) S IBPDIV=+$P($G(^DIC(42,+$P(IBWRD,U,6),0)),U,11)
 ;
 I +IBPDIV,+$P(IB0,U,22)'=+IBPDIV D
 . S DIE="^DGCR(399,",DA=IBIFN,DR=".22////"_+IBPDIV D ^DIE K DIE,DR,DA,X,Y
 . S IBX=+IBPDIV_"^Bill Division Changed to "_$P($G(^DG(40.8,+IBPDIV,0)),U,1)
 Q IBX
 ;
DVTYP(IBIFN) ; reset Bill Charge Type (399, .27) based on Bill Division (399, .22)
 ; if bill division is type 3 - Freestanding then reset Charge Type to 2 - Professional
 ; with RC 2.0+ Type 3 sites have only professional charges, start date of bill must be on/after beginning of RC 2.0
 N IB0,IBDV,IBCHGTYP,IBDVTYP,DIC,DIE,DA,DR,X,Y
 S IB0=$G(^DGCR(399,+$G(IBIFN),0)),IBDV=$P(IB0,U,22),IBCHGTYP=$P(IB0,U,27)
 I +$G(^DGCR(399,+$G(IBIFN),"U"))<$$VERSDT^IBCRU8(2) G DVTYPQ
 I +IBDV,+IBCHGTYP S IBDVTYP=$$RCDV^IBCRU8(+IBDV) I +$P(IBDVTYP,U,3)=3,IBCHGTYP'=2 D
 . S DIE="^DGCR(399,",DA=IBIFN,DR=".27////"_2 D ^DIE K DIE,DR,DA,X,Y
 . S IBCHGTYP="2^Bill Charge Type Changed to Professional"
DVTYPQ Q IBCHGTYP
