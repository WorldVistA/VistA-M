EASECSCC ;ALB/LBD - LTC Co-Pay Test Screen Completion;13 AUG 2001 ; 3/20/03 2:24pm
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**5,7,34,40**;Mar 15, 2001
 ;
 ;NOTE: This routine was modified from DGMTSCC for LTC Co-pay
 ; Input  -- DFN      Patient IEN
 ;           DGMTACT  Menu Action
 ;           DGMTDT   Date of Test
 ;           DGMTYPT  Type of Test 3=LTC COPAY
 ;           DGMTPAR  Annual Means Test Parameters
 ;           DGMTI    Annual Means Test IEN
 ;           DGVINI   Veteran Individual Annual Income IEN
 ;           DGVIRI   Veteran Income Relation IEN
 ;           DGVPRI   Veteran Patient Relation IEN
 ; Output -- DGERR    1=INCOMPLETE and 0=COMPLETE
 ;
EN N DGCAT,DGCOMF,DGDC,DGDET,DGIN0,DGIN1,DGIN2,DGINT,DGINTF,DGMTS,DGNC,DGND,DGNWT,DGNWTF,DGREF1,DGSP,DGTYC,DGTHA,DGTHB,DGVIR0,DGCOPS,DGCOST,DGRE,DGSTA,DGAGR
 S DGERR=0
 S DGCOMF=1 D DEP^EASECSU3,INC^EASECSU3
 ; If veteran's income is below the threshold then exempt from LTC copay
 ;   LTC III (EAS*1*34)  modified to make vet with $0 income exempt 
 I DGINT'>+$$THRES^IBARXEU1(DGMTDT,1,0) D  G Q
 .D EXMPT(DFN,DGMTI,12)
 .D PRT
 ; Check if test can be completed
 D CHK I DGERR W !?3,*7,"LTC copay test cannot be completed." G Q
 ; Did vet refuse to give income info
 I 'DGINTF,'DGNWTF S DGREF1="" D  G Q:$D(DTOUT)!($D(DUOUT))
 .D REF
 .I $D(DGREF) S DGSTA="NON-EXEMPT"
 ; Get test status (Exempt or Non-Exempt)
 D STA G Q:$D(DTOUT)!($D(DUOUT))
 ; Does vet agree to pay co-payments
 I $G(DGSTA)="NON-EXEMPT" D AGREE G Q:$D(DTOUT)!($D(DUOUT))
UPD S DA=DGMTI,DIE="^DGMT(408.31,",DIE("NO^")="",DR="[EASEC COMPLETE LTC CO-PAY TEST]" D ^DIE K DA,DIE,DR I '$D(DGFIN) S DGERR=1 G Q
 W !?3,"...The LTC copay test has been completed with a status of ",DGSTA,"..."
 D PRT
 ;
Q K DGFIN,DGREF,DTOUT,DUOUT,Y
 Q
 ;
COM ;Check if user wants to complete the LTC co-pay test
 N DIR
 S DIR("A")="Do you wish to complete the LTC copay test"
 S DIR("B")="YES",DIR(0)="Y" D ^DIR
 Q
 ;
REF ;Check if patient declines to provide income information
 N DIR,Y
 S DIR("A")="Does veteran decline to give income information"
 I $P($G(^DGMT(408.31,DGMTI,0)),"^",14)]"" S DIR("B")=$$YN^DGMTSCU1($P(^(0),"^",14))
 S:'$D(DIR("B")) DIR("B")="NO"
 S DIR("?")="Answer 'Y' or 'N'."
 S DIR("?",1)="Enter whether the veteran declines to provide current income information."
 S DIR(0)="Y" D ^DIR K DIR G REFQ:$D(DTOUT)!($D(DUOUT))
 S:Y DGREF=""
REFQ Q
 ;
CHK ;Check if LTC copay test can be completed
 ;   For LTC III (EAS*1*34) removed check if expenses greater than income
 N DGA,DGD,DGDEP,DGREL,DGL,DGM,I
 D GETREL^DGMTU11(DFN,"CS",$E(DGMTDT,1,3)_"0000",$S($G(DGMTI):DGMTI,1:""))
 S DGM=$P(DGVIR0,"^",14),DGL=$P(DGVIR0,"^",17),DGD=$P(DGVIR0,"^",8)
 I DGM="" W !?3,"Marital section must be completed." S DGERR=1
 ;  For LTC IV (EAS*1*40) added check for legally separated
 I DGM,'DGL,'$D(DGREL("S")) W !?3,"Married is 'YES'.  An active spouse for this LTC copay test does not exist." S DGERR=1
 I 'DGM,$D(DGREL("S")) W !?3,"An active spouse exists for this LTC copay test. Married should be 'YES'." S DGERR=1
 I DGD']"" W !?3,"Dependent Children section must be completed." S DGERR=1
 I DGD,'$D(DGREL("C")) W !?3,"Dependent Children is 'YES'.  No active children exist." S DGERR=1
 I 'DGD,$D(DGREL("C")) W !?3,"Active children exist.  Dependent Children should be 'YES'." S DGERR=1
 Q:$G(DGERR)
 N CNT,ACT,DGDEP,FLAG,DGINCP
 D INIT^EASECDEP S CNT=0 D
 .F  S CNT=$O(DGDEP(CNT)) Q:'CNT  I $P(DGDEP(CNT),U,2)="SPOUSE" D  Q:$G(DGERR)
 ..D GETIENS^EASECU2(DFN,$P(DGDEP(CNT),U,20),DGMTDT)
 ..S DGINCP=$G(^DGMT(408.22,+DGIRI,"MT")) S:DGINCP FLAG=$G(FLAG)+1
 ..I $G(FLAG)>1 W !?3,"Patient has more than one spouse for this LTC copay test." S DGERR=1
 Q
 ;
STA ;Ask test status
 N DIR,Y,SCRN
 S DGMTS=$P($G(^DGMT(408.31,DGMTI,0)),U,3)
 S DGRE=$P($G(^DGMT(408.31,DGMTI,2)),U,7)
 I DGMTS S DGSTA=$P($G(^DG(408.32,DGMTS,0)),U)
 I '$D(DGSTA) S DGSTA="NON-EXEMPT"
 I DGSTA="EXEMPT",("12"[DGRE),$G(DGINT)>+$$THRES^IBARXEU1(DGMTDT,1,0) S DGSTA="NON-EXEMPT"
 I DGSTA="EXEMPT",$G(DGNSTA)="NON-EXEMPT" S DGSTA="NON-EXEMPT"
 S DIR("A")="LTC Copay Test Status" S DIR("B")=DGSTA
 S DIR(0)="P^408.32:EM",DIR("S")="I $P(^(0),U,19)=3"
 D ^DIR K DIR Q:'Y!($D(DTOUT))!($D(DUOUT))
 S DGMTS=+Y,DGSTA=$P(Y,U,2) Q:DGSTA="NON-EXEMPT"
 ;If Exempt, ask reason for exemption
 S DIR("A")="Reason for Exemption"
 I DGRE S DIR("B")=$P($G(^EAS(714.1,DGRE,0)),U)
 ; Screen the look-up on file #714.1.  Exemption reasons 1, 2 and 12
 ; will be screened out unless this is the call from the Edit option
 ; (DGEFLG=1) and only reason 1 is screened out.
 S SCRN="2^12^" S:$G(DGEFLG) SCRN=""
 S DIR("S")="I $P(^(0),U,2),""^1^"_SCRN_"""'[(U_Y_U)"
 S DIR(0)="P^714.1:EM" D ^DIR K DIR I 'Y!($D(DTOUT))!($D(DUOUT)) D  G STA
 .W !!,"A reason for exemption must be entered for an Exempt status.",!
 S DGRE=+Y
 Q
AGREE ;Ask if vet agrees to pay co-payment
 N DIR,Y
 S DIR("A")="Does the veteran agree to pay copayments"
 I $P($G(^DGMT(408.31,DGMTI,0)),U,11)]"" S DIR("B")=$$YN^DGMTSCU1($P(^(0),U,11))
 S:'$D(DIR("B")) DIR("B")="YES"
 S DIR("?")="Answer 'Y' or 'N'."
 S DIR("?",1)="Enter in this field whether the veteran agrees to pay the"
 S DIR("?",2)="LTC copayments.  The veteran must also sign the 1010-EC form"
 S DIR("?",3)="agreeing to pay the copayments. If the veteran does not agree"
 S DIR("?",4)="to pay the copayments, the veteran becomes ineligible to"
 S DIR("?",5)="receive extended care services."
 S DIR(0)="Y" D ^DIR K DIR Q:$D(DTOUT)!($D(DUOUT))
 S DGAGR=Y
 Q
PRT ;Print Extended Care Services test (1010EC)
 N DIR,Y,X,ZTSK
 S DIR("A")="PRINT 10-10EC"
 S DIR("B")="YES",DIR(0)="Y" D ^DIR G PRTQ:'Y!($D(DTOUT))!($D(DUOUT))
 S ZTSK=$$QUE^EASEC10E(DFN,DGMTI)
PRTQ Q
 ;
EXMPT(DFN,DGMTI,EX) ; Veteran is exempt from LTC co-payments
 ; Complete LTC co-pay test in Annual Means Test file (#408.31)
 ; Input -- DFN     Patient IEN
 ;          DGMTI   Annual Means Test IEN
 ;          EX      Copay exemption code
 ;                  1 = SC compensable disability
 ;                  2 = NSC, single, receiving VA pension (no A&A, HB)
 ;                         or
 ;                      Income (last year) is below single pension threshold
 ;                 12 = Income (current year) is below single pension threshold 
 Q:'DGMTI  Q:'EX
 N DATA,I
 W !! F I=1:1:80 W "="
 W !!,?10,"Veteran is EXEMPT from Long Term Care copayments."
 W !,?10,"Reason for Exemption: ",$P($G(^EAS(714.1,EX,0)),U)
 W !! F I=1:1:80 W "="
 W !!
 S DATA(.03)=$O(^DG(408.32,"C","X","")),DATA(2.07)=EX,DATA(.06)=DUZ
 S (DATA(.07),DATA(2.02))=$$NOW^XLFDT
 S DATA(.04)=$G(DGINT),DATA(.05)=$G(DGNWT),DATA(.15)=$G(DGDET)
 S DATA(.18)=$G(DGND),DATA(2.08)=$P($$GETLTC4^EASECMT(DFN),U,1)
 S DATA(.14)=$S($D(DGREF):1,1:0)     ;LTC III (EAS*1*34)
 I $$UPD^DGENDBS(408.31,DGMTI,.DATA) Q
 W !,"ERROR:  COULD NOT UPDATE LTC COPAY TEST",!!
 Q
