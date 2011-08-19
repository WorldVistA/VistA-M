ENCTMAN ;(WASH ISC)/RGY-Schedule Processing of Bar Code Data ;1-11-90
 ;;7.0;ENGINEERING;;Aug 17, 1993
 ;Copy of PRCTMAN ;DH-WASH ISC
 S DIC="^PRCT(446.4,",DIC(0)="QEAM" D ^DIC G:+Y<0 Q5 S:'$D(^PRCT(446.4,+Y,2,0)) ^(0)="^446.42DI^^" S (DA(1),ENCTID)=+Y,DIC=DIC_ENCTID_",2," D ^DIC G:+Y<0 Q5 S ENCTTI=+Y
 W !!,"Current Status is: ",$P(^PRCT(446.4,ENCTID,2,ENCTTI,0),"^",3)
 S X="Are you sure you want to reschedule this data to process ?^Y" D ENYN^ENCTQUES I X="^"!'X W !,"OK, nothing scheduled !",! G Q5
 S ZTDTH=-1 D TASK^ENCTREAD
Q5 K DIC,DA Q
DEQUE ;
 S ENCT=$S('$D(ENCTID):0,$D(^PRCT(446.4,ENCTID,0))#2:^(0),1:0) G:ENCT=0 Q4 G:$S('$D(ENCTTI):1,1:'$D(^PRCT(446.4,ENCTID,2,ENCTTI,0))#2) Q4
 I $P(ENCT,"^",4)="" D TIME S $P(^PRCT(446.4,ENCTID,2,ENCTTI,0),"^",3)="RTN FLD IS MISSING"_Y G Q4
 S X=$P(ENCT,"^",4) D RTN^ENCTUTL I '$D(X) D TIME S $P(^PRCT(446.4,ENCTID,2,ENCTTI,0),"^",3)="RTN IS MISSING"_Y G Q4
 D TIME S X=$P(ENCT,"^",4),$P(^PRCT(446.4,ENCTID,2,ENCTTI,0),"^",3)="STARTED ON"_Y D @($P(X,"-")_"^"_$P(X,"-",2)),TIME S:$E($P(^PRCT(446.4,ENCTID,2,ENCTTI,0),"^",3),1,11)="STARTED ON-" $P(^(0),"^",3)="FINISHED ON"_Y
Q4 K ENCT,ENCTID,ENCTTI Q
TIME D NOW^%DTC S Y=% X ^DD("DD") S Y="-"_Y Q
