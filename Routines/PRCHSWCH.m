PRCHSWCH ;WISC/AKS-Check switches ;7/13/2001  08:00
 ;;5.1;IFCAP;**37**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
CHECK ;check switches
 ;
 ; processing is controlled by PRCHOBL
 ; PRCHOBL=0 do nothing  PRCHOBL=1 obligate immediately without Fiscal
 ; PRCHOBL=2 call PRCOEDI to generate PHA transactions
 I FILE'=442&(FILE'=443.6) W !,"Improper file." Q
 N EDICHK,EDIVEN S EDICHK="N",EDIVEN=$P($G(^PRC(FILE,PRCHPO,1)),U) S:EDIVEN'="" EDICHK=$P($G(^PRC(440,EDIVEN,3)),U,2)
 K PRCHOBL
 N PRCHFUND
 S PRCHOBL=0,PRCHFUND=""
 S PRCHFUND=$P(^PRC(FILE,PRCHPO,0),U,3) Q:PRCHFUND=""  S PRCHFUND=+$P(PRCHFUND," ")
 I $P($G(^PRC(442,PRCHPO,23)),U,11)="D" S PRCHOBL=1 D
 . I $P($G(^PRC(420,PRC("SITE"),3)),U,2)="",$P($G(^PRC(420,PRC("SITE"),1,PRCHFUND,6)),U,2)="" S PRCHOBL=0
 . I $P(^PRC(FILE,PRCHPO,0),U,2)=26 S PRCHOBL=1
 I '$G(PRCHOBL) D
 . I $P($G(^PRC(420,PRC("SITE"),3)),U,2)="A",$P($G(^PRC(420,PRC("SITE"),1,PRCHFUND,6)),U,2)'="D" S PRCHOBL=1
 . I $P($G(^PRC(420,PRC("SITE"),3)),U,2)="D",$P($G(^PRC(420,PRC("SITE"),1,PRCHFUND,6)),U,2)="A" S PRCHOBL=1
 . I $P($G(^PRC(420,PRC("SITE"),3)),U,2)="",$P($G(^PRC(420,PRC("SITE"),1,PRCHFUND,6)),U,2)="A" S PRCHOBL=1
 I '$G(PRCHOBL) D
 . I $P($G(^PRC(420,PRC("SITE"),3)),U)="Y",EDICHK="Y" S PRCHOBL=1
 . I $P($G(^PRC(420,PRC("SITE"),1,PRCHFUND,6)),U)="N" S PRCHOBL=0
 . ;  PRC*5.1*37, Added a missing check for EDI vendor at FCP level
 . I $P($G(^PRC(420,PRC("SITE"),1,PRCHFUND,6)),U)="Y",EDICHK="Y" S PRCHOBL=1
 ;  if a certified invoice, set flag to 0 so that Fiscal must process
 I $P($G(^PRC(FILE,PRCHPO,0)),"^",2)=2 S PRCHOBL=0
 K FILE
 QUIT
POST ;post init for PRC*5*113
 N ZP,ZIP,CNTR
 S ZP="" F  S ZP=$O(^PRC(442,"F",25,ZP)) Q:ZP=""  D
 .S ZIP=$P($G(^PRC(442,+ZP,23)),"^",13) Q:ZIP=""  Q:ZIP[";"
 .S $P(^PRC(442,ZP,23),"^",13)=$P(^PRC(442,ZP,23),"^",13)_";PRCS(410.7,"
 S ZP="" F  S ZP=$O(^PRC(442,"F",25,ZP)) Q:ZP=""  D CONV
 S ZP="" F  S ZP=$O(^PRC(442,"F",26,ZP)) Q:ZP=""  D CONV
 QUIT
CONV ;
 Q:+$P($G(^PRC(442,ZP,1)),"^")=0
 S DA=ZP,DIK(1)="5^D",DIK="^PRC(442," D EN^DIK
 S VALUE=$P($G(^PRC(442,ZP,23)),"^",14) Q:+VALUE=0
 S VVAL=$P($G(^PRC(440,VALUE,0)),"^") Q:VVAL=""
 S VVAL=$E(VVAL,1,30) K ^PRC(442,"D",VVAL,ZP)
 K DA,DIK,VALUE,VVAL
 QUIT
