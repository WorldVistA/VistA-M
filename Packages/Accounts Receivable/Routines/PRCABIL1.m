PRCABIL1 ;SF-ISC/RSD - ENTER BILL INFO ;10/16/96  7:04 PM
V ;;4.5;Accounts Receivable;**57,64,109,147,220,276,315,338**;Mar 20, 1995;Build 69
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
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
FORM N PRCACAT,PRCAFUND,PRCABENE,PRCACA,PRCATYP,PRCAADD,PRCAAD1D,PRCAAD2D,PRCAAD3D,PRCACD,PRCASTD
 N PRCAZPD,PRCAPHD,PREND
 S PRCABENE=0
 S DR="[PRCA BILL "_$P("1081^1080^1114","^",X)_"]",PRCABT=X D ^DIE
 S:$D(DUZ) $P(^PRCA(430,PRCABN,9),U,8)=DUZ
 S PRCACAT=$P(^PRCA(430,PRCABN,0),U,2)
 ;PRCA*4.5*315 New Prompt for Beneficiary Travel if Category is VENDOR
 I PRCACAT=17 D  I $G(PREND)=1 Q
 .W !!
 .S DIR("A")="IS THIS FOR VETERANS BENEFICIARY TRAVEL? "
 .S DIR("?")="Please answer Yes or No."
 .S DIR("B")="NO",DIR(0)="YA^^"
 .D ^DIR K DIR
 .I '$D(Y(0)) S PREND=1 Q
 .I Y(0)="YES" D
 ..S PRCABENE=1
 ..S PRCACA=$O(^RC(342.1,"B","AGENT CASHIER",0))
 ..S PRCATYP=$P(^RC(342.1,PRCACA,0),U,2)
 ..S PRCAADD=$$SADD^RCFN01(PRCATYP)
 ..I $G(PRCAADD)'="" D
 ...S PRCAAD1D=$P(PRCAADD,U),PRCAAD2D=$P(PRCAADD,U,2),PRCAAD3D=$P(PRCAADD,U,3),PRCACD=$P(PRCAADD,U,4)
 ...S PRCASTD=$P(PRCAADD,U,5),PRCAZPD=$P(PRCAADD,U,6),PRCAPHD=$P(PRCAADD,U,7)
 I PRCACAT>39,PRCACAT<45 D
 .S X=PRCACAT,PRCAFUND=$S(X=40:"05",X=41:"06",X=42:"07",X=43:"08",1:"10"),PRCAFUND=5287_PRCAFUND
 .S DR="259////"_"09;203////^S X=PRCAFUND"
 .D ^DIE
 .K Y,X
 .Q
 I PRCACAT=47 D  ;315
 .N FUND
 .S FUND="0160R1" ; patch PRCA*4.5*338
 .S DR="259////"_"02;203////^S X=FUND"
 .D ^DIE
 .K Y,X
 .Q
 I $P(^PRCA(430,PRCABN,0),U,9)=""!('$D(^(100))!('$D(^(101)))) D MESG W !,"Bill is incomplete and must be re-edited !",*7 G Q
 D EN4^PRCABIL S PRCAMT1=0,PRCAMTY=0,DIK="^PRCA(430,PRCABN,2,"
 F PRCAI=0:0 S PRCAI=$O(^PRCA(430,PRCABN,2,PRCAI)) Q:'PRCAI  I $D(^(PRCAI,0)) S X=^(0) I $P(X,"^",8)]"" S PRCAMT1=PRCAMT1+$P(X,"^",8),PRCAMTY=PRCAMTY+1
 I 'PRCAMT1 W !!,"Fiscal Year Amount was not entered !  Bill is incomplete",*7 G Q
 I PRCAMTY>1 W !!,"Multiple Fiscal Years are not allowed at this time !",!,"Bill is incomplete and must be re-edited.",*7 G Q
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
 K %,%Y,A,B,C,D0,DA,DIC,DIE,DIK,DR,I,PRCA,PRCABC,PRCABN,PRCABT,PRCADFM,PRCAI,PRCAKCT,PRCARN,PRCATIME,PRCAMT,PRCAMTY,PRCANODE,PRCAMT1,PRCAMT2,PRCAQ,PRCAP,PRCAT,PRCATY,PRCAX,X,Y,Z0,ZRTN,ZTSK Q
LCK L +^PRCA(430,DA,0):0 I  Q
 W !,"ANOTHER USER IS EDITING THIS ENTRY !" K DA Q
CP ;CONTROL POINT LOOK-UP
 N DIC,PRC,DIE,DA,DR,X,Y,PRCSIP,PRCSI
 S PRC("SITE")=$S($G(PRCA("SITE")):PRCA("SITE"),1:$$SITE^RCMSITE)
 S DIC("B")=$P($G(^PRCA(430,PRCABN,11)),U)
 D CP^PRCSUT I '$G(PRC("CP")) Q
 I PRC("CP")<0 Q
 S $P(^PRCA(430,PRCABN,11),U)=PRC("CP")
 Q
BENEPRT ;PRCA*4.5*315 Beneficiary Travel Notice of Rights and Responsibilities
 I $G(PRCABENE) D
 .N LINE,BENELTR,DIWF,DIWL,DIWR,IOSLSAVE,PRNT
 .S BENELTR=$O(^RC(343,"B","BENEFICIARY TRAVEL NOTICE",0))
 .K ^UTILITY($J) ;print main body text from 343
 .S ^UTILITY($J,1)="W "_IOF
 .S IOSLSAVE=IOSL,IOSL=140
 .U IO
 .W #
 .F LINE=0:0 S LINE=$O(^RC(343,BENELTR,1,LINE)) Q:'LINE  S X=$G(^(LINE,0)) I X]"" W:($Y+2)>IOSL @IOF S DIWL=1,DIWR=80,DIWF="N" D ^DIWP
 .D ^DIWW S:$G(PRNT)="FL" PRNT=1 K ^UTILITY($J)
 .S IOSL=IOSLSAVE
 .W !,"Local Agent Cashier Contact Information"
 .W !,"   Office Phone: ",$G(PRCAPHD)
 .W !,"Mailing Address: ",$G(PRCAAD1D)
 .I $G(PRCAAD2D)'="" W !,"                 ",$G(PRCAAD2D)
 .I $G(PRCAAD3D)'="" W !,"                 ",$G(PRCAAD3D)
 .W !,"                 ",PRCACD_", "_PRCASTD_"  "_PRCAZPD
 Q
 ;
ST D CKSITE^PRCAUDT S %=$D(PRCA("CKSITE")) Q
ST1 D SVC^PRCABIL S %=$S($D(PRCAP("S")):1,1:0) Q:%
 K PRCAP Q
DIP D SVC^PRCABIL Q:'$D(PRCAP("S"))
 ; PRCA*4.5*276 - add '@' to BILL NO. in the 'BY' paramter so that printout does not show it as a sorting field.
 S FR=PRCAP("S")_",?,@",TO=PRCAP("S")_",?",L=0,DIC="^PRCA(430,",FLDS="[PRCA BILL LIST]",BY="@INTERNAL(SERVICE),@BILL NO.,FORM TYPE" D EN1^DIP K BY,DHD,DIC,FLDS,FR,L,PRCAP,TO Q
MESG I $P(^PRCA(430,PRCABN,0),U,9)="" W !,?3,"Debtor (or Payer) data is missing."
 I '$D(^PRCA(430,PRCABN,100)) W !,?3,"Service (or Section) , Form type or Voucher number data is missing."
 I '$D(^PRCA(430,PRCABN,101)) W !,?3,"Date of Charge data does not exist."
 W ! Q
