SRSBDEL ;B'HAM ISC/MAM - DELETE SERVICE BLOCKOUT ; [ 01/08/98   9:54 AM ]
 ;;3.0; Surgery ;**26,77,104,165**;24 Jun 93;Build 6
SER ; service abbreviation
 S SRBPRG=1 D CURRENT^SRSBUTL
 S SRSOUT=0
 R !!,"Select service you wish to delete. (3-4 characters)  ",SRSSER:DTIME I '$T!("^"[SRSSER) S SRSOUT=1 G END
 I SRSSER["?"!(SRSSER["=") D QUES G SER
 F SRMM=1:1:$L(SRSSER) I $E(SRSSER,SRMM)?1U S SRSSER=$E(SRSSER,0,SRMM-1)_$C($A(SRSSER,SRMM)+32)_$E(SRSSER,SRMM+1,999)
 I '$D(^SRS("SER",SRSSER)) W !!!,SRSSER_" does not exist.",! G SER
 S (OR,CNT)=0 F I=0:0 S OR=$O(^SRS("SER",SRSSER,OR)) Q:OR=""  D
 .I $D(SRSITE("DIV")) Q:'($$ORDIV^SROUTL0(OR,SRSITE("DIV"))) 
 .S SRSOR=$P(^SC($P(^SRS(OR,0),"^"),0),"^") S DAY=0 F I=0:0 S DAY=$O(^SRS("SER",SRSSER,OR,DAY)) Q:DAY=""  D TIME
 W !!!,"The service '"_SRSSER_"' has the following time(s) scheduled: " F I=1:1:CNT W !,?2,$P(SRSOR(I),"^")
NUM R !!!,"Which number would you like to delete ?  ",NUM:DTIME I '$T!("^"[NUM) S SRSOUT=1 G END
 I NUM<1!(NUM>CNT)!(NUM'?.N) W !!,"Enter a number from 1 to "_CNT_", or '^' to leave this option.",! G NUM
STDATE S SRSOR=$P(SRSOR(NUM),"^",2),DAY=$P(SRSOR(NUM),"^",3),SRSST=$P(SRSOR(NUM),"^",4),SRSET=$P(SRSOR(NUM),"^",5)
DATE W ! S %DT("A")="Delete the Blockout starting with which date ?  ",%DT="AEFX" D ^%DT W:Y<1 !!,"No action taken.",! G:Y<1 END S (X,SRSDATE)=Y D DW^%DTC S DAYOFW=X
 I SRSDATE<DT W !!,"Past dates cannot be entered.",! G DATE
 I $E(DAYOFW,1,2)'=DAY W !!,"The date you entered is not a " D DAY W DAY2_".",!! G STDATE
 D DAYCHK^SRSBD1 I SRCHK=1 W !!,"The service '"_SRSSER_"' is not scheduled for this date at the time period you",!,"have entered.  The option 'Display Availability' may be used to determine",!,"the proper date." H 4 G END
 S SRSNUM=$P(^SRS("SER",SRSSER,SRSOR,DAY,SRSST),"^",4)
ASK W !!,"Do you want to delete the blockout for this service on this",!,"date only ?  NO// " R Z:DTIME I '$T!(Z="^") G END
 S:Z="" Z="N" S Z=$E(Z)
 I "NnYy"'[Z W !!,"If you only want to delete the blockout for this date, enter 'YES'.  Enter",!,"RETURN to delete the blockout from this date on." G ASK
 W !!,"Updating Schedules...",!! S SRSALL=$S("Nn"[Z:1,1:0) I SRSALL=1 G MULD
DEL D:'SRSALL MULD
 Q:^SRS(SRSOR,"S",SRSDATE,1)'[SRBCKH
 S SRS1=11+($P(SRSST,".")*5)+(SRSST-$P(SRSST,".")*100\15),SRS2=11+($P(SRSET,".")*5)+(SRSET-$P(SRSET,".")*100\15),S="" F I=SRS1:1:SRS2-1 S S=S_$S('(I#5):"|",1:"_")
 S X0=^SRS(SRSOR,"SS",SRSDATE,1),(X0,^(1))=$E(X0,1,SRS1)_S_$E(X0,SRS2+1,200)
 S X1=^SRS(SRSOR,"S",SRSDATE,1)
 F I=SRS1:1:SRS2+1 I $E(X1,I)'="X" S X1=$E(X1,1,I-1)_$E(X0,I)_$E(X1,I+1,200)
 S ^SRS(SRSOR,"S",SRSDATE,1)=X1
 G:'SRSALL END Q
DAY S DAY2=$S(DAY="MO":"Monday",DAY="TU":"Tuesday",DAY="WE":"Wednesday",DAY="TH":"Thursday",DAY="FR":"Friday",DAY="SA":"Saturday",1:"Sunday")
 Q
CK1 I SRSNUM=0 S X=7 D UPDATE G:X CK1
CK2 I SRSNUM>7 S X=14 D UPDATE G:X CK2
CK0 I SRSNUM>0,(SRSNUM<5) S X5=$E(SRSDATE,4,5),X1=SRSDATE,X2=7 D C^%DTC S SRSDATE=X G:$E(X,4,5)=X5 CK0
CK3 I SRSNUM>0,(SRSNUM<5) S X=SRSNUM-1*7 D UPDATE G:X CK0
CK5 I SRSNUM=5 S X1=SRSDATE,X2=21 D C^%DTC S SRSDATE=X
CK4 I SRSNUM=5 S X1=SRSDATE,X2=7,X5=$E(SRSDATE,4,5) D C^%DTC S SRSDATE=X G:$E(SRSDATE,4,5)=X5 CK4 S X=-7 D UPDATE G:X CK5
 Q
UPDATE S X1=SRSDATE,X2=X D C^%DTC S SRSDATE=X D:$D(^SRS(SRSOR,"S",SRSDATE)) DEL S X=1 S:$O(^SRS(SRSOR,"S",SRSDATE))="" X=0 Q
TIME S TIME=0 F I=0:0 S TIME=$O(^SRS("SER",SRSSER,OR,DAY,TIME)) Q:TIME=""  S CNT=CNT+1,ETIME=$P(^(TIME),"^",2) D DAY S SRSOR(CNT)=CNT_".  "_SRSOR_" on "_DAY2_" from "_TIME_" to "_ETIME_"^"_OR_"^"_DAY_"^"_TIME_"^"_ETIME
 Q
MULD ; delete all
 S S="" F I=SRX1:1:SRX2-1 S S=S_$S('(I#5):"|",$E(SRSSER,I#5)'="":$E(SRSSER,I#5),1:".")
 S SRBCKH=S
 Q:'SRSALL
 S X=0 D UPDATE,DELCHK^SRSBUTL(DAY),CK1 S DA(3)=SRSOR,DA(2)=$O(^SRS(DA(3),1,"B",DAY,0)),DA(1)=$O(^SRS(DA(3),1,DA(2),1,"B",SRSSER,0)),DA=$O(^SRS(DA(3),1,DA(2),1,DA(1),1,"B",SRSST,0))
 S DIK="^SRS("_DA(3)_",1,"_DA(2)_",1,"_DA(1)_",1," D ^DIK
 I '$O(^SRS(DA(3),1,DA(2),1,DA(1),1,0)) S DA=DA(1),DA(1)=DA(2),DA(2)=DA(3) K DA(3) S DIK="^SRS("_DA(2)_",1,"_DA(1)_",1," D ^DIK I '$O(^SRS(DA(2),1,DA(1),1,0)) S DA=DA(1),DA(1)=DA(2) S DIK="^SRS("_DA(1)_",1," D ^DIK
 K ^SRS("R",DAY,SRSOR,SRSST,SRSNUM),^SRS("SER",SRSSER,SRSOR,DAY,SRSST)
END I 'SRSOUT W !!,"Press RETURN to continue  " R X:DTIME
 D ^SRSKILL K SRBCKH,SRBPRG W @IOF
 Q
QUES W !!,"Choose from: " S SERV=0 F I=0:0 S SERV=$O(^SRS("C",SERV)) Q:SERV=""  W !,?5,SERV
 Q
