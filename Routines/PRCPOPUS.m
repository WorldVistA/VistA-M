PRCPOPUS ;WISC/RFJ-utility: distribution order selection ; 5/5/99 10:25am
V ;;5.1;IFCAP;**1**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
ADDNEW(ORDER,PRCPPRIM,PRCPSECO)   ;  add new distribution order number ORDER
 ;  returns distribution order
 N %,%DT,C,D0,DA,DD,DI,DIC,DIE,DLAYGO,DQ,DR,X,Y
 S DIC="^PRCP(445.3,",DIC("DR")="1////"_(+PRCPPRIM)_";2////"_(+PRCPSECO)_";3///TODAY;3.5////R;4////"_DUZ,DIC(0)="LZ",DLAYGO=445.3,X=+ORDER,PRCPPRIV=1 D FILE^DICN K PRCPPRIV
 Q $S(+Y>0:+Y,1:0)
 ;
 ;
NEWORDER(PRCPPRIM) ;  get next order number for primary
 ;  called from 445.3,.01 input transform when entering 'new'.
 ;  returns variable x = new order
 I '$D(^PRCP(445,+PRCPPRIM,0)) K X Q
 N END,FLAG,Z
 L +^PRCP(445.3,"ANXT",PRCPPRIM)
 S (END,X)=+$G(^PRCP(445.3,"ANXT",PRCPPRIM))
 F  S X=X+1 Q:X=END  S:X>999999 X=1 Q:'$D(^PRCP(445.3,"B",X))  D  Q:'$G(FLAG)
 .   K FLAG S Z=0 F  S Z=$O(^PRCP(445.3,"B",X,Z)) Q:'Z  I $D(^PRCP(445.3,"AC",PRCPPRIM,Z)) S FLAG=1 Q
 S ^PRCP(445.3,"ANXT",PRCPPRIM)=X
 L -^PRCP(445.3,"ANXT",PRCPPRIM)
 I X=END W !!?10,"YOU NEED TO DELETE SOME OF THE OLD ORDERS FIRST!" K X
 Q
 ;
 ;
ORDERSEL(PRCPPRIM,PRCPSECO,PRCPSTAT,ADDNEW) ;  select distribution order
 ;  prcpprim=primary inventory point screen
 ;  prcpseco=secondary inventory point screen
 ;  prcpstat=status for screen (set to * to eliminate screen on status)
 ;  addnew=1 to add new orders
 ;  returns selected distribution order da number
 ;  returns variable prcpfnew if its a newly created order
 N %,%H,%I,C,D0,DA,DG,DI,DQ,DIC,DIE,DLAYGO,DR,ORDERDA,PRCPNEW,PRCPPRIV,SCREEN,STATUS,X,Y
 K PRCPFNEW
 S DIC(0)="AEQM",DIC="^PRCP(445.3,"
 S DIC("A")="Select DISTRIBUTION ORDER: "
 S PRCPPRIV=1
 ;
 ;  set up screen
 I PRCPPRIM S DIC("S")="I $P(^(0),U,2)="_PRCPPRIM
 I PRCPSECO S DIC("S")=$S($G(DIC("S"))="":"I ",1:DIC("S")_",")_"$P(^(0),U,3)="_PRCPSECO
 I PRCPSTAT'="*" D
 .   S DIC("S")=DIC("S")_" S %=$P(^(0),U,6)"
 .   I PRCPSTAT="" S DIC("S")=DIC("S")_" I %=""""" Q
 .   S SCREEN=""
 .   F %=1:1 S STATUS=$P(PRCPSTAT,"!",%) Q:STATUS=""  S SCREEN=SCREEN_$S(SCREEN="":"",1:"!")_"(%="_$C(34)_STATUS_$C(34)_")"
 .   S DIC("S")=DIC("S")_" I "_SCREEN
 ;
 ;  adding new entries allowed
 I ADDNEW S DIC(0)="AEQML",DLAYGO=445.3,DIC("DR")="1////"_PRCPPRIM_$S(PRCPSECO:";2////"_PRCPSECO,1:"")
 ;
 D ^DIC I Y'>0 Q 0
 S ORDERDA=+Y
 I $P(Y,"^",3) S PRCPFNEW=1
 I $G(PRCPFNEW) S $P(^PRCP(445.3,ORDERDA,0),"^",4,5)=DT_"^"_DUZ,$P(^(0),"^",8)="R"
 Q ORDERDA
 ;
 ;
TYPE(ORDERDA) ;  ask order type for orderda
 ;  returns 1 if unsuccessful
 I '$D(^PRCP(445.3,+ORDERDA,0)) Q 1
 I $P(^PRCP(445.3,+ORDERDA,0),"^",6)="P" Q 0
 N %,D,D0,DA,DDH,DI,DIC,DIE,DIR,DQ,DR,DZ,ORD,PRCPEXIT,PRCPPRIV,PRCPSEC,X,Y
 ; if this is a regular order for a supply station secondary, don't prompt
 ; if this is an emergency or call-in order for a supply station secondary, allow all selections but regular.
 S ORD=0,PRCPEXIT=0
 S PRCPSEC=$P($G(^PRCP(445.3,ORDERDA,0)),"^",3)
 I $P($G(^PRCP(445,PRCPSEC,5)),"^",1)]"",$D(^PRCP(445.3,ORDERDA,1)) D  G TYPEQ:PRCPEXIT
 . S ORD=$P($G(^PRCP(445.3,ORDERDA,0)),"^",8)
 . I ORD="R" D  Q
 . . D EN^DDIOL("This is a regular order on a supply station secondary.")
 . . D EN^DDIOL("Its 'TYPE OF ORDER' cannot be edited to CALL_IN or EMERGENCY.")
 . . S PRCPEXIT=1
 . S DIR("A")="TYPE OF ORDER"
 . S DIR("A",1)="This order is for a supply station secondary."
 . S DIR("A",2)="The order type cannot be changed to regular."
 . S DIR(0)="SB^C:CALL-IN;E:EMERGENCY"
 . S DIR("B")="CALL-IN" I ORD="E" S DIR("B")="EMERGENCY"
 . D ^DIR
 . I $D(DUOUT)!$D(DTOUT) S PRCPEXIT=1 Q
 . S ORD=0 I Y="E"!(Y="C") S ORD=Y
 S (DIE,DIC)="^PRCP(445.3,",DA=ORDERDA,DR="3.5"
 I ORD'=0 S DR=DR_"///^S X=ORD"
 S PRCPPRIV=1 D ^DIE
 I $D(Y) Q 1
TYPEQ Q 0
 ;
 ;
REMARKS(ORDERDA) ;  ask remarks for orderda
 ;  returns 1 if unsuccessful
 I '$D(^PRCP(445.3,+ORDERDA,0)) Q 1
 I $P(^PRCP(445.3,+ORDERDA,0),"^",6)="P" Q 0
 N %,D,D0,DA,DDH,DI,DIC,DIE,DQ,DR,DZ,PRCPPRIV,X,Y
 S (DIE,DIC)="^PRCP(445.3,",DA=ORDERDA,DR="8",PRCPPRIV=1 D ^DIE
 I $D(Y) Q 1
 Q 0
 ;
 ;
ITEMSEL(ORDERDA,PRCPPRIM,PRCPADD) ;  select item from distribution order
 ;  returns item number selected
 N %,C,DA,DDC,DG,DIC,DLAYGO,I,PRCPSET,X,Y
 I '$D(^PRCP(445.3,ORDERDA,0)) Q 0
 S:'$D(^PRCP(445.3,ORDERDA,1,0)) ^(0)="^445.37PI^^"
 S DIC="^PRCP(445.3,"_ORDERDA_",1,",DIC(0)="QEAMZO"
 I PRCPADD S DIC(0)="QEALMZO"
 S (PRCPSET,DIC("S"))="I $D(^PRCP(445,PRCPPRIM,1,+Y,0))"
 ; if this is a regular order for a supply station secondary, restrict
 ; item selection to items stocked in the supply station (i.e. items
 ; with non-zero normal levels)
 I PRCPADD,$P($G(^PRCP(445,$P(^PRCP(445.3,ORDERDA,0),"^",3),5)),"^",1)]"",$P(^PRCP(445.3,ORDERDA,0),"^",8)="R" D
 . S PRCPSEC=$P(^PRCP(445.3,ORDERDA,0),"^",3)
 . S U="^"
 . S (PRCPSET,DIC("S"))=PRCPSET_",$D(^PRCP(445,PRCPSEC,1,+Y,0)),$P(^PRCP(445,PRCPSEC,1,+Y,0),U,9)>0"
 S DA(1)=ORDERDA
 S DLAYGO=445.3
 W ! D ^DIC
 Q $S(+Y>0:+Y,1:0)
 ;
 ;
ITEMEDIT(ORDERDA,ITEMDA,ASKCOST) ;  edit item on distribution order
 N D,D0,DA,DI,DIC,DIE,DQ,DR,X,Y
 I '$D(^PRCP(445.3,ORDERDA,1,ITEMDA,0)) Q
 S (DIC,DIE)="^PRCP(445.3,"_ORDERDA_",1,",DA(1)=ORDERDA,DA=ITEMDA,DR="1;"_$S(ASKCOST:"2;",1:"") D ^DIE
 Q
 ;
 ;
ITEMADD(ORDERDA,ITEMDA,QTY) ;  automatically add items to distribution order
 ;  return item number added or 0 if unsuccessful
 N %,D0,DA,DD,DI,DIC,DIE,DLAYGO,DQ,DR,PRCPPRIM,PRCPPRIV,UNITCOST,X,Y
 I '$D(^PRCP(445.3,ORDERDA)) Q 0
 I 'ITEMDA Q 0
 S PRCPPRIM=+$P($G(^PRCP(445.3,ORDERDA,0)),"^",2),UNITCOST=+$P($G(^PRCP(445,PRCPPRIM,1,ITEMDA,0)),"^",22)
 I 'PRCPPRIM,'QTY Q 0
 I '$D(^PRCP(445.3,ORDERDA,1,0)) S ^(0)="^445.37PI^^"
 S DIC("DR")="1///"_QTY_";2///"_UNITCOST
 S DIC="^PRCP(445.3,"_ORDERDA_",1,",DA(1)=ORDERDA,DIC(0)="LZ",DLAYGO=445.3,(DINUM,X)=ITEMDA,PRCPPRIV=1 D FILE^DICN
 I Y<0 Q 0
 Q +Y
