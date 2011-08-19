PSS0114 ;BIR/JLC-UPDATE ORDERABLE ITEMS WITH DEFAULT MED ROUTES ;08/28/2006
 ;;1.0;PHARMACY DATA MANAGEMENT;**114**;9/30/97;Build 2
 ;
 ;
 N A,B,C,DF,Y,MRP,MR,OUT,IEN,OK,X
EN K DIC S DIC="^PS(50.606,",DIC(0)="AEMQ",DIC("A")="Select DOSAGE FORM: " D ^DIC K DIC Q:X=""!(X="^")  I Y<0 G EN
 S DF=$P(Y,"^",2)
EN1 K DIC S DIC="^PS(51.2,",DIC(0)="AEMQ",DIC("A")="Select MEDICATION ROUTE: " D ^DIC K DIC Q:X=""!(X="^")  I Y<0 G EN1
 W ! S MRP=$P(Y,"^"),MR=$P(Y,"^",2),(OUT,IEN)=0
 F  S IEN=$O(^PS(50.7,IEN)) Q:'IEN  D  Q:OUT
 . S A=$G(^(IEN,0)) Q:$P(A,"^",6)]""  S B=$P(A,"^",2) Q:B=""  S C=$P($G(^PS(50.606,B,0)),"^")
 . Q:C'=DF
 . W !,IEN," ",$P(A,"^")," ok to change? " R OK:60 W "  " I OK="^" S OUT=1 Q
 . I OK'="Y" Q
 . S $P(^PS(50.7,IEN,0),"^",6)=MRP
 Q
EXIT     Q
