FHREP1 ; HISC/NCA - Inventory Worksheet and Report ;3/9/95  08:28
 ;;5.5;DIETETICS;**13**;Jan 28, 2005;Build 1
EN2 ; Print the Inventory Worksheet & Report
 S FHXX="F"
 R !!,"Select W=Worksheet or R=Report: ",FHR:DTIME G:'$T!("^"[FHR) KIL^FHREP
 I "wr"[FHR S X=FHR D TR^FH S FHR=X
 I FHR'?1U!("WR"'[FHR) W *7,"   Enter W or R" G EN2
E0 ; Read in Month and Year
 D NOW^%DTC S NOW=%\1
 K %DT W !!,"Enter Mth/Yr: "_+$E(NOW,4,5)_"/"_$E(NOW,2,3)_"// " R X:DTIME G:'$T!(X["^") KIL^FHREP
 I X="" S X=$E(NOW,1,5)_"00"
 S %DT="M" D ^%DT K %DT I Y<1!($E(Y,1,5)>$E(NOW,1,5)) W *7,"  Answer Month and Yr as Mth/Yr or Mth Yr.",!?25,"   CANNOT be greater than now." G E0
 S MTH=+$E(Y,4,5),MTH=$P("January February March April May June July August September October November December"," ",MTH),YR=$E(Y,2,3),MTH=MTH_" "_YR
 I FHR="W" D F1^FHREP G:FHXX["^"!("^"[X) KIL^FHREP
 I FHR="R" D D1^FHREP G:"^"[X KIL^FHREP
E1 K IOP S %ZIS="MQ",%ZIS("B")="HOME" W ! D ^%ZIS K %ZIS,IOP G:POP KIL^FHREP
 I $D(IO("Q")) S FHPGM="Q0^FHREP1",FHLST="FHR^FHXX^MTH^SRT" D EN2^FH G KIL^FHREP
 U IO D Q0 D ^%ZISC K %ZIS,IOP G KIL^FHREP
Q0 ; Process Printing worksheet or report
 D Q1 G KIL^FHREP
Q1 ; Loop through Ingredients
 K ^TMP($J) S ANS="",(K,GRDTOT,OLD,SUBTOT,TOTAL,PG)=0 D NOW^%DTC S DTP=% D DTP^FH S HD=DTP S CK=1
 F K=0:0 S K=$O(^FHING(K)) Q:K<1  S X=$P($G(^(K,0)),"^",19) I X="Y" S X=$G(^(0)) D LP S:OK ^TMP($J,P0_$S(FHXX="S":$E(L0,1,15),1:"FG"_P0),ING)=K_"^"_UP_"^"_COST_"^"_QOH_"^"_UDC_"^"_UDQ_"^"_$E(MIN,1,5)
 S REC=0
 S P0="" F L1=0:0 S P0=$O(^TMP($J,P0)) Q:P0=""!(ANS="^")  S ING="" F L2=0:0 S ING=$O(^TMP($J,P0,ING)) Q:ING=""  S XX=^(ING) D P1 Q:ANS="^"
 I FHR="R",ANS="",SRT W !!,?55,"TOTAL:   ",$J(SUBTOT,8,2)
 I FHR="R",ANS="",'SRT D SUB W !!?49,"GRAND TOTAL:   ",$J(GRDTOT,8,2)
 Q
LP ; Get Food Group or Storage
 S ING=$P(X,"^",1),UP=$P(X,"^",5),COST=$P(X,"^",9),QOH=$P(X,"^",11),UDC=$P(X,"^",23),UDQ=$P(X,"^",24),MIN=$P(X,"^",25),OK=1,L0=""
 S DTP=UDC D:DTP'="" DTP^FH S UDC=DTP,DTP=UDQ D:DTP'="" DTP^FH S UDQ=DTP
 I FHXX="F" S P0=$P(X,"^",13) S:P0<1!(P0>6) P0=7 S:SRT&(P0'=SRT) OK=0 Q
 S LOC=$P(X,"^",12),L0=$P($G(^FH(113.1,+LOC,0)),"^",1) S:L0="" L0="UNCLASSIFIED" S P0=$P($G(^FH(113.1,+LOC,0)),"^",3),P0=$S(P0<1:99,P0<10:"0"_P0,1:P0) S:SRT&(LOC'=SRT) OK=0
 Q
P1 ; Loop to print or if FHR="E" edit QOH
 S K=$P(XX,"^",1),UP=$P(XX,"^",2),COST=$P(XX,"^",3),QOH=$P(XX,"^",4),UDC=$P(XX,"^",5),UDQ=$P(XX,"^",6),MIN=$P(XX,"^",7),REC=REC+1
 I FHR="E" D  Q
 .W !!,"Ingredient: ",$P(^FHING(K,0),"^",1)
 .W:UDQ'="" !?12,"QOH LAST UPDATED ON ",UDQ,!
 .K DIE S DIE="^FHING(",DA=K
 .S:OKAY DR="8;S:X=COST Y=""@1"";29////"_DT_";@1;10;S:X=QOH Y="""";30////"_DT
 .S:'OKAY DR="10;S:X=QOH Y="""";30////"_DT D ^DIE S:$D(DTOUT) CK=0 S:$D(Y)!$D(DTOUT) ANS="^" K DA,DIE,DR,DTOUT,Y
 .Q
 D CHK Q:ANS="^"
 D:$Y'<(IOSL-5) HD W ! Q:ANS="^"
 I $L(ING)'>30 D
 .W !,$J(MIN,5),?6,ING,?39,UP,?43,$J(COST,8,3)
 .I FHR="W" W ?53,UDC,?63,$J(QOH,8,2),?73,"_____" Q
 .W ?55,$J(QOH,8,2),?64,$J(TOTAL,8,2)
 .Q
 E  D
 .S L=$L($E(ING,1,30),",")
 .S:L=1 L=L+1 W !,$J(MIN,5),?6,$P(ING,",",1,L-1),","
 .W !?6,$P(ING,",",L,99),?39,UP,?43,$J(COST,8,3)
 .I FHR="W" W ?53,UDC,?63,$J(QOH,8,2),?73,"_____" Q
 .W ?55,$J(QOH,8,2),?64,$J(TOTAL,8,2)
 .Q
 Q
CHK ; Check the Food Group or Storage to do Subtotal & Grandtotal
 S P1=$S(FHXX="F":+P0,1:$E(P0,3,17))
 I REC=1 S OLD=P1 D HDR
 I OLD'=P1 D:FHR="R" SUB D HD
 S OLD=P1
 ; Calculate subtotal grand total
 Q:FHR'="R"
 S TOTAL=COST*QOH
 S SUBTOT=SUBTOT+TOTAL
 S GRDTOT=GRDTOT+TOTAL
 Q
SUB ; Write subtotal
 W !!,?52,"SUBTOTAL:   ",$J(SUBTOT,8,2)
 S SUBTOT=0
 Q
HD ; Check for end of page
 G:REC=1 HDR
 I IOST?1"C".E W:$X>1 ! W *7 K DIR S DIR(0)="E" D ^DIR I 'Y S ANS="^" Q
HDR ; Heading for the Inventory
 W:'($E(IOST,1,2)'="C-"&'PG) @IOF S PG=PG+1
 W !,HD,?70,"Page ",PG,!!?22,"I N V E N T O R Y   " W $S(FHR="W":"W O R K S H E E T",1:"R E P O R T"),!!
 W ?(80-$L(MTH)/2),MTH,!!
 I FHXX="F" S P2="FOOD GROUP: "_$P("MEAT PRODUCTS^MILK PRODUCTS^FRUITS & VEGETABLES^BREADS^COMMERCIAL NUTRITION SUPPLEMENTS^MISCELLANEOUS^UNCLASSIFIED","^",+P1)
 E  S P2=P1
 W ?(80-$L(P2)/2),P2,!!
 I FHR="W" W !?56,"DATE",!?47,"ITEM",?56,"LAST",?66,"QOH",?74,"QOH",!,"ITEM#",?20,"NAME",?38,"U/P",?47,"COST",?55,"UPDATE",?63,"LAST MTH",?72,"CURRENT",! Q
 W !?47,"ITEM",?58,"QOH",?67,"TOTAL",!,"ITEM#",?20,"NAME",?38,"U/P",?47,"COST",?56,"CURRENT",?68,"COST",!
 Q
