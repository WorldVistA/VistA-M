DGPMRB ;ALB/MRL,MIR - ROOM-BED DETERMINATION (SINGLE WARD); 9 JAN 89
 ;;5.3;Registration;**54**;Aug 13, 1993
 N I,I1,J,L,M,W,Y
 D Q S DGHOW=$S(('$D(X)#2):1,X["??":0,1:1),DGPMDD=$S('$D(DGSWITCH):+^DGPM(DA,0),1:DT),W=+$P(^DGPM(DA,0),"^",6),(DGL,DGA,DGFL)=0 G Q:'$D(^DIC(42,+W,0))
 W !!,"CHOOSE FROM",!
 F I=0:0 S I=$O(^DG(405.4,"W",W,I)) Q:I'>0!(DGFL)  I $D(^DG(405.4,+I,0)) S J=^(0),J=$P($P(J,"^",1,3)_"^^^","^",1,3),DGR=$P(J,"^",1) D ACT I 'DGU D DIS
 I DGA W !!,"Select from the above listing the bed you wish to assign this patient." I DGHOW W !,"Enter two question marks for a more detailed list of available beds." G Q
 I 'DGA W !!,"There are no available beds on this ward."
 F I=0:0 S I=$O(^DGS(41.1,"ARSV",W,I)) Q:'I  I $D(^DGS(41.1,I,0)) S J=^(0) I '$P(J,"^",13),($P(J,"^",2)'<DT),'$P(J,"^",17) W !,"Scheduled Admission for " W:$D(^DPT(+J,0)) $P(^(0),"^",1)," -- ",$P(^(0),"^",9) S Y=$P(J,"^",2) I J W " on " D DT^DIQ
 I '$D(^UTILITY("DGPMLD",$J)) G Q
 W !,"There are beds on this ward which are assigned to ""lodger"" patients.  In order",!,"to use these beds you will need to either ""check-out"" the lodger occupying",!,"the bed or move him to another available bed."
 W ! S DGL=1,DGR=0 F I1=0:0 S DGR=$O(^UTILITY("DGPMLD",$J,DGR)) Q:DGR=""  S J=^(DGR) D LOD
 G Q
 ;
ACT S DGU=1,Y=I D OCC I 'DGPMOC S DGU=0
 S M=$O(^DGPM("ARM",I,0)) I M,^(M) D LDGER Q
 I DGU Q
 S DGU=0,X=$O(^DG(405.4,I,"I","AINV",9999999-DGPMDD)),X=$O(^(+X,0)) I $D(^DG(405.4,I,"I",+X,0)) S DGPMDD("D")=^(0) D AVAIL
 I DGU Q
 S DGA=DGA+1 Q
 ;
AVAIL I +DGPMDD("D")'>DGPMDD,$S('$P(DGPMDD("D"),"^",4):1,$P(DGPMDD("D"),"^",4)>DGPMDD:1,1:0) S DGU=1
 Q
 ;
DIS W:DGA=1 !?3 I DGHOW S $P(J,"^",1)=$E($P(J,"^",1)_"                    ",1,18) W:$X+$L($P(J,"^",1))>79 !?3 W $P(J,"^",1) Q
LOD W !?3,DGR,", (",$S($D(^DG(405.6,+$P(J,"^",2),0)):$P(^(0),"^",1),1:"NO DESCRIPTION"),")" W:$D(^DIC(45.7,+$P(J,"^",3),0)) ",",$P(^(0),"^",1) W "."
 I DGL W !?3,"[Occupied by lodger patient '",$P(J,"^",4),"' SSN: ",$S($P(J,"^",5)]"":$P(J,"^",5),1:"UNKNOWN"),"]"
 I '(DGA#15) D READ
 Q
LDGER ;create UTILITY for lodgers
 ;J=ROOM-BED NAME^DESCRIPTION^T.S
 N DFN
 Q:'$D(^DGPM(+M,0))  S DFN=+$P(^(0),"^",3)
 S ^UTILITY("DGPMLD",$J,DGR)=J
 I $D(^DPT(DFN,0)) S ^UTILITY("DGPMLD",$J,DGR)=^UTILITY("DGPMLD",$J,DGR)_"^"_$P(^DPT(DFN,0),"^",1)
 D PID^VADPT6 S ^(DGR)=^UTILITY("DGPMLD",$J,DGR)_"^"_VA("PID")
 Q
Q K DGA,DGFL,DGHOW,DGL,DGPMDD,DGR,DGU,VA
Q1 K ^UTILITY("DGPMLD",$J) Q
DD ;
 S DGX=X,DGPMOS=+^DGPM(DA,0),D0=+X D RIN^DGPMDDCF K DGPMOS
 I X W "...INACTIVE" K X,DGX Q
 S X=DGX K DGX
 Q
READ ;prompt to continue
 W !,"Enter RETURN to continue or '^' to exit: " R DGPMX:DTIME S:'$T!(DGPMX["^") DGFL=1
 I DGPMX["?" W !!?5,"Enter either RETURN or '^'",! G READ
 K DGPMX Q
 ;
 ;
OCC ;is bed occupied
 ;
 ; INPUT:  DA...ifn of DGPM entry
 ;OUTPUT:  DGPMOC...1 if occupied, 0 if not
 ;
 N DFN S DGPMOC=0
 S DFN=$P(^DGPM(DA,0),"^",3) I 'DFN G OCCQ
 S DGPMX=$O(^DGPM("ARM",+Y,0)) I '$D(^DGPM(+DGPMX,0)) G OCCQ
 S DGPMX=^(0) I DFN=$P(DGPMX,"^",3),($D(^DG(405.4,+Y,"W","B",+$P(^DGPM(DA,0),"^",6)))) S DGPMOC=0 G OCCQ
 S DGPMOC=1
OCCQ K DGPMX Q
