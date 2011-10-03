DGBTCR1 ;ALB/SCK - BENEFICIARY TRAVEL FORM 70-3542d; 2/7/88@08:00  6/11/93@09:30
 ;;1.0;Beneficiary Travel;;September 25, 2001
 ;This routine is a modification of AIVBTPRT / pmg / GRAND ISLAND ;07 Jul 88  12:02 PM
 Q
 ;Called by DGBTCR
PRINT K I S $P(I,"=",65)="" W !?66,"|",I,"|",!?7,VADM(1),?50 I $D(^DIC(13,+VADM(9),0)) W $P(^(0),"^",4)
 W ?66,"|  VOUCHER FOR CASH REIMBURSEMENT OF BENEFICIARY TRAVEL EXPENSES |"
 W !?7,VAPA(1),?50,DGBTCC,?66,"|"
 K I S $P(I,"=",65)="" W ?67,I,"|"
 W !?7,VAPA(4),?40,DGBTST,?50,$P(VAPA(11),U,2),?66,"| 2.  Name and Address of Issuing Health Care Facility",?131,"|"
 W !?66,"|",?131,"|"
 W !?7,DGBTSSN,?21,$E($P(VADM(10),"^",2),1),?22,$P(VADM(5),"^"),?30,DGBTDOB,?50,DGBTDIV,?66,"|",?88,$P(DGBTINS,"^"),?131,"|"
 W !?66,"|",?88 W:$P(DGBTINS1,"^")'="" $P(DGBTINS1,"^") W:$P(DGBTINS1,"^")="" $P(DGBTINS1,"^",2) W:$P(DGBTINS1,"^")=""&($P(DGBTINS1,"^",2)="") DGBTINS2 W ?131,"|"
 W !?7,VAEL(7),?19 I $D(^DIC(8,+VAEL(1),0)) W $P(^(0),"^",4)
 W ?21,DGBTSCP,?28 I $D(^DIC(21,+VAEL(2),0)) W $P(^(0),"^",3)
 W ?66,"|",?88 W:$P(DGBTINS1,"^",2)'=""&($P(DGBTINS1,"^")'="") $P(DGBTINS1,"^",2) W:$P(DGBTINS1,"^")'=""&($P(DGBTINS1,"^",2)="") DGBTINS2 W:$P(DGBTINS1,"^")=""&($P(DGBTINS1,"^",2)'="") DGBTINS2 W ?131,"|"
 W !?66,"|",?88 W:$P(DGBTINS1,"^")'=""&($P(DGBTINS1,"^",2)'="")&($P(DGBTINS,"^",2)'="") DGBTINS2 W ?131,"|"
 W !,"  1.  Patient Data Card Information",?66,"|",?131,"|" D LINE
FISCAL W !,"| 3.  Fiscal Symbols"
 W ?30,$P(DGBTRATE,"^",4),?131,"|" D LINE
 W !,"| 4.  From (Place of Departure)",?66,"| 5.  To (Destination)",?131,"|"
RMV ; W !,"|",?66,"|",?131,"|"
 W !,"|",?12,$P(DGBTVAR("D"),"^"),?66,"|",?88,$P(DGBTVAR("T"),"^"),?131,"|"
 W !,"|",?12 W:$P(DGBTVAR("D"),"^",2)'="" $P(DGBTVAR("D"),"^",2) W:$P(DGBTVAR("D"),"^",2)="" $P(DGBTVAR("D"),"^",3) W:$P(DGBTVAR("D"),"^",2)=""&($P(DGBTVAR("D"),"^",3)="") DGBTFCTY
 W ?66,"|",?88 W:$P(DGBTVAR("T"),"^",2)'="" $P(DGBTVAR("T"),"^",2) W:$P(DGBTVAR("T"),"^",2)="" $P(DGBTVAR("T"),"^",3) W:$P(DGBTVAR("T"),"^",2)=""&($P(DGBTVAR("T"),"^",3)="") DGBTTCTY W ?131,"|"
 W !,"|",?12 W:$P(DGBTVAR("D"),"^",3)'="" $P(DGBTVAR("D"),"^",3) W:$P(DGBTVAR("D"),"^",2)'=""&($P(DGBTVAR("D"),"^",3)="") DGBTFCTY
 W ?66,"|",?88 W:$P(DGBTVAR("T"),"^",3)'="" $P(DGBTVAR("T"),"^",3) W:$P(DGBTVAR("T"),"^",2)'=""&($P(DGBTVAR("T"),"^",3)="") DGBTTCTY W ?131,"|"
 W !,"|",?12 W:$P(DGBTVAR("D"),"^",2)'=""&($P(DGBTVAR("D"),"^",3)'="") DGBTFCTY
 W ?66,"|",?88 W:$P(DGBTVAR("T"),"^",2)'=""&($P(DGBTVAR("T"),"^",3)'="") DGBTTCTY W ?131,"|" D LINE
 Q
LINE K I S $P(I,"=",131)="" W !,"|",I,"|"
 Q
