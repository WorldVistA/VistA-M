FHCMSR1 ; HISC/NCA - Cost of Meals Served (cont.) ;4/25/93  13:57
 ;;5.5;DIETETICS;;Jan 28, 2005
Q1 ; Process Calculating Cost of Meals
 ; STG contains a string of number that is used to indicate which column
 ; to print each cost in the row.
 S DA=SDT D NOW^%DTC S DTP=% D DTP^FH S HD=DTP,PG=0 D HDR
 S S1=$E(SDT,4,5),S2=$S(S1<4:"01",S1<7:"04",S1<10:"07",1:10) S:$E(SDT,4,5)'=S2 SDT=$E(SDT,1,3)_S2_"00"
 K S S (STG,X1)=""
 S STG="1,7,13,1,19,8,15,1;2,8,14,2,20,9,16,2;3,9,15,3,21,10,17,3;4,10,16,4,22,11,18,4;5,11,17,5,23,12,19,5;6,12,18,6,24,13,20,6"
 S L=SDT-100 F L1=L:0 S L1=$O(^FH(117.2,L1)) Q:L1<1!(L1>EDT)  S X1=$G(^(L1,0)) D ADD
 Q:X1=""  D CAL
 Q
CAL ; Calculate the costs
 ; P(1) contains the cost entered for calculating all the cost of the
 ; Food Groups. P(2) contains the total of the beg inv, issue, end inv,
 ; and recommanded.
 K P F L=1:1:4 S P(L)=""
 S P1=$P($G(^FH(117.2,SDT,0)),"^",2,7)_"^"_$P(X1,"^",8,25) Q:P1=""
 F L=1:1:24 S $P(P(1),"^",L)=$P(P1,"^",L)
 S K=6 F L=1:1:6 S $P(P(1),"^",K+L)=S(L)
 S K=0 F I=1:1:4 F L=1:1:6 S K=K+1,$P(P(2),"^",I)=$P(P(2),"^",I)+$P(P(1),"^",K)
 ; P(3) contains Beg Inv + Issue - End Inv.  Piece 7 Total,
 ; Pieces 8-13 contains Usage / Total Usage and Total.
 ; Pieces 15-20 contains % Actual - % Cost rec (F-E) and Total.
 ; P(4) contains Usage / Total Meals Served (FHTOT) AND Total/Total Meals.
 F L=1:1:6 S $P(P(3),"^",L)=($P(P(1),"^",L)+$P(P(1),"^",L+6))-$P(P(1),"^",L+12),$P(P(3),"^",7)=$P(P(3),"^",7)+$P(P(3),"^",L)
 F L=1:1:6 D
 .S $P(P(3),"^",L+7)=$S(+$P(P(3),"^",7)'<1:($P(P(3),"^",L)/$P(P(3),"^",7))*100,1:"")
 .S $P(P(3),"^",L+7)=$J($P(P(3),"^",L+7),0,0)
 .S $P(P(3),"^",L+14)=$P(P(3),"^",L+7)-$P(P(1),"^",L+18)
 .Q
 S K=7 F L=1:1:6 S K=K+1,$P(P(3),"^",14)=$P(P(3),"^",14)+$P(P(3),"^",K)
 S K=14 F L=1:1:6 S K=K+1,$P(P(3),"^",21)=$P(P(3),"^",21)+$P(P(3),"^",K)
 K N F I=1:1:21 S N(I)=0
 D ^FHCMS1
 G:'FHTOT PRT F I=1:1:6 S $P(P(4),"^",I)=$S(FHTOT:$P(P(3),"^",I)/FHTOT,1:"")
 S $P(P(4),"^",7)=$S(FHTOT:$P(P(3),"^",7)/FHTOT,1:"")
PRT ; Print the costs
 F L=1:1:18 S X=$P(P(1),"^",L),X2="0",X3=11 D COMMA^%DTC S $P(P(1),"^",L)=X
 F L=1:1:3 S X=$P(P(2),"^",L),X2="0",X3=11 D COMMA^%DTC S $P(P(2),"^",L)=X
 F L=1:1:7 S X=$P(P(3),"^",L),X2="0",X3=11 D COMMA^%DTC S $P(P(3),"^",L)=X
 F L=19:1:24 S $P(P(1),"^",L)=$J($P(P(1),"^",L),5)
 F L=8:1:20 S $P(P(3),"^",L)=$J($P(P(3),"^",L),5)
 F I=1:1:7 S $P(P(4),"^",I)=$J($P(P(4),"^",I),9,4)
 F I=1:1:6 S PC=$P(STG,";",I),T1=0 D LP
 G ND
LP ; Loop to print costs for each group
 W $P("I II III IV V VI"," ",I)
 W ?7,$P(P(1),"^",$P(PC,"^",1)),?18,$P(P(1),"^",$P(PC,",",2)),?29,$P(P(1),"^",$P(PC,",",3)),?40,$P(P(3),"^",$P(PC,",",4)),?50,$P(P(1),"^",$P(PC,",",5))_"%"
 W ?57,$P(P(3),"^",$P(PC,",",6))_"%",?64,$P(P(3),"^",$P(PC,",",7))_"%",?71,$P(P(4),"^",$P(PC,",",8))
 W !
 Q
ND ; Print the last line,the total of each column
 W !,"Total",?7,$P(P(2),"^",1),?18,$P(P(2),"^",2),?29,$P(P(2),"^",3),?40,$P(P(3),"^",7),?50,$J($P(P(2),"^",4),5)_"%",?57,$J($P(P(3),"^",14),5),"%",?64,$J($P(P(3),"^",21),5),"%",?71,$P(P(4),"^",7),! Q
ADD ; Add Issue for the quarter
 Q:X1=""
 S K=7 F I=1:1:6 S:'$D(S(I)) S(I)=0 S S(I)=S(I)+$P(X1,"^",K+I)
 Q
HDR ; Print Heading
 W:'($E(IOST,1,2)'="C-"&'PG) @IOF
 W !,HD D HDR1 S Y=X_" "_(1700+$E(DA,1,3)) I SDT'=EDT S DA=EDT D HDR1 S Y=Y_"-"_X_" "_(1700+$E(DA,1,3))
 W !!,?(80-$L(Y)/2),Y
 W !!,?24,"COST  OF  MEALS  SERVED  WORKSHEET"
 S PG=PG+1 W ?74,"Page ",PG
 W !!!?24,"Costs",! S LN="",$P(LN,"-",43)="" W ?8,LN,!
 W "Food",?11,"Beg",?32,"Close",?54,"%",?61,"%",?68,"%",?73,"Food",!
 W "Group",?11,"Inv",?21,"Issue",?33,"Inv",?43,"Usage",?53,"Rec",?60,"Act",?67,"Dev",?73,"Cost"
 W !?12,"A",?23,"B",?34,"C",?45,"D",?54,"E",?61,"F",?68,"G",?75,"H"
 S LN="",$P(LN,"-",81)="" W !,LN,! Q
HDR1 S X=$P("Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec"," ",+$E(DA,4,5)) Q
