SDNACT ;ALB/TMP - INACTIVATE A CLINIC ;9/16/10  17:38
 ;;5.3;Scheduling;**63,380,549,568**;Aug 13, 1993;Build 14
 S:'$D(DTIME) DTIME=300 I '$D(DT) D DT^SDUTL
 S SDAY="Sun^Mon^Tues^Wednes^Thurs^Fri^Satur",SDZQ=1
 D DT^DICRW S DIC="^SC(",DIC(0)="AEMZQ",DIC("A")="Select CLINIC NAME: ",DIC("S")="I $P(^(0),""^"",3)=""C"",'$G(^(""OOS""))"
 D TURNON^DIAUTL(44,".01;8;2502;2503;2505;2506")
 D ^DIC K DIC("A"),DIC("S") G:Y<0 END S SC=+Y,SDX="",SDX1=9999999
 N SDRES S SDRES=$$CLNCK^SDUTL2(SC,0)
 I 'SDRES D
 .W !,?5,"WARNING:     Clinic's Stop Code ",$P(SDRES,U,2)
 .W !,?5,"Recommend:   Clinic be corrected."
 I $D(^SC(SC,"I")),+^("I")'=0,+^("I")'>DT,+$P(^("I"),"^",2)'>0 W *7,!,"This clinic was inactivated effective: " S Y=+^("I") D DTS^SDUTL W Y G END
 I $D(^SC(SC,"I")),+^("I")>DT G CHECK
 I $D(^SC(SC,"I")),+^("I")'>DT,+$P(^("I"),"^",2)'<DT W !,*7,"Clinic is already inactive until " S Y=+$P(^("I"),"^",2) D DTS^SDUTL W Y G END
D S %DT="AEFX",%DT("A")="Enter Date Clinic is to be Inactivated: " D ^%DT K %DT G:Y'>0 END S SDDATE=Y I Y<DT W "??",!,*7,"Inactivate date must be greater than or equal to today's date" G D
 I SDX<9999999,Y>SDX1,SDX1 W "??",!,*7,"Inactivate date must be < reactivate date" G D
 S POP=0 F I=SDDATE-.0001:0 S I=$O(^SC(SC,"S",I)) Q:'I!(POP)!(SDDATE'<SDX1&(SDX1))  F I1=0:0 S I1=$O(^SC(SC,"S",I,1,I1)) Q:'I1  I $P(^(I1,0),"^",9)'="C" S POP=1 Q
 I POP W *7,!,"Can't inactivate the clinic - appointments exist beyond " S Y=SDDATE D DT^DIQ G END
 I SDX'="" D CHG1 G OVR
 K SDN S ^SC(SC,"I")="",X=SDDATE D DOW^SDM0 S SDN(Y)=SDDATE F I=1:1:6 S X2=1,X1=X D C^%DTC,DOW^SDM0 S SDN(Y)=X
 F I=0:1:6 S J=$O(^SC(SC,"T"_I,SDN(I))) D GOT
OVR F I=SDDATE-.0001:0 S I=$O(^SC(SC,"ST",I)) Q:'I!(I>SDX1)  K ^(I)
 F I=SDDATE-.0001:0 S I=$O(^SC(SC,"T",I)) Q:'I!(I>SDX1)  K ^(I)
 F I=SDDATE-.0001:0 S I=$O(^SC(SC,"OST",I)) Q:'I!(I>SDX1)  K ^(I)
 S DIE="^SC(",DA=SC,DR="2505///^S X=SDDATE" D ^DIE  ;SD*549 use FM API to update field so Audit Trail functions properly
 W !!,"Clinic will be inactivated effective " S Y=SDDATE D DTS^SDUTL W Y G END
 ;
CHECK W *7,!,"This clinic is to be inactivated as of " S SDX=+^("I"),Y=SDX D DTS^SDUTL W Y S SDX1=+$P(^("I"),"^",2),Y=SDX1 I Y D DTS^SDUTL W " and reactivated as of ",Y ;NAKED REFERENCE - ^SC(DFN,"I")
 S %=1 W !,"Do you want to change the inactivate date" D YN^DICN I '% W !,"RESPOND YES OR NO" G CHECK
 G D:'(%-1),END:(%<0),DEL
 ;
DEL S %=2 W !,"Do you want to delete the inactivate date" D YN^DICN I '% W !,"RESPOND YES (Y) OR NO (N)" G DEL
 G:(%-1) END
 I '$D(^SC(SC,"SL")) W !,*7,"Cannot Delete - 'SL' node doesn't exist" G END
 G ^SDNACT1
CHG1 K SDN S X1=SDDATE,X2=6 D C^%DTC S SDNL=X,X=SDDATE D DOW^SDM0 S SDN(Y)=X
 F I=1:1:6 S X1=X,X2=1 D C^%DTC,DOW^SDM0 S SDN(Y)=X
 S X1=SDX,X2=6 D C^%DTC S SDOL=X,X1=SDX,X2=-1 D C^%DTC
 F I=0:0 S X2=1,X1=X D C^%DTC Q:X>SDOL  D DOW^SDM0 S:$D(^SC(SC,"T"_Y))&($O(^SC(SC,"T"_Y,0))'=9999999) ^SC(SC,"T"_Y,SDN(Y),1)=$S($D(^SC(SC,"T"_Y,X,1)):^(1),1:""),^(0)=SDN(Y) D A1,A
 I SDDATE<SDX F I=0:1:6 F J=SDNL:0 S J=$O(^SC(SC,"T"_I,J)) Q:'J!(J'<SDX)  K ^SC(SC,"T"_I,J)
 Q
A1 S:'$D(^SC(SC,"T"_Y,9999999,1)) ^(1)="",^(0)=9999999 K:(SDN(Y)-X) ^SC(SC,"T"_Y,X)
 Q
A I $O(^SC(SC,"T"_Y,SDN(Y)))>0 S SD=$O(^SC(SC,"T"_Y,SDN(Y))) S:^SC(SC,"T"_Y,SD,1)]"" ^SC(SC,"T"_Y,SDN(Y),1)=^SC(SC,"T"_Y,SD,1),^(0)=SDN(Y),^SC(SC,"T"_Y,SD,1)=""
 I SDX'>SDDATE,$O(^SC(SC,"ST",SDX-.1))>0 F Z=SDX-.1:0 S Z=$O(^SC(SC,"ST",Z)) Q:'Z!(SDX1&(Z'<SDX1))  K ^SC(SC,"ST",Z)
 K SD,Z Q
GOT S SD=$O(^SC(SC,"T"_I,0))
 I J>0,SD'=9999999 S ^SC(SC,"T"_I,SDN(I),1)=^SC(SC,"T"_I,J,1),^(0)=SDN(I) K ^SC(SC,"T"_I,J) F J1=J:0 S J1=$O(^SC(SC,"T"_I,J1)) Q:'J1  K ^SC(SC,"T"_I,J1)
 S ^SC(SC,"T"_I,9999999,1)="",^(0)=9999999
 Q
END K A,DA,CNT,D0,DH,DO,DOW,I,I1,J,J1,POP,SC,SD,SD0,SDAY,SDEL,SDDATE,SDFSW,SDN,SDNL,SDOL,SDREACT,SI,SL,STARTDAY,SDX,SDX1,SDZQ,X,X1,X2,Y,Z,DIE,DR,DIC Q
