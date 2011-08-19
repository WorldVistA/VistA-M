DGMTEO ;ALB/RMO,CAW,LD,TDM - Other Means Test Edit Options ; 8/2/02 11:14am
 ;;5.3;Registration;**33,45,182,456**;Aug 13, 1993
 ;
ADJ ;Entry point to adjudicate a means test
 N PADISP
 S DIC="^DPT(",DIC(0)="AEMQ"
 I DGMTYPT=1 S DIC("S")="I $P(^(0),U,14)=2"
 I DGMTYPT=2 S DIC("S")="I $D(^DGMT(408.31,""AID"",DGMTYPT,+Y))"
 W ! D ^DIC K DIC G ADJQ:Y<0 S DFN=+Y
 S DGMTI=+$$LST^DGMTU(DFN,"",DGMTYPT),DGMTS=$P($G(^DGMT(408.31,DGMTI,0)),"^",3)
 I "^2^11^"'[("^"_DGMTS_"^") W !?3,*7,"Last means test is not PENDING ADJUDICATION." G ADJ
 ;
 S PADISP=$$PA^DGMTUTL(DGMTI) S:PADISP="" PADISP="UNKNOWN"
 W !!,"=============================================="
 W !,?3,"Patient pending adjudication for ",PADISP,"."
 W !,"=============================================="
 ;
 S DGMTACT="ADJ" D PRIOR^DGMTEVT
 S DA=DGMTI,DIE="^DGMT(408.31,",DR="[DGMT ENTER/EDIT ADJUDICATION]" W ! D ^DIE K DA,DIE,DR
 D AFTER^DGMTEVT S DGMTINF=0 D EN^DGMTEVT
 ;
 ;Update the TEST-DETERMINED STATUS field (#2.03) in the Annual Means
 ;TEST file (#408.31) when adjudicating a means test.
 D SAVESTAT^DGMTU4(DGMTI)
 G ADJ
ADJQ K DFN,DGMTA,DGMTACT,DGMTI,DGMTINF,DGMTP,DGMTS,DGMTYPT,Y
 Q
 ;
COM ;Entry point to complete a required means test
 S DIC="^DPT(",DIC(0)="AEMQ",DIC("S")="I $P(^(0),U,14)=1" W ! D ^DIC K DIC G COMQ:Y<0 S DFN=+Y
 S DGMTI=+$$LST^DGMTU(DFN),DGMT0=$G(^DGMT(408.31,DGMTI,0)),DGMTDT=$P(DGMT0,"^")
 I $P(DGMT0,"^",3)'=1 W !?3,*7,"Last means test is not REQUIRED." G COM
 S DGMTYPT=1,DGMTACT="COM",DGMTROU="COM^DGMTEO" G EN^DGMTSC
COMQ K DFN,DGMT0,DGMTACT,DGMTDT,DGMTI,DGMTROU,DGMTYPT,Y
 Q
 ;
CAT ;Entry point to change a patient's means test category
 ;
 ;no longer allowed to do this - instead, must enter a hardship or
 ;net-worth adjudication
 Q
 ;
 S DIC="^DPT(",DIC(0)="AEMQ",DIC("S")="I ""^1^3^""'[(U_$P(^(0),U,14)_U)" W ! D ^DIC K DIC G CATQ:Y<0 S DFN=+Y
 S DGMTI=+$$LST^DGMTU(DFN),DGMTS=$P($G(^DGMT(408.31,DGMTI,0)),"^",3)
 I 'DGMTS W !?3,*7,"No means test to change." G CAT
 S DGMTACT="CAT" D PRIOR^DGMTEVT
 I $G(DGMTP) D
 .W !!,"MEANS TEST DATE: ",$$DATE^DGMTOREQ($P(DGMTP,U)),?44,"SOURCE OF TEST: ",$$SR^DGMTAUD1(DGMTP),!
 .I $P($G(^DG(408.34,+$P(DGMTP,U,23),0)),U)="VAMC",($P($G(^DG(408.32,+$P(DGMTP,U,3),0)),U)="CATEGORY A") D
 ..F I=1:1 S J=$P($T(CATTXT+I),";;",2) Q:J="END"  W !,J
 S DA=DGMTI,DIE="^DGMT(408.31,",DR="[DGMT ENTER/EDIT CATEGORY]" W ! D ^DIE K DA,DIE,DR
 S DGMTYPT=1 D AFTER^DGMTEVT S DGMTINF=0 D EN^DGMTEVT,CATQ G CAT
CATQ K DFN,DGMTA,DGMTACT,DGMTDT,DGMTI,DGMTINF,DGMTP,DGMTS,DGMTYPT,I,J,Y
 Q
CATTXT ;
 ;;NOTE:  VAMC Category A means tests can be changed to another 
 ;;       category by editing the patient's means test data through
 ;;       the 'Edit an Existing Means Test' option ONLY.
 ;;END
