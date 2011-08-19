SROWL0 ;B'HAM ISC/MAM - EDIT OR DELETE WAITING LIST ; 16 OCT 1989  08:00
 ;;3.0; Surgery ;**58**;24 Jun 93
DEL S SRDEL=1
EDIT S:'$D(SRDEL) SRDEL=0
 S SRSOUT=0 W @IOF,! K DIC S DIC=2,DIC(0)="QEAMZ",DIC("A")=$S(SRDEL:"Delete ",1:"Edit ")_"which Patient ?  " D ^DIC G:Y<0 END S DFN=+Y,SRSDPT=$P(Y(0),"^")
LIST W @IOF,!,"Procedures entered on the Waiting List for "_SRSDPT,!!
 K SRW S (CNT,SRSS)=0 F I=0:0 S SRSS=$O(^SRO(133.8,"AP",DFN,SRSS)) Q:'SRSS  S SROFN=0 F I=0:0 S SROFN=$O(^SRO(133.8,"AP",DFN,SRSS,SROFN)) Q:'SROFN  D ARRAY
 I '$D(SRW(1)) W !!,"There are no entries on the Waiting List for "_SRSDPT_".",!! G END
 I '$D(SRW(2)) S SRW=1 G DIE
 W !!!,"Select Number: " R X:DTIME I "^"[X S SRSOUT=1 G END
 I '$D(SRW(X)) W !!,"Select the number corresponding to the entry you want to "_$S(SRDEL:"delete",1:"edit")_".  Enter '^'",!,"to quit this option.",!!,"Press RETURN to continue  " R X:DTIME G LIST
 S SRW=X
DIE I SRDEL G DIK
 D NOW^%DTC S SRNOW=$E(%,1,12),SRSS=$P(SRW(SRW),"^"),SROFN=$P(SRW(SRW),"^",2)
 K DR,DIE,DA S DA(1)=SRSS,DA=SROFN,DIE="^SRO(133.8,"_DA(1)_",1,",DR="1T;4T;5T;6T;W !;3T",DR(2,133.8013)=".01T;1T;2T;3T;4T;5T" D ^DIE K DR,DIE,DA D WL^SROPCE1
 G END
DIK ; delete entry
 W !!,"Are you sure that you want to delete this entry ?  YES//  " R SRYN:DTIME I '$T!(SRYN["^") S SRSOUT=1 G END
 S SRYN=$E(SRYN) S:SRYN="" SRYN="Y" I "YyNn"'[SRYN W !!,"Enter 'NO' if you have made a mistake and do not want to remove this",!,"procedure from the list, or 'YES' to delete the entry." G DIE
 I "Yy"'[SRYN W !!,"No action taken." G END
 S DA(1)=$P(SRW(SRW),"^"),DA=$P(SRW(SRW),"^",2),DIK="^SRO(133.8,"_DA(1)_",1," D ^DIK
 W !!,SRSDPT_" has been removed from the Waiting List."
END I 'SRSOUT W !!,"Press RETURN to continue  " R X:DTIME
 D ^SRSKILL W @IOF
 Q
ARRAY ; set array containing waiting list info
 S CNT=CNT+1,SRSNM=$P(^SRO(133.8,SRSS,0),"^"),SRSNM=$P(^SRO(137.45,SRSNM,0),"^")
 S SROPER=$P(^SRO(133.8,SRSS,1,SROFN,0),"^",2),SRDT=$P(^(0),"^",3),SROPDT=$P(^(0),"^",5),Y=SRDT D D^DIQ S SRDT=$E(Y,1,12) I SROPDT S Y=SROPDT D D^DIQ S SROPDT=$E(Y,1,12)
 K SROP,MM,MMM S:$L(SROPER)<36 SROP(1)=SROPER I $L(SROPER)>35 S SROPER=SROPER_"  " S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MMM=""
 S SRW(CNT)=SRSS_"^"_SROFN_"^"_SRSNM_"^"_SRDT_"^"_SROPER_"^"_SROPDT
 W !,CNT_". "_SRSNM,?40,"Date Entered on List:",?66,SRDT,!,?3,SROP(1),?40,"Tentative Operation Date: ",?66,SROPDT
 I $D(SROP(2)) W !,?3,SROP(2)
 W !
 Q
LOOP ; break procedure if greater than 36 characters
 S SROP(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROP(M))+$L(MM)'<36  S SROP(M)=SROP(M)_MM_" ",SROPER=MMM
 Q
