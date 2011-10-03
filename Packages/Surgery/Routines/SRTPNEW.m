SRTPNEW ;BIR/SJA - CREATE NEW RISK ASSESSMENT ;02/14/08
 ;;3.0; Surgery ;**167**;24 Jun 93;Build 27
 D NEW G:SRSOUT END I SRVA="N" D ADD Q
START W @IOF,!,?1,VADM(1)_"  "_VA("PID")
 W !!! S (SRDT,CNT)=0 F I=0:0 S SRDT=$O(^SRF("ADT",DFN,SRDT)) Q:'SRDT!(SRSOUT)  S SRASS=0 F I=0:0 S SRASS=$O(^SRF("ADT",DFN,SRDT,SRASS)) Q:'SRASS!($D(SRTN))!(SRSOUT)  D LIST I $D(SRTN) G ASK
 I 'CNT W "No operations exist for this patient.  Assessment cannot be entered.",!!,"Press RETURN to continue... " R X:DTIME G END
OPT W !!,"Select Operation: " R X:DTIME I '$T!("^"[X) S SRSOUT=1 G END
 I '$D(SRCASE(X)) W !!,"Enter the number of the desired operation" W $S('$D(SRNEWOP):".",1:", or '"_CNT_"' to enter a new case.") G OPT
 S SRTN=+SRCASE(X)
ASK W !!,"Sure you want "_$S($D(SRCHG):"to assign this Surgical case to the Transplant Assessment? YES//",1:"to create a Transplant Assessment for this surgical case? YES//") R SRYN:DTIME I '$T!(SRYN["^") K SRTN S SRSOUT=1 Q
 S SRYN=$E(SRYN) I "YyNn"'[SRYN W !!,"Enter 'YES' to create an assessment for this surgical case, or 'NO' to quit",!,"this option." G ASK
 I "Yy"'[SRYN K SRTN S SRSOUT=1 Q
 S:SRVA="V" SRTPDT=$P($P(^SRF(SRTN,0),"^",9),".")
 I '$D(SRCHG) D VACO Q:SRSOUT  D ADD
 Q
LIST ; list assessments
 I $P($G(^SRF(SRASS,"NON")),"^")="Y" Q
 S SRSCAN=1 I $D(^SRF(SRASS,.2)),$P(^(.2),"^",12)'="" K SRSCAN
 I $D(SRSCAN),$P($G(^SRF(SRASS,30)),"^") Q
 I $D(SRSCAN),$P($G(^SRF(SRASS,31)),"^",8) Q
 I $D(^SRF(SRASS,37)),$P(^(37),"^") Q
 I '$P($G(^SRF(SRASS,.2)),"^",12) Q
 I $Y+5>IOSL S SRBACK=0 D SEL Q:$D(SRTN)!(SRSOUT)  I SRBACK S CNT=0,SRASS=SRCASE(1)-1,SRDT=$P(SRCASE(1),"^",2) W @IOF,!,?1,VADM(1)_"   "_VA("PID"),! Q
 S CNT=CNT+1,SRSDATE=$P(^SRF(SRASS,0),"^",9)
DISP S SROPER=$P(^SRF(SRASS,"OP"),"^") I $O(^SRF(SRASS,13,0)) S SROTHER=0 F I=0:0 S SROTHER=$O(^SRF(SRASS,13,SROTHER)) Q:'SROTHER  D OTHER
 S SROP=SRASS D ^SROP1
 K SROPS,MM,MMM S:$L(SROPER)<65 SROPS(1)=SROPER I $L(SROPER)>64 S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MMM=""
 I '$D(SRTN) W CNT_". "
CASE W $E(SRSDATE,4,5)_"-"_$E(SRSDATE,6,7)_"-"_$E(SRSDATE,2,3),?14,SROPS(1) I $D(SROPS(2)) W !,?14,SROPS(2) I $D(SROPS(3)) W !,?14,SROPS(3)
 I $D(SROPS(4)) W !,?14,SROPS(4)
 I $D(SRTN) Q
 W !! S SRCASE(CNT)=SRASS_"^"_SRDT
 Q
OTHER ; other operations
 S SRLONG=1 I $L(SROPER)+$L($P(^SRF(SRASS,13,SROTHER,0),"^"))>235 S SRLONG=0,SROTHER=999,SROPERS=" ..."
 I SRLONG S SROPERS=$P(^SRF(SRASS,13,SROTHER,0),"^")
 S SROPER=SROPER_$S(SROPERS'=" ...":", "_SROPERS,1:SROPERS)
 Q
LOOP ; break procedures
 S SROPS(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROPS(M))+$L(MM)'<65  S SROPS(M)=SROPS(M)_MM_" ",SROPER=MMM
 Q
SEL ; select case
 W !!!,"Select Operation, or enter <RET> to continue listing Procedures: " R X:DTIME I '$T!(X["^") S SRSOUT=1 Q
 I X="" W @IOF,!,?1,VADM(1)_"  "_VA("PID"),!! Q
 I '$D(SRCASE(X)) W !!,"Please enter the number corresponding to the Surgical Case you want to edit.",!,"If the case desired does not appear, enter <RET> to continue listing",!,"additional cases."
 I '$D(SRCASE(X)) W !!,"Press <RET> to continue  " R X:DTIME S:'$T SRSOUT=1 S SRBACK=1 Q
 S SRTN=+SRCASE(X)
 Q
END D ^SRSKILL W @IOF
 Q
NEW K SRL,SRCNT
 S SRCNT=0 I '$P($G(^SRO(133,SRSITE,0)),"^",21) S YY=$G(^SRO(133,SRSITE,8)) D
 .F I=1:1:$L(YY,"^") I $P(YY,"^",I)="Y" S SRCNT=SRCNT+1 D
 ..S SRL(SRCNT)=$S(I=1:"Kidney;1",I=2:"Liver;2",I=3:"Lung;3",I=4:"Heart;4",1:"")
 I SRCNT=1 S Y=1 W !!,"Creating a New "_$P(SRL(1),";")_" Transplant Assessment..." G T1
 W ! S II=0 F  S II=$O(SRL(II)) Q:'II  W !,II,". ",$P(SRL(II),";")
 W ! K DIR S DIR(0)="N^1:"_SRCNT,DIR("A")="Select Type of Transplant" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) K SRTN,SRTPP S SRSOUT=1 Q
T1 S XX=$P(SRL(Y),";",2),SRTTYPE=$S(XX=1:"K",XX=2:"LI",XX=3:"LU",XX=4:"H",1:"")
 ; VA or Non-VA Indicator
VA K DIR W ! S DIR(0)="139.5,185",DIR("A")="Is this a VA or a Non-VA Transplant (V or N)" D ^DIR K DIR I $D(DTOUT)!(X="^") K SRTN,SRTPP S SRSOUT=1 Q
 S SRVA=Y
DATE ; Date of Transplant
 I SRVA'="N" Q
 K DIR  W ! S DIR(0)="139.5,1",DIR("A")="Date of Transplant" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1 Q
 S SRTPDT=Y
VACO ; VACO ID
 K SRVACO,DIR W ! S DIR(0)="139.5,3",DIR("A")="VACO ID" D ^DIR K DIR I $D(DTOUT)!(X="^") S SRSOUT=1 Q
 S SRVACO=Y
 Q
ADD K DA,DIC,DD,DO S X=DFN,DIC="^SRT(",DIC(0)="L",DLAYGO=139.5 D FILE^DICN K DD,DO,DIC,DLAYGO S SRTPP=+Y
 K DIE,DR,DA S DA=SRTPP,DIE=139.5,DR="1////"_SRTPDT_$S(SRVA="V":";2////"_SRTN,1:"")_";3////"_SRVACO_";182////"_SRTTYPE_";Q;181////I;185////"_SRVA
 ; if kidney transplant, defualt Pancreas fields to "N/NS"
 I SRTTYPE="K" N SRPAN S SRPAN="134;135;136;137;138;139;140;141;142" F II=1:1:$L(SRPAN,";") S DR=DR_";"_$P(SRPAN,";",II)_"////"_$S($P(SRPAN,";",II)=134:"N",1:"NS")
 D ^DIE K DR,DIE,DA
 S ^SRT(SRTPP,8)=$S(SRVA="N":SRSITE("DIV"),SRVA="V":$P($G(^SRF(SRTN,8)),"^"),1:"")
 Q
CHK ; VACO ID check
 Q:'$O(^SRT("AE",X,0))  N SRDFN,SRDFN1,SRNODE0,SRC
 I $D(DA) S SRNODE0=$G(^SRT(DA,0))
 S SRDFN1=$S($D(DFN):DFN,1:$P(SRNODE0,"^"))
 S SRDFN=0 F  S SRDFN=$O(^SRT("AE",X,SRDFN)) Q:'SRDFN  I SRDFN'=SRDFN1 D  K X Q
 .S SRC(1)="This VACO ID has already been assigned to another patient.",SRC(1,"F")="!!?5"
 .S SRC(2)="VACO ID is a unique identifier provided centrally for each patient",SRC(2,"F")="!?5"
 .S SRC(3)="undergoing a transplant.",SRC(3,"F")="!?5"
 .D EN^DDIOL(.SRC)
 Q
