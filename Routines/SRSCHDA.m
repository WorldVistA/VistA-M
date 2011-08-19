SRSCHDA ;B'HAM ISC/MAM - SCHEDULE ANESTHESIA PERSONNEL ; [ 01/31/01  7:58 AM ]
 ;;3.0; Surgery ;**77,50,100**;24 Jun 93
 I $D(SRTN) S SRCASE=SRTN
DATE W ! K %DT S %DT="AEFX",%DT("A")="Schedule Anesthesia Personnel for which Date ?  " D ^%DT G:Y<0 END S SRSDATE=+Y K %DT
 S X1=SRSDATE,X2="+1" D C^%DTC S SRSD1=X
OR W ! K DIC S SRZ=0,DIC("S")="I $$ORDIV^SROUTL0(+Y,$G(SRSITE(""DIV""))),'$P(^(0),""^"",6)",DIC=131.7,DIC(0)="QEAMZ",DIC("A")="Schedule Anesthesia Personnel for which Operating Room ?  " D ^DIC G:Y<0 END S SROR=+Y,SROR("N")=Y(0,0)
 I '$O(^SRF("AMM",SROR,SRSDATE-.0001))!($O(^SRF("AMM",SROR,SRSDATE-.0001))>SRSD1) W !!,"There are no cases scheduled for this operating room. ",!!,"Press RETURN to continue  " R X:DTIME
 S (SRANES(1),SRANES(2))=""
 S SRSD=SRSDATE-.0001 F  S SRSD=$O(^SRF("AMM",SROR,SRSD)) Q:'SRSD!(SRSD>SRSD1)  S SRTN=0 F  S SRTN=$O(^SRF("AMM",SROR,SRSD,SRTN)) Q:'SRTN  D LIST
 W @IOF
AGAIN W !!,"Would you like to continue with another operating room ?  YES// " R X:DTIME S:'$T X="^" I X["?" W !!,"Enter RETURN if you would like to schedule anesthesia personnel in another",!,"room, or 'NO' to quit." G AGAIN
 I X["^" G END
 S X=$E(X) I "YyNn"'[X W !!,"Please answer 'YES' or 'NO'." G AGAIN
 I "Yy"[X G OR
END K SRTN I $D(SRCASE) S SRTN=SRCASE
 D ^SRSKILL W @IOF
 Q
LIST ; set variables and list case
 Q:SRZ  K SROPS,MM,MMM S DFN=$P(^SRF(SRTN,0),"^") D DEM^VADPT S SRNM=VADM(1),SROPER=$P(^SRF(SRTN,"OP"),"^") S:$L(SROPER)<70 SROPS(1)=SROPER I $L(SROPER)>69 S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MMM=""
 S SRST=$P(^SRF(SRTN,31),"^",4),SRET=$P(^(31),"^",5),SRST=$P(SRST,".",2)_"0000",SRST=$E(SRST,1,2)_":"_$E(SRST,3,4),SRET=$P(SRET,".",2)_"0000",SRET=$E(SRET,1,2)_":"_$E(SRET,3,4)
 W @IOF,!!,"Scheduled Operations for "_SROR("N"),! F LINE=1:1:80 W "-"
 W !!,"Case # "_SRTN_"   Patient: "_SRNM,!,"From: "_SRST_"  To: "_SRET,!,SROPS(1) I $D(SROPS(2)) W !,?5,SROPS(2) I $D(SROPS(3)) W !,?5,SROPS(3)
 K DR,SRODR
 I '$$LOCK^SROUTL(SRTN) G MORE
 W !! S DA=SRTN,DIE=130,DR="1.01T;.31T//"_SRANES(1)_";S SRANES(1)=$S(X:$P(^VA(200,X,0),""^""),1:X);.34T//"_SRANES(2)_";S SRANES(2)=$S(X:$P(^VA(200,X,0),""^""),1:X)" D ^DIE K DR
 I $D(SRODR) S SRNOCON=1 D ^SROCON1 K SRNOCON
 D UNLOCK^SROUTL(SRTN)
MORE W !!!,"Press RETURN to continue, or '^' to quit:  " R X:DTIME S:'$T X="^" I X["?" W !!,"Enter RETURN to continue scheduling other cases, or '^' to leave this option.",!! G MORE
 I X["^" S SRZ=1
 Q
LOOP ; break procedure if greater than 70 characters
 S SROPS(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROPS(M))+$L(MM)'<70  S SROPS(M)=SROPS(M)_MM_" ",SROPER=MMM
 Q
