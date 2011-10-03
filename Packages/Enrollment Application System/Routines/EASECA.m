EASECA ;ALB/PHH,LBD - Add a New LTC Co-Pay Test ;10 AUG 2001
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**5,7,34,40**;Mar 15, 2001
 ;
EN ;Entry point to add a new LTC Co-Pay test
 N DGMDOD S DGMDOD=""
 S DGMTYPT=3
 I $D(DGMTDFN)#2 K DGMTDFN
 S DIC="^DPT(",DIC(0)="AEMQ" W !! D ^DIC K DIC G Q:Y<0 S (DFN,DGMTDFN)=+Y
 I $P($G(^DPT(DFN,.35)),U)'="" S DGMDOD=$P(^DPT(DFN,.35),U)
 I $G(DGMDOD) W !!,"Patient died on: ",$$FMTE^XLFDT(DGMDOD,"1D") Q
 ; Is patient a veteran?  Added for LTC III (EAS*1*34)
 I $P($G(^DPT(DFN,"VET")),U)'="Y" W !!,"Patient is not a Veteran." Q
 ;
 S DGLDT=$$LST^EASECU(DFN,"",DGMTYPT),DGLD=$P(DGLDT,U,2),DGLDYR=$E(DGLD,1,3)_"1231"
 ;
DT S %DT("A")="Date of LTC Copay Test: ",%DT="AEX",%DT(0)="-NOW",%DT("B")="NOW" W ! D ^%DT K %DT G Q:Y<0 S DGMTDT=Y
 I DGLD,DGMTDT'>DGLD W !?3,*7,"The date of test must be after the date of the last test on " S Y=DGLD X ^DD("DD") W Y,"." G DT
 ; LTC III (EAS*1*34) - change to allow multiple tests within a year
 I DGLD S X1=DGMTDT,X2=DGLD D ^%DTC I X<365 D  G EN:$G(Y)'=1
 .W !?3,*7,"An LTC Copay Test already exists on " S Y=DGLD X ^DD("DD") W Y,"."
 .S DIR(0)="Y",DIR("A")="Are you sure you want to add a new test",DIR("B")="NO" D ^DIR K DIR
 .;S DGTTYP="LTC COPAY "
 .;W !,$S($P($G(^DG(408.34,+$P($G(^DGMT(408.31,+DGLDT,0)),U,23),0)),U)="VAMC":"   Use the 'EASEC "_DGTTYP_"TEST EDIT' Option.",1:"   Use the 'EASEC "_DGTTYP_"TEST VIEW' Option.")
 ;
 D ADD G EN:DGMTI<0
 ;
EXMPT ; Is veteran exempt from LTC copayments?
 S DGEXMPT=$$EXMPT^EASECU(DFN)
 I DGEXMPT D EXMPT^EASECSCC(DFN,DGMTI,DGEXMPT) D Q G EN
 ; Is veteran exempt for reason other than low income?
 ; LTC Phase IV (EAS*1*40)
 W !!
 S DIR("A")="Is veteran EXEMPT from LTC copayments",DIR("B")="NO",DIR(0)="Y",DIR("?")="Enter either 'Y' or 'N'."
 S DIR("?",1)="Answer 'Yes' if the veteran is exempt from LTC copayments"
 S DIR("?",2)="for a reason other than low income.",DIR("?",3)=""
 D ^DIR K DIR I $D(DTOUT)!($D(DUOUT)) D DEL,Q G EN
 I Y D  D Q G EN
 .; Get reason for exemption
 .S DIR("A")="Reason for Exemption",DIR(0)="P^714.1:EM"
 .S DIR("S")="I $P(^(0),U,2),""^1^2^12^""'[(U_Y_U)"
 .D ^DIR K DIR I 'Y!($D(DUOUT))!($D(DTOUT)) D  D DEL Q
 ..W !!,"A reason for exemption must be entered.  LTC Copay Test cannot be added.",!
 .D EXMPT^EASECSCC(DFN,DGMTI,+Y)
 ; Check if veteran's income is below the pension threshold
 D EN^EASECMT I $G(DGOUT) D DEL,Q G EN
 I DGEXMPT D EXMPT^EASECSCC(DFN,DGMTI,2) D Q G EN
 W !! F I=1:1:80 W "="
 W !!,?10,"Veteran is NOT EXEMPT from Long Term Care copayments based"
 W !,?10,"on last year's income and must complete a 10-10EC form."
 W !! F I=1:1:80 W "="
 ; Does veteran decline to provide income information?
 W !!
 D REF^EASECSCC I $D(DTOUT)!($D(DUOUT)) D Q G EN
 I $D(DGREF) D  D Q G EN
 .; Ask if veteran agrees to pay copayments; complete LTC copay test
 .D AGREE^EASECSCC Q:$D(DTOUT)!($D(DUOUT))
 .S DGSTA="NON-EXEMPT",DGCAT="T" D STA^DGMTSCU2 S (DGINT,DGDET,DGNWT)=""
 .D UPD^EASECSCC
 ; Go to LTC co-pay test (1010-EC) input screens
 S DGMTACT="ADD",DGMTROU="EN^EASECA" G EN^EASECSC
 ;
Q K DA,DFN,DGADDF,DGBL,DGCAT,DGEXMPT,DGFL,DGFLD,DGIRO,DGLD,DGLDT,DGLDYR
 K DGMTACT,DGMTCOR,DGMTDT,DGMTI,DGMTROU,DGMTYPT,DGOUT,DGREQF,DGSTA
 K DGTTYP,DGVI,DGVO,DTOUT,DUOUT,X,X1,X2,Y
 Q
 ;
ADD ;Add LTC Copay test
 ; Input  -- DFN     Patient IEN
 ;           DGMTDT  Date
 ;           DGMTYPT Type of Test 3 = LTC Copay
 ; Output -- DGMTI   Annual LTC Copay Test IEN
 N DA,DD,DIC,DIK,DINUM,DLAYGO,DO,DS,X,D0,DGSITE
 ;
 S X=DGMTDT,(DIC,DIK)="^DGMT(408.31,",DIC(0)="L",DLAYGO=408.31
 S DGSITE=$$GETSITE^DGMTU4(.DUZ)
 ; For LTC IV (EAS*1*40) - set 1010EC Form field (#2.1) = 1
 S DIC("DR")=".02////"_DFN_";.019////"_DGMTYPT_";.23////1;2.05////"_DGSITE_";2.1////1"
 K DD,D0
 D FILE^DICN S DGMTI=+Y
ADDQ Q
 ;
DEL ;Delete incomplete LTC Copay test
 ; Input   -- DGMTI  LTC Copay test IEN
 N DA,DIK
 Q:'$G(DGMTI)  Q:$P($G(^DGMT(408.31,DGMTI,0)),U,19)'=3
 S DA=DGMTI,DIK="^DGMT(408.31,"
 D ^DIK
 Q
