FBAADCB ;AISC/GRR-DISPLAY CLOSED BATCHES ;03JAN86
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 I '$D(^FBAA(161.7,"AC","C")) W !!,*7,"There are No Closed Batches that have not been Certified!",!! G Q
 W ! S PGM="START^FBAADCB",VAR="" D ZIS^FBAAUTL G Q:FBPOP
 ;
START U IO S FBAAOUT=0,Q="",$P(Q,"=",80)="=" W:$E(IOST,1,2)="C-" @IOF D HED
 F B=0:0 S B=$O(^FBAA(161.7,"AC","C",B)) Q:B'>0!(FBAAOUT)  I $D(^FBAA(161.7,B,0)) S Z=^(0) D WRT
 F B=0:0 S B=$O(^FBAA(161.7,"AC","A",B)) Q:B'>0!(FBAAOUT)  I $D(^FBAA(161.7,B,0)) S Z=^(0) D WRT
 ;
Q K A,B1,B2,B3,B4,B5,B6,Q,X,ZZ,Z,B,D,Y,FBAAOUT,PRC,PRCSCPAN,DIRUT
 D CLOSE^FBAAUTL Q
 ;
HED W !?22,"FEE BATCHES PENDING RELEASE",!!,"Batch #",?10,"Date Closed",?25,"Clerk Who Opened",?54,"FCP-Obligation #",?72,"Total $",!,Q
 Q
WRT I $Y+5>IOSL D HANG Q:FBAAOUT
 S B1=$P(Z,"^"),B4=$P(Z,"^",2),B2=$P(Z,"^",13),B2=$E(B2,4,5)_"/"_$E(B2,6,7)_"/"_$E(B2,2,3)
 S B3=$P($G(^VA(200,+$P(Z,"^",5),0)),"^"),B5=$P(Z,"^",9)+.0001,B5=$P(B5,".",1)_"."_$E($P(B5,".",2),1,2)
 D FCP S B4=$S(B6="":B4,1:B6_"-"_B4)
 W !!,B1,?11,B2,?25,B3,?55,B4,?71,$J(B5,8)
 Q
HANG I $E(IOST,1,2)["C-" S DIR(0)="E" D ^DIR K DIR I 'Y S FBAAOUT=1 Q
 W @IOF D HED
 Q
FCP ;GET FCP FROM IFCAP
 I $P(Z,"^",8)="" S B6="" Q
 S PRC("SITE")=$P(Z,"^",8),PRCS("X")=PRC("SITE")_"-"_B4
 N Z,B,B1,B2,B3,B4,B5,Q
 D EN1^PRCS58
 S B6=$S(Y=-1:"",1:+$P(Y,"^",3))
 Q
