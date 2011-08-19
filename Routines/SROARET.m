SROARET ;BIR/MAM - UPDATE RETURNS ;07/07/04  12:27 PM
 ;;3.0; Surgery ;**16,19,38,46,88,100,125,142**;24 Jun 93
 I '$D(SRTN) S SRTN1=1 D ^SROPS I '$D(SRTN) S SRSOUT=1 G END1
 S SRSUPCPT=1 D ^SROAUTL S SRNAME=VADM(1),SRSOUT=0,SR(0)=^SRF(SRTN,0),SRLINE="" F I=1:1:79 S SRLINE=SRLINE_"-"
 S SRT=$P($G(^SRF(SRTN,.2)),"^",10),(SRSDATE,X1)=$E($P(SR(0),"^",9),1,7),X2=30 D C^%DTC S SRENDT=X,END=SRENDT+.9999 K SRETURN
 S SRCASE=0 F  S SRCASE=$O(^SRF(SRTN,29,SRCASE)) Q:'SRCASE  D
 .S CASE=$P(^SRF(SRTN,29,SRCASE,0),"^"),SRCT=$P(^SRF(CASE,0),"^",9),SRT1=$P($G(^SRF(CASE,.2)),"^",10)
 .I $E(SRCT,1,7)<SRSDATE!(SRCT=$P(SR(0),"^",9))!(SRCT>END)!$P($G(^SRF(CASE,30)),"^")!$P($G(^SRF(CASE,31)),"^",8)!$P($G(^SRF(CASE,37)),"^") D DEL Q
 .I SRT,SRT1,SRT>SRT1 D DEL
 S SRCASE=0 F  S SRCASE=$O(^SRF("B",DFN,SRCASE)) Q:'SRCASE  I SRCASE'=SRTN D CHECK
 I '$O(^SRF(SRTN,29,0)) W !!,"There are no surgical cases entered for "_SRNAME_"",!,"within 30 days of this operation." G END
RETURN S SRPAGE="RETURNS TO SURGERY" D HDR^SROAUTL
 S (SRCASE,CNT)=0 F  S SRCASE=$O(^SRF(SRTN,29,SRCASE)) Q:'SRCASE  D
 .S CNT=CNT+1,X=$P(^SRF(SRTN,29,SRCASE,0),"^",3) I X="" S X="U",$P(^SRF(SRTN,29,SRCASE,0),"^",3)=X
 .S SRELATE=$S(X="U":"UNRELATED",1:"RELATED"),SRETURN(CNT)=SRCASE_"^"_SRELATE D LIST
 I '$D(SRETURN(2)) S X=1 D RELATED G END
 W !,SRLINE,!
PICK W !!,"Select Number: " R X:DTIME I '$T!("^"[X) S SRSOUT=1 G END
 I '$D(SRETURN(X)) W !!,"Select the number corresponding to the return which you want to update, or",!,"enter RETURN to quit this option.",!!,"Press RETURN to continue  " R X:DTIME G RETURN
 D RELATED G RETURN
DEL ; delete returns
 S DA(1)=SRTN,DA=SRCASE,DIK="^SRF("_SRTN_",29," D ^DIK
 Q
CHECK ; add to RETURNS if necessary
 Q:$P($G(^SRF(SRCASE,"NON")),"^")="Y"!$P($G(^SRF(SRCASE,37)),"^")  S CAN=$P($G(^SRF(SRCASE,30)),"^") I CAN Q
 S CAN=$P($G(^SRF(SRCASE,31)),"^",8) I CAN'="" Q
 S CON=$P($G(^SRF(SRTN,"CON")),"^") I CON=SRCASE Q
 S DATE=$P(^SRF(SRCASE,0),"^",9),SRT1=$P($G(^SRF(SRCASE,.2)),"^",10) I $E(DATE,1,7)<SRSDATE!(DATE>END)!(DATE=$P(SR(0),"^",9)) Q
 I SRT,SRT1,SRT>SRT1 Q
 I $D(^SRF(SRTN,29,SRCASE,0)) Q
 I '$D(^SRF(SRTN,29,0)) S ^SRF(SRTN,29,0)="^130.43PA^^"
 K DA,DO,DD,DA,DINUM,DIC S DA(1)=SRTN,DIC="^SRF("_SRTN_",29,",X=SRCASE,DINUM=X,DIC(0)="L",DLAYGO=130.43 D FILE^DICN K DD,DO,DIC,DINUM,DLAYGO
 S $P(^SRF(SRTN,29,SRCASE,0),"^",3)="U"
 Q
LIST ; list returns
 S SROPER=$P(^SRF(SRCASE,"OP"),"^")
 S SROPER=SROPER_" - "_SRELATE
 S DATE=$P(^SRF(SRCASE,0),"^",9),DATE=$E(DATE,4,5)_"/"_$E(DATE,6,7)_"/"_$E(DATE,2,3)
 K SROPS,MM,MMM S:$L(SROPER)<65 SROPS(1)=SROPER I $L(SROPER)>64 S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MMM=""
 W !,CNT_".",?3,DATE,?15,SROPS(1) I $D(SROPS(2)) W !,?15,SROPS(2) I $D(SROPS(3)) W !,?15,SROPS(3)
 W ! Q
LOOP ; break procedures
 S SROPS(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROPS(M))+$L(MM)'<65  S SROPS(M)=SROPS(M)_MM_" ",SROPER=MMM
 Q
UPDATE ; update single return
END I 'SRSOUT W !!,"Press RETURN to continue  " R X:DTIME
END1 I $D(SRTN1) K SRTN,SRTN1
 D ^SRSKILL W @IOF
 Q
RELATED ; update RELATED/UNRELATED status
 S RETURN=$P(SRETURN(X),"^"),SRELATE=$P(SRETURN(X),"^",2),OPPOSITE=$S(SRELATE["U":"RELATED",1:"UNRELATED")
 I $D(SRETURN(2)) S SRPAGE="RETURNS TO SURGERY" D HDR^SROAUTL W ! S SRCASE=$P(SRETURN(X),"^"),CNT=X D LIST W !,SRLINE,!
CHANGE W !!,"This return to surgery is currently defined as "_SRELATE_" to the case selected.",!,"Do you want to change this status ? NO// " R SRYN:DTIME I '$T!(SRYN["^") S SRSOUT=1 Q
 S SRYN=$E(SRYN) I "YyNn"'[SRYN W !!,"Enter 'YES' to change the status of this return from "_SRELATE_" to "_OPPOSITE_".",!,"Enter 'NO' to leave the information unchanged.",! G CHANGE
 S:SRYN="" SRYN="N" I "Yy"'[SRYN Q
 S $P(^SRF(SRTN,29,RETURN,0),"^",3)=$E(OPPOSITE)
 Q
