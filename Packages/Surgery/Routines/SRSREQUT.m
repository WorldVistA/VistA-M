SRSREQUT ;B'HAM ISC/MAM - REQUEST UTILITIES ; 29 SEPT 1992  10:35 am
 ;;3.0; Surgery ;;24 Jun 93
LFTOVR ; check for outstanding requests
 K SRCASE S (CNT,SRSRDT,SRTN)=0 F  S SRSRDT=$O(^SRF("AR",SRSRDT)) Q:'SRSRDT  F  S SRTN=$O(^SRF("AR",SRSRDT,SRSDPT,SRTN)) Q:'SRTN  D COMP I 'SRDONE S CNT=CNT+1,SRCASE(CNT)=SRTN
 Q:'$O(SRCASE(0))  S GRAMMER=$S($D(SRCASE(2)):"requests are",1:"request is") W !!,"The following "_GRAMMER_" outstanding for "_SRNM_":",!
 S CNT=0 F I=0:0 S CNT=$O(SRCASE(CNT)) Q:'CNT  S SRTN=SRCASE(CNT),SRSDT=$P(^SRF(SRTN,0),"^",9),SRSDT=$E(SRSDT,4,5)_"-"_$E(SRSDT,6,7)_"-"_$E(SRSDT,2,3) D LIST
UP W !!,"Do you want to update "_$S(CNT>1:"one of ",1:"")_"the outstanding request"_$S(CNT>1:"s",1:"")_" ?  YES// " R SROUTS:DTIME S:'$T SROUTS="^" Q:SROUTS["^"  S:SROUTS="" SROUTS="Y"
 S SROUTS=$E(SROUTS)
 I "YyNn"'[SROUTS W !!,"Enter a RETURN if you would like to delete, update, or change the date of the",!,"requested cases." G UP
 I "Yy"[SROUTS S SRDFN=SRSDPT,SRSOUT=0 D OPT^SRSUPRQ S (SRSOTH,SRSOUT)=1
NEW Q:SRSOTH  W !!,"Do you want to make a new request for "_SRNM_" ? NO//  " R X:DTIME I '$T!("^"[X) S X="N"
 S X=$E(X) I "YyNn"'[X W !!,"Enter 'YES' to continue with this option to make a new request, or RETURN to",!,"quit." G NEW
 I "Nn"[X S SRSOTH=1
 Q
COMP S SRDONE=0 I '$D(^SRF(SRTN,.2)) Q
 I $P(^SRF(SRTN,.2),"^",12)="" Q
 S SRDONE=1 K DIE,DR,DA S DA=SRTN,DIE=130,DR="36///0;Q;.09///"_$P(^SRF(SRTN,0),"^",9) D ^DIE K DR,DIE,DA
 Q
LIST ;
 S SRSOP=$P(^SRF(SRTN,"OP"),"^") K SROPS,MM,MMM S:$L(SRSOP)<70 SROPS(1)=SRSOP I $L(SRSOP)>69 S SROPER=SRSOP S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MMM=""
 W !,CNT_".",?5,SRSDT,!,?5,SROPS(1) I $D(SROPS(2)) W !,?5,SROPS(2) I $D(SROPS(3)) W !,?5,SROPS(3) I $D(SROPS(4)) W !,?5,SROPS(4)
 Q
LOOP ; break procedure if greater than 70 characters
 S SROPS(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROPS(M))+$L(MM)'<70  S SROPS(M)=SROPS(M)_MM_" ",SROPER=MMM
 Q
