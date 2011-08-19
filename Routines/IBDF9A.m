IBDF9A ;ALB/CJM - ENCOUNTER FORM - (create,edit,delete selection list) ;FEB 1,1993
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**15**;APR 24, 1997
 ;
LIST ;Create, Edit, or Delete a selection list from the form
 N IBVALMBG
 S VALMBCK="R",IBVALMBG=VALMBG
 K DIR S DIR("?",1)="You can create a [N]ew list, edit its [A]ppearance, [D]elete it,",DIR("?")="edit its [Co]ntents, [P]osition or size its columns.  Choose from:"
 S DIR("B")="C" I $G(IBBLK) D
 .S X=$G(^IBE(357.2,+$O(^IBE(357.2,"C",IBBLK,0)),0))
 .I $P(X,"^",14),'$P(X,"^",19) S DIR("B")="A" ;dynamic list, can't edit contents, default changed to appearance, unless its clinical reminders
 ;
 S DIR(0)="SAB^A:APPEARANCE;C:CONTENTS;D:DELETE;N:NEW;P:POSITION",DIR("A")="[N]ew   [A]ppearance   [D]elete   [C]ontents   [P]osition: "
 W !!,DIR("?",1),!,DIR("?"),!
 D ^DIR K DIR I $D(DIRUT)!(Y<0) Q
 D @$S(Y="C":"EDITLIST^IBDF3",Y="A":"EDITLIST",Y="N":"NEWLIST^IBDF9A1",Y="D":"DLTLIST",Y="P":"COLUMNS",1:"NOSUCH")
 S VALMBG=IBVALMBG
 Q
NOSUCH ;
 Q
EDITLIST ;allows editing of the structure of a list
 ;expects IBBLK to be defined
 ;IBSC1,IBSC2,IBSWITCH,IBD,IBOLD,IBLEN  are used in the input template
 N IBLIST,IBRTN,IBSC1,IBSC2,IBSWITCH,IBSWT,IBD,IBOLD,IBLEN,IBDELETE,IBSCOLD,IBSCNEW,FROM,TO,IBDYN,IBINPUT,IBSC,IBSCRAY
 S VALMBCK="R",(IBOLD,IBSWITCH)=1
 D FULL^VALM1
 D SELECT
 I IBLIST D
 .S (IBSCOLD,IBSCNEW)=""
 .S IBRTN=$P($G(^IBE(357.2,IBLIST,0)),"^",11)
 .D LISTTYPE(IBRTN)
 .D GETSC^IBDF9A3(.IBSCOLD,IBLIST)
 .D:IBRTN DATASIZE(IBRTN)
 .K DIE,DA,DR S DIE=357.2,DA=IBLIST,DR="[IBDF EDIT SELECTION LIST]",DIE("NO^")="BACKOUTOK" D ^DIE K DIE,DR,DA,%,I
 .;
 .;if the list already had selections the subcolumns may need to be reordered/created/deleted
 .S IBSWITCH="" F  S IBSWITCH=$O(IBSWITCH(IBSWITCH)) Q:'IBSWITCH  S FROM=$P(IBSWITCH(IBSWITCH),"^"),TO=$P(IBSWITCH(IBSWITCH),"^",2) D  S IBSWT(FROM)=TO
 ..I $D(IBSCOLD(TO)) D DELSC^IBDF9A3(IBLIST,TO)
 ..;D SWITCH(IBLIST,FROM,TO)
 ..I $D(IBSCOLD(FROM)) S IBSCOLD(TO)=IBSCOLD(FROM) K IBSCOLD(FROM)
 .D SWITCH(IBLIST,.IBSWT)
 .D GETSC^IBDF9A3(.IBSCNEW,IBLIST)
 .N SC S SC=0 F  S SC=$O(IBSCOLD(SC)) Q:'SC  I IBSCOLD(SC)'=$G(IBSCNEW(SC)) D DELSC^IBDF9A3(IBLIST,SC)
 .S SC=0 F  S SC=$O(IBSCNEW(SC)) Q:'SC  I IBSCNEW(SC)'=$G(IBSCOLD(SC)) D ADDSC^IBDF9A3(IBLIST,SC)
 .D BLKCHNG^IBDF19(IBFORM,IBBLK) ;8/20/96 changed from d UNCMPLBLK^IBDF19
 .D IDXBLOCK^IBDFU4
 S VALMBCK="R"
 Q
COLUMNS ;allows the user to place and size the columns of the list
 ;expects IBBLK to be defined
 N IBLIST
 S VALMBCK="R"
 D FULL^VALM1
 D SELECT
 I IBLIST D
 .K DIE,DA,DR S DIE=357.2,DA=IBLIST,DR="[IBDF POSITION/SIZE COLUMNS]",DIE("NO^")="BACKOUTOK" D ^DIE K DIE,DR,DA
 .D UNCMPBLK^IBDF19(IBBLK),IDXBLOCK^IBDFU4
 S VALMBCK="R"
 Q
SELECT ;
 S IBLIST=""
 Q:'$G(IBBLK)
 I '$O(^IBE(357.2,"C",IBBLK,0)) W !,"There is no selection list!" D PAUSE^IBDFU5 Q
AGAIN K DIC S DIC="^IBE(357.2,",DIC(0)="EQ",D="C",X=IBBLK
 S DIC("S")="I $P($G(^(0)),U,2)=IBBLK"
 D IX^DIC K DIC
 S:+Y>0 IBLIST=+Y
 I 'IBLIST,'$D(DTOUT),'$D(DUOUT) K DIR S DIR(0)="Y",DIR("A")="No selection list selected! Try again",DIR("B")="YES" D ^DIR K DIR I '$D(DIRUT),Y=1 G AGAIN
 Q
MSG1 ;called by the input template
 W !!,"Entering the number of list columns is optional. By default the list will be",!,"given as many columns as the block has space for.",!
 Q
MSG2 ;called by the input template
 W !!,"Entering the information on the position of the columns and their",!,"height is optional. Appropriate default values will be used. However,",!,"you may specify your own values for up to 4 coulmns.",!
 Q
MSG3 ;called by the input template
 W !!,"You can now specify the subcolumns the list should contain.",!,"There can be at most 6 subcolumns, numbered 1-6.",!
 Q
 ;
DATASIZE(RTN) ;IBLEN() stores the lengths of the pieces of the record returned by the package interface
 N NODE,IEN,PIECE
 Q:'$G(RTN)
 S PIECE=0 F  S PIECE=$O(^IBE(357.6,RTN,15,"C",PIECE)) Q:'PIECE  S IEN=0 F  S IEN=$O(^IBE(357.6,RTN,15,"C",PIECE,IEN)) Q:'IEN  S NODE=$G(^IBE(357.6,RTN,15,IEN,0)) I $P(NODE,"^",3) S IBLEN($P(NODE,"^",3))=+$P(NODE,"^",2)_"^"_$P(NODE,"^",5)
 S IBLEN(0)=4
 S IBLEN(1)=$P($G(^IBE(357.6,RTN,2)),"^",2)_"^"_$P($G(^IBE(357.6,RTN,2)),"^",16)
 Q
 ;
NEWNAME() ;
 K DIR S DIR(0)="357.2,.01A",DIR("A")="New Selection List Name: ",DIR("B")=""
 D ^DIR K DIR I $D(DIRUT) Q -1
 Q Y
SWITCH(IBLIST,IBARRY) ;FOR loops thru selection list and changes all subcolumn numbers from old to new (called only once)
 N SLCTN,SC
 S SLCTN="" F  S SLCTN=$O(^IBE(357.3,"C",IBLIST,SLCTN)) Q:'SLCTN  D
 .S (IBSC1,SC)=0 F  S IBSC1=$O(^IBE(357.3,SLCTN,1,"B",IBSC1)) Q:'IBSC1  F  S SC=$O(^IBE(357.3,SLCTN,1,"B",IBSC1,SC)) Q:'SC  S IBSC(SC)=IBSC1
 . S (IBSC1,SC)=0 F  S SC=$O(IBSC(SC)) Q:'SC  S IBSC1=IBSC(SC) D
 ..;I $P($G(^IBE(357.3,SLCTN,1,SC,0)),"^")=IBSC1 D
 ..I $D(IBARRY(IBSC1)) S IBSC2=IBARRY(IBSC1) D
 ...I $G(^IBE(357.3,SLCTN,1,0))="" S ^IBE(357.3,SLCTN,1,0)="^357.31IA^"
 ...K DIE,DA,DR S DIE="^IBE(357.3,SLCTN,1,",DA(1)=SLCTN,DA=SC,DR=".01////"_IBSC2
 ...D ^DIE
 ...;K DIE,DA,DR S DA(1)=SLCTN,DIE="^IBE(357.3,"_DA(1)_",1,",DA=SC,DR=".01////"_IBSC2
 ..E  D
 ...K ^IBE(357.3,SLCTN,1,"B",IBSC1,SC)
 ...K DIK,DA S DIK="^IBE(357.3,SLCTN,1,",DA(1)=SLCTN,DA=SC D IX^DIK
 K DIK,DA,DIE,DR
 Q
RTN() ;does a lookup on the package interface file using the E cross-reference, which uses the name with the prefix=namespace removed
 K DIC S DIC("S")="I $P(^(0),U,6)=3,$P(^(0),U,9)=1"
 S DIC="^IBE(357.6,",DIC(0)="MQEA",D="E^D^B",DIC("A")="Select the TYPE OF DATA that the list will contain: " D MIX^DIC1 K DIC,DA
 Q $S((Y<0)!$D(DTOUT)!$D(DUOUT):0,1:+Y)
DLTLIST ;expects IBBLK to be defined
 N IBLIST
 D FULL^VALM1
 D SELECT
 I IBLIST D
 .Q:'$$RUSURE^IBDFU5($P($G(^IBE(357.2,IBLIST,0)),"^"))
 .D DLTLIST^IBDFU3(357.2,IBBLK,IBLIST)
 .D UNCMPBLK^IBDF19(IBBLK),IDXBLOCK^IBDFU4
 Q
 ;
LISTTYPE(RTN) ;sets IBDYN=1 if the rtn is dynamic selection,IBINPUT to the input interface
 N NODE
 I '$G(RTN) S (IBDYN,IBINPUT,IBCLRM)=0 Q
 S NODE=$G(^IBE(357.6,RTN,0))
 S IBDYN=$P(NODE,"^",14)
 S IBINPUT=$P(NODE,"^",13)
 S IBCLRM=$P(NODE,"^",20)
 Q
 ;
OTHEROK(PI) ;returns 1 if the selection interface=PI allows 'other', 0 otherwise
 N NODE
 Q:'$G(PI) 0
 ;
 ;there must be an interface for input
 Q:'$P((^IBE(357.6,PI,0)),"^",13) 0
 ;
 ;the selection interface must allow input of narrative or code
 S NODE=$G(^IBE(357.6,PI,16))
 I '$P(NODE,"^",2),'$P(NODE,"^",6) Q 0
 Q 1
