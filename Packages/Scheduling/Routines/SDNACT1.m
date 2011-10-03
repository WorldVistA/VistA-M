SDNACT1 ;ALB/TMP - Inactivate a Clinic (continued) ; 30 APR 85  9:02 am 
 ;;5.3;Scheduling;**167**;Aug 13, 1993
 S SDREACT="",SD0=0,X=$S(SDX1:SDX1,1:SDX) D DOW^SDM0 S SDN(Y)=X D PAT F I=1:1:6 S X1=X,X2=1 D C^%DTC,DOW^SDM0 S SDN(Y)=X D PAT
R I 'SD0 S SD=SDX G SEL
 S Y=$S(SDX1:SDX1,1:SDX) D D^DIQ
 W !,"Do you want to restore to the existing patterns from the ",$S(SDX1:"re",1:"in"),"activate date ",Y S %=2 D YN^DICN I '% D LIST G R
 S SDREACT="" G:%<0 END^SDNACT I (%-1) S SD=SDX G SEL
 F I=0:1:6 I $D(SDN(I,1)) D D1
 S SD=$S(SDX1:SDX1,1:SDX) D SET
 D G1^SDB G DD
D1 W !!,"Do you want to restore this pattern ",!,SDN(I,1),!,?7,"for ",$P(SDAY,"^",I+1),"days " S Y=SDN(I) D D^DIQ W "from ",Y S %=1 D YN^DICN I '% W !,"RESPOND YES (Y) OR NO (N)" G D1
 Q:(%-1)  S SDREACT=1 I SDX1 Q:$O(^SC(SC,"T"_I,0))=SDN(I)  K ^SC(SC,"T"_I,SDN(I)) Q
 S SD=$O(^SC(SC,"T"_I,SDN(I))) Q:SD'>0  S ^SC(SC,"T"_I,SD,1)=SDN(I,1),^(0)=SD K ^SC(SC,"T"_I,SDN(I))
 Q
LIST W !!!,"EXISTING PATTERNS: ",! F A=0:1:6 I $D(SDN(A,1)) W !,$P(SDAY,"^",A+1),"day " S Y=SDN(A) D DT^DIQ W " : ",!,SDN(A,1),!
 W !! Q
SEL W !!,"AVAILABILITY DATE: ",$E(SDX,4,5),"-",$E(SDX,6,7),"-",$E(SDX,2,3),"  (" S Y=SDX D DT^DIQ W ")" D SET
 S SDH1=$S($D(SDIN):SDIN,1:""),SDH2=$S($D(SDRE):SDRE,1:"") K SDINH,SDIN,SDRE
 D EN1^SDB0 S SDRE=SDH2,SDIN=SDH1 K SDH1,SDH2,CNT,D0,DH,DO,H1,H2,HSI,LT,M1,M2,NSL
DD I $S('$D(SDREACT):1,1:0) W *7,!,"Inactivation date not deleted" G END^SDNACT
 K ^SC(SC,"I") W !,*7,"Inactivation date deleted" G END^SDNACT
 ;
SET S (POP,SDEL)=0,DA=SC,SL=^SC(SC,"SL"),X=$P(^("SL"),"^",3),STARTDAY=$S($L(X):X,1:8),SI=$P(^("SL"),"^",6),SDFSW="",X=SD,D0=SD D DOW^SDM0 S DOW=Y
 Q
PAT I $D(^SC(SC,"T"_Y,X,1)) S SDZ=$S(SDX1:+$O(^SC(SC,"T"_Y,X)),1:X) I SDZ>0,$D(^SC(SC,"T"_Y,SDZ,1)),^(1)]"" S SDN(Y,1)=^(1) S:'SD0 SD0=1
 K SDZ Q
