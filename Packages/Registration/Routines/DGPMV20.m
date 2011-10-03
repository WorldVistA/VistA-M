DGPMV20 ;ALB/MIR - DISPLAY DATES FOR SELECTION ; 27 APR 90
 ;;5.3;Registration;**40**;Aug 13, 1993
 W !!,"CHOOSE FROM:" F I=1:1:6 Q:'$D(^UTILITY("DGPMVN",$J,I))  D WR
 Q
WR S DGX=$P(^UTILITY("DGPMVN",$J,I),"^",2,20),DGIFN=+^(I),Y=+DGX X ^DD("DD") W !,$J(I,2),">  ",Y I 'DGONE W ?27,$S('$D(^DG(405.1,+$P(DGX,"^",4),0)):"",$P(^(0),"^",7)]"":$P(^(0),"^",7),1:$E($P(^(0),"^",1),1,20))
 I DGPMT=4!(DGPMT=5) S DGPMLD=$S($D(^DGPM(+DGIFN,"LD")):^("LD"),1:"")
 D @("W"_DGPMT) K DGIFN,DGX,DGPMLD Q
W1 W ?50,"TO:  ",$S($D(^DIC(42,+$P(DGX,"^",6),0)):$E($P(^(0),"^",1),1,17),1:"") I $D(^DG(405.4,+$P(DGX,"^",7),0)) W " [",$E($P(^(0),"^",1),1,10),"]"
 I $P(DGX,"^",18)=9 W !?23,"FROM:  ",$S($D(^DIC(4,+$P(DGX,"^",5),0)):$P(^(0),"^",1),1:"")
 Q
W2 Q:"^25^26^"[("^"_$P(DGX,"^",18)_"^")
 I "^43^45^"[("^"_$P(DGX,"^",18)_"^") W ?50,"TO:  ",$S($D(^DIC(4,+$P(DGX,"^",5),0)):$E($P(^(0),"^",1),1,18),1:"") Q
 I "^1^2^3^"[("^"_$P(DGX,"^",18)_"^") W ?50,"RETURN:  " S Y=$P(DGX,"^",13) X ^DD("DD") W Y Q
 W ?50,"TO:  ",$S($D(^DIC(42,+$P(DGX,"^",6),0)):$E($P(^(0),"^",1),1,17),1:"") I $D(^DG(405.4,+$P(DGX,"^",7),0)) W " [",$E($P(^(0),"^",1),1,10),"]"
 Q
W3 I $P(DGX,"^",18)=10 W ?50,"TO:  ",$S($D(^DIC(4,+$P(DGX,"^",5),0)):$E($P(^(0),"^",1),1,18),1:"")
 Q
W4 S X="" I $P(DGX,"^",18)=5 S X=$S($D(^DIC(42,+$P(DGX,"^",6),0)):^(0),1:"")
 I $P(DGX,"^",18)=6 S X=$S($D(^DIC(4,+$P(DGX,"^",5),0)):^(0),1:"")
 W ?55,"TO:  ",$E($P(X,"^",1),1,20)
 I DGPMLD]"" W !?7,"REASON:  ",$S($D(^DG(406.41,+DGPMLD,0)):$E($P(^(0),"^",1),1,20),1:""),?35,"COMMENTS:  ",$P(DGPMLD,"^",2)
 Q
W5 W:DGONE ?30 W:'DGONE !?7 W "DISPOSITION: ",$S($P(DGPMLD,"^",3)="a":"ADMITTED",$P(DGPMLD,"^",3)="d":"DISMISSED",1:"") Q
W6 W:DGONE ?30 W:'DGONE !?7 W "SPECIALTY:  ",$S($D(^DIC(45.7,+$P(DGX,"^",9),0)):$E($P(^(0),"^",1),1,18),1:"")
 W:DGONE !?7 W:'DGONE ?37 W "PROVIDER :  ",$S($D(^VA(200,+$P(DGX,"^",8),0)):$E($P(^(0),"^",1),1,15),1:"")
 W:DGONE !?7 W:'DGONE ?33 W "ATTENDING:  ",$S($D(^VA(200,+$P(DGX,"^",19),0)):$E($P(^(0),"^",1),1,15),1:"")
 S DGDX=$S($D(^DGPM(+DGIFN,"DX",1,0)):$E(^(0),1,30),1:"") I DGDX]"" W:DGONE ?37 W:'DGONE !?7 W "DX:  ",DGDX
 K DGDX Q
ENEX ;CALLED FROM DGPMEX FOR EXTENDED BED CONTROL/EXTENDED PATIENT INQ
 S IOP="HOME" D ^%ZIS S DGFL=0 W @IOF,!!,"ADMISSION:" S DGX=DGPMAN,DGPMT=1,DGONE=0 D WEX
 S DGPMT=2 W !!,"TRANSFERS:" F I=+DGPMAN+.0000005:0 S I=$O(^DGPM("APCA",DFN,DGPMCA,I)) Q:'I  S DGX=$O(^(I,0)) I $D(^DGPM(+DGX,0)) S DGX=^(0) Q:($P(DGX,"^",2)=3)  D WEX Q:DGFL
 G Q:DGFL S DGONE=1 ;I $O(^DG(405.1,"AM",DGX,+$O(^DG(405.1,"AM",DGX,0)))) S DGONE=0
 W !!,"TREATING SPECIALTY CHANGES:" S DGPMT=6 K ^UTILITY($J,"ATS") F I=0:0 S I=$O(^DGPM("ATS",DFN,DGPMCA,I)) Q:'I  S J=$O(^(I,0)),DGIFN=$O(^(+J,0)) I $D(^DGPM(+DGIFN,0)) S ^UTILITY($J,"ATS",+^(0),DGIFN)=^(0)
 F I=0:0 S I=$O(^UTILITY($J,"ATS",I)) Q:'I  S DGIFN=$O(^(I,0)),DGX=^(DGIFN) D WEX Q:DGFL
 I 'DGFL W !!,"DISCHARGE:" I $D(^DGPM(+$P(DGPMAN,"^",17),0)) S DGX=^(0),DGPMT=3,DGONE=0 D WEX
Q K DIR,I,J,DGDIS,DGIFN,DGX,DUOUT,DTOUT Q
WEX S Y=+DGX X ^DD("DD") W !?5,Y W:'DGONE ?27,$S('$D(^DG(405.1,+$P(DGX,"^",4),0)):"",$P(^(0),"^",7)]"":$P(^(0),"^",7),1:$E($P(^(0),"^",1),1,20))
 D @("W"_DGPMT) I $S(DGPMT=1:0,DGPMT'=3:1,1:0),($Y>(IOSL-5)) S DIR(0)="E" D ^DIR S DGFL='Y S:$D(DTOUT) DGFL=2 I 'DGFL W @IOF
 Q
