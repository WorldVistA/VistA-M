RTT11 ;ISC-ALBANY/MJK,PKE-Record Transaction Option; ; 5/7/87  12:02 PM ;
 ;;v 2.0;Record Tracking;;10/22/91 
 ;;multiple new Volume Creation
11 S RTA=+RTAPL D ASK^RTB K RTA G Q2:$D(RTESC),11:Y<0 S RTE=X D NEW G 11
NEW D SET1 I '$D(RTS) S Y=RTE D NAME^RTB W !!?3,*7,"...currently no volume #1 for ",Y,".",!,?3,"...use Create volume option." Q
 ;
 W !!?5,"Record Type",?30,"Highest Volume Number",!?5,"------------",?30,"---------------------"
 S RTC=0 F T=0:0 S T=$O(RTS(T)) Q:'T  S RTC=RTC+1,X=RTS(T) W !?5,$P(X,"^",3),?40,+X
 S:$D(RTTY) RTTYX=RTTY I RTC=1 S Y=+$O(RTS(0)) D TYPE1^RTUTL
 I RTC>1 W ! S DIC="^DIC(195.2,",DIC("S")="I $D(RTS(+Y)),$S('$D(^(""I"")):1,'^(""I""):1,1:DT'>^(""I""))",DIC("A")="Select Record Type: ",DIC(0)="IAEMQZ" D ^DIC K DIC G SETQ:Y<0 S RTTY=+Y_";"_Y(0)
 S X=RTS(+RTTY),RTVOL=X+1,RTPAR=+$P(X,"^",2)
 S RTRD(1)="Yes^create new volumes",RTRD(2)="No^do not create new volumes",RTRD(0)="S",RTRD("B")=2,RTRD("A")="Create "_$P(X,"^",3)_" Volumes starting with # "_RTVOL_"? " D SET^RTRD K RTRD S X=$E(X) G SETQ:X'="Y"
RD W !," Enter the Highest volume # to create,  Volume # ",RTVOL,"?// " R X:DTIME I '$T!(X["^") G SETQ
 I X["?"!($E(X_1)'?1N) W !!,?5,"Enter a number between '",RTVOL,"' and '",RTVOL+5,"'",! G RD
 S:X="" X=RTVOL I X<RTVOL!(X>(RTVOL+5)) G RD
 ;
 S RTVOLL=X W !," .." F RTVOL=RTVOL:1:RTVOLL S RTSHOW="" D SET^RTDPA1 K RTSHOW
 D ^RTT12
SETQ K RTESC,RTSHOW,RTC,T,V,RTPAR,RTVOL,RTVOLL,RT,RTTY,RTS S:$D(RTTYX) RTTY=RTTYX K RTTYX Q
 ;
SET1 F I=0:0 S I=$O(^RT("AA",+RTAPL,RTE,I)) Q:'I  I $D(^RT(I,0)) S X=^(0),T=+$P(X,"^",3),V=+$P(X,"^",7) I $D(^DIC(195.2,T,0)),$P(^(0),"^",17)="y",$P(X,"^",4)=+RTAPL,$S('$D(RTTY):1,T=+RTTY:1,1:0) D SET2
 Q
SET2 ;naked ref to the current record type ^DIC(195.2,x,0)
 S:'$D(RTS(T)) RTS(T)=V_"^^"_$P(^(0),"^") S:V=1 $P(RTS(T),"^",2)=I S:+RTS(T)'>V $P(RTS(T),"^")=V Q
 Q
Q2 K RTE,RTESC
 K %,%YV,D0,DGO,DI,DIC,DICR,DIE,DIG,DIH,DIU,DIV,DIW,DIYS,DK,DL,DR,I1,POP Q
12 ;select last record/volume to update pointers
 W ! S DIC(0)="AZEMQ",RTSEL="" D ^RTDPA K DIC,RTESC,RTY,RTC G Q12:Y<0 S RT=+Y,RT0=Y(0),V=+$P(RT0,"^",7),P=$S(V=1:RT,1:+$P(RT0,"^",5)),T=+$P(RT0,"^",3) G 12:'P
 ;
 S V1=0,I=0 F J=1:1 S I=$O(^RT("P",P,I)) Q:'I  I $D(^RT(I,0)),$P(^(0),"^",7)>V1 S V1=+$P(^(0),"^",7)
 I J<2 W !!?5,"No multiple volumes selected" G 12
 I V1>V W !!?5,*7,"This record is volume '",V,"' of a '",V1,"' record set.",!?5,"Requests may only be transferred to volume, 'V",V1,"'" G 12
 S RTPAR=P,RTVOL=V,Y=T D TYPE1^RTUTL I '$D(RTTY) W !!?5,"Unknown Record type" G 12
 S Y=$P(RT0,"^") D NAME^RTB W !!,"Record Chosen: ",Y,"'s ",$S($D(^DIC(195.2,+$P(RT0,"^",3),0)):$P(^(0),"^"),1:"UNKNOWN")," [Volume: ",+$P(RT0,"^",7),"]"
 ;
 S RTRD("A")="Pending Requests will be transferred to last Record/Volume just selected. "_$C(13,10)_"        Transfer Requests to volume '"_RTVOL_"' ? "
 D ^RTT12
 ;
Q12 K RTTY,RTVOL,RTPAR,RTDIK,RTI,RT,P,T,J,I,V,V1
 K RT0,RTBCIFN,RTSEL,X Q
 Q
