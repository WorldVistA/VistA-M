FBAADOB ;AISC/GRR-DISPLAY OPEN BATCHES ;03JAN86
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 S IOP=$S($D(ION):ION,1:"HOME") D ^%ZIS K IOP S Q="",$P(Q,"=",80)="=",FBAAOUT=0
 I '$D(^FBAA(161.7,"AC","O")) W !!,*7,"There are No Open Batches!",!! G Q
 D HED
 F B=0:0 S B=$O(^FBAA(161.7,"AC","O",B)) Q:B'>0!(FBAAOUT)  I $D(^FBAA(161.7,B,0)) S Z=^(0) D WRT
Q K A,B1,B2,B3,B4,B5,Q,Z,B,BT,D,FBAAOUT,J,K,POP,X,Y Q
HED W @IOF W !,"Batch #","  Type",?22,"Dt Open",?32,"Clerk Who Opened",?65,"Obligation #",!,Q
 Q
WRT I $Y+5>IOSL S DIR(0)="E" D ^DIR K DIR S:'Y FBAAOUT=1 Q:FBAAOUT  W @IOF D HED
 S B1=$P(Z,"^",1),B4=$P(Z,"^",2),B2=$$DATX^FBAAUTL($P(Z,"^",4)),BT=$P(Z,"^",3)
 S BT=$S(BT="B3":"Medical",BT="B5":"Pharmacy",BT="B2":"Travel",BT="B9":"CH/CNH",1:"Unknown")
 S BT=$S($P($G(Z),U,19):BT_"-STAT",1:BT)
 S B3=$S($P(Z,"^",5)]"":$P(Z,"^",5),1:""),B3=$S(B3="":"",$D(^VA(200,B3,0)):$P(^VA(200,B3,0),"^",1),1:"")
 W !!,B1,?7,BT,?22,B2,?32,B3,?65,B4
 Q
