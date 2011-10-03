FBAAPOC ;AISC/GRR-PRINT OBSOLETE CARDS ;15APR86
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 S VAR="",PGM="START^FBAAPOC" D ZIS^FBAAUTL G:FBPOP Q
START S FBOUT=0 U IO S UL="" F A=1:1:80 S UL=UL_"="
 W:$E(IOST,1,2)="C-" @IOF D HED
 S J=0 F JJ=0:0 S J=$O(^FBAA(161.83,"C",J)) Q:J'>0!($G(FBOUT))  F K=0:0 S K=$O(^FBAA(161.83,"C",J,K)) Q:K'>0!($G(FBOUT))  F L=0:0 S L=$O(^FBAA(161.83,"C",J,K,L)) Q:L'>0!($G(FBOUT))  I $D(^FBAA(161.83,K,1,L,0)) S Y(0)=^(0) D GOT Q:FBOUT
Q W ! K A,J,K,JJ,UL,FBOUT,FBDT,FBNM,FBSSN,FBR,FBPOP,L,Y
 D CLOSE^FBAAUTL Q
GOT S FBDT=$P(Y(0),"^"),FBNM=$S($D(^DPT(K,0)):$P(^(0),"^"),1:""),FBSSN=$S(FBNM="":"",1:$$SSN^FBAAUTL(K)),FBDT=$S(FBDT[".":$P(FBDT,"."),1:FBDT),FBR=$P(Y(0),"^",3)
 I $E(IOST,1,2)["C-",$Y+4>IOSL S DIR(0)="E" D ^DIR K DIR S:'Y FBOUT=1 Q:FBOUT  W @IOF D HED
 E  I $Y+4>IOSL W @IOF
 W !!,J,?10,FBNM,?42,$G(FBSSN),?61,$$DATX^FBAAUTL(FBDT),!,?2,FBR
 Q
HED W !,"Old Card ",?10,"Patient Name",?42,"Pt.ID",?61,"Change Date",!?1,"Number",!?2,"Reason For Change",!,UL Q
