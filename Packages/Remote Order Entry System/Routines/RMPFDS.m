RMPFDS ;DDC/KAW-LIST ORDERS BY PATIENT OR STATUS; [ 08/25/97  12:03 PM ]
 ;;2.0;REMOTE ORDER/ENTRY SYSTEM;**8**;MAY 30, 1995
RMPFSET I '$D(RMPFMENU) D MENU^RMPFUTL I '$D(RMPFMENU) W !!,$C(7),"*** A MENU SELECTION MUST BE MADE ***" Q  ;;RMPFMENU must be defined
 I '$D(RMPFSTAN)!'$D(RMPFDAT)!'$D(RMPFSYS) D ^RMPFUTL Q:'$D(RMPFSTAN)!'$D(RMPFDAT)!'$D(RMPFSYS)
 W @IOF,!!,"LIST ORDERS BY PATIENT OR STATUS"
 S Y=DT D DD^%DT S RMPFDAT=Y
A1 W !!,"List Orders by <P>atient or by <S>tatus:  "
 D READ G END:$D(RMPFOUT)
A11 I $D(RMPFQUT) W !!,"Enter a <P> to display a list of orders for a patient or",!?5,"an <S> to display all orders with a chosen status." G A1
 G END:Y="" S Y=$E(Y,1) I "PpSs"'[Y S RMPFQUT="" G A11
 S RMPFORD=$S("Pp"[Y:"P",1:"S") G PAT:RMPFORD="P"
STAT W !!,"Enter an <*> to Display ALL Orders or",!,"Enter One or More of the Following Statuses Separated by Commas:",! S (CT,X)=0 K RMPFP
 F  S X=$O(^RMPF(791810.2,X)) Q:X=""  D
 .Q:'$D(^RMPF(791810.2,X,0))  S A=$P(^(0),U,1),B=$P(^(0),U,2),C=$P(^(0),U,10)
 .I RMPFMENU=10,C Q
 .I B'="" W !?5,"<",B,">  ",?11,A S CT=CT+1
S1 W !!,"Select Status(es): " D READ G END:$D(RMPFOUT)
S11 I $D(RMPFQUT) W !!,"Enter the letter of the status you wish to print or <*> to print all status." H 1 G STAT
 G A1:Y="" I Y="*" S RMPFP=Y G S2
 F I=1:1 S X=$P(Y,",",I) Q:X=""  D  G S11:$D(RMPFQUT)
 .I '$D(^RMPF(791810.2,"C",X)) S RMPFQUT="" Q
 .S Z=$O(^RMPF(791810.2,"C",X,0)) I Z S RMPFP(Z)=""
 .Q
 G A1:'$D(RMPFP)
S2 K RMPFOO W !!,"Print for <A>ll or <S>elected Ordering Officials: ALL// "
 D READ G END:$D(RMPFOUT)
S21 I $D(RMPFQUT) W !!,"Enter an <A> to print orders for ALL Ordering Officials",!?6,"an <S> to select an ordering official" G S2
 S:Y="" Y="A" S Y=$E(Y,1) I "AaSs"'[Y S RMPFQUT="" G S21
 G TYP:"Aa"[Y
S3 W ! S DIC="^VA(200,",DIC(0)="AEQM",DIC("A")="Select Ordering Official: "
 D ^DIC G S2:Y=-1 S RMPFOO=+Y K DIC G TYP
PAT W ! S DIC=2,DIC(0)="AEQM" D ^DIC G END:Y=-1 S DFN=+Y
 S RMPFTP="P" G DISP
TYP W !!,"Display <P>atient, <S>tation or <B>oth Types of Orders: B// "
 D READ G END:$D(RMPFOUT)
TYP1 I $D(RMPFQUT) W !!,"Enter a <P> to display only patient type orders,",!?5,"an <S> to display only station type orders,",!?8,"<B> or <RETURN> to display both types." G TYP
 S:Y="" Y="B" S Y=$E(Y,1) I "BbPpSs"'[Y S RMPFQUT="" G TYP1
 S RMPFTP=$S("Bb"[Y:"B","Pp"[Y:"P",1:"S")
DISP D ^RMPFDS1 G RMPFSET:$D(RMPFOUT)
 I IOST?1"P-".E W @IOF
 E  D CONT^RMPFDS1 G END:$D(RMPFOUT),RMPFSET
END K RMPFORD,RMPFTP,RMPFS,RMPFOUT,RMPFQUT,DIC,DFN,RMPFCX,RMPFP,RMPFO
 K RMPFOO,DIPGM,DISYS,CT,S0,%,%Y,%XX,%YY,A,B,C,I,J,Y,X,Z Q
READ K RMPFOUT,RMPFQUT
 R Y:DTIME I '$T W $C(7) R Y:5 G READ:Y="." S:'$T Y=U
 I Y?1"^".E S (RMPFOUT,Y)="" Q
 S:Y?1"?".E (RMPFQUT,Y)=""
 Q
