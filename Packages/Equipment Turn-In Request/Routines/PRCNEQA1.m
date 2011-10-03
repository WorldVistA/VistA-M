PRCNEQA1 ;SSI/ALA-Equipment Committee Approval ;[ 09/09/96  3:15 PM ]
 ;;1.0;Equipment/Turn-In Request;;Sep 13, 1996
FAP ;
 S PRCNDIS=1 D LINE
QS K % W !!,"Does request need a final confirmation from responsible CMR Official"
 D YN^DICN
 I %=0 D  G QS
 . W !,"Enter 'Yes' if this request is to be sent to the CMR Offical for a final review"
 . W !,"before a 2237 is to be created.  Enter 'No' if a 2237 should be created without"
 . W !,"further review."
 I %=1 D MSG
 I %<0 S DUOUT=1 Q
 S DIC="^PRCN(413,",DIE=DIC,(DA,D0)=IN
 S DR="6////^S X=STAT;7////^S X=DT;47////^S X=STT;48////^S X=DT;49///@" D ^DIE
 S MSGN=$S(EQXI=1:43,EQXI=2:44,EQXI=3:40,EQXI=4:39,1:"")
 D MES^PRCNMESG
 S D1=0 F  S D1=$O(^PRCN(413,D0,1,D1)) Q:D1'>0  S QTY=$P(^(D1,0),U,5) D ^DIE
 I EQXI>2 G AXT
AXT K DIC,DIE,DR,EANS,%,QTY,D0,D1,DA,PRCNDIS
 Q
LINE ; Display line item information
 W !!,"TRANSACTION #: ",$P(^PRCN(413,IN,0),U)
 S OIN2=$P(^PRCN(413,IN,1,0),U,3)
 F IN2=1:1:OIN2 D  Q:$D(DUOUT)
 . Q:$G(^PRCN(413,IN,1,IN2,0))=""
 . S REQ=$P(^PRCN(413,IN,1,IN2,0),U,5),LST=""
 . S PRCNI=IN,(PRCNJ,PRCNK)=IN2,APP=$S(REQ="":0,1:REQ)
 . S QTY=$P(^PRCN(413,PRCNI,1,PRCNJ,0),U,5),PR=$P(^(0),U,4)
 . W !!,"Qty: ",QTY,?20,"Price: ",PR,?40,"Total: ",QTY*PR,!,"Description:"
 . S PRCNL=0 F  S PRCNL=$O(^PRCN(413,PRCNI,1,PRCNJ,1,PRCNL)) Q:'+PRCNL  W !,"    ",^(PRCNL,0)
 . I $G(PRCNDIS)="" D LINE2
 K OIN2,REQ,QTY,APP,LAPP,DR,PR,DIC,DA,D0,D1,PRCNI,PRCNL,PRCNJ,PRCNK
 K DIR,ST,PRCNN,DLAYGO,LST
 Q
LINE2 ; Display line item & get input
 S DIR(0)="S^AF:Approved and Funded;AP:Approved Pending Funds;DD:Disapproved;DF:Deferred until later"
 S DIR("A")="Select a status code" D ^DIR Q:$G(DIRUT)=1
 S ST=Y
 ;  Decide on actual quantity being decided, may not be same as the
 ;  requested quantity
QUAN W !,"Quantity requested: ",REQ
 W ?40,"Quantity approved: ",APP,"//" R PRCNN:DTIME I '$T G QUAN
 I PRCNN["?" D  G QUAN
 . W !!,"Enter a numeric quantity that is being approved.  It"
 . W !,"does not have to be the same as the requested quantity."
 S:PRCNN="^" DUOUT="^" Q:$D(DUOUT)
 S:PRCNN="" PRCNN=APP S:LST="" LST=ST
 I PRCNN>APP!(PRCNN<1)!(PRCNN'?.N) W $C(7) G QUAN
 I ST'=LST D SPLIT S LST=ST
 I ST=LST S DA=PRCNJ,DA(1)=PRCNI D UPDT
 S LAPP=APP-PRCNN Q:LAPP=0  S APP=LAPP
 G LINE2
UPDT ;  Update the line item/transaction
 S DR="10////^S X=ST;12////^S X=DT;9////^S X=PRCNN"
 S:ST["D" DR=DR_";11;I '$D(^PRCN(413,DA(1),1,DA,3)) W $C(7),!,""Explanation is required!"" S Y=11"
 S (DIC,DIE)="^PRCN(413,"_DA(1)_",1," D ^DIE
 Q
SPLIT ; Split line item based on quantity approved
 S DA(1)=PRCNI,X=$P(^PRCN(413,DA(1),1,PRCNJ,0),U),DIC(0)="L"
 S DIC="^PRCN(413,"_DA(1)_",1,",DLAYGO=413.015
 D FILE^DICN S (PRCNJ,DA)=+Y D COPY
 S DR=".01////^S X=PRCNJ",DIE=DIC D ^DIE
 Q
EXIT K DIC,DIE,DA,%
 Q
COPY ;  Copy data from one line item to new line item
 S %X="^PRCN(413,"_PRCNI_",1,"_PRCNK_",",%Y="^PRCN(413,"_PRCNI_",1,"_PRCNJ_","
 D %XY^%RCR
 K %X,%Y
 Q
MSG ;  Send message to CMR Official for final confirmation
 S MSGN=53 K NOD
 ;  set transaction data into message
 D MES^PRCNMESG
 S DIC="^PRCN(413,",DIE=DIC,(DA,D0)=IN
 S DR="6////^S X=45;7////^S X=DT" D ^DIE
 Q
