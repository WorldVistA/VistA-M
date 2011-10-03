DGMTSC ;ALB/RMO,CAW,RTK,PDJ,LBD,EG - Means Test Screen Driver ;05/02/2006
 ;;5.3;Registration;**182,327,372,433,463,540,566,611**;Aug 13, 1993;Build 3
 ;
 ;A series of screens used to collect the means test data
 ; Input  -- DFN      Patient IEN
 ;           DGMTACT  Means Test Action  (ie, ADD to Add a Means Test)
 ;           DGMTDT   Date of Test
 ;           DGMTI    Annual Means Test IEN
 ;           DTMTYPT  Type of Test 1=MT 2=COPAY
 ;           DGMTROU  Option Routine Return
 ; Output -- None
 ;
 ;DG*5.3*540 - set 408.21 (Idiv. Ann. Income) ien to 0 to prevent from
 ;             linking to old test incomes for IVM converted cases.
 ;
EN ;Entry point for means test screen driver
 D PRIOR^DGMTEVT:DGMTACT'="VEW",HOME^%ZIS,SETUP^DGMTSCU I DGERR D MG G Q1
 N DGREF,DTOUT,DUOUT,DGCAT,DGREF,ANSPFIN,PROVS
 S ANSPFIN="N"
 I DGMTACT="ADD"!(DGMTACT="EDT")!(DGMTACT="COM") D DISCF Q:$D(DTOUT)!$D(DUOUT)  I $D(DGREF) D Q Q
 ;
EN1 ;Entry point to edit means test if incomplete
 S DGMTSCI=+$O(DGMTSC(0))
 I DGMTI,$$GET1^DIQ(408.31,DGMTI,.23)["IVM" S DGVINI=0     ;DG*5.3*540
 G @($$ROU^DGMTSCU(DGMTSCI))
 ;
 ;
Q I DGMTACT'="VEW" D EN^DGMTSCC I DGERR G EN1:$$EDT
 ; Added for LTC Co-pay Phase II - DG*5.3*433
 I DGMTACT'="VEW",DGMTYPT=4 D  G K
 .Q:$P($G(^DGMT(408.31,DGMTI,0)),U,3)=""  ; LTC 4 test is incomplete
 .D AFTER^DGMTEVT S DGMTINF=0
 .D EN^DGMTAUD,EN^IVMPMTE
 .D DATETIME^DGMTU4(DGMTI)
 .; If LTC copay exemption test is edited, update LTC copay test
 .I DGMTACT="EDT" D UPLTC3^EASECMT(DGMTI)
Q1 I DGMTACT'="VEW" D AFTER^DGMTEVT S DGMTINF=0 D EN^DGMTEVT
 ;
 ;If the veteran has agreed to pay copay after previously refusing,
 ;automatically update their Primary Eligibility (327-Ineligible Project)
 I $D(DGMTP),$D(DGMTA) D
 .I $D(^DPT(DFN,.3)),$P(DGMTP,U,11)=0,$P(DGMTA,U,11)=1 D
 ..N DATA
 ..I $P(^DPT(DFN,.3),U)="Y" S DATA(.361)=$O(^DIC(8,"B","SC LESS THAN 50%",""))
 ..E  S DATA(.361)=$O(^DIC(8,"B","NSC",""))
 ..I $$UPD^DGENDBS(2,DFN,.DATA)
 .;If the veteran has refused to pay copay, update ENROLLMENT
 .;PRIORITY to null.
 .I $P(DGMTA,U,11)=0 D
 ..S CUR=$$FINDCUR^DGENA(DFN)
 ..N DATA S DATA(.07)="@" I $$UPD^DGENDBS(27.11,CUR,.DATA)
 ;
 ; Added for LTC Copay Phase II (DG*5.2*433)
 ; If means test or copay test is edited and has a LTC copay exemption
 ; test associated with it, update the LTC copay exemption test.
 I DGMTACT="EDT",$O(^DGMT(408.31,"AT",DGMTI,0)) D LTC4^EASECMT(DGMTI)
 ;
K K %,DGBL,DGDC,DGDEP,DGDR,DGFCOL,DGFL,DGMT0,DGMTA,DGMTINF,DGMTOUT,DGMTP,DGMTPAR,DGMTSC,DGMTSCI,DGREL,DGRNG,DGRPPR,DGSCOL,DGSEL,DGSELTY,DGVI,DGVINI,DGVIRI,DGVO,DGVPRI,DGX,DGY,DTOUT,DUOUT,Y,Z
 ;
 ; Validate record with consistency checks, when adding, editing, or
 ; completing either a means or copay test.
 ; For DG*5.3*566 - added a check for Status field to be defined before
 ; calling the consistency check API (INCON^DGMTUTL1).
 K IVMERR,IVMAR,IVMAR2
 ;don't apply consistency checks if user elects to not provide financial information
 I DGMTACT'="VEW",$P($G(^DGMT(408.31,DGMTI,0)),U,3),'$D(DGREF) D INCON^DGMTUTL1(DFN,DGMTDT,DGMTI,DGMTYPT,.IVMERR),PROB^IVMCMFB(DGMTDT,.IVMERR,1)
 ;
 ;Update the TEST-DETERMINED STATUS field (#2.03) in the ANNUAL MEANS
 ;TEST file (408.31) when adding a means or copay test, completing a 
 ;means test, or editing a means or copay test.
 I "ADDCOMEDT"[DGMTACT D SAVESTAT^DGMTU4(DGMTI,DGERR)
 K DGERR,IVMERR,ARRAY,ZIC,ZIR,ZMT,ZDP,IVMAR,IVMAR2,DGREF
 ;
 G @(DGMTROU)
 ;
MG ;Print set-up error messages
 I $D(DGVPRI),DGVPRI'>0 W !!?3,"Patient Relation cannot be setup for patient."
 I $D(DGVINI),DGVINI'>0 W !!?3,"Individual Annual Income cannot be setup for patient."
 I $D(DGMTPAR),DGMTPAR']"",DGMTYPT=1 W !!?3,"Means Test Thresholds are not defined."
 W !?3,*7,"Please contact your site manager."
 Q
 ;
EDT() ;Edit means/copay test if incomplete
 N DIR,Y
 S DIR("A")="Do you wish to edit the "_$S(DGMTYPT=1:"means",1:"copay exemption")_" test"
 S DIR("B")="YES",DIR(0)="Y" D ^DIR
 Q +$G(Y)
 ;
DEDUCT() ;
 N DIR,Y
 S DIR("A")="Agreed to pay deductible",DIR(0)="Y"
 D ^DIR
 Q +$G(Y)
 ;
DISCF ;Check if patient declines to provide income information
 ;similar to module REF in program DGMTSCC, but the questions
 ;are negatives of each other
 N DIR,Y,U,MSG
 S U="^"
 S MSG(1)=""
 S MSG(2)="PROVIDE SPECIFIC INCOME AND/OR ASSET INFORMATION"
 S MSG(3)="TO HAVE ELIGIBILITY FOR CARE DETERMINED. <YES>"
 S MSG(4)="Continue, and complete the test with last calendar year's information."
 S MSG(5)=""
 S MSG(6)="PROVIDE MY DETAILED FINANCIAL INFORMATION. <NO>"
 S MSG(7)="The appropriate enrollment priority based on nondisclosure of"
 S MSG(8)="my financial information will be assigned."
 S MSG(9)=""
 D BMES^XPDUTL(.MSG)
 S DIR("A")="Do you wish to provide financial information? "
 ;piece 14 says declines to give income info yes or no
 ;if the user declines to give income info, then provide financial information is no
 I $P($G(^DGMT(408.31,DGMTI,0)),"^",14)]"" S DIR("B")=$S($P(^DGMT(408.31,DGMTI,0),"^",14):"N",1:"Y")
 I '$D(DIR("B")) S DIR("B")="YES"
 S DIR(0)="408.31,.14" D ^DIR K DIR I $D(DTOUT)!($D(DUOUT)) Q
 S:'Y DGREF="" S ANSPFIN="Y" Q:'$D(DGREF)!($D(DGREF1))!(DGMTYPT'=1)  S DGCAT="C" D STA^DGMTSCU2
 Q
