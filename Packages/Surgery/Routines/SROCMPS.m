SROCMPS ;BIR/MAM - ENTER/EDIT OCCURRENCES ;06/17/04  6:55 AM
 ;;3.0; Surgery ;**14,32,38,95,102,116,125,142**;24 Jun 93
INTRA S SRTYPE=10,SRTY="INTRAOPERATIVE",SRTYPDD="130.13A"
POST I '$D(SRTYPE) S SRTYPE=16,SRTY="POSTOPERATIVE",SRTYPDD="130.22A"
 W @IOF,! S SRSOUT=0 I '$D(SRTN) S SRTN1=1 D ^SROPS I '$D(SRTN) S SRSOUT=1 G END
 D SRA^SROES
 S SRSUPCPT=1 D ^SROAUTL S SRNAME=$P(VADM(1),"^")_"  ("_VA("PID")_")",SRLINE="" F I=0:1:79 S SRLINE=SRLINE_"-"
EDIT G:SRSOUT END K SRCOMP S SRNEW=0
 I '$O(^SRF(SRTN,SRTYPE,0)) D NEW G:SRSOUT END D ^SROCMPED G EDIT
 D HDR^SROAUTL W "Enter/Edit "_$S(SRTYPE=10:"Intraoperative",1:"Postoperative")_" Occurrences",! S (COMP,CNT)=0 F  S COMP=$O(^SRF(SRTN,SRTYPE,COMP)) Q:'COMP  D LIST
SEL W !,"Select a number ("_$S(CNT=1:1,1:"1-"_CNT)_"), or type 'NEW' to enter another occurrence: " R X:DTIME I '$T!("^"[X) S SRSOUT=1 G END
 K SRENTRY I $E(X)="N"!($E(X)="n") D NEW G:SRSOUT END D ^SROCMPED G EDIT
 I '$D(SRCOMP(X)) W !!,"Select the number corresponding to the occurrence you want to update, or",!,"enter 'NEW' to add another occurrence. ",!!,"Press RETURN to continue  " R X:DTIME G EDIT
 S:'$D(SRENTRY) SRENTRY=$P(SRCOMP(X),"^",3) D ^SROCMPED G EDIT
 Q
END D:$D(SRTN) EN^SROCCAT,EXIT^SROES I $D(SRTN1) K SRTN,SRTN1
 I 'SRSOUT W !!,"Press RETURN to continue  " R X:DTIME
 D:'$D(SROVER) ^SRSKILL W @IOF
 Q
LIST ; list existing occurrences
 S CNT=CNT+1,SRC(0)=^SRF(SRTN,SRTYPE,COMP,0),SRCMP=$P(SRC(0),"^"),SRCAT=$P(SRC(0),"^",2),SRCAT=$S(SRCAT:$P(^SRO(136.5,SRCAT,0),"^"),1:"NOT ENTERED"),SRCOMP(CNT)=SRCMP_"^"_SRCAT_"^"_COMP
 W !,CNT_".  ",?5,SRCMP,!,?5,"Category: "_SRCAT,!
 Q
NEW ; enter new occurrences
 D HDR^SROAUTL W ! I '$O(^SRF(SRTN,SRTYPE,0)) W !,"There are no "_$S(SRTYPE=10:"Intraoperative",1:"Postoperative")_" Occurrences entered for this case.",!!
 K DIR,X S SRDD=$S(SRTYPE=10:130.13,1:130.22),DIR(0)=SRDD_","_$S(SRTYPE=10:3,1:5)_"O",DIR("A")="Enter a New "_$S(SRTYPE=10:"Intraoperative",1:"Postoperative")_" Occurrence" D ^DIR I $D(DUOUT)!(Y="") S SRSOUT=1 Q
 K SRCOM,SRPOINT S SRPOINT=+Y,SRCOM=$P(Y,"^",2),SRNEW=1 D PRESS
 S SRICD="" I SRCOM["OTHER" D ICD I SRSOUT Q
 I '$D(^SRF(SRTN,SRTYPE,0)) S ^SRF(SRTN,SRTYPE,0)="^"_SRTYPDD_"^^"
 K DD,DA,DO,DIC,DINUM S X=SRCOM,DIC(0)="L",DLAYGO=SRDD,DA(1)=SRTN,DIC="^SRF("_SRTN_","_SRTYPE_"," D FILE^DICN S SRENTRY=+Y
 S $P(^SRF(SRTN,SRTYPE,+Y,0),"^",2)=SRPOINT,$P(^SRF(SRTN,SRTYPE,+Y,0),"^",3)=SRICD
 Q
ICD W !!,"Since you have selected one of the 'OTHER' occurrence categories, an ICD",!,"Diagnosis Code should be entered for this occurrence."
 S DIR(0)=$S(SRTY="INTRAOPERATIVE":"130.13,4",1:"130.22,6"),DIR("A")="Select ICD Diagnosis Code" D ^DIR K DIR I $D(DUOUT) Q
 I +Y>0 S SRICD=+Y,SRCOM=$P($$ICDC^SROICD(+Y),"^",3)
 Q
DESC ; output occurrence category description when doing lookup
 N SRX,SRY,SRZ
 S SRX=0,SRY=Y F  S SRX=$O(^SRO(136.5,SRY,1,SRX)) Q:'SRX  S SRZ(SRX)=^SRO(136.5,SRY,1,SRX,0),SRZ(SRX,"F")="!?2"
 I $O(SRZ(0)) D EN^DDIOL(.SRZ)
 D EN^DDIOL(" ","","!")
 Q
PRESS K DIR W ! S DIR(0)="FOA",DIR("A")="Press RETURN to continue: " D ^DIR K DIR I $D(DTOUT) S SRSOUT=1
 Q
CO() ; called by screen on post-op occurrence category field
 N SRSCR,SRTYPE,SRX S SRSCR="I '$P(^(0),U,2)" D  Q SRSCR
 .S SRX=$S($D(SRTN):SRTN,$D(DA(1)):DA(1),1:"") Q:'SRX
 .S SRTYPE=$P($G(^SRF(SRX,"RA")),U,2)
 .I SRTYPE'=""&(SRTYPE'="C") S SRSCR=SRSCR_"&($P(^(0),U,4)'="_"""Y"""_")"
 Q
