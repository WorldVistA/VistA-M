PRCSD12 ;WISC/SAW-CONTROL POINT ACT. 2237 TERMINAL DISPLAY ;10-11-91/10:16
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 S U="^",P(1)=0,Z1="" D NOW^%DTC S Y=% D DD^%DT W @IOF S L="",$P(L,"-",IOM)="-"
 S P=$S($D(^PRCS(410,DA,1)):$P(^(1),U,3),1:""),P=$S(P="EM":"***EMERGENCY***",P="SP":"*SPECIAL*",1:"STANDARD") W ?26,"PRIORITY: ",P
 W !,Y,?31,$P(^PRCS(410,DA,0),U) W !,L
 W !,?16,"REQUEST, TURN-IN, AND RECEIPT FOR PROPERTY OR SERVICES" W !,L
 W !,"TO: A&MM Officer",?24,"Requesting Office"
 W !,?24 S P=$P(^PRCS(410,DA,0),U,5),P1=$S($D(^(3)):+$P(^(3),U),1:"") I P,P1 S P=$S($D(^PRC(420,P,1,P1,0)):$P(^(0),U,10),1:"") I P,$D(^DIC(49,P,0)) W $P(^(0),U) W:$P(^(0),U,8)]"" " ("_$P(^(0),U,8)_")"
 W !,$E(L,1,23)
 W " ",$E(L,25,IOM)
 W !,"Action Requested",?24,"Date Prepared",?46,"Date Required"
 W !,?4,"Delivery",?24 I $D(^PRCS(410,DA,1)),$P(^(1),U)'="" S Y=$P(^(1),U) D DD^%DT W Y
 W ?46 I $D(^PRCS(410,DA,1)),$P(^(1),U,4)'="" S Y=$P(^(1),U,4) D DD^%DT W Y
 W !,$E(L,1,23)
 W " ",$E(L,25,45)
 W " ",$E(L,47,IOM)
 W !,?2,"ITEM NO.   ",?23,"DESCRIPTION",?52," QUANTITY  UNIT ESTIMATED"
 W !,"OR STOCK NO. ",?68,"UNIT COST",!,L
 D ^PRCSD121 G EXIT:Z1=U D ^PRCSD122 G EXIT:Z1=U D ^PRCSD123 G EXIT:Z1=U W !,"Press return to continue: " R Z1:DTIME
EXIT K FPROJ,%DT,P,P1,PRCS("SUB"),X,X1,Y,Z,Z1,DIWL,DIWR,DIWF,I,J,K,^UTILITY($J,"W"),PRCSIN,PRCSQTY,PRCSDES,PRCSDS,PRCSDSD,PRCSILP,PRCSLNT,PRCSLN,N,PRCSPG Q
 Q
