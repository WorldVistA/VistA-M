DGPTDRG ;ALB/ABS - DRG Information Report User Prompts ; 11/15/06 8:31am
 ;;5.3;Registration;**60,441,510,559,599,606,669,729**;Aug 13, 1993;Build 59
 ;;ADL;Update for CSV Project;;Mar 28, 2003
 S U="^" D Q,DT^DICRW
PAT D EFFDATE G Q:$D(DUOUT),Q:$D(DTOUT)
 W !!,"Choose Patient from PATIENT file" S %=1 D YN^DICN G Q:%=-1
 I %Y["?"!('%) W !?3,"Enter <RET> for YES if you want DRGs for a patient from your PATIENT File",!?3,"Answer 'N' for NO if you want DRGs for a hypothetical patient" G PAT
 S DGPTHOW=% I %=2 S NAME="" G AGE
 N DOB S DIC="^DPT(",DIC(0)="AEQMZ" W ! D ^DIC G Q:Y'>0 S DFN=+Y,NAME=$P(Y(0),"^"),(DOB,AGE)=$P(Y(0),U,3),SEX=$P(Y(0),U,2),X1=DT,X2=AGE D ^%DTC S AGE=X\365.25 W "  AGE:",AGE
 ;I AGE<0!(AGE>124) W !,"Unacceptable AGE",!,"Grouper accepts age values from 0-124 years.",!,"Verify patient's age in PATIENT File before continuing." G Q
 S DGEXP=$S($D(^DPT(DFN,.35))#2:1,1:0) I DGEXP,'$P(^(.35),"^") S DGEXP=0
 G EXP:DGEXP,TRS
AGE R !!,"Patient's AGE: ",AGE:DTIME G Q:AGE["^"!('$T) S:AGE<0!(AGE="")!(AGE>124)!(AGE'?.N) AGE="?" I AGE["?" W !,"Enter a number for patient's age in years (0-124)" G AGE
SEX R !!,"Patient's SEX: MALE// ",X:DTIME G Q:X["^"!('$T) S Z="^MALE^FEMALE" I X="" S X="M" W X
 D IN^DGHELP I %=-1 W !?3,"Enter <RET> for MALE if hypothetical patient is male",!?3,"Enter 'F' for Female" G SEX
 S SEX=$E(X)
EXP W !!,"Did patient die during this episode" S %=2 D YN^DICN G Q:%=-1 I %Y["?"!('%) W !?3,"Enter <RET> for NO if patient did not die during the hospital",!?15,"stay for which this DRG is to be calculated",!?3,"Enter 'Y' for YES" G EXP
 S DGEXP=$S(%=1:1,1:0) I DGEXP S (DGTRS,DGDMS)=0 G DX
TRS W !!,"Transfer to an acute care facility" S %=2 D YN^DICN G Q:%=-1 I %Y["?"!('%) W !?3,"Enter <RET> for NO if patient not transfered to an acute care facility",!?3,"Enter 'Y' for YES if patient was transfered to acute care facility" G TRS
 S DGTRS=$S(%=1:1,1:0)
DMS W !!,"Discharged against medical advice" S %=2 D YN^DICN G Q:%=-1 I %Y["?"!('%) W !?3,"Enter <RET> for NO if patient did not leave against medical advice",!?3,"Enter 'Y' for YES if patient did leave against medical advice",!,*7 G DMS
 S DGDMS=$S(%=1:1,1:0)
DX N DXINF,ICDVDT S ICDVDT=DGDAT
 S (DGDX,DGSURG)="" S PROMPT="Enter PRINCIPAL diagnosis: "
 D ICDEN1^DGPTF5
 Q:X["^"!(X="")
 S Y=+$$CODEN^ICDCODE(X,80)
 I $P($$ICDDX^ICDCODE(Y,DGDAT),U,5) D  G DX
 . W !,*7,">>>You have selected diagnosis code that is not considered"
 . W !,"a primary diagnosis code.  Please enter a PRIMARY code."
 S DGPTTMP=$$ICDDX^ICDCODE(+Y,DGDAT) S:$P(DGPTTMP,U,10) DGDX=+Y,DXINF=$$ICDDX^ICDCODE(+Y,DGDAT),DGDX(1)=$P(DXINF,"^",2)_"^"_$P(DXINF,"^",4) I '$$ISVALID^ICDGTDRG(+Y,DGDAT,9) D INAC G DX
 S PROMPT="Enter SECONDARY diagnosis: " W !
 F DGI=2:1:5 D ICDEN1^DGPTF5 Q:X["^"!(X="")  S Y=+$$CODEN^ICDCODE(X,80) I +Y>0 S DGPTTMP=$$ICDDX^ICDCODE(+Y,DGDAT) S:DGPTTMP>0&($P(DGPTTMP,U,10)) DGDX=DGDX_"^"_+Y,DXINF=$$ICDDX^ICDCODE(+Y,DGDAT),DGDX(DGI)=$P(DXINF,"^",2)_"^"_$P(DXINF,"^",4) D
 . I '$P(DGPTTMP,U,10) D INAC S DGI=DGI-1
 G Q:X["^" S DIC(0)="AEQMZ",DIC("S")="I $$ISVALID^ICDGTDRG(+Y,DGDAT,0)",DIC="^ICD0(",DIC("A")="Enter Operation/Procedure: " W !
 F DGI=1:1:4 D ^DIC Q:X["^"!(X="")  I +Y>0 S DGSURG=+Y_"^"_DGSURG,DXINF=$$ICDOP^ICDCODE(+Y,DGDAT),DGSURG(DGI)=$P(DXINF,U,2)_U_$P(DXINF,U,5)
 ; added next line for DG*5.3*441
 S DGSURG=U_DGSURG
 G Q:X["^" I $D(DGPTODR) S DGVAR="AGE^NAME^SEX^DGDMS^DGEXP^DGTRS^DGDX#^DGSURG#^DGDAT",DGPGM="^DGPTODR" W ! D ZIS^DGUTQ G:POP Q U IO D ^DGPTODR,CLOSE^DGUTQ,Q S DGPTODR=1 G PAT
 S DGDRGPRT=1 D ^DGPTICD,Q G PAT  ;return DRG code even if inactive
Q K DFN,DGI,DGPGM,AGE,NAME,DGDMS,DGDX,DGEXP,DGPTHOW,DGSURG,DGTRS,DGVAR,DGDRGPRT,DRG,DIC,SEX,POP,X,Y,Z,X1,X2,%,%Y Q
 ;
EFFDATE ;prompts for effective date for DRG grouper?
 K DIR S DIR(0)="D^::AEX",DIR("B")="TODAY",DIR("A")="Effective Date"
 S DIR("?")="The effective to be used when calculating the DRG code for the patient."
 D ^DIR K DIR I $D(DIRUT) S QUIT=1 Q
 S DGDAT=Y
 Q
INAC ;
 W !,*7,">>> You have selected an INACTIVE diagnosis code."
 W !,"    This code is not used by the grouper and may cause"
 W !,"    the case to be grouped into DRG 470 - UNGROUPABLE.",!
 W !,"    Therefore, this diagnosis code will NOT be passed"
 W !,"    to the grouper. Please enter another code."
