DGDISPL ;ALB/JDS - DISPOSITION LOG ;1/8/91  13:25
 ;;5.3;Registration;;Aug 13, 1993
 ;
EN S Z="^In Process^ALL"
 R !,"In process(I) or All(A): I// ",X:DTIME G Q:X["^"!'$T X:X="" "S X=""I"" W X" D IN^DGHELP I %=-1 W !!,"Enter 'I' to print only those dispositions in process,",!,"'A' to print all disposition's for a specified date range.",*7 G EN
H S DGS=0 I $D(^DG(43,1,"GL")) I $P(^("GL"),U,2) W !,"Sort by Facility" S %=1 D YN^DICN G Q:%=-1,HELP:'% S DGS=$S(%=1:1,1:0)
 S DIC="^DPT(",L=0 G I:X="I" S FLDS="[DGDISPOSTIONS]",BY="1000,@.01;",FR="?",TO="?"
 I DGS S BY="1000,'.01,1000,#3,1000,@99",FR="?,?,",TO="?,?,",DG1=0,DIS(0)="D DIS^DGDISPL:'DG1 S DG1=1 I 1"
 W !!,*7,"Note: This report requires a column width of 132.",! D EN1^DIP
Q K IP,L,DIC,FLDS,FR,TO,DGS,DG1,%,Z,DIS,X,VA,VAERR Q
I S L=0,DIC="^DPT(",BY="1000,@50,1000,.01",FLDS="[DGOPENDISPOSITIONS]",DHD="OPEN DISPOSITIONS",FR=",",TO=FR
 I DGS S BY="1000,'@50,1000,#3,1000,.01",FR=",?,",TO=FR
 D EN1^DIP G Q
PRO S L2=+$P(L1,"^",6),L1=+L1,(TI,TO,PT)="",X=L1,DISP=$P(L,"^",7) D H^%DTC S LL1=%H,X=L2,LL2="" I X?7N.E D H^%DTC S LL2=%H
 S TI=L1#1*10000,TI=$E("0000",1,4-$L(TI))_TI,TI=+$E(TI,1,2)_":"_$E(TI,3,4)
 Q:'LL2  S X1=L1#1*10000,X2=L2#1*10000,TO=X2\100_":",X4=X2#100,TO=TO_$E("00",1,2-$L(X4))_X4 S:LL2-LL1 X2=X2+(LL2-LL1*2400\1) S X3=X2\100-(X1\100),X2=X2#100,X1=X1#100 S:X1>X2 X2=X2+60,X3=X3-1 S X4=X2-X1,X5=X3\24,X3=X3#24
 S PT=$S(X5>0:X5_":",1:"")_$S(X5>0:$E("00",1,2-$L(X3)),1:"")_X3_":"_$E("00",1,2-$L(X4))_X4
 Q
DIS I $D(DPP(1,"F")) S DPP(3,"F")=DPP(1,"F")
 I $D(DPP(1,"T")) S DPP(3,"T")=DPP(1,"T")
 Q
HELP W !,"Your facility is Multidivisonal",!,"Type 'Yes' to sort output by division",!,"This will add time to processing",! G H
