SRODTH ;BIR/ADM - UPDATE CASE AS UNRELATED OR RELATED TO DEATH ;01/30/01  10:06 AM
 ;;3.0; Surgery ;**47,88,100,142**;24 Jun 93
PAT W @IOF,!,?15,"Update Operations as Unrelated or Related to Death",!!
 S SRSOUT=0 K DIC S DIC("A")="Select Patient: ",DIC=2,DIC(0)="QEAM" D ^DIC K DIC I Y<0 G END
 S DFN=+Y D DEM^VADPT S SRDEATH=$P(VADM(6),"^") I 'SRDEATH G NODIE
 S X1=SRDEATH,X2=-90 D C^%DTC S SRDAY=X,(CNT,SRDT)=0
 K SRCASE F  S SRDT=$O(^SRF("ADT",DFN,SRDT)) Q:'SRDT  S SRCASE=0 F  S SRCASE=$O(^SRF("ADT",DFN,SRDT,SRCASE)) Q:'SRCASE  D SET
OUT D HDR I 'CNT W !!,"This patient had no operations in 90 days prior to death.",!! K DIR S DIR(0)="E" D ^DIR K DIR G:$D(DTOUT)!$D(DUOUT) END G PAT
 W !!,"Operations in 90 Days Prior to Death:",!
 F NUM=1:1 Q:'$D(SRCASE(NUM))  S SRCASE=SRCASE(NUM) D LIST W !
SEL ; select operation to update
 K DIR S DIR(0)="NO^1:"_CNT_":0",DIR("?",1)="Enter the number corresponding to the operation to be updated or",DIR("?")="press RETURN to quit this patient."
 S DIR("A")="Select Number of Operation to be Updated" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) G END
 I Y S NUM=Y D RELATED G OUT
 G PAT
 Q
RELATED ; update UNRELATED/RELATED status
 S SRCASE=SRCASE(NUM) I $$LOCK^SROUTL(SRCASE) D  D UNLOCK^SROUTL(SRCASE)
 .D HDR W ! D LIST W ! K DA,DIE,DR S DA=SRCASE,DR="903T;904T",DIE=130 D ^DIE K DA,DIE,DR
 Q
SET ; set up array of cases in 90 days prior to death
 S SRSDATE=$P(^SRF(SRCASE,0),"^",9) I SRSDATE<SRDAY!(SRSDATE>SRDEATH) Q
 I '$P($G(^SRF(SRCASE,.2)),"^",12)!$P($G(^SRF(SRCASE,30)),"^")!($P($G(^SRF(SRCASE,"NON")),"^")="Y")!$P($G(^SRF(SRCASE,37)),"^") Q
 S CNT=CNT+1,SRCASE(CNT)=SRCASE
 Q
LIST ; display list of operations
 S X=$P($G(^SRF(SRCASE,.4)),"^",7) I X="" S X="U",$P(^SRF(SRCASE,.4),"^",7)=X
 S SRELATE=$S(X="U":"UNRELATED",1:"RELATED")
 S SROPER=$P(^SRF(SRCASE,"OP"),"^")
 S SROPER=SROPER_" - "_SRELATE
 S X1=SRDEATH,(DATE,X2)=$P(^SRF(SRCASE,0),"^",9),DATE=$E(DATE,4,5)_"/"_$E(DATE,6,7)_"/"_$E(DATE,2,3) D ^%DTC S SRLENGTH=X
 K SROPS,MM,MMM S:$L(SROPER)<65 SROPS(1)=SROPER I $L(SROPER)>64 S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MMM=""
 W !,NUM_".",?3,DATE,?15,SROPS(1) I $D(SROPS(2)) W !,?15,SROPS(2) I $D(SROPS(3)) W !,?15,SROPS(3)
 W !,?15," >>> Died "_SRLENGTH_" day"_$S(SRLENGTH>1:"s",1:"")_" postop. <<<"
 Q
LOOP ; break procedures
 S SROPS(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROPS(M))+$L(MM)'<65  S SROPS(M)=SROPS(M)_MM_" ",SROPER=MMM
 Q
HDR ; print heading
 W @IOF,!,?15,"Update Operations as Unrelated or Related to Death",!!,VADM(1)_"   "_VA("PID") S X=$P($G(VADM(6)),"^") W:X "        * DIED "_$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)_" *"
 Q
NODIE D HDR W !!!,"No death is recorded for this patient.",!!! K DIR S DIR(0)="E" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) G END
 G PAT
END I SRSOUT K DIR S DIR(0)="E" D ^DIR
 D ^SRSKILL W @IOF
 Q
