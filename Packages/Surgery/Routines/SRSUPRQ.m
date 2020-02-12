SRSUPRQ ;B'HAM ISC/MAM - UPDATE REQUESTED OPERATIONS; AUGUST 29, 2001@9:04 AM
 ;;3.0;Surgery;**7,47,58,67,107,114,100,154,177,184,196**;24 Jun 93;Build 1
 ;
 ; Reference to ^TMP("CSLSUR1" supported by DBIA #3498
 ;
 K SRSCHED
ASK K DIC,SRCASE S SRSOUT=0,DIC=2,DIC(0)="QEAMZ",DIC("A")="Select Patient: " D ^DIC K DIC Q:Y<0  S SRDFN=+Y,SRNM=$P(Y(0),"^")
 S (CNT,SRSDATE,SRTN)=0 F  S SRSDATE=$O(^SRF("AR",SRSDATE)) Q:'SRSDATE  F  S SRTN=$O(^SRF("AR",SRSDATE,SRDFN,SRTN)) Q:'SRTN  D SETUP
 I '$D(SRCASE(1)) W !!,"There are no requested cases for "_SRNM_"." G END
 S GRAMMER=$S($D(SRCASE(2)):"cases are",1:"case is") W @IOF,!,"The following "_GRAMMER_" requested for "_SRNM_":",!
 S CNT=0 F  S CNT=$O(SRCASE(CNT)) Q:'CNT  D OPS W !,$P(SRCASE(CNT),"^",2),?15,SROPS(1) I $D(SROPS(2)) W !,?15,SROPS(2) I $D(SROPS(3)) W !,?15,SROPS(3)
OPT S SREQ=1 I $D(SRCASE(2)) D MANY
 G:"^"[SREQ END S:'$D(SRCASE(2)) SRTN=$P(SRCASE(1),"^") S SRSDATE=$E($P(^SRF(SRTN,0),"^",9),1,7) I $P(^SRF(SRTN,0),"^",4)="" D SS^SRSCHUP I SRSOUT K SRTN
 Q:$D(SRSCHED)  G:'$D(SRTN) END W !!,"1. Delete",!,"2. Update Request Information",!,"3. Change the Request Date"
SEL W !!,"Select Number: " R Z:DTIME S:'$T!("^"[Z) SRSOUT=1 G:SRSOUT END S:Z["?" Z=4
 I Z<1!(Z>3)!(+Z\1'=Z) W !!,"If you want to delete this request, enter '1'.  Enter '2' if you only want",!,"to update the general information about this case, or '3' to change the date",!,"that this case is requested for." G SEL
 I $D(^XTMP("SRLOCK-"_SRTN)) D MSG G END
 I Z=1 D DEL G END
 I Z=2 D UPDATE S SRSOUT=1 G END
 I Z=3 D CHANGE^SRSDT
END I '$D(SRLATE) S SRLATE=0
 I 'SRLATE,'SRSOUT W !!,"Press RETURN to continue  " R X:DTIME
 W @IOF D ^SRSKILL K SRTN,SRTN1,SRTNX
 Q
OPS S SROPER=$P(SRCASE(CNT),"^",3) K SROPS,MM,MMM S:$L(SROPER)<60 SROPS(1)=SROPER I $L(SROPER)>59 S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MMM=""
 Q
LOOP ; break procedure if greater than 60 characters
 S SROPS(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROPS(M))+$L(MM)'<60  S SROPS(M)=SROPS(M)_MM_" ",SROPER=MMM
 Q
MANY ; select requested case if more than one
 W !!,"Select Operation Request: " R SREQ:DTIME S:'$T SREQ="^" Q:"^"[SREQ  I SREQ["?"!'$D(SRCASE(SREQ)) W !!,"Enter the number corresponding to the request that will be updated or deleted. " G MANY
 S SRTN=$P(SRCASE(SREQ),"^")
 Q
SETUP ; set SRCASE array to list requested cases for this patient
 S CNT=CNT+1,SRSDT=$P(^SRF(SRTN,0),"^",9),SRSDT=$E(SRSDT,4,5)_"-"_$E(SRSDT,6,7)_"-"_$E(SRSDT,2,3),SRCASE(CNT)=SRTN_"^"_CNT_".  "_SRSDT_"^"_$P(^SRF(SRTN,"OP"),"^")
 Q
DEL ; delete request
 S SRBOTH=0 W !!,"Are you sure that you want to delete this request ?  YES// " R X:DTIME S:'$T X="N" S:X="" X="Y" I X["?" W !!,"Enter RETURN if this request is to be deleted, or NO to quit. " G DEL
 S X=$E(X) Q:"Yy"'[X  I '$$LOCK^SROUTL(SRTN) Q
 K DIE,DR,DA S DA=SRTN,DIE=130,DR="36///0;Q;.09///"_SRSDATE D ^DIE K DR,DA,DIE S SRSDOC=$P(^SRF(SRTN,.1),"^",4)
 S SRCON=$P($G(^SRF(SRTN,"CON")),"^") I SRCON D CON I SRBOTH="^" G END
OPALSO ; delete from file 130
 S SROPCOM="Operation ..."
 S DFN=SRDFN,SRCC="",SRTNX=SRTN D KILL^SROPDEL,UNLOCK^SROUTL(SRTNX) S SRTN=SRTN1 I $D(SRCON) S SRC="" G:"^"[SRBOTH END I SRBOTH=1 S SRTN=SRCON,SRCC="Concurrent " D KILL^SROPDEL,UNLOCK^SROUTL(SRCON)
 Q
CON S SRCON=^SRF(SRTN,"CON"),SRC="the request for" D CC Q:SRBOTH="^"  I SRBOTH=1 K DIE,DR,DA S DA=SRCON,DIE=130,DR="36///0;Q;.09///"_SRSDATE D ^DIE K DR,DIE,DA S SRSDOCC=$P(^SRF(SRCON,.1),"^",4)
 Q
CC ; check to see if concurrent case should be deleted
 W !!,"A concurrent case has been requested for this operation.  Do you want to",!,"delete "_SRC_" it also ?  YES// " R SRBOTH:DTIME S:'$T SRBOTH="^" I SRBOTH["?" W !!,"Enter 'Y' if you want to delete "_SRC_" concurrent case." G CC
 S:SRBOTH="" SRBOTH="Y" S SRBOTH=$E(SRBOTH) I "YyNn"'[SRBOTH W !!,"Enter RETURN if you want these cases to remain concurrent." G CC
 I SRBOTH["Y" S SRBOTH=1
 I SRBOTH="^" Q
 I $P($G(^SRF(SRCON,.2)),U,12)'="" D  Q
 .W !!,"The concurrent procedure associated with this case: ",SRCON S SRBOTH=0
 .W !,"has been completed and must remain in the file for your records."
 .S DA=SRCON,DR="35///@",DIE=130 D ^DIE S SROERR=SRCON D ^SROERR0 S DA=SRTN,DR="35///@",DIE=130 D ^DIE
 .K SRCON
 .W !!,"Press RETURN to continue  " R X:DTIME
 S DA=SRCON,DR="35///@",DIE=130 D ^DIE S SROERR=SRCON D ^SROERR0 S DA=SRTN,DR="35///@",DIE=130 D ^DIE
 I SRBOTH'=1 K SRCON
 Q
UPDATE ; update requested operation
 N SRLCK S SRLCK=$$LOCK^SROUTL(SRTN) Q:'SRLCK
 D AVG^SRSREQ D RT K SRLNTH,SRLNTH1,DR,X
 ;JAS - 7/31/13 - Patch 177 (NEXT LINE)
 N SRICDV S SRICDV=$$ICDSTR^SROICD(SRTN)
 S ST="UPDATE REQUEST",DA=SRTN,DIE=130,DR=$S($$SPIN^SRTOVRF():"[SRSRES-ENTRY1]",1:"[SRSRES-ENTRY]")
 D EN2^SROVAR K Q3("VIEW"),Y
 S SPD=$$CHKS^SRSCOR(SRTN)
 D ^SRCUSS
 I SPD'=$$CHKS^SRSCOR(SRTN) S ^TMP("CSLSUR1",$J)=""
 K DR D:$D(SRODR) ^SROCON1
 D RISK^SROAUTL3
 D ^SROPCE1
 S SROERR=SRTN K SRTX D ^SROERR0
 I $G(SRLCK) D UNLOCK^SROUTL(SRTN)
 Q
RT ; start RT logging
 I $D(XRTL) S XRTN="SRSUPRQ" D T0^%ZOSV
 Q
MSG W !!,"This case is currently being edited.",!,"Please try again later...",!! Q
