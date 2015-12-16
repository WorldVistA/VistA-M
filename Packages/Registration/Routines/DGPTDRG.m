DGPTDRG ;ALB/ABS,HIOFO/FT - DRG Information Report User Prompts ;07/01/2015  11:21 AM
 ;;5.3;Registration;**60,441,510,559,599,606,669,729,850,884**;Aug 13, 1993;Build 31
 ;;ADL;Update for CSV Project;;Mar 28, 2003
 ;
 ; %ZIS APIs - #10086
 ;
 ; called by entry action of DRG Information Report [DG PTF DRG INFORMATION OUTPUT] DGPTODR=1
 ; called by DRG Calculation [DG DRG CALCULATION]
 ;
 S U="^" D Q,DT^DICRW
PAT ;
 D EFFDATE G Q:$D(DUOUT),Q:$D(DTOUT)
 W !!,"Choose Patient from PATIENT file" S %=1 D YN^DICN G Q:%=-1
 I %Y["?"!('%) W !?3,"Enter <RET> for YES if you want DRGs for a patient from your PATIENT File",!?3,"Answer 'N' for NO if you want DRGs for a hypothetical patient" G PAT
 S DGPTHOW=% I %=2 S NAME="" G AGE
 N DOB
 S DIC="^DPT(",DIC(0)="AEQMZ"
 W ! D ^DIC G Q:Y'>0
 S DFN=+Y,NAME=$P(Y(0),"^"),(DOB,AGE)=$P(Y(0),U,3),SEX=$P(Y(0),U,2)
 S X1=DT,X2=AGE D ^%DTC S AGE=X\365.25 W "  AGE:",AGE
 ; -- is patient Expired
 S DGEXP=$S($D(^DPT(DFN,.35))#2:1,1:0) I DGEXP,'$P(^(.35),"^") S DGEXP=0
 G EXP:DGEXP,TRS
 ;
AGE ;
 R !!,"Patient's AGE: ",AGE:DTIME
 G Q:AGE["^"!('$T)
 S:AGE<0!(AGE="")!(AGE>124)!(AGE'?.N) AGE="?"
 I AGE["?" W !,"Enter a number for patient's age in years (0-124)" G AGE
 ;
SEX ;
 R !!,"Patient's SEX: MALE// ",X:DTIME G Q:X["^"!('$T)
 S Z="^MALE^FEMALE" I X="" S X="M" W X
 D IN^DGHELP I %=-1 W !?3,"Enter <RET> for MALE if hypothetical patient is male",!?3,"Enter 'F' for Female" G SEX
 S SEX=$E(X)
 ;
EXP ;
 W !!,"Did patient die during this episode" S %=2 D YN^DICN G Q:%=-1
 I %Y["?"!('%) W !?3,"Enter <RET> for NO if patient did not die during the hospital",!?15,"stay for which this DRG is to be calculated",!?3,"Enter 'Y' for YES" G EXP
 S DGEXP=$S(%=1:1,1:0) I DGEXP S (DGTRS,DGDMS)=0 G DX
 ;
TRS W !!,"Transfer to an acute care facility" S %=2 D YN^DICN G Q:%=-1
 I %Y["?"!('%) W !?3,"Enter <RET> for NO if patient not transfered to an acute care facility",!?3,"Enter 'Y' for YES if patient was transfered to acute care facility" G TRS
 S DGTRS=$S(%=1:1,1:0)
 ;
DMS ;
 W !!,"Discharged against medical advice" S %=2 D YN^DICN G Q:%=-1 I %Y["?"!('%) W !?3,"Enter <RET> for NO if patient did not leave against medical advice",!?3,"Enter 'Y' for YES if patient did leave against medical advice",!,*7 G DMS
 S DGDMS=$S(%=1:1,1:0)
 ;
DX ;
 N DXINF,ICDVDT
 K X,Y
 ;
 ; What terminology to use, ICD9 or ICD10
 I DGDAT<IMPDATE S DGTERMIN="ICD"
 I DGDAT'<IMPDATE S DGTERMIN="10D"
 ;
 W !
 S (DGDX,DGSURG)="" S PROMPT="Enter PRINCIPAL diagnosis "_$$DISP()_": "
 ;D ICDEN1^DGPTF5
 S CODESET=$S(DGTERMIN="ICD":9,1:10) D DIAG^DGPTFIC
 Q:$G(X)["^"!($G(X)="")
 Q:$G(DTOUT)!$G(DUOUT)!$G(DIRUT)!$G(DIROUT)
 ;
 S DGPTTMP=Y ; -- ICDEN1^DGPTF5 returns Y=$$ICDDATA^ICDXCODE
 I $P(DGPTTMP,U,5) D  G DX
 . W !,*7,">>>You have selected diagnosis code that is not considered"
 . W !,"a primary diagnosis code.  Please enter a PRIMARY code."
 ;
 I '$P(DGPTTMP,U,10) D INAC G DX
 S:$P(DGPTTMP,U,10) DGDX=+Y,DGDX(1)=$P(DGPTTMP,"^",2)_"^"_$P(DGPTTMP,"^",4)
 ;S:DGTERMIN="10D" DGDXPOA=$$ASKPOA(0)
 S DGDXPOA=$S(DGTERMIN="10D":$$ASKPOA(0),1:"Y")
 ;
 S PROMPT="Enter SECONDARY diagnosis "_$$DISP()_": " W !
 F DGI=2:1:25 D DIAG^DGPTFIC Q:$G(X)["^"!($G(X)="")  D
 . S DGPTTMP=Y
 . I '$P(DGPTTMP,U,10) D INAC S DGI=DGI-1 Q
 . I +DGPTTMP>0&($P(DGPTTMP,U,10)) S DGDX=DGDX_"^"_+Y,DGDX(DGI)=$P(DGPTTMP,"^",2)_"^"_$P(DGPTTMP,"^",4)
 . S:DGTERMIN="10D" DGDXPOA=DGDXPOA_"^"_$$ASKPOA(DGI-1)
 . S:DGTERMIN="ICD" DGDXPOA=DGDXPOA_"^"_"Y"
 . W !
 ;
 G Q:$G(X)["^"
 S DIC(0)="AEQMZ",DIC("S")="I $$ISVALID^ICDGTDRG(+Y,DGDAT,80.1)"
 ;
 D OP
 ;
 I ($G(X)["^") G Q ; User exiting up front 
 I ($D(DGSURG)<10),$D(DTOUT)!($D(DUOUT))!($D(DIROUT)) G Q ;Continue to DRG calc unless user failed to finish.
 I $D(DGPTODR) S DGVAR="AGE^NAME^SEX^DGDMS^DGEXP^DGTRS^DGDX#^DGSURG#^DGDAT^DGDXPOA",DGPGM="^DGPTODR" W ! D ZIS^DGUTQ G:POP Q U IO D ^DGPTODR,CLOSE^DGUTQ,Q S DGPTODR=1 G PAT
 ;
 ;S DGDRGPRT=1 D ^DGPTICD,Q G PAT  ;return DRG code even if inactive
 D NEWOUT,Q G PAT
 ;
Q K DFN,DGI,DGPGM,AGE,NAME,DGDMS,DGDX,DGEXP,DGPTHOW,DGSURG,DGTRS,DGVAR,DGDRGPRT,DRG,DIC,SEX,POP,X,Y,Z,X1,X2,%,%Y
 K EFFDATE,IMPDATE,DGTERMIN,DGTEMP,ICDVDT,DGDXPOA,CODESET,PROMPT,TERM,DGENR,DGPTTMP
 K ICDDRG,ICDDX,ICDPOA,ICDPDRG,ICDSEX,ICDSYS,ICDTMP,ICDY
 Q
DISP() ; -- Return value to display
 Q $S(DGTERMIN="10D":"(ICD 10)",DGTERMIN="ICD":"(ICD 9)",1:"")
 ;
 ;
EFFDATE ;prompts for effective date for DRG grouper?
 K DIR S DIR(0)="D^::AEX",DIR("B")="TODAY",DIR("A")="Effective Date"
 S DIR("?")="The effective to be used when calculating the DRG code for the patient."
 D ^DIR K DIR I $D(DIRUT) S QUIT=1 Q
 S DGDAT=Y
 D EFFDAT1^DGPTIC10(DGDAT)
 Q
 ;
INAC ;
 W !,*7,">>> You have selected an INACTIVE diagnosis code."
 W !,"    This code is not used by the grouper and may cause"
 W !,"    the case to be grouped into DRG 470 - UNGROUPABLE.",!
 W !,"    Therefore, this diagnosis code will NOT be passed"
 W !,"    to the grouper. Please enter another code."
 Q
 ;
ASKPOA(CNT) ; -- asks POA for each Diagnosis
 N X,Y,DIR,DUOUT,DTOUT,DIRUT,DIROUT,DGPOA,DA
 S DIR(0)="45,82.01"
 S DIR("A")=$S(+$G(CNT)=0:"POA FOR PRINCIPAL diagnosis",1:"POA FOR SECONDARY diagnosis "_+$G(CNT))
 S DIR("B")="Y"
 D ^DIR K DIR
 S DGPOA=$$POA^DGPTFD(Y)
 Q DGPOA
 ;
OP() ; -- asks Operation Procedure code.
 N DIR,DUOUT,DTOUT,DIRUT,DIROUT,DGPOA,DA,DGI,PROMPT,TERM
 S TERM="PROC"
 W !
 I $G(DGDAT)="" S DGDAT=DT
 S DGI=1
 S PROMPT="Enter Operation/Procedure "_$$DISP()_": "
 S DGDRGDT=DGDAT
 F DGI=1:1:25 D PROC^DGPTFIC Q:$G(X)["^"!($G(X)="")  D
 . I +Y>0,($P(Y,U,10)'=0) S DGSURG=+Y_"^"_$G(DGSURG)
 . S:$P(Y,U,10)'=0 DGSURG(DGI)=$P(Y,U,2)_U_$P(Y,U,5)
 ; added next line for DG*5.3*441
 S DGSURG=U_$G(DGSURG)
 Q
NEWOUT ;
 D HOME^%ZIS
 S DGTMP=DGDX,DGDRGPRT=1,(DGPG,DGQ)=0,$P(DGLN,"=",81)="" D HDR
 D ^DGPTICD ;S DGDX=$P(DGDX,"^",2,99)_"^"_$P(DGDX,"^")
 W !!
 ;D CONT:$E(IOST,1,2)="C-"
Q2 K AGE,NAME,SEX,DGDMS,DGDRGPRT,DGDX,DGEXP,DGSURG,DGTRS,DGLN,DGPG,DGQ,DGTMP,DGX,DGPTODR,I,Y
 Q
 ;
HDR ;print heading
 S DGPG=$G(DGPG)+1 W:$Y>0 @IOF,"DRG Calculation",?45,"Date: " S Y=DT X ^DD("DD") W Y,"  Page: ",DGPG,!!
 S Y=DGDAT D DD^%DT ; Y = external format of effective date
 W "Effective Date: ",Y,! I NAME]"" W "Patient: ",NAME,?40
 W "Sex: ",$S(SEX="M":"Male",1:"Female"),?61,"Age: ",AGE,!,"Expired: ",$S(DGEXP:"Yes",1:"No"),?18,"Transferred to Acute Care: ",$S(DGTRS:"Yes",1:"No"),?55,"Irreg D/C: ",$S(DGDMS:"Yes",1:"No")
 W !!,"Diagnosis Codes:"
 F I=0:0 S I=$O(DGDX(I)) Q:I'>0  W !,$J($P(DGDX(I),"^"),8),"  ",$P(DGDX(I),"^",2) I $G(DGDXPOA)'="" D
 . W:DGTERMIN="10D" "  (POA="_$P(DGDXPOA,"^",I)_")"
 ;
 I $D(DGSURG) W !!,"Operation/Procedure Codes:" F I=0:0 S I=$O(DGSURG(I)) Q:I'>0  W !,$J($P(DGSURG(I),"^"),8),"  ",$P(DGSURG(I),"^",2)
 Q
CONT I $Y+8>IOSL R !!?20,"Press <RET> to continue or ""^"" to EXIT ",DGQ:DTIME S:'$T DGQ="^" Q:DGQ["^"
 Q
