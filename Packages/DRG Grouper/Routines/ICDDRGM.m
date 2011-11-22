ICDDRGM ;ALB/GRR/EG/ADL - GROUPER DRIVER ; 10/23/00 11:45am
 ;;18.0;DRG Grouper;**7,36**;Oct 20, 2000;Build 14
 ;;ADL;Add Date prompt and passing of effective date for DRG CSV project
 ;;ADL;Update DIC("S") code to screen using new function calls
 ;;ADL;Update to access DRG file using new API for CSV Project
 S U="^",DT=$$DT^XLFDT W !!?11,"DRG Grouper    Version ","18.0",!! ;$$VERSION^XPDUTL("ICD"),!!
PAT D KILL ; clean up old variables
 S ICDQU=0 K ICDEXP,SEX,ICDDX,ICDSURG
 D EFFDATE G KILL:$D(DUOUT),OUT:$D(DTOUT)
 S DIR(0)="Y",DIR("A")="DRGs for Registered PATIENTS  (Y/N)",DIR("B")="YES"
 S DIR("?")="Enter 'Yes' if the patient has been previously registered, enter 'No' for other patient, or '^' to quit."
 D ^DIR K DIR S ICDPT=Y G KILL:$D(DUOUT),OUT:$D(DTOUT)
PAT0 G:ICDPT=0 ASK
VA S DIC="^DPT(",DIC(0)="AEQMZ" D ^DIC G Q:X=""!(X[U)!(Y'>0),OUT:$D(DTOUT) S DFN=+Y,(DOB,AGE)=$P(Y(0),U,3),SEX=$P(Y(0),U,2)
 D TAC G:ICDQU PAT D DAM G:ICDQU PAT
EN1 I $D(^DPT(DFN,.35)),$L(^DPT(DFN,.35)) D ALIVE G:ICDQU PAT
 S ICDEXP=$S($D(ICDEXP):ICDEXP,1:0)
 I AGE]"" N %,X,X1,X2 S X1=DT,X2=AGE D ^%DTC S AGE=X\365.25 W "  AGE: ",AGE
CD K DIC S CC=0,DIC="^ICD9(",DIC(0)="AEQMZ",DIC("A")="Enter Primary diagnosis: " D  D ^DIC K DIC G Q:X=""!(X[U)!(Y'>0),OUT:$D(DTOUT) S ICDDX(1)=+Y
 . S DIC("S")="I '$P($$ICDDX^ICDCODE(+Y,ICDDATE),U,5),$$ISVALID^ICDGTDRG(+Y,ICDDATE,9)"
 F ICDNSD=2:1 S DIC="^ICD9(",DIC(0)="AEQMZ",DIC("A")="Enter SECONDARY diagnosis: ",DIC("S")="I $$ISVALID^ICDGTDRG(+Y,ICDDATE,9)" D ^DIC K DIC Q:X=""!(X[U)!(Y'>0)  G:$D(DTOUT) OUT S ICDDX(ICDNSD)=+Y
 G Q:X[U
OP S DIC("S")="I $$ISVALID^ICDGTDRG(+Y,ICDDATE,0)" K ICDPRC
 W ! F ICDNOR=1:1 S DIC="^ICD0(",DIC(0)="AEQMZ",DIC("A")="Enter Operation/Procedure: " D ^DIC Q:X=""!(X[U)!(Y'>0)  G:$D(DTOUT) OUT S ICDPRC(ICDNOR)=+Y,ICDSURG(ICDNOR)=X
 K DIC G Q:X["^"
 D ^ICDDRG
 D WRT G PAT0
WRT S ICDDRG(0)=$$DRG^ICDGTDRG(+ICDDRG,ICDDATE)  ;  new CSV code
 W !!?9,"Effective Date: ","   ",ICDDSP
 W !,"Diagnosis Related Group: ",$J(ICDDRG,6),?40,"Avg len of stay: ",$J($P(ICDDRG(0),"^",8),6)
 W !?17,"Weight: ",$J($P(ICDDRG(0),"^",2),6),?40,"Local Breakeven: ",$J($P(ICDDRG(0),"^",12),6)
 W !?12," Low day(s): ",$J($P(ICDDRG(0),"^",3),6),?39,"Local low day(s): ",$J($P(ICDDRG(0),"^",9),6)
 W !?13," High days: ",$J($P(ICDDRG(0),"^",4),6),?40,"Local High days: ",$J($P(ICDDRG(0),"^",10),6)
 ;W !!,"DRG: ",ICDDRG,"-" F I=0:0 S I=$N(^ICD(ICDDRG,1,I)) Q:I'>0  W ?10,$P(^(I,0),U,1),!
 ;W !!,"DRG: ",ICDDRG,"-" F I=0:0 S I=$O(^ICD(ICDDRG,1,I)) Q:(I="")!(I'?.N)  W ?10,$P(^(I,0),U,1),!
 N ICDXD,ICDGDX,ICDGI
 S ICDXD=$$DRGD^ICDGTDRG(ICDDRG,"ICDGDX",,ICDDATE),ICDGI=0
 W !!,"DRG: ",ICDDRG,"-" F  S ICDGI=$O(ICDGDX(ICDGI)) Q:'+ICDGI  Q:ICDGDX(ICDGI)=" "  W ?10,ICDGDX(ICDGI),!
 Q
ERROR D WRT
 I ICDRTC<5 W !!,"Invalid ",$S(ICDRTC=1:"Principal Diagnosis",ICDRTC=2:"Operation/Procedure",ICDRTC=3:"Age",ICDRTC=4:"Sex",1:"") G PAT0
 I ICDRTC=5 W !!,"Grouper needs to know if patient died during this episode!" G PAT0
 I ICDRTC=6 W !!,"Grouper needs to know if patient was transferred to an acute care facility!" G PAT0
 I ICDRTC=7 W !!,"Grouper needs to know if patient was discharged against medical advice!" G PAT0
 I ICDRTC=8 W !!,"Patient assigned newborn diagnosis code.  Check diagnosis!" G PAT0
 G PAT0
KILL K DIC,DFN,DUOUT,DTOUT,ICDNOR,ICDDX,ICDPRC,ICDEXP,ICDTRS,ICDDMS,ICDDRG,ICDMDC,ICDO24,ICDP24,ICDP25,ICDRTC,ICDPT,ICDQU,ICDNSD,ICDNMDC
 K ICDMAJ,ICDS25,ICDSEX,AGE,DOB,CC,HICDRG,ICD,ICDCC3,ICDJ,ICDJJ,ICDL39,ICDFZ,ICDDT,ICDDSP
 Q
Q G PAT
AGE S DIR(0)="NOA^0:124:0",DIR("A")="Patient's age: ",DIR("?")="Enter how old the patient is (0-124)." D ^DIR K DIR S AGE=Y G QQ:$D(DUOUT),OUT:$D(DTOUT)
 Q
ALIVE S DIR(0)="YO",DIR("A")="Did patient die during this episode" D ^DIR K DIR S ICDEXP=Y G QQ:$D(DUOUT),OUT:$D(DTOUT)
 Q
TAC S DIR(0)="YO",DIR("A")="Was patient transferred to an acute care facility" D ^DIR K DIR S ICDTRS=Y G QQ:$D(DUOUT),OUT:$D(DTOUT)
 Q
DAM S DIR(0)="YO",DIR("A")="Was patient discharged against medical advice" D ^DIR K DIR S ICDDMS=Y G QQ:$D(DUOUT),OUT:$D(DTOUT)
 Q
SEX S DIR(0)="SBO^M:MALE;F:FEMALE",DIR("?")="Enter M for Male and F for Female",DIR("A")="Patient's Sex" D ^DIR K DIR S SEX=Y G QQ:$D(DUOUT),OUT:$D(DTOUT)
 Q
QQ S ICDQU=1 Q
EFFDATE ;prompts for effective date for DRG grouper?
 K DIR S DIR(0)="D^::AEX",DIR("B")="TODAY",DIR("A")="Effective Date"
 S DIR("?")="The effective to be used when calculating the DRG code for the patient."
 D ^DIR K DIR I $D(DIRUT) S QUIT=1 Q
 S ICDDATE=Y,ICDDSP=Y(0)
 Q
ASK K DTOUT,DUOUT D AGE G:ICDQU PAT D ALIVE G:ICDQU PAT D TAC G:ICDQU PAT D DAM G:ICDQU PAT D SEX G:ICDQU PAT G CD
OUT G H^XUS
