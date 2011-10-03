SOWKDB1 ;B'HAM ISC/SAB-DATA BASE ASSESSMENT PROFILE CONTINUED ; [ 06/17/96  9:33 AM ]
 ;;3.0; Social Work ;**14,17,26,38,44**;27 Apr 93
 S DIWR=80,DIWL=10,DIWF="W"
 D CHK^SOWKDB Q:$G(SWX)["^"  W !?5,"2.  Usual Occupation: "_$S($P(^DPT(DFN,0),"^",7)]"":$P(^DPT(DFN,0),"^",7),1:"_______________")
 S TI=0 F G=1:1:8 S TI=TI+(+$P(VAMB(G),"^",2))
 D CHK^SOWKDB Q:$G(SWX)["^"  W !?5,"3.  Present Source of Funds:",!?9,"Total Income: _________",!?9,"HB: _________"
 D CHK^SOWKDB Q:$G(SWX)["^"  W ?25,"Employment:__________",?50,"Social Security: _________"
 D CHK^SOWKDB Q:$G(SWX)["^"  W !?9,"VA Pension: _________",?35,"Retirement: _________",!?9,"SSI: _________",?25,"VA Compensation: _________",?53,"Other Disability:_________",!?9,"A&A: _________"
 D CHK^SOWKDB Q:$G(SWX)["^"  W ?25,"None:________",?50,"Other: _________"
 D CHK^SOWKDB Q:$G(SWX)["^"  W !?5,"4.  Potential source of other financial resources:"
 I $O(^SOWK(655.2,DFN,1,0)) F SOWKG=0:0 D CHK^SOWKDB S SOWKG=$O(^SOWK(655.2,DFN,1,SOWKG)) Q:'SOWKG  S X=^(SOWKG,0) D ^DIWP
 D ^DIWW
 D CHK^SOWKDB Q:$G(SWX)["^"  W !?5,"5.  Assets: " F G=1:1:63 W "_"
 D CHK^SOWKDB Q:$G(SWX)["^"  W !?5,"6.  Potential Employability:  "_$S($P(^SOWK(655.2,DFN,0),"^",22)=1:"YES",$P(^(0),"^",22)=2:"NO",1:"UNSPECIFIED")
 D CHK^SOWKDB Q:$G(SWX)["^"  W !?5,"7.  Insurance Coverage: " S I=0 F G=0:0 S G=$O(^DPT(DFN,.312,G)) Q:'G  S IC=$P(^DPT(DFN,.312,G,0),"^"),I=I+1,IC(I)=$S($D(^DIC(36,IC,0)):$P(^DIC(36,IC,0),"^"),1:"UNKNOWN") W IC(I)_", " D CHK^SOWKDB
 D CHK^SOWKDB Q:$G(SWX)["^"  W !?5,"8.  Employment/Financial Assessment: " I $O(^SOWK(655.2,DFN,2,0)) F SOWKG=0:0 D CHK^SOWKDB S SOWKG=$O(^SOWK(655.2,DFN,2,SOWKG)) Q:'SOWKG  S X=^(SOWKG,0) D ^DIWP
 D ^DIWW
 S EDL=$P(^SOWK(655.2,DFN,0),"^",23),ED="LESS THAN 6^6 - 12^12 - 16^MORE THAN 16" D CHK^SOWKDB Q:$G(SWX)["^"  W !!,"III.  Education:",!?5,"1.  Highest educational level attained: "_$S(EDL:$P(ED,"^",EDL)_" YEARS",1:"UNSPECIFIED")
 D CHK^SOWKDB Q:$G(SWX)["^"  W !?5,"2.  Special educational training or skills: " I $O(^SOWK(655.2,DFN,3,0)) F SOWKG=0:0 D CHK^SOWKDB S SOWKG=$O(^SOWK(655.2,DFN,3,SOWKG)) Q:'SOWKG  S X=^(SOWKG,0) D ^DIWP
 D ^DIWW
 D CHK^SOWKDB Q:$G(SWX)["^"  W !?5,"3.  "_$S($P(^SOWK(655.2,DFN,0),"^",4):"Yes,",1:"Is not, or unknown if")_" currently enrolled in an educational program" W:'$P(^(0),"^",4) !?8 W " or trade school."
 G:'$P(^SOWK(655.2,DFN,0),"^",4) ED W !?9,"(If 'Yes' explain)"
 F T=1:1:3 W !?9 F G=1:1:71 W "_"
ED D CHK^SOWKDB Q:$G(SWX)["^"  W !?5,"4.  Educational Assesment:" I $O(^SOWK(655.2,DFN,4,0)) F SOWKG=0:0 D CHK^SOWKDB S SOWKG=$O(^SOWK(655.2,DFN,4,SOWKG)) Q:'SOWKG  S X=^(SOWKG,0) D ^DIWP
 D ^DIWW
 D CHK^SOWKDB Q:$G(SWX)["^"  W !!,"IV.  Military History:",!?5,"1.  Period of Service: " W $P(VAEL(2),"^",2)
 D CHK^SOWKDB Q:$G(SWX)["^"  W !?5,"2.  POW - "_$S(+VASV(4):"Yes",1:"NO"),!?5,"3.  Combat - "_$S(+VASV(5):"YES",1:"NO")
 D CHK^SOWKDB Q:$G(SWX)["^"  W !?5,"4.  Service Connected Disability: "_$S(+VAEL(3):$P(VAEL(3),"^",2)_"%",1:"")
 D CHK^SOWKDB Q:$G(SWX)["^"  W !?5,"5.  Military Assessment: " I $O(^SOWK(655.2,DFN,5,0)) F SOWKG=0:0 D CHK^SOWKDB S SOWKG=$O(^SOWK(655.2,DFN,5,SOWKG)) Q:'SOWKG  S X=^(SOWKG,0) D ^DIWP
 D ^DIWW
 D CHK^SOWKDB Q:$G(SWX)["^"  W !!,"V.  Social/Family Relationship:",!?5,"1.  Marital status: "_$P(VADM(10),"^",2)
 D CHK^SOWKDB Q:$G(SWX)["^"  W !?5,"2.  Spouse: " G:'$D(^SOWK(655.2,DFN,6)) NX W !?15,$P(^SOWK(655.2,DFN,6),"^"),!?15,$P(^(6),"^",2) W:$P(^(6),"^",3)]"" !?15,$P(^(6),"^",3)
 D CHK^SOWKDB W !?15,$P(^SOWK(655.2,DFN,6),"^",4),?$X+5,$S($P(^(6),"^",5):", "_$P(^DIC(5,$P(^(6),"^",5),0),"^"),1:"")_"  "_$P(^SOWK(655.2,DFN,6),"^",6),!?15,"Phone #: "_$P(^(6),"^",7)
NX D CHK^SOWKDB Q:$G(SWX)["^"  W !?5,"3.  Children: "
 F SOWKG=0:0 D CHK^SOWKDB S SOWKG=$O(^SOWK(655.2,DFN,7,SOWKG)) Q:'SOWKG  D CHK^SOWKDB Q:$G(SWX)["^"  S X2=$P(^SOWK(655.2,DFN,7,SOWKG,0),"^",2),X1=DT D ^%DTC S AG=X\365.25 W !?15,$P(^SOWK(655.2,DFN,7,SOWKG,0),"^"),?50,"Age: "_AG K AG
 D ^SOWKDB2 Q
HDR U IO W:PG'=0!($E(IOST)["C") @IOF Q:$E(IOST)["C"  F Q=1:1:5 W !
 F Q=1:1:80 W "_"
 S PG=PG+1 W !?20,"SOCIAL WORK SERVICE-REPORTS AND SUMMARIES",?65,"PAGE: "_PG_"."
 F E=1:1:2 W ! F W=1:1:80 W "_"
 W ! Q
