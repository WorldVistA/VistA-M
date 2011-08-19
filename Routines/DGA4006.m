DGA4006 ;ALB/MRL - LIST OF PATIENTS ON AMIS 401-420 SEGMENT ;01 JAN 1988@2300
 ;;5.3;Registration;;Aug 13, 1993
 S DGC=0 F I=0:0 S I=$O(^UTILITY($J,"DGSEGP",I)) Q:'I  D DV^DGA4001,H F I1=0:0 S I1=$O(^UTILITY($J,"DGSEGP",I,I1)),I2="" D:I1'>0&(DGC) END Q:I1'>0  F I4=0:0 S I2=$O(^UTILITY($J,"DGSEGP",I,I1,I2)) Q:I2=""  D 1
 D END:DGC G QUIT^DGA4002
1 F I3=0:0 S I3=$O(^UTILITY($J,"DGSEGP",I,I1,I2,I3)) Q:'I3  S X=^(I3),X2=$P(I3,".",2),X1=$E(I3,4,5)_"/"_$E(I3,6,7)_"/"_$E(I3,2,3)_"@"_$E($E(X2,1,2)_"00",1,2)_":"_$E($E(X2,3,4)_"00",1,2) D W
 Q
W I $Y>$S($D(IOSL):(IOSL-6),1:58) D:DGC END D H
 S DGC=1 W !,I1,?5,I2,?22,$S($P(X,"^",2)]"":$P(X,"^",2),1:"----"),?28,X1,?46,$P(X,"^",4),?60,$P(X,"^",3) S X3=$P(X,"^",1) W ?90,$E(X3,1,$L(X3)-1),?100,$P(X,"^",5) Q
H W @IOF,!,"PATIENTS INCLUDED ON '",$P(DGDV,"^",2),"' DIVISION, AMIS 401-420 SEGMENTS, " S Y=DGA X ^DD("DD") W Y,!,DGL1
 W !,"SEG",?5,"Patient Name",?22,"SSN4",?28,"Reg Date/Time",?46,"Benefit",?60,"Reg Elig Code",?90,"*Blocks",?100,"Disposition Type",!,DGL1 Q
END S DGC=0 W !!,DGL1,!,"* - Block 01 (applications received) is presumed for all patients!",!!,"**Dispositions with an UNSCHEDULED status will no longer be counted on this AMIS as of Oct 1, 1989**",! Q
