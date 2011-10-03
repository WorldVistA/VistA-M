FHORTR ; HISC/NCA - Tubefeeding Product Search ;8/8/96  08:12
 ;;5.5;DIETETICS;;Jan 28, 2005
SRCH(FHX) ; Search For Tubefeeding Product
 N DIC,FHY,X,Y
 S X=FHX,FHY=""
 W ! K DIC S DIC="^FH(118.2,",DIC(0)="EQM" D ^DIC G:"^"[X!$D(DTOUT) EXIT
 G:Y<1 EXIT
 S FHY=+Y
EXIT Q FHY
DISP ; Display Edited Tubefeeding
 N TC,TK S (TC,TK)=0 W !
 I $O(TUN(0))="" W !!,"No Tubefeeding Products Selected." Q
 F K=0:0 S K=$O(TUN(K)) Q:K<1  D
 .S TC=TC+$P(TUN(K),"^",4)+$P(TUN(K),"^",5)
 .S TK=TK+$P(TUN(K),"^",6),STR=$P(TUN(K),"^",2)
 .S PRO=$P(TUN(K),"^",1)
 .W !,"Product: ",$P($G(^FH(118.2,PRO,0)),"^",1),", "
 .W $S(STR=4:"Full",STR=2:"1/2",STR=1:"1/4",STR=3:"3/4",1:""),", "
 .W $P(TUN(K),"^",3)
 .Q
 W !!,"Total Kcal: ",TK,?36,"Total Quantity: ",TC
 Q
HELP ; Help Prompt for Tubefeeding Product.
 W !!,"Hit return to take the default.",!,"Enter a ""@"" to delete the product, strength and quantity.",!,"Enter another product name to replace existing product name."
 W !,"To Replace, enter first few characters of the product name, e.g., SUS for SUSTACAL."
 W !,"Enter a ""^"" will Exit Completely."
 Q
