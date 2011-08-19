PRCABIL1 ;SF-ISC/RSD-ENTER BILL INFO ;10/16/96  7:04 PM
V ;;4.5;Accounts Receivable;**57,64,109,147,220**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
EN1 ;ENTER NEW BILL
 D ST Q:'%  N CP
EN10 D EN^PRCABIL2 G Q:'$D(PRCABN) S $P(^PRCA(430,PRCABN,0),"^",8)=$O(^PRCA(430.3,"AC",201,0)) D EN G EN10
EN2 ;EDIT BILL
EN20 D SVC^PRCABIL Q:'$D(PRCAP("S"))  S DIC("S")="S Z0=$S($D(^PRCA(430.3,+$P(^(0),U,8),0)):$P(^(0),U,3),1:0) I Z0>199,Z0<210,'$P($G(^PRCA(430,Y,3)),U,3),+$P($G(^(100)),U,2)="_PRCAP("S")
 D BILLN^PRCAUTL G Q:'$D(PRCABN) D EN G EN20
EN4 ;CANCEL BILL
EN40 D SVC^PRCABIL Q:'$D(PRCAP("S"))  S DIC("S")="S Z0=$S($D(^PRCA(430.3,+$P(^(0),U,8),0)):$P(^(0),U,3),1:0) I Z0>199,Z0<210,$D(^PRCA(430,Y,100)),+$P(^(100),U,2)="_PRCAP("S")
 D BILLN^PRCAUTL G Q:'$D(PRCABN)
YN S %=2 W !,"  Sure you want to cancel this Bill" D YN^DICN
 I %=0 W !,*7,"Answer 'Yes' or 'No' " G YN
 I %'=1 D Q G EN40
 S $P(^PRCA(430,PRCABN,0),"^",14)=DT,$P(^(0),"^",17)=DUZ,$P(^(9),"^",6)=$P(^(0),"^",8),PRCA("STATUS")=$O(^PRCA(430.3,"AC",210,0)) D UPSTATS^PRCAUT2 K PRCA("STATUS") D Q G EN40
EN K PRCADFM S DA=PRCABN D LCK G Q:'$D(DA)
 S DIE="^PRCA(430,"
 I $D(RCAMEND) S X=+^PRCA(430,DA,100) I X?1N,X<4,X>0 G FORM
 S DR="100" D ^DIE G:X'?1N Q
FORM N PRCACAT,PRCAFUND
 S DR="[PRCA BILL "_$P("1081^1080^1114","^",X)_"]",PRCABT=X D ^DIE
 S:$D(DUZ) $P(^PRCA(430,PRCABN,9),U,8)=DUZ
 S PRCACAT=$P(^PRCA(430,PRCABN,0),U,2)
 I PRCACAT>39,PRCACAT<45 D
    .S X=PRCACAT,PRCAFUND=$S(X=40:"05",X=41:"06",X=42:"07",X=43:"08",1:"10"),PRCAFUND=5287_PRCAFUND
    .S DR="259////"_"09;203////^S X=PRCAFUND"
    .;I PRCAFUND'=528707 S DR=DR_";258////1"
    .D ^DIE
    .Q
 I $P(^PRCA(430,PRCABN,0),U,9)=""!('$D(^(100))!('$D(^(101)))) D MESG W !,"Bill is incomplete and must be re-edited !",*7 G Q
 D EN4^PRCABIL S PRCAMT1=0,PRCAMTY=0,DIK="^PRCA(430,PRCABN,2,"
 F PRCAI=0:0 S PRCAI=$O(^PRCA(430,PRCABN,2,PRCAI)) Q:'PRCAI  I $D(^(PRCAI,0)) S X=^(0) I $P(X,"^",8)]"" S PRCAMT1=PRCAMT1+$P(X,"^",8),PRCAMTY=PRCAMTY+1
 I 'PRCAMT1 W !!,"Fiscal Year Amount was not entered !  Bill is incomplete",*7 G Q
 I PRCAMTY>1 W !!,"Multiple Fiscal Years are not allowed at this time !",!,"Bill is incomplete and must be re-edited.",*7 G Q
 ;S DIE=DIK,DA(1)=PRCABN,DA=+$O(^PRCA(430,PRCABN,2,0)),DR=".01;7" S:'DA ^PRCA(430,PRCABN,2,0)="^430.01" D ^DIE
 I PRCAMT1'=PRCAMT,PRCABT'=1 W !!,"Fiscal Year Amounts do not equal the total bill amount !",!,"Bill is incomplete and must be re-edited !",*7 G Q
 I PRCAMT1'=PRCAMT,PRCABT=1 D  ;
 . N DIE,DA,DR
 . S PRCAMT1=PRCAMT
 . S DIE="^PRCA(430,PRCABN,2,"
 . S DA(1)=PRCABN
 . S DA=+$O(^PRCA(430,PRCABN,2,0))
 . S DR="1///"_PRCAMT1
 . QUIT:'DA
 . ; 
 . DO ^DIE
 ;
 S Y=$P(^PRCA(430,PRCABN,0),"^",9),Y=Y_"^"_$P(^RCD(340,Y,0),"^",1)
 G:$P(Y,";",2)="DPT("!($P(Y,";",2)="DIC(36,") CONT
 S PRCANODE=.11 S:$P(Y,";",2)="DIC(4," PRCANODE=1 S PRCANODE="^"_$P(Y,";",2)_+$P(Y,"^",2)_","_PRCANODE_")",PRCANODE=$G(@PRCANODE)
 I $P(PRCANODE,"^",1)="" S DR=$P(Y,"^",2),%=1 W !," (No Street Address)  Edit Debtor Address: " D YN^DICN,EN1^RCAM(DR):%=1 K DIE,DR,DA
CONT S Y=^PRCA(430,PRCABN,0),$P(Y,"^",3)=PRCAMT,PRCA("STATUS")=$O(^PRCA(430.3,"AC",205,0)),^PRCA(430,PRCABN,0)=Y,$P(^PRCA(430,PRCABN,7),"^")=PRCAMT
 I '$D(RCAMEND) S DIE="^PRCA(430,",DA=PRCABN,DR="8////"_PRCA("STATUS")_"" D ^DIE K DIE,DR,DA
DISP S %=1,PRCADFM=1 W !,"   Display/Print Bill:"
 K IOP D YN^DICN
 I %=0 W !,*7,"Answer 'Yes' or 'No' " G DISP
 D ^PRCABD:%=1
Q L -^PRCA(430,+$G(PRCABN),0)
 K %,%Y,A,B,C,D0,DA,DIC,DIE,DIK,DR,I,PRCA,PRCABC,PRCABN,PRCABT,PRCADFM,PRCAI,PRCAKCT,PRCANM,PRCARN,PRCATIME,PRCAMT,PRCAMTY,PRCANM,PRCANODE,PRCAMT1,PRCAMT2,PRCAQ,PRCAP,PRCAT,PRCATY,PRCAX,X,Y,Z0,ZRTN,ZTSK Q
LCK L +^PRCA(430,DA,0):0 I  Q
 W !,"ANOTHER USER IS EDITING THIS ENTRY !" K DA Q
CP ;CONTROL POINT LOOK-UP
 N DIC,PRC,DIE,DA,DR,X,Y,PRCSIP,PRCSI
 S PRC("SITE")=$S($G(PRCA("SITE")):PRCA("SITE"),1:$$SITE^RCMSITE)
 ;S PRC("SITE")=$$SITE^RCMSITE
 S DIC("B")=$P($G(^PRCA(430,PRCABN,11)),U)
 D CP^PRCSUT I '$G(PRC("CP")) Q
 I PRC("CP")<0 Q
 S $P(^PRCA(430,PRCABN,11),U)=PRC("CP")
 Q
ST D CKSITE^PRCAUDT S %=$D(PRCA("CKSITE")) Q
ST1 D SVC^PRCABIL S %=$S($D(PRCAP("S")):1,1:0) Q:%
 K PRCAP Q
DIP D SVC^PRCABIL Q:'$D(PRCAP("S"))
 S FR=PRCAP("S")_",?,@",TO=PRCAP("S")_",?",L=0,DIC="^PRCA(430,",FLDS="[PRCA BILL LIST]",BY="@INTERNAL(SERVICE),BILL NO.,FORM TYPE" D EN1^DIP K BY,DHD,DIC,FLDS,FR,L,PRCAP,TO Q
MESG I $P(^PRCA(430,PRCABN,0),U,9)="" W !,?3,"Debtor (or Payer) data is missing."
 I '$D(^PRCA(430,PRCABN,100)) W !,?3,"Service (or Section) , Form type or Voucher number data is missing."
 I '$D(^PRCA(430,PRCABN,101)) W !,?3,"Date of Charge data does not exist."
 W ! Q
