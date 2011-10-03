DGPMOLD1 ;ALB/MIR - CONTINUATION OF LODGER OUTPUTS (SORT/PRINT) ;23 MAY 90 @12
 ;;5.3;Registration;;Aug 13, 1993
STORE D NOW^%DTC S Y=% X ^DD("DD") S DGNOW=Y I DGHOW=2 S Y=DGFR+.1 X ^DD("DD") S DGFROM=Y,Y=$P(DGTO,".") X ^DD("DD") S DGEND=Y
 G:DGHOW=2 DR S W=""
 F I=0:0 S W=$S(VAUTW:$O(^DGPM("LD",W)),1:$O(VAUTW(W))) Q:W=""  S DGX=$O(^DIC(42,"B",W,0)),DGX=$S($D(^DIC(42,+DGX,0)):$P(^(0),"^",11),1:0) D DIV I DGX'<0 F J=0:0 S J=$O(^DGPM("LD",W,J)) Q:'J  D SORT ;current lodgers
 I DGOF F I=0:0 S I=$O(^DGPM("ATID4",I)) Q:'I  S J=$O(^(I,0)),J=$O(^(+J,0)) I $D(^DGPM(+J,0)) S X=^(0) I '$P(X,"^",17),($P(X,"^",18)=6) S W="ZZOF"_$S($D(^DIC(4,+$P(X,"^",5),0)):$P(^(0),"^",1),1:"UNKNOWN") D SORT ;current lodgers/other facility
 D PRINT Q
DR ;lodgers for a date range
 F I=0:0 S I=$O(^DGPM("AMV4",I)) Q:'I!(I>DGTO)  F K=0:0 S K=$O(^DGPM("AMV4",I,K)) Q:'K  S J=$O(^(+K,0)) D SORT
 D PRINT Q
SORT Q:'$D(^DGPM(+J,0))  S X=^(0),R=$P(X,"^",7) I DGHOW=2,'DGOF,($P(X,"^",18)=6) Q
 I $D(^DGPM(+$P(X,"^",17),0)),(^(0)<DGFR) Q
 I DGHOW=2 S W=$S($P(X,"^",18)=5:$S($D(^DIC(42,+$P(X,"^",6),0)):$P(^(0),"^",1),1:"UNKNOWN"),1:"ZZOF"_$S($D(^DIC(4,+$P(X,"^",5),0)):$P(^(0),"^",1),1:"UNKNOWN")),DGX=$P(X,"^",6) I DGX Q:$S(VAUTW:0,$D(VAUTW(DGX)):0,1:1)
 I DGHOW=2,DGX S DGX=$S($D(^DIC(42,+DGX,0)):$P(^(0),"^",11),1:0) D DIV Q:DGX<0
 S DFN=$P(X,"^",3),L=$S($D(^DGPM(+J,"LD")):^("LD"),1:"")
 S ^UTILITY($J,"LOD",W,+X,$S($D(^DPT(+DFN,0)):$P(^(0),"^",1),1:"UNKNOWN PATIENT"))=DFN_"^"_R_"^"_$S($D(^DGPM(+$P(X,"^",17),0)):+^(0),1:"")_"^"_$S($D(^DGPM(+$P(X,"^",17),"LD")):$P(^("LD"),"^",3),1:"")_"^"_L Q
PRINT ;output for either type
 S DGONE=1,(DGFL,DGPG)=0,W="" F I=0:0 S W=$O(^UTILITY($J,"LOD",W)) Q:W=""!DGFL  D NEWWARD Q:DGFL  F J=0:0 S J=$O(^UTILITY($J,"LOD",W,J)) Q:'J!DGFL  S K=0 F L=0:0 S K=$O(^UTILITY($J,"LOD",W,J,K)) Q:K=""  S DGX=^(K) D WRITE Q:DGFL
 Q
WRITE D:DGONE!($Y>(IOSL-5)) HEAD Q:DGFL
 W !,$E(K,1,25) S DFN=+DGX D PID^VADPT6 W ?27,$E(VA("BID"),1,8),?37 S Y=J X ^DD("DD") W Y,?59,$E($S($D(^DG(405.4,+$P(DGX,"^",2),0)):$P(^(0),"^",1),1:""),1,15),?76,$E($S($D(^DG(406.41,+$P(DGX,"^",5),0)):$P(^(0),"^",1),1:"UNKNOWN"),1,15)
 I DGHOW=1 W ?98,$P(DGX,"^",6) Q
 S Y=$P(DGX,"^",3) X ^DD("DD") W ?93,Y I $P(DGX,"^",3) S X1=$P(DGX,"^",3),X2=J D ^%DTC W ?115,$J($S(X:X,1:1),3)
 W ?120,$S($P(DGX,"^",4)="":"",$P(DGX,"^",4)="a":"ADMITTED",1:"DISMISSED") I $P(DGX,"^",6)]"" W !?37,"COMMENTS:  ",$P(DGX,"^",6)
 Q
NEWWARD I DGONE!($Y>(IOSL-8)) D HEAD Q
 I DGOF,(W=$O(^UTILITY($J,"LOD","ZZOF"))) S DGOF=2 D HEAD Q
 D WARD Q
HEAD I $E(IOST)="C",'DGONE S DIR(0)="E" D ^DIR S DGFL='Y Q:DGFL
 S DGPG=DGPG+1 I DGHOW=1 W @IOF,!,"CURRENT LODGERS " W:DGOF=2 "AT OTHER FACILITIES " W "AS OF ",DGNOW,?122,"PAGE:  ",$J(DGPG,3)
 I DGHOW=2 W @IOF,!,"LODGERS ",$S(DGOF'=2:"IN HOUSE",1:"AT OTHER FACILITIES")," BETWEEN ",DGFROM," AND ",DGEND,?122,"PAGE:  ",$J(DGPG,3)
 S DGONE=0 W !!,"PATIENT",?27,"SHORT ID",?37,"CHECKED IN",?59,"BED",?76,"REASON" I DGHOW=2 W ?93,"CHECKED OUT",?115,"LOS",?120,"DISPOSITION" K Z S $P(Z,"-",133)="" W !,Z D WARD Q
 W ?98,"COMMENTS" K Z S $P(Z,"-",133)="" W !,Z D WARD Q
DIV I $S(VAUTD:0,$D(VAUTD(+DGX)):0,'DGX&$D(VAUTD($O(^DG(40.8,0)))):0,1:1) S DGX=-1
 Q
WARD ;ward or facility print
 I $E(W,1,4)'="ZZOF" W !!?(62-($L(W)/2)),W Q
 S X=$P(W,"ZZOF",2) W !!?(60-($L(X)/2)),X Q
