PSGDCC ;BIR/CML3-CHANGE DRUG COST DATA IN 57.6 ;14 JUL 94 / 9:16 AM
 ;;5.0; INPATIENT MEDICATIONS ;;16 DEC 97
 ;
 D ENCV^PSGSETU I $D(XQUIT) Q
 K %DT,DIC S DIC="^PSDRUG(",DIC(0)="AEIMOQZ",DIC("A")="Select DRUG: " W ! D ^DIC K DIC I Y'>0 W !,"No drug chosen, or change made." G DONE
 S DRG=+Y,DRGN=Y(0,0),CC=$S($D(^PSDRUG(DRG,660)):$P(^(660),"^",6),1:0) W !,$S('CC:"NO ",1:""),"CURRENT PRICE PER DISPENSE UNIT",$S(CC:" IS "_CC,1:".")
 K DIR S DIR(0)="NAO^0:222:4",DIR("A")="Enter NEW COST: ",DIR("?")="^D NCM^PSGDCC" D ^DIR
 I $D(DIRUT) W !,"No new cost entered.  No changes made." G DONE
 S NC=Y
 F M="START","STOP" D DT G:Y'>0 DONE
 ;
CHG ;
 W !!,"...This may take a few minutes..." F  H 1 D NOW^%DTC I '$D(^PS(57.6,"ADCC",%)) S PSGDT=% Q
 S X1=SD1,X2=-1 D C^%DTC S SD=X F  S SD=$O(^PS(57.6,SD)) Q:'SD!(SD>FD)  S W=0 F  S W=$O(^PS(57.6,SD,1,W)) Q:'W  S P=0 F  S P=$O(^PS(57.6,SD,1,W,1,P)) Q:'P  I $D(^PS(57.6,SD,1,W,1,P,1,DRG,0)) S OLD=^(0) D C1
 I '$D(^PS(57.6,"ADCC",PSGDT)) W !!,$S('$D(^PSDRUG(DRG,0)):DRG,$P(^(0),"^")]"":$P(^(0),"^"),1:DRG)," NOT FOUND WITHIN THE DATE RANGE SPECIFIED."
 E  S ^PS(57.6,"ADCC",PSGDT)=DUZ_"^"_DRG_"^"_NC_"^"_SD1_"^"_FD D ^PSGDCCM
 ;
DONE ;
 D ENKV^PSGSETU K CC,DRG,DRGN,FD,M,NC,OLD,OLDC,P,SD,SD1,W,XCNP,XMZ Q
 ;
NCM ;
 W !!,"  Enter the new cost (Price Per Dispense Unit) for the drug chosen.  The cost",!,"entered here will be used in resetting the data in the cost stats file.",!,"The cost entered may be a decimal value with no trailing zeros." Q
 ;
DT ;
 S %DT="EX" S:M="STOP" %DT(0)=SD1 F  S Y=-1 W !!,"Enter ",M," DATE: " R X:DTIME W:'$T $C(7) S:'$T X="^" Q:"^"[X  D DTM:X?1."?",^%DT Q:Y>0
 K %DT I Y'>0 W !?2,M," DATE NOT ENTERED.  CHANGE TERMINATED." Q
 S @$S(M="STOP":"FD",1:"SD1")=Y Q
 ;
DTM ;
 W !!,"  Enter the ",$S(M="STOP":"stop",1:"start")," date of the range of dates over which the cost data is to be",!,"changed.  The start and stop dates may be the same day, effectively creating a  one day change,"
 W " but the stop date may not come before the start date.",!,"  Time is not entered.",! Q
 ;
C1 ;
 S OLDC=$S($P(OLD,"^",2):$P(OLD,"^",3)/$P(OLD,"^",2),1:"")_"^"_$S($P(OLD,"^",4):$P(OLD,"^",5)/$P(OLD,"^",4),1:"")
 S ^PS(57.6,SD,1,W,1,P,1,DRG,0)=$P(OLD,"^",1,2)_"^"_($P(OLD,"^",2)*NC)_"^"_$P(OLD,"^",4)_"^"_($P(OLD,"^",4)*NC)_$S($P(OLD,"^",6,99)]"":"^"_$P(OLD,"^",6,99),1:""),^PS(57.6,"ADCC",PSGDT,SD,W,P)=OLDC Q
 ;
ENDEL ; delete cost data (completely!)
 S PSGID=$O(^PS(57.6,0)) I 'PSGID W $C(7),!!,"NO COST DATA FOUND TO DELETE." G DELOUT
 K %DT S PSGOD=$E($$ENDTC^PSGMI(PSGID),1,8),%DT="EXP",Y=-1 F  R !!,"Enter LIMIT DATE: ",X:DTIME W:'$T $C(7) S:'$T X="^" Q:"^"[X  D DELM:X?1."?",^%DT Q:X'?1."?"
 W:Y'>0 !?2,"No date chosen, or data deleted." I Y>0 W !,"...a few moments, please..." D DELDC W:'H $C(7),$C(7),!,"No data found prior to date chosen!"
 ;
DELOUT ;
 K %DT,PSGID,PSGOD,Q,X,Y Q
 ;
DELDC ;
 S (F,H)=0 F X=0:0 S X=$O(^PS(57.6,X)) Q:'X!(X>Y)  K ^(X) S F=1,H=X
 F Q=0:0 S Q=$O(^PS(57.6,"ADCC",Q)) Q:'Q  F X=0:0 S X=$O(^PS(57.6,"ADCC",Q,X)) Q:'X!(X>Y)  K ^(X) K:$D(^PS(57.6,"ADCC",Q))<10 ^(Q)
 Q
 ;
DELM ;
 W !!?2,"ALL cost data for doses dispensed on or before the date selected will be",!,"completely deleted from the computer.  The earliest date found is ",PSGOD,".",!!,"WARNING!!  THIS DATA CANNOT BE REBUILT OR RECOMPILED!",! Q
